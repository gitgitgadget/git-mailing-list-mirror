From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule deinit: don't output "Cleared directory" when directory
 is empty
Date: Tue, 16 Apr 2013 22:47:10 +0200
Message-ID: <516DB8CE.6050109@web.de>
References: <5112C6F6.4030607@web.de> <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com> <7v1ubk8u6o.fsf@alter.siamese.dyndns.org> <51477EFF.2010505@web.de> <7v7gl4mabf.fsf@alter.siamese.dyndns.org> <5159D9A8.30901@web.de> <CABURp0rkeYc7K0COhc1+96Q2Ox2TaNRpMSmQYOiwBpgPJbsafA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 22:50:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USCps-0007BG-AN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 22:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965348Ab3DPUrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 16:47:25 -0400
Received: from mout.web.de ([212.227.15.3]:59552 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964981Ab3DPUrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 16:47:24 -0400
Received: from [192.168.178.41] ([91.3.167.3]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MEmKo-1UM67R14wc-00GJNc; Tue, 16 Apr 2013 22:47:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CABURp0rkeYc7K0COhc1+96Q2Ox2TaNRpMSmQYOiwBpgPJbsafA@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:muBKSulhOqQUhKH6MJRP38ILUcJuZN5Z0qQesEqzfYz
 ZZMhM0VdJq3z+bCLpdc5eGKpAQOtKSOTijZNRtOET1lDU6Yz81
 yYOgyT9dW1rVnPIf/Iu3uncslkgYGsh2yxUGVZnZvlUDcmUUYq
 BrhJ2f5ML/qt4evSP2jjUWAGp3fk68b+O2BVDuxhXNGf6vVIyL
 XEMdlnZu8MwsGmu6DvEBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221470>

Currently a "submodule deinit" run on a non-populated submodule will still
print the "Cleared directory" message even though the directory is already
empty. While that is technically correct (as the directory is removed and
created again), it is rather surprising to see this message for an empty
submodule directory where nothing is to be cleared.

Fix that by using 'test ! -d "$(find "$sm_path" -maxdepth 0 -empty)"' to
test for the directory being not empty before removing and recreating it.

Thanks-to: Phil Hord <phil.hord@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 16.04.2013 15:32, schrieb Phil Hord:
> On Mon, Apr 1, 2013 at 3:02 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Okay, so here is the patch for that. If someone could point out
>> a portable and efficient way to check if a directory is already
>> empty I would be happy to use that to silence the "Cleaned
>> directory" message currently printed also when deinit is run on
>> an already empty directory.
> 
>    isemptydir() {
>         test -d "$(find $1 -maxdepth 0 -empty)"
>    }
> 
> Sorry for the late reply.  I see this patch is already in master
> (which is fine with me).

Thanks, I managed to miss that solution when googling for it.


 git-submodule.sh           | 35 +++++++++++++++++++----------------
 t/t7400-submodule-basic.sh |  8 ++++----
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..52ecbf1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -594,27 +594,30 @@ cmd_deinit()
 		die_if_unmatched "$mode"
 		name=$(module_name "$sm_path") || exit

-		# Remove the submodule work tree (unless the user already did it)
-		if test -d "$sm_path"
+		# Remove the submodule work tree (unless the user already did it or it is empty)
+		if test ! -d "$(find "$sm_path" -maxdepth 0 -empty)"
 		then
-			# Protect submodules containing a .git directory
-			if test -d "$sm_path/.git"
+			if test -d "$sm_path"
 			then
-				echo >&2 "$(eval_gettext "Submodule work tree '\$sm_path' contains a .git directory")"
-				die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
-			fi
+				# Protect submodules containing a .git directory
+				if test -d "$sm_path/.git"
+				then
+					echo >&2 "$(eval_gettext "Submodule work tree '\$sm_path' contains a .git directory")"
+					die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
+				fi

-			if test -z "$force"
-			then
-				git rm -qn "$sm_path" ||
-				die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"
+				if test -z "$force"
+				then
+					git rm -qn "$sm_path" ||
+					die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"
+				fi
+				rm -rf "$sm_path" &&
+				say "$(eval_gettext "Cleared directory '\$sm_path'")" ||
+				say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
 			fi
-			rm -rf "$sm_path" &&
-			say "$(eval_gettext "Cleared directory '\$sm_path'")" ||
-			say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
-		fi

-		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$sm_path'")"
+			mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$sm_path'")"
+		fi

 		# Remove the .git/config entries (unless the user already did it)
 		if test -n "$(git config --get-regexp submodule."$name\.")"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ff26535..b56e4a5 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -792,7 +792,7 @@ test_expect_success 'submodule deinit deinits a submodule when its work tree is
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
 	test_i18ngrep ! "Cleared directory .init" actual &&
-	test_i18ngrep "Cleared directory .example2" actual &&
+	test_i18ngrep ! "Cleared directory .example2" actual &&
 	rmdir init
 '

@@ -842,15 +842,15 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit init >actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_i18ngrep ! "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_i18ngrep ! "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_i18ngrep ! "Cleared directory .init" actual &&
 	rmdir init example2
 '

-- 
1.8.2.1.419.g33f67ba
