From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv5 3/3] git rebase -i: add static check for commands and SHA-1
Date: Wed, 10 Jun 2015 17:20:47 +0200
Message-ID: <vpq8ubrtws0.fsf@anie.imag.fr>
References: <1433931035-20011-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433931035-20011-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Galan =?iso-8859-1?Q?R=E9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:21:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hoR-0003Eu-2a
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbbFJPVB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 11:21:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45922 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171AbbFJPU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:20:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFKkHM025701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 17:20:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFKlQO024702;
	Wed, 10 Jun 2015 17:20:47 +0200
In-Reply-To: <1433931035-20011-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	("Galan \=\?iso-8859-1\?Q\?R\=E9mi\=22's\?\= message of "Wed, 10 Jun 2015 12:10:35
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Jun 2015 17:20:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5AFKkHM025701
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434554450.13816@Z1H2lFj1P3ziviHSi5GGUA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271301>

Galan R=E9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> +# from the todolist in stdin
> +check_bad_cmd_and_sha () {
> +	git stripspace --strip-comments |
> +	while read -r command sha1 rest
> +	do
> +		case $command in
> +		''|noop|x|"exec")
> +			;;
> +		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
> +			if test -z $sha1
> +			then
> +				echo "$command $rest" >>"$todo".badsha
> +			else
> +				sha1_verif=3D"$(git rev-parse --verify --quiet $sha1^{commit})"
> +				if test -z $sha1_verif
> +				then
> +					echo "$command $sha1 $rest" \
> +						>>"$todo".badsha

When you reach the right end of your screen because of indentation,
cutting lines with \ is rarely the best option. Having 5 levels of
indentation is a sign that you should make more functions.

How about:

check_bad_cmd_and_sha () {
	git stripspace --strip-comments |
	while read -r command sha1 rest
	do
		case $command in
		''|noop|x|"exec")
			;;
		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
			check_commit_id $sha1
			;;
		*)
			record_bad_command $sha1
			;;
	esac
}

?

> +		*)
> +			if test -z $sha1
> +			then
> +				echo "$command" >>"$todo".badcmd

Avoid echo on user-supplied data.

> +			else
> +				commit=3D"$(git rev-list --oneline -1 --ignore-missing $sha1 2>/=
dev/null)"
> +				if test -z "$commit"
> +				then
> +					echo "$command $sha1 $rest" \
> +						>>"$todo".badcmd
> +				else
> +					echo "$command $commit" >>"$todo".badcmd
> +				fi
> +			fi

What are you trying to do here? It seems that you are trying to recover
the line, but the line is your input, you shouldn't have to recompute
it.

Why isn't printf '%s %s %s' "$command" "$sha1" "$rest" sufficient in al=
l
cases?

Maybe it would be better to read line by line (to avoid loosing
whitespace information for example), like

	while read -r line
	do
		printf '%s' "$line" | read -r cmd sha1 rest
		case $sha1 in
			...

or maybe it's overkill.

> +	check_bad_cmd_and_sha <"$todo"
> +
> +	if test -s "$todo".badsha
> +	then
> +		raiseError=3Dt

We usually don't use camelCase in shell-scripts. raise_error would be
the usual way to spell in in Git's codebase.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
