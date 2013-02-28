From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/5] Export rewrite_parents() for 'log -L'
Date: Thu, 28 Feb 2013 09:19:55 -0800
Message-ID: <7vfw0gicec.fsf@alter.siamese.dyndns.org>
References: <cover.1362069310.git.trast@student.ethz.ch>
 <8269ddf785d10c05e39905041df317b685e85168.1362069310.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:20:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB79c-0002P2-FH
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 18:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab3B1RT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 12:19:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53036 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497Ab3B1RT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 12:19:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15AA6BDA8;
	Thu, 28 Feb 2013 12:19:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oikokeC+RXyLboscqMzx9VsSUdg=; b=j8kYnA
	L9nL+J6cmCGcOd/t86dfHvpXhXPE9gyB/yxJFYzpy8dYlnKsbg3Rng0EBraHoL+X
	J2k4WlGE72kNwamYXRB5ArJhHQXiyTkIVcaNL0Zk/k+kPqC/89XrHG7N6xXc7abd
	nHrk0QrCN3VGacKugueaIsANC+Ek2sm6n/9CI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZomqfNUAk2D8kUA8uzIDgEuZoRul7Pek
	+kYSyyr8t9r6PRFw+chKFIWKGxm4bUAzo2Wjs8NP3INX5PObfI0phgfma+F3gsMs
	xadG7/Kw4JKhQ6uwmWwAwFytw3/6tvFdN2urQN+sbLgYv8HdcTYnUp6L8pwe/J15
	NBlRFUG1x3w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09E95BDA7;
	Thu, 28 Feb 2013 12:19:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59E46BDA6; Thu, 28 Feb 2013
 12:19:57 -0500 (EST)
In-Reply-To: <8269ddf785d10c05e39905041df317b685e85168.1362069310.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 28 Feb 2013 17:38:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13215324-81CB-11E2-9C61-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217245>

Thomas Rast <trast@student.ethz.ch> writes:

> From: Bo Yang <struggleyb.nku@gmail.com>
>
> The function rewrite_one is used to rewrite a single
> parent of the current commit, and is used by rewrite_parents
> to rewrite all the parents.
>
> Decouple the dependence between them by making rewrite_one
> a callback function that is passed to rewrite_parents. Then
> export rewrite_parents for reuse by the line history browser.
>
> We will use this function in line.c.

Did you mean log-line.c or line-log.c or something?

> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  revision.c | 13 ++++---------
>  revision.h | 10 ++++++++++
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index ef60205..46319d5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2173,12 +2173,6 @@ int prepare_revision_walk(struct rev_info *revs)
>  	return 0;
>  }
>  
> -enum rewrite_result {
> -	rewrite_one_ok,
> -	rewrite_one_noparents,
> -	rewrite_one_error
> -};
> -
>  static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
>  {
>  	struct commit_list *cache = NULL;
> @@ -2200,12 +2194,13 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
>  	}
>  }
>  
> -static int rewrite_parents(struct rev_info *revs, struct commit *commit)
> +int rewrite_parents(struct rev_info *revs, struct commit *commit,
> +	rewrite_parent_fn_t rewrite_parent)
>  {
>  	struct commit_list **pp = &commit->parents;
>  	while (*pp) {
>  		struct commit_list *parent = *pp;
> -		switch (rewrite_one(revs, &parent->item)) {
> +		switch (rewrite_parent(revs, &parent->item)) {
>  		case rewrite_one_ok:
>  			break;
>  		case rewrite_one_noparents:
> @@ -2371,7 +2366,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
>  	if (action == commit_show &&
>  	    !revs->show_all &&
>  	    revs->prune && revs->dense && want_ancestry(revs)) {
> -		if (rewrite_parents(revs, commit) < 0)
> +		if (rewrite_parents(revs, commit, rewrite_one) < 0)
>  			return commit_error;
>  	}
>  	return action;
> diff --git a/revision.h b/revision.h
> index 5da09ee..640110d 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -241,4 +241,14 @@ enum commit_action {
>  extern enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit);
>  extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
>  
> +enum rewrite_result {
> +	rewrite_one_ok,
> +	rewrite_one_noparents,
> +	rewrite_one_error
> +};
> +
> +typedef enum rewrite_result (*rewrite_parent_fn_t)(struct rev_info *revs, struct commit **pp);
> +
> +extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
> +	rewrite_parent_fn_t rewrite_parent);
>  #endif
