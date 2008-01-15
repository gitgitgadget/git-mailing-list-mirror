From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 16:18:06 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801141611560.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org> <7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
 <7vd4s6qal0.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org> <7vr6glnrvp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 01:20:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEZXl-0007m1-0i
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 01:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYAOAUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbYAOAUM
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 19:20:12 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34609 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733AbYAOAUK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2008 19:20:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0F0I7vq032648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2008 16:18:08 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0F0I6wq022576;
	Mon, 14 Jan 2008 16:18:06 -0800
In-Reply-To: <7vr6glnrvp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70493>



On Sun, 13 Jan 2008, Junio C Hamano wrote:
> 
> I've reworked the patch, and in the kernel repository, a
> single-path commit after touching that path now calls 23k
> lstat(2).  It used to call 46k lstat(2) after your fix.

Hmm. This part of it looks incorrect:

> diff --git a/diff.c b/diff.c
> index b18c140..62d0c06 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1510,6 +1510,10 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
>  	if (pos < 0)
>  		return 0;
>  	ce = active_cache[pos];
> +
> +	if (ce_uptodate(ce))
> +		return 1;
> +
>  	if ((lstat(name, &st) < 0) ||
>  	    !S_ISREG(st.st_mode) || /* careful! */
>  	    ce_match_stat(ce, &st, 0) ||

Isn't this wrong? I think it also needs to check that ce->sha1 matches the 
right SHA1, because even if the lstat() information may be fine, if the 
SHA1 doesn't match what we want, we still shouldn't use the checked-out 
copy, of course.

The old code continues with a

	   hashcmp(sha1, ce->sha1))
		return 0;

in that if-statement that is partially visible in the context, and it's 
that hashcmp() that got incorrectly cut off from the logic.

(Of course, maybe we never call this function unless we've already checked 
that the cache-entry SHA1 matches, but if so, that subsequent hashcmp 
should just be removed instead).

		Linus
