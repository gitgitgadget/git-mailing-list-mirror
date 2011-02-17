From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2 (v2)] t7406: "git submodule update {--merge|--rebase]"
 with new submodules
Date: Thu, 17 Feb 2011 20:43:01 +0100
Message-ID: <4D5D7A45.6020204@web.de>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu> <1297959526-8089-2-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Thu Feb 17 20:44:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq9m5-0000nX-5e
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 20:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781Ab1BQToV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 14:44:21 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:45039 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1BQToT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 14:44:19 -0500
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id E068D198611F7;
	Thu, 17 Feb 2011 20:43:01 +0100 (CET)
Received: from [93.246.40.171] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pq9kj-0001Bg-00; Thu, 17 Feb 2011 20:43:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1297959526-8089-2-git-send-email-olsonse@umich.edu>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18t6gZiBnYoENO/7unoBLMEIYc1eaO/Q7vXDK7p
	lk+JEDrrrJpL6Z1qDlLzO/eo0BW44HsWUzjLxveMsv1Tk8CHVM
	RWkKlBG4HepYArh3obFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167102>

Am 17.02.2011 17:18, schrieb Spencer E. Olson:
> This patch adds two new test cases in t7406 to ensure that the --merge/--rebase
> options are ignored for "git submodule update" with new modules.  These test
> that a simple checkout is performed instead.
> 
> Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
> ---
>  t/t7406-submodule-update.sh |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index bfb4975..141251c 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -203,4 +203,28 @@ test_expect_success 'submodule init picks up merge' '
>  	)
>  '
>  
> +test_expect_success 'submodule update --merge  - ignores --merge  for new submodules' '
> +	(cd super &&
> +	 rm -rf submodule &&
> +	 git submodule update submodule &&
> +	 git submodule status submodule >expect &&
> +	 rm -rf submodule &&
> +	 git submodule update --merge submodule &&
> +	 git submodule status submodule >actual &&
> +	 test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'submodule update --rebase - ignores --rebase for new submodules' '
> +	(cd super &&
> +	 rm -rf submodule &&
> +	 git submodule update submodule &&
> +	 git submodule status submodule >expect &&
> +	 rm -rf submodule &&
> +	 git submodule update --rebase submodule &&
> +	 git submodule status submodule >actual &&
> +	 test_cmp expect actual
> +	)
> +'
> +
>  test_done

Thanks for writing these tests!

Unfortunately the first new test doesn't fail for me with current git.
This should be fixed to be able to detect regressions in the future, so
I came up with replacing the "git submodule status submodule" calls with
"git status -s submodule", which did the trick for me.

Apart from that tests which cover the case when rebase or merge are
configured via "submodule.<name>.update" would help, as that triggers
the same problem.

So maybe you want to squash the following diff in, then feel free to add:
Acked-by: Jens Lehmann <Jens.Lehmann@web.de>


diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 141251c..fa9d23a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -207,10 +207,10 @@ test_expect_success 'submodule update --merge  - ignores --merge  for new submod
 	(cd super &&
 	 rm -rf submodule &&
 	 git submodule update submodule &&
-	 git submodule status submodule >expect &&
+	 git status -s submodule >expect &&
 	 rm -rf submodule &&
 	 git submodule update --merge submodule &&
-	 git submodule status submodule >actual &&
+	 git status -s submodule >actual &&
 	 test_cmp expect actual
 	)
 '
@@ -219,10 +219,38 @@ test_expect_success 'submodule update --rebase - ignores --rebase for new submod
 	(cd super &&
 	 rm -rf submodule &&
 	 git submodule update submodule &&
-	 git submodule status submodule >expect &&
+	 git status -s submodule >expect &&
 	 rm -rf submodule &&
 	 git submodule update --rebase submodule &&
-	 git submodule status submodule >actual &&
+	 git status -s submodule >actual &&
+	 test_cmp expect actual
+	)
+'
+
+test_expect_success 'submodule update ignores update=merge config for new submodules' '
+	(cd super &&
+	 rm -rf submodule &&
+	 git submodule update submodule &&
+	 git status -s submodule >expect &&
+	 rm -rf submodule &&
+	 git config submodule.submodule.update merge &&
+	 git submodule update submodule &&
+	 git status -s submodule >actual &&
+	 git config --unset submodule.submodule.update &&
+	 test_cmp expect actual
+	)
+'
+
+test_expect_success 'submodule update ignores update=rebase config for new submodules' '
+	(cd super &&
+	 rm -rf submodule &&
+	 git submodule update submodule &&
+	 git status -s submodule >expect &&
+	 rm -rf submodule &&
+	 git config submodule.submodule.update rebase &&
+	 git submodule update submodule &&
+	 git status -s submodule >actual &&
+	 git config --unset submodule.submodule.update &&
 	 test_cmp expect actual
 	)
 '
-- 
1.7.4.1.109.g3d8f5
