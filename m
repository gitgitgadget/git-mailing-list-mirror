From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Mon, 21 Mar 2016 18:24:41 +0100
Message-ID: <vpqfuvju4km.fsf@anie.imag.fr>
References: <1458573317-15532-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Elena Petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 18:26:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai3ag-0006zU-MN
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 18:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbcCUR0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2016 13:26:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48658 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756638AbcCUR0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 13:26:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2LHOdNZ004841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 21 Mar 2016 18:24:40 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2LHOfMH007750;
	Mon, 21 Mar 2016 18:24:41 +0100
In-Reply-To: <1458573317-15532-1-git-send-email-elena.petrashen@gmail.com>
	(Elena Petrashen's message of "Mon, 21 Mar 2016 18:15:17 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 21 Mar 2016 18:24:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2LHOdNZ004841
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459185885.24904@kct1ZJhjlcaTZ+k9MAfmbg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289425>

Hi, and welcome!

Elena Petrashen <elena.petrashen@gmail.com> writes:

> Signed-off-by: Elena Petrashen <elena.petrashen@gmail.com>
>
> ---
> This micro-patch is meant to allow =E2=80=9C-=E2=80=9C as a short-han=
d for
> =E2=80=9C@{-1} for branch -D (Cf. $gmane/230828):

Is it a good thing to do?

I find "git checkout -" to be a very nice shortcut, because users very
often want to get back to the branch they used to be before.

But I'm not sure how often people want to delete (force-delete accordin=
g
to your message) the branch they just come from. It might be less
dangerous to give incentive to the user to spell the branch name
completely to avoid mistake. As analogy, my shell knows "cd -" but I
can't "rm -fr -" and I'm happy about it.

Not a strong objection, but I think you can motivate the change better
in the commit message, or give it up if I convinced you that it wasn't =
a
good idea.

> * git branch (-d | -D) is not supposed to accept any other
> arguments except for branch name so it makes sense to replace
> the argv[i] with @{-1}. We will not lose the opportunity to
> use it for something different for other git branch uses if
> we will decide it=E2=80=99s required.

This could go inside the commit message, not below the ---.

> +As a special case, the "@{-N}" syntax for the N-th last branch
> +deletes the specified branch.=20

It's not really a special case. The @{-N} syntax works everywhere,
doesn't it?

> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -169,6 +169,8 @@ static int check_branch_commit(const char *branch=
name, const char *refname,
>  	return 0;
>  }
> =20
> +
> +

Don't include useless changes in your patches. Using "git add -p" and
"git commit" without -a helps. Review your patch carefully and eliminat=
e
such artefacts before sending: they only distract reviewers.

> +static void allow_dash_as_prev_branch_alias(const char **argv, int d=
ash_position)

The function name looks overly verbose and I'm not sure it describes
exactly what it does: it does not really "allow", but it "expands" it.
I'd call it expand_dash_shortcut().

>  		if (!target) {
> -			error(remote_branch
> -			      ? _("remote-tracking branch '%s' not found.")
> -			      : _("branch '%s' not found."), bname.buf);
> +			error(!strcmp(bname.buf, "@{-1}")
> +				? _("There is no previous branch that could be referred to at th=
e moment.")

This is not directly related to your change: the user could already
write "@{-1}" and may already have wanted a better error message. I
think this could/should be split into a separate patch.

> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -403,6 +403,16 @@ test_expect_success 'test deleting branch withou=
t config' '
>  	test_i18ncmp expect actual
>  '
> =20
> +test_expect_success 'test deleting "-" deletes previous branch' '
> +	git checkout -b prev &&
> +	test_commit prev &&
> +	git checkout master &&
> +	git branch -D - >actual &&
> +	sha1=3D$(git rev-parse prev | cut -c 1-7) &&

git rev-parse --short avoids this "cut".

Regards,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
