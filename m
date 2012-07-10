From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] branch: suggest how to undo a --set-upstream when given one branch
Date: Tue, 10 Jul 2012 19:20:23 +0200
Message-ID: <vpqpq83mt2g.fsf@bauges.imag.fr>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
	<1341939181-8962-3-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:20:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soe73-00082q-Pj
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 19:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507Ab2GJRUc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jul 2012 13:20:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35289 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719Ab2GJRUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 13:20:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6AHJ6ok016567
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Jul 2012 19:19:06 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Soe6q-0000Cg-2T; Tue, 10 Jul 2012 19:20:24 +0200
In-Reply-To: <1341939181-8962-3-git-send-email-cmn@elego.de> ("Carlos
 =?iso-8859-1?Q?Mart=EDn?=
	Nieto"'s message of "Tue, 10 Jul 2012 18:53:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 10 Jul 2012 19:19:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6AHJ6ok016567
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342545549.32082@HrIBdEuciq4tl5D6T6H6Ww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201265>

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

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

Multi-line comments are usually written in Git as

/*
 * multi-line
 * comment
 */

> +		if (branch_has_merge_config(branch))
> +		  old_upstream =3D shorten_unambiguous_ref(branch->merge[0]->dst, =
0);

Broken indentation.

> +		if (argc =3D=3D 1) {
> +			printf("If you wanted to make '%s' track '%s', do this:\n", head,=
 argv[0]);

Could be marked for translation with _("...").

> +			if (branch_existed)
> +				printf(" $ git branch --set-upstream '%s' '%s'\n", argv[0], old_=
upstream);

old_upstream may be NULL at this point. I guess you want to skip this
line if old_upsteam is NULL.

The fact that I could find this bug suggests that this lacks a few new
tests too ;-).

> +			else
> +				printf(" $ git branch -d '%s'\n", argv[0]);
> +
> +			printf(" $ git branch --set-upstream-to '%s'\n", argv[0]);

=46or the 3 printf()s: we usually display commands without the "$", and
separate them from text with a blank line. See for example what "git
commit" says when you didn't provide authorship:

You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

(the absence of $ sign avoids the temptation to cut-and-paste it)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
