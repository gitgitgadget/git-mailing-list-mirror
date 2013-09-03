From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Tue, 03 Sep 2013 21:17:07 +0200
Message-ID: <522635B3.5050306@web.de>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net> <1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, judge.packham@gmail.com,
	gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 21:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGw6W-0004yt-6W
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 21:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933197Ab3ICTRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 15:17:20 -0400
Received: from mout.web.de ([212.227.15.4]:56915 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933026Ab3ICTRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 15:17:14 -0400
Received: from [192.168.178.41] ([91.3.162.32]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Mas22-1VaGT72hi6-00KPRf for <git@vger.kernel.org>;
 Tue, 03 Sep 2013 21:17:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:2ii9U2/uDCEAHjXpN2ofC5PwTUkd/fveHv4vCWNjTgJntj72EZe
 hmAhPZ7omR31MztjBrn5z4ZVK8xQkLqe+hX+ZZZr/Hdu8+tCp+F5xBd2oBv3bNehGiYhffr
 Mgw0Gabum1BAi2uLtHS7t8NBOXnVlpUL+zUfkZ/OVMBpgzm1v5aL/GZtip5vKE+wehLCquk
 lVlzUzk4ydf2zooaZ7PvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233761>

Am 01.09.2013 22:06, schrieb brian m. carlson:
> git status prints information for submodules, but it should ignore the status of
> those which have submodule.<name>.ignore set to all.  Fix it so that it does
> properly ignore those which have that setting either in .git/config or in
> .gitmodules.
> 
> Not ignored are submodules that are added, deleted, or moved (which is
> essentially a combination of the first two) because it is not easily possible to
> determine the old path once a move has occurred, nor is it easily possible to
> detect which adds and deletions are moves and which are not.  This also
> preserves the previous behavior of always listing modules which are to be
> deleted.
> 
> Tests are included which verify that this change has no effect on git submodule
> summary without the --for-status option.

Thanks, that fixes the bug Matthieu noticed which is now tested for.

I only have some nits concerning the new tests, please see below.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  git-submodule.sh             |  7 +++++++
>  t/t7401-submodule-summary.sh | 30 ++++++++++++++++++++++++++++++
>  t/t7508-status.sh            |  4 ++--
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 38520db..004b21c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1036,6 +1036,13 @@ cmd_summary() {
>  		do
>  			# Always show modules deleted or type-changed (blob<->module)
>  			test $status = D -o $status = T && echo "$sm_path" && continue
> +			# Respect the ignore setting for --for-status.
> +			if test -n "$for_status"
> +			then
> +				name=$(module_name "$sm_path")
> +				ignore_config=$(get_submodule_config "$name" ignore none)
> +				test $status != A -a $ignore_config = all && continue
> +			fi
>  			# Also show added or modified modules which are checked out
>  			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
>  			echo "$sm_path"
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index ac2434c..ca9441e 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -104,6 +104,36 @@ EOF
>  	test_cmp expected actual
>  "
>  
> +test_expect_success '.gitmodules ignore=all has no effect' "
> +	git config --add -f .gitmodules submodule.sm1.ignore all &&
> +	git config --add -f .gitmodules submodule.sm1.path sm1 &&
> +	git submodule summary >actual &&
> +	cat >expected <<-EOF &&
> +* sm1 $head1...$head2 (1):
> +  > Add foo3
> +
> +EOF
> +	test_cmp expected actual &&
> +	git config -f .gitmodules --remove-section submodule.sm1
> +"
> +
> +test_expect_success '.git/config ignore=all has no effect' "
> +	git config --add -f .gitmodules submodule.sm1.ignore none &&
> +	git config --add -f .gitmodules submodule.sm1.path sm1 &&
> +	git config --add submodule.sm1.ignore all &&
> +	git config --add submodule.sm1.path sm1 &&
> +	git submodule summary >actual &&
> +	cat >expected <<-EOF &&
> +* sm1 $head1...$head2 (1):
> +  > Add foo3
> +
> +EOF
> +	test_cmp expected actual &&
> +	git config --remove-section submodule.sm1 &&
> +	git config -f .gitmodules --remove-section submodule.sm1
> +"
> +
> +
>  commit_file sm1 &&
>  head3=$(
>  	cd sm1 &&

I think we should do both tests in one go: just turn on all ignore
options and test against that. Additionally we should also set
diff.ignoreSubmodules too, while there is no need to set the path
in .git/config. And I believe we can drop the --add option from
the config command, so I'd propose something like this:

-------------------------8<---------------------------
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index ac2434c..81ae7c9 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -104,6 +104,24 @@ EOF
 	test_cmp expected actual
 "

+test_expect_success 'no ignore=all setting has any effect' "
+	git config -f .gitmodules submodule.sm1.path sm1 &&
+	git config -f .gitmodules submodule.sm1.ignore all &&
+	git config submodule.sm1.ignore all &&
+	git config diff.ignoreSubmodules all &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
+* sm1 $head1...$head2 (1):
+  > Add foo3
+
+EOF
+	test_cmp expected actual &&
+	git config --unset diff.ignoreSubmodules &&
+	git config --remove-section submodule.sm1 &&
+	git config -f .gitmodules --remove-section submodule.sm1
+"
+
+
 commit_file sm1 &&
 head3=$(
 	cd sm1 &&
-------------------------8<---------------------------

> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index ac3d0fe..fb89fb9 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1316,7 +1316,7 @@ test_expect_success "--ignore-submodules=all suppresses submodule summary" '
>  	test_i18ncmp expect output
>  '
>  
> -test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
> +test_expect_success '.gitmodules ignore=all suppresses submodule summary' '
>  	git config --add -f .gitmodules submodule.subname.ignore all &&
>  	git config --add -f .gitmodules submodule.subname.path sm &&
>  	git status > output &&
> @@ -1324,7 +1324,7 @@ test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
>  	git config -f .gitmodules  --remove-section submodule.subname
>  '
>  
> -test_expect_failure '.git/config ignore=all suppresses submodule summary' '
> +test_expect_success '.git/config ignore=all suppresses submodule summary' '
>  	git config --add -f .gitmodules submodule.subname.ignore none &&
>  	git config --add -f .gitmodules submodule.subname.path sm &&
>  	git config --add submodule.subname.ignore all &&
> 
