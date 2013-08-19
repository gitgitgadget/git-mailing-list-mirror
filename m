From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 2/2] submodule: don't print status output with ignore=all
Date: Mon, 19 Aug 2013 23:14:19 +0200
Message-ID: <52128AAB.1010401@web.de>
References: <1376760343-741047-1-git-send-email-sandals@crustytoothpaste.net> <1376760343-741047-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Aug 19 23:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWmP-0007zW-UT
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 23:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009Ab3HSVOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 17:14:22 -0400
Received: from mout.web.de ([212.227.15.4]:61241 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab3HSVOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 17:14:21 -0400
Received: from [192.168.178.41] ([91.3.132.244]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LaCji-1VwAFx3zmo-00m4Kn for <git@vger.kernel.org>;
 Mon, 19 Aug 2013 23:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1376760343-741047-3-git-send-email-sandals@crustytoothpaste.net>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:AukVcNXAyvfZkf7lN6rFbR4CCusaMI4nG4RNeUiI6LmJdi3uch4
 VIbG487/b4BlFOowAnW4q6OVSbldzeCySlkVU8But0LOEW7aw4N7He6oxCudLx4eUiyzohr
 43l5WclpRCE/MLrp6P+XC/n5XmuoyYeOTuFgoht7CMS2i99aFghNJdLbu87RBiHeT48V3Fg
 SwOOSuw5BBfSBHM1AoMog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232568>

Am 17.08.2013 19:25, schrieb brian m. carlson:
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

Sounds sane. Even though we should be able to follow renames by inspecting
the old .gitmodules content with the new --blob option of git config, I doubt
it'll be worth the hassle. Thanks for fixing two known test breakages.

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  git-submodule.sh  | 7 +++++++
>  t/t7508-status.sh | 4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 38520db..c1ba0f8 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1036,6 +1036,13 @@ cmd_summary() {
>  		do
>  			# Always show modules deleted or type-changed (blob<->module)
>  			test $status = D -o $status = T && echo "$sm_path" && continue
> +			# Respect the ignore setting for --for-status.
> +			if test -n $for_status
> +			then
> +				name=$(module_name "$sm_path")
> +				ignore_config=$(get_submodule_config "$name" ignore none)
> +				test $status != A -a $ignore_config = all && continue
> +			fi
>  			# Also show added or modified modules which are checked out
>  			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
>  			echo "$sm_path"
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
