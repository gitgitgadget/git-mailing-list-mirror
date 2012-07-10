From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] branch: suggest how to undo a --set-upstream when
 given one branch
Date: Tue, 10 Jul 2012 10:40:33 -0700
Message-ID: <7va9z7ikfi.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-3-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:40:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoeQX-0001d6-7t
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 19:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab2GJRkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jul 2012 13:40:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637Ab2GJRkj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2012 13:40:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A42685AE;
	Tue, 10 Jul 2012 13:40:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dqItJBG1I4Ey
	1PmKiqCKTGIy2Ec=; b=VVUOQYy3O8h8x702dpyiUFwk1V6rlVLV2DhqL0azAuqh
	wcYu46KWtOQcRPsTsGN+WITd5xt6+I3EoYzwaxZf8Lvh55ufl4dqK5iJZ4NfjHC6
	Q9JD0YJ36PohI60kHVfBxf//iGbno3RbLf6z/7Htu1jBa0yoYK+U+/hOaq3nNyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gWpRHh
	1KcTyyLZLJPVnuk3UNqfOOSWh3TmDgrq9OuazRnpiSm0P5OK2ddrr5hELkJ7crBH
	AV4bBtFCgV3l6IVI0Ogh64XH/C+rbESI9ZJ+OiXf4tjTJQdQxXrlRQ72dRldq2JI
	03JJBo1VEypWVVKJv7edlpO/Z3+iQaLJ9x1SM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0106D85AC;
	Tue, 10 Jul 2012 13:40:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56E0785AB; Tue, 10 Jul 2012
 13:40:35 -0400 (EDT)
In-Reply-To: <1341939181-8962-3-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 10 Jul 2012 18:53:00
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AC6DBE4-CAB6-11E1-AE0C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201268>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> This interface is error prone, and a better one (--set-upstream-to)
> exists. Suggest how to fix a --set-upstream invocation in case the
> user only gives one argument, which makes it likely that he meant to
> do the opposite, like with
>
>     git branch --set-upstream origin/master
>
> when they meant one of
>
>     git branch --set-upstream origin/master master
>     git branch --set-upstream-to origin/master
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

The new code does not seem to depend on the value of "track" (which
is set by either -t or --set-upstream) in any way.  Shouldn't it be
done only when it is set to track-override?

Doesn't "git branch [-f] frotz" without any other argument trigger
the warning?

>  builtin/branch.c |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index c886fc0..5551227 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -864,10 +864,32 @@ int cmd_branch(int argc, const char **argv, con=
st char *prefix)
>  		   info and making sure new_upstream is correct */
>  		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BR=
ANCH_TRACK_OVERRIDE);
>  	} else if (argc > 0 && argc <=3D 2) {
> +		struct branch *branch =3D branch_get(argv[0]);
> +		const char *old_upstream =3D NULL;
> +		int branch_existed =3D 0;
> +
>  		if (kinds !=3D REF_LOCAL_BRANCH)
>  			die(_("-a and -r options to 'git branch' do not make sense with a=
 branch name"));
> +
> +		/* Save what argv[0] was pointing to so we can give
> +		   the --set-upstream-to hint */
> +		if (branch_has_merge_config(branch))
> +		  old_upstream =3D shorten_unambiguous_ref(branch->merge[0]->dst, =
0);
> +
> +		branch_existed =3D ref_exists(branch->refname);
>  		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
>  			      force_create, reflog, 0, quiet, track);
> +
> +		if (argc =3D=3D 1) {
> +			printf("If you wanted to make '%s' track '%s', do this:\n", head,=
 argv[0]);
> +			if (branch_existed)
> +				printf(" $ git branch --set-upstream '%s' '%s'\n", argv[0], old_=
upstream);
> +			else
> +				printf(" $ git branch -d '%s'\n", argv[0]);
> +
> +			printf(" $ git branch --set-upstream-to '%s'\n", argv[0]);
> +		}
> +
>  	} else
>  		usage_with_options(builtin_branch_usage, options);
