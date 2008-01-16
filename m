From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make 'git fsck' complain about non-commit branches
Date: Tue, 15 Jan 2008 16:43:09 -0800
Message-ID: <7v8x2qd2hu.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801151618300.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:44:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwO5-0007Iq-Gr
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 01:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbYAPAnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbYAPAnZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:43:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbYAPAnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 19:43:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 43A022FEC;
	Tue, 15 Jan 2008 19:43:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2C52FEB;
	Tue, 15 Jan 2008 19:43:20 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801151618300.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 15 Jan 2008 16:34:17 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70587>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Since having non-commits in branches is a no-no, and just means you cannot 
> commit on them, let's make fsck tell you when a branch is bad.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

I think all of the three patches (so far -- do you have more?)
look sane from the Porcelain-plumbing combination point of view,
but I wonder if we should make it more explicit that we are now
moving in the direction that makes plumbing much more aware of
the Porcelain convention.

So far, the plumbing level did not care much about the Porcelain
convention, such as refs/heads and refs/remotes (you seem to
have forgot) are about "branches" and must point at commit
objects.

> ---
>
>  builtin-fsck.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/builtin-fsck.c b/builtin-fsck.c
> index 8876d34..6fc9525 100644
> --- a/builtin-fsck.c
> +++ b/builtin-fsck.c
> @@ -555,20 +555,23 @@ static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, in
>  	return 0;
>  }
>  
> +static int is_branch(const char *refname)
> +{
> +	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/");
> +}
> +
>  static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>  {
>  	struct object *obj;
>  
> -	obj = lookup_object(sha1);
> +	obj = parse_object(sha1);
>  	if (!obj) {
> -		if (has_sha1_file(sha1)) {
> -			default_refs++;
> -			return 0; /* it is in a pack */
> -		}
>  		error("%s: invalid sha1 pointer %s", refname, sha1_to_hex(sha1));
>  		/* We'll continue with the rest despite the error.. */
>  		return 0;
>  	}
> +	if (obj->type != OBJ_COMMIT && is_branch(refname))
> +		error("%s: not a commit", refname);
>  	default_refs++;
>  	obj->used = 1;
>  	mark_reachable(obj, REACHABLE);
