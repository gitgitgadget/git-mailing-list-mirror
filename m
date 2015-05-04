From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/7] t5520: implement tests for no merge candidates cases
Date: Mon, 04 May 2015 10:04:53 +0200
Message-ID: <vpqvbg8u5sq.fsf@anie.imag.fr>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<1430581035-29464-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 10:05:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpBNG-000550-VE
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 10:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbbEDIFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 04:05:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36911 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbbEDIFG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 04:05:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4484rjk005126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 May 2015 10:04:53 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4484rbs012080;
	Mon, 4 May 2015 10:04:53 +0200
In-Reply-To: <1430581035-29464-3-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Sat, 2 May 2015 23:37:10 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 May 2015 10:04:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4484rjk005126
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1431331493.6881@TaTebwMQwX/N/BtVmS0lpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268310>

Thanks for the patch. On overall, it looks good to me. Some minor
comments below.

Paul Tan <pyokagan@gmail.com> writes:

> Commit a8c9bef4 fully established the current advices given by git-pull
> for the different cases where git-fetch will not have anything marked
> for merge:
>
> 1. We're not on a branch, so there is no branch
>    configuration.

Nit: you seem to be wrapping your lines with a rather short length. I
would prefer reading this as a single line:

1. We're not on a branch, so there is no branch configuration.

(62 columns)

> ---
>
> I'm having trouble hitting the 1st case without resorting to the hack below. A
> detached HEAD will always have no remote configured, and the code flow would
> make it such that case (4) is hit in the detached HEAD case instead of case
> (1).

This should appear in comments in the test 'fail if not on a branch'.
People reading your [branch ""] in the future won't look for
below-triple-dash comments in the mailing-list archives ...

And actually, it would be more user-friendly to trigger this error
message in the normal senario, i.e. check for 1. before 4. in the code.
This was most likely the intension of the programmer who wrote this
error message. You may want to fix this now, or add a
test_expect_failure which will become a test_expect_success when you
replace git-pull.sh with builtin/pull.c.

>  t/t5520-pull.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 01ae1bf..635ec02 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -122,6 +122,58 @@ test_expect_success 'the default remote . should not break explicit pull' '
>  	test `cat file` = modified
>  '
>  
> +test_expect_success 'fail if not on a branch' '
> +	cp .git/config .git/config.bak &&
> +	test_when_finished "cp .git/config.bak .git/config" &&
> +	git remote add test_remote . &&
> +	git checkout HEAD^{} &&
> +	test_when_finished "git checkout -f copy" &&
> +	cat >>.git/config <<-\EOF &&
> +	[branch ""]
> +	remote = test_remote
> +	EOF
> +	test_must_fail git pull test_remote 2>out &&
> +	test_i18ngrep "You are not currently on a branch" out

It may make sense to grep only a subset of the string, to be less
sensitive to rewords of error message. For example, just:

test_i18ngrep "not currently on a branch"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
