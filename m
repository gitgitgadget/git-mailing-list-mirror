From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "make quick-install-man" broke recently
Date: Mon, 17 Aug 2009 09:34:23 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908170932390.3162@localhost.localdomain>
References: <86my5z8cjd.fsf@blue.stonehenge.com> <7vy6pj449g.fsf@alter.siamese.dyndns.org> <86iqgn8brv.fsf@blue.stonehenge.com> <7vd46v3tp1.fsf@alter.siamese.dyndns.org> <8c9a060908162258ua50e34ah53c1ada9dbcd4aa0@mail.gmail.com>
 <7vhbw72ap3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:34:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5AN-0004k0-6u
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbZHQQea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756443AbZHQQea
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:34:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50762 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755793AbZHQQe3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 12:34:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7HGYPjm023902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Aug 2009 09:34:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7HGYNoZ008655;
	Mon, 17 Aug 2009 09:34:23 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vhbw72ap3.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126222>



On Sun, 16 Aug 2009, Junio C Hamano wrote:
>
> -/* "careful lstat()" */
> -extern int check_path(const char *path, int len, struct stat *st);
> -
>  #define REFRESH_REALLY		0x0001	/* ignore_valid */
>  #define REFRESH_UNMERGED	0x0002	/* allow unmerged */
>  #define REFRESH_QUIET		0x0004	/* be quiet about it */
> diff --git a/entry.c b/entry.c
> index f276cf3..6813f8a 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -179,9 +179,18 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
>   * This is like 'lstat()', except it refuses to follow symlinks
>   * in the path.
>   */
> -int check_path(const char *path, int len, struct stat *st)
> +static int check_path(const char *path, int len, struct stat *st,
> +		      const struct checkout *co)
>  {
> -	if (has_symlink_leading_path(path, len)) {
> +	if (co->base_dir_len) {
> +		const char *slash = path + len;
> +		while (path < slash && *slash != '/')
> +			slash--;
> +		if (!has_dirs_only_path(path, slash-path, co->base_dir_len)) {
> +			errno = ENOENT;
> +			return -1;
> +		}
> +	} else if (has_symlink_leading_path(path, len)) {

Grr. Now 'check_path()' is no longer something generically useful.

Could you perhaps instead only change 'checkout_entry()' to do this hack, 
and leave 'check_path()' as a generic replacement for "lstat()" that 
doesn't follow symlinks?

		Linus
