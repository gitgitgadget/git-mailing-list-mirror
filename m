From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] merge: make merge state available to prepare-commit-msg hook
Date: Wed, 08 Jan 2014 21:06:05 +0100
Message-ID: <vpqr48ip7bm.fsf@anie.imag.fr>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
	<DA9E6645-82DC-4714-845F-423726F96A40@yaauie.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ryan Biesemeyer <ryan@yaauie.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 21:06:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0zOP-000352-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 21:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbaAHUGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 15:06:18 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55743 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121AbaAHUGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 15:06:16 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s08K65qH013404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Jan 2014 21:06:05 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id s08K65ve029426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jan 2014 21:06:05 +0100
In-Reply-To: <DA9E6645-82DC-4714-845F-423726F96A40@yaauie.com> (Ryan
	Biesemeyer's message of "Wed, 8 Jan 2014 19:02:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Jan 2014 21:06:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s08K65qH013404
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1389816366.42581@Q6yE17ERFRZhurTX9mN6OQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240224>

Ryan Biesemeyer <ryan@yaauie.com> writes:

> index 3573751..89cdfe8 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -181,5 +181,27 @@ test_expect_success 'with failing hook (merge)' '
>  	test_must_fail git merge other
>  
>  '
> +git merge --abort # cleanup, since the merge failed.

Please, avoid having code outside a test_expect_* (see t/README, " - Put
all code inside test_expect_success and other assertions.").

> +test_expect_success 'should have MERGE_HEAD (merge)' '
> +
> +	git checkout -B other HEAD@{1} &&
> +	echo "more" >> file &&
> +	git add file &&
> +	rm -f "$HOOK" &&
> +	git commit -m other &&
> +	git checkout - &&
> +	write_script "$HOOK" <<-EOF
> +	if [ -s "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then
> +		exit 0
> +	else
> +		exit 1
> +	fi
> +	EOF

I think you lack one && for the write_script line.

There's another instance in the same file (probably where you got it
from), you should add this to your patch series:

>From c3d754a2a16d98b31d43a7e45973821ae8adc043 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Wed, 8 Jan 2014 21:03:27 +0100
Subject: [PATCH] t7505: add missing &&

---
 t/t7505-prepare-commit-msg-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 3573751..1c95652 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -174,7 +174,7 @@ test_expect_success 'with failing hook (merge)' '
 	git add file &&
 	rm -f "$HOOK" &&
 	git commit -m other &&
-	write_script "$HOOK" <<-EOF
+	write_script "$HOOK" <<-EOF &&
 	exit 1
 	EOF
 	git checkout - &&
-- 
1.8.5.rc3.4.g8bd3721

(a quick "git grep write_script" seems to show a lot of other instances,
but no time to dig this now sorry)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
