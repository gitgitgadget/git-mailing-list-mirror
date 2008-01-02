From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: input validation in receive-pack
Date: Wed, 2 Jan 2008 10:53:56 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801021043220.13593@iabervon.org>
References: <20080101213451.GA26772@auto.tuwien.ac.at> <7vzlvp3oya.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801012353580.13593@iabervon.org> <7vhchw3hkz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 16:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA5vP-0002Jd-P3
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 16:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbYABPx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 10:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbYABPx6
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 10:53:58 -0500
Received: from iabervon.org ([66.92.72.58]:55141 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163AbYABPx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 10:53:57 -0500
Received: (qmail 31912 invoked by uid 1000); 2 Jan 2008 15:53:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Jan 2008 15:53:56 -0000
In-Reply-To: <7vhchw3hkz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69475>

On Tue, 1 Jan 2008, Junio C Hamano wrote:

> @@ -816,9 +821,13 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
>  
>  struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
>  {
> -	if (check_ref_format(ref) == -1)
> +	switch (check_ref_format(ref)) {
> +	case CHECK_REF_FORMAT_ERROR:
> +	case CHECK_REF_FORMAT_WILDCARD:
>  		return NULL;
> -	return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
> +	default:
> +		return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);

It might be wise to make "default" the return NULL case, and list the two 
okay cases explicitly, so it doesn't need to be changed if 
check_ref_format() someday gets additional "okay for some purposes" 
values.

Aside from that, it looks good, except that builtin-send-pack.c and 
fast-import.c should probably use the symbolic constants, too. (All other 
callers only check whether the value is true or not).

	-Daniel
*This .sig left intentionally blank*
