From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: reject invalid refnames
Date: Thu, 03 Jan 2008 13:40:07 -0800
Message-ID: <7vy7b6oafc.fsf@gitster.siamese.dyndns.org>
References: <1199310726946-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAXoF-0007TA-Kj
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 22:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYACVkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 16:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYACVkU
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 16:40:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbYACVkT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 16:40:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CD9922F5;
	Thu,  3 Jan 2008 16:40:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B4BA322F2;
	Thu,  3 Jan 2008 16:40:13 -0500 (EST)
In-Reply-To: <1199310726946-git-send-email-mkoegler@auto.tuwien.ac.at> (Martin
	Koegler's message of "Wed, 2 Jan 2008 22:52:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69538>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
>  receive-pack.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/receive-pack.c b/receive-pack.c
> index d0a563d..a038a40 100644
> --- a/receive-pack.c
> +++ b/receive-pack.c
> @@ -165,7 +165,9 @@ static const char *update(struct command *cmd)
>  	unsigned char *new_sha1 = cmd->new_sha1;
>  	struct ref_lock *lock;
>  
> -	if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
> +	/* only HEAD and refs/... are allowed */
> +	if (strcmp(name, "HEAD") && 
> +	    (prefixcmp(name, "refs/") || check_ref_format(name + 5))) {
>  		error("refusing to create funny ref '%s' remotely", name);
>  		return "funny refname";
>  	}
> @@ -177,7 +179,8 @@ static const char *update(struct command *cmd)
>  	}
>  	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
>  	    !is_null_sha1(old_sha1) &&
> -	    !prefixcmp(name, "refs/heads/")) {
> +	    (!prefixcmp(name, "refs/heads/") ||
> +	     !strcmp(name, "HEAD"))) {
>  		struct object *old_object, *new_object;
>  		struct commit *old_commit, *new_commit;
>  		struct commit_list *bases, *ent;

Yuck.  What I was smoking.

Normal client "git push" does not even allow "git push victim
foo:HEAD".  So if name is "HEAD" that has to be a malicious
crafted push.

I think 

	if (prefixcmp(name, "refs/") || check_ref_format(name + 5))
		error();

is enough and correct.

Sorry for my earlier thinko.
