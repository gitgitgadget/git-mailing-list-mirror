From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 21/25] t9001: use test_when_finished
Date: Wed, 25 Mar 2015 03:00:22 +0100
Message-ID: <20150325030022.Horde.yvJScxCdU4w4HDIV_xUwrw1@webmail.informatik.kit.edu>
References: <20150320100429.GA17354@peff.net>
 <20150320101321.GU12543@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:00:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaacX-0000Lw-Qg
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 03:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbbCYCAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 22:00:33 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:45009 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343AbbCYCAc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 22:00:32 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YaacQ-0002i1-Ul; Wed, 25 Mar 2015 03:00:30 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YaacI-0004tO-8k; Wed, 25 Mar 2015 03:00:22 +0100
Received: from x590cf8a1.dyn.telefonica.de (x590cf8a1.dyn.telefonica.de
 [89.12.248.161]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 25 Mar 2015 03:00:22 +0100
In-Reply-To: <20150320101321.GU12543@peff.net>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1427248831.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266247>


Quoting Jeff King <peff@peff.net>:

> The confirmation tests in t9001 all save the value of
> sendemail.confirm, do something to it, then restore it at
> the end, in a way that breaks the &&-chain (they are not
> wrong, because they save the $? value, but it fools
> --chain-lint).
>
> Instead, they can all use test_when_finished, and we can
> even make the code simpler by factoring out the shared
> lines.

I think that saving the value of 'sendemail.confirm' is not necessary.

There are two blocks of confirmation tests, this patch concerns only tests
of the second block.  The first block of confirmation tests is nearly at
the beginning of the file in order to check the "no confirm" cases early.
If any of those fails the remainig tests in the file are skipped because
they might hang.  The last of those tests sets 'sendemail.confirm' to
'never' and leaves it so to avoid unintentional prompting in the remaining
tests and then its value is not modified until that second block of
confirm tests are reached.  This means that when those tests save the
value of 'sendemail.confirm' they always save 'never'.  Then why save it,
just use test_when_finished to restore it to 'never' and all is well.


> Note that we can _almost_ use test_config here, except that:
>
>  1. We do not restore the config with test_unconfig, but by
>     setting it back to some prior value.
>
>  2. We are not always setting a config variable. Sometimes
>     the change to be undone is unsetting it entirely.
>
> We could teach test_config to handle these cases, but it's
> not worth the complexity for a single call-site.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> t/t9001-send-email.sh | 30 ++++++++++--------------------
> 1 file changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 37caa18..c9f54d5 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -817,26 +817,25 @@ test_expect_success $PREREQ '--confirm=compose' '
> 	test_confirm --confirm=compose --compose
> '
>
> -test_expect_success $PREREQ 'confirm by default (due to cc)' '
> +save_confirm () {
> 	CONFIRM=$(git config --get sendemail.confirm) &&
> +	test_when_finished "git config sendemail.confirm ${CONFIRM:-never}"
> +}
> +
> +test_expect_success $PREREQ 'confirm by default (due to cc)' '
> +	save_confirm &&
> 	git config --unset sendemail.confirm &&
> 	test_confirm
> -	ret="$?"
> -	git config sendemail.confirm ${CONFIRM:-never}
> -	test $ret = "0"
> '
>
> test_expect_success $PREREQ 'confirm by default (due to --compose)' '
> -	CONFIRM=$(git config --get sendemail.confirm) &&
> +	save_confirm &&
> 	git config --unset sendemail.confirm &&
> 	test_confirm --suppress-cc=all --compose
> -	ret="$?"
> -	git config sendemail.confirm ${CONFIRM:-never}
> -	test $ret = "0"
> '
>
> test_expect_success $PREREQ 'confirm detects EOF (inform assumes y)' '
> -	CONFIRM=$(git config --get sendemail.confirm) &&
> +	save_confirm &&
> 	git config --unset sendemail.confirm &&
> 	rm -fr outdir &&
> 	git format-patch -2 -o outdir &&
> @@ -846,13 +845,10 @@ test_expect_success $PREREQ 'confirm detects EOF
> (inform assumes y)' '
> 			--to=nobody@example.com \
> 			--smtp-server="$(pwd)/fake.sendmail" \
> 			outdir/*.patch </dev/null
> -	ret="$?"
> -	git config sendemail.confirm ${CONFIRM:-never}
> -	test $ret = "0"
> '
>
> test_expect_success $PREREQ 'confirm detects EOF (auto causes failure)' '
> -	CONFIRM=$(git config --get sendemail.confirm) &&
> +	save_confirm &&
> 	git config sendemail.confirm auto &&
> 	GIT_SEND_EMAIL_NOTTY=1 &&
> 	export GIT_SEND_EMAIL_NOTTY &&
> @@ -861,13 +857,10 @@ test_expect_success $PREREQ 'confirm detects EOF
> (auto causes failure)' '
> 			--to=nobody@example.com \
> 			--smtp-server="$(pwd)/fake.sendmail" \
> 			$patches </dev/null
> -	ret="$?"
> -	git config sendemail.confirm ${CONFIRM:-never}
> -	test $ret = "0"
> '
>
> test_expect_success $PREREQ 'confirm does not loop forever' '
> -	CONFIRM=$(git config --get sendemail.confirm) &&
> +	save_confirm &&
> 	git config sendemail.confirm auto &&
> 	GIT_SEND_EMAIL_NOTTY=1 &&
> 	export GIT_SEND_EMAIL_NOTTY &&
> @@ -876,9 +869,6 @@ test_expect_success $PREREQ 'confirm does not loop
> forever' '
> 			--to=nobody@example.com \
> 			--smtp-server="$(pwd)/fake.sendmail" \
> 			$patches
> -	ret="$?"
> -	git config sendemail.confirm ${CONFIRM:-never}
> -	test $ret = "0"
> '
>
> test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
> --
> 2.3.3.520.g3cfbb5d
