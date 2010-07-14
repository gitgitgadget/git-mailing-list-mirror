From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/4] make rewrite_parents an external function
Date: Wed, 14 Jul 2010 12:10:52 -0700
Message-ID: <7vpqypyj43.fsf@alter.siamese.dyndns.org>
References: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829657-26607-2-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 21:11:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ7MX-0002Hb-5H
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 21:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431Ab0GNTLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 15:11:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427Ab0GNTLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 15:11:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D257FC4DCC;
	Wed, 14 Jul 2010 15:11:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=2P+p+XO2sGphAmytLWW/fuMRCbo=; b=TRq+2Wa4KnA508WNOZuZwLM
	9j0N2OIsfJeKah1tppAxOPLP/Jq6Bpd8Qee8qTzomqRJz4vr8wWxZQYk1fanrTkl
	dHYoL8jwKBAhyWpYAYLcRFfacti3M6T51qa7aFuh6m5z1EeL8A+coWjzDoMU4zAr
	cG1EBvBl3Kr1ze0qLYWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vi9z0gHOmKtxcuuEyUVsyf7Xx1/gEGlkbFWcVChnktpRfonLQ
	RMEiLBPbrlJD29nIlRowdrprxMOI191787pLWftg2nH9CjTC4AyP3MBz/W1tUGJH
	mT+UDyLsA1+XQyrlNsmmb49/ukhrrLPG0WmVp4dSnvkzxOQIkF9akuD96M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41AABC4DCB;
	Wed, 14 Jul 2010 15:11:00 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89E93C4DC9; Wed, 14 Jul
 2010 15:10:54 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 89EEF5A0-8F7B-11DF-896E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151027>

Bo Yang <struggleyb.nku@gmail.com> writes:

> The function rewrite_one is used to rewrite a single
> parent of the current commit, and is used by rewrite_parents
> to rewrite all the parents.
> This commit decouple the dependence between them, make
> rewrite_one as a callback function and be passed to
> rewrite_parents. Make rewrite_parents public to other
> part of git.
> We will use this function in line.c.

Sorry, but -ECANTREALLYPARSE.

This particular refactoring is probably harmless, but we would need to see
how it is used to convince ourselves it is a good change.

> @@ -1920,7 +1914,8 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
>  	}
>  }
>  
> -static int rewrite_parents(struct rev_info *revs, struct commit *commit)
> +int rewrite_parents(struct rev_info *revs, struct commit *commit,
> +	rewrite_parent rewrite_one)
>  {
>  	struct commit_list **pp = &commit->parents;
>  	while (*pp) {
> @@ -1993,7 +1988,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
>  	if (action == commit_show &&
>  	    !revs->show_all &&
>  	    revs->prune && revs->dense && want_ancestry(revs)) {
> -		if (rewrite_parents(revs, commit) < 0)
> +		if (rewrite_parents(revs, commit, rewrite_one) < 0)
>  			return commit_error;
>  	}
>  	return action;

It would probably make sense to rename this "rewrite_one" (local function
pointer variable) not to collide with the "rewrite_one" (static function)
for readability.

> diff --git a/revision.h b/revision.h
> index 433da9a..9b8e3d9 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -200,4 +200,14 @@ enum commit_action {
>  extern enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit);
>  extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
>  
> +enum rewrite_result {
> +	rewrite_one_ok,
> +	rewrite_one_noparents,
> +	rewrite_one_error
> +};
> +
> +typedef enum rewrite_result (*rewrite_parent)(struct rev_info *revs, struct commit **pp);

Yikes; at least name the type rewrite_parent_fn or something for readability.


> +extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
> +	rewrite_parent rewrite_one);
>  #endif
> -- 
> 1.7.0.2.273.gc2413.dirty
