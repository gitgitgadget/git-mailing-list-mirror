From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule deinit: clarify work tree removal message
Date: Mon, 01 Apr 2013 21:02:00 +0200
Message-ID: <5159D9A8.30901@web.de>
References: <5112C6F6.4030607@web.de> <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com> <7v1ubk8u6o.fsf@alter.siamese.dyndns.org> <51477EFF.2010505@web.de> <7v7gl4mabf.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Mon Apr 01 21:03:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMk0Z-00058j-5F
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 21:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759189Ab3DATCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 15:02:38 -0400
Received: from mout.web.de ([212.227.17.11]:50834 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758668Ab3DATCh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 15:02:37 -0400
Received: from [192.168.178.41] ([91.3.147.157]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LsyOA-1UlJIm117y-011srR; Mon, 01 Apr 2013 21:02:35
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7v7gl4mabf.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:2SPJLE1p6Hoe0y3bDqpgQ2H8yIDqktDAxWOVrX6WC41
 Z+RQDhZaK9v1LVkWA0k5PxHEUE1KzJRcP3EbsMdZYUb2tbhhJV
 /+GVbEIvYhFd6tb5o5TRC0R2GLCLaHPRg/vd0ecmqpnYAJYsZw
 BUJhD77g2cqUBGPwchyuzDC6RQh0ZO5HXzY2oGMmd/0Qr3zo9E
 KH6Sc0U6WGhDXTNXnVitQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219701>

The output of "git submodule deinit sub" of a populated submodule prints

  rm 'sub'

as the first line unless used with the -f option.

The "rm 'sub'" line is exactly the same output the user gets when using
"git rm sub" (because that command is used with the --dry-run option under
the hood to determine if the submodule is clean), which can easily lead to
the false impression that the submodule would be permanently removed. Also
users might be confused that the "rm 'submodule'" line won't show up when
the -f option is used, as the test is skipped in this case.

Silence the "rm 'submodule'" output by using the --quiet option for "git
rm" and always print

  Cleared directory 'submodule'

instead as the first output line. This line is printed as long as the
directory exists, no matter if empty or not.

Also extend the tests in t7400 to make sure the "Cleared directory" line
is printed correctly.

Reported-by: Phil Hord <phil.hord@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Am 19.03.2013 02:45, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> Am 12.03.2013 17:22, schrieb Junio C Hamano:
>>> Phil Hord <phil.hord@gmail.com> writes:
>>>
>>>> I think this would be clearer if 'git deinit' said
>>>>
>>>>     rm 'submodule/*'
>>>>
>>>> or maybe
>>>>
>>>>     Removed workdir for 'submodule'
>>>>
>>>> Is it just me?
>>>
>>> The latter may probably be better.  
>>
>> Hmm, it doesn't really remove the directory but only empties it
>> (it recreates it a few lines after removing it together with its
>> contents). So what about
>>
>>     Cleared directory 'submodule'
> 
> Sounds the cleanest among the suggested phrasing so far.

Okay, so here is the patch for that. If someone could point out
a portable and efficient way to check if a directory is already
empty I would be happy to use that to silence the "Cleaned
directory" message currently printed also when deinit is run on
an already empty directory. Technically that is correct, as the
"rm -rf" is also executed, but I think it would be better to
skip the whole if block containing the "rm -rf" and "mkdir"
commands in that case as there is really nothing to do. Calling
"find" to see if there is anything inside the directory sounds
too expensive to me, as the directory will contain a lot of
files sometimes. But maybe this should be done in another patch.


 git-submodule.sh           |  6 ++++--
 t/t7400-submodule-basic.sh | 21 ++++++++++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 204bc78..d003e8a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -601,10 +601,12 @@ cmd_deinit()

 			if test -z "$force"
 			then
-				git rm -n "$sm_path" ||
+				git rm -qn "$sm_path" ||
 				die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"
 			fi
-			rm -rf "$sm_path" || say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
+			rm -rf "$sm_path" &&
+			say "$(eval_gettext "Cleared directory '\$sm_path'")" ||
+			say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
 		fi

 		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$sm_path'")"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5030f1f..ff26535 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -777,18 +777,22 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
 	git config submodule.example.foo bar &&
 	git config submodule.example2.frotz nitfol &&
 	test_must_fail git submodule deinit &&
-	git submodule deinit . &&
+	git submodule deinit . >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
+	test_i18ngrep "Cleared directory .init" actual &&
+	test_i18ngrep "Cleared directory .example2" actual &&
 	rmdir init example2
 '

 test_expect_success 'submodule deinit deinits a submodule when its work tree is missing or empty' '
 	git submodule update --init &&
 	rm -rf init example2/* example2/.git &&
-	git submodule deinit init example2 &&
+	git submodule deinit init example2 >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
+	test_i18ngrep ! "Cleared directory .init" actual &&
+	test_i18ngrep "Cleared directory .example2" actual &&
 	rmdir init
 '

@@ -798,8 +802,9 @@ test_expect_success 'submodule deinit fails when the submodule contains modifica
 	test_must_fail git submodule deinit init &&
 	test -n "$(git config --get-regexp "submodule\.example\.")" &&
 	test -f example2/.git &&
-	git submodule deinit -f init &&
+	git submodule deinit -f init >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init
 '

@@ -809,8 +814,9 @@ test_expect_success 'submodule deinit fails when the submodule contains untracke
 	test_must_fail git submodule deinit init &&
 	test -n "$(git config --get-regexp "submodule\.example\.")" &&
 	test -f example2/.git &&
-	git submodule deinit -f init &&
+	git submodule deinit -f init >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init
 '

@@ -823,8 +829,9 @@ test_expect_success 'submodule deinit fails when the submodule HEAD does not mat
 	test_must_fail git submodule deinit init &&
 	test -n "$(git config --get-regexp "submodule\.example\.")" &&
 	test -f example2/.git &&
-	git submodule deinit -f init &&
+	git submodule deinit -f init >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init
 '

@@ -832,14 +839,18 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	git submodule update --init &&
 	git submodule deinit init >actual &&
 	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit init >actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init example2
 '

-- 
1.8.2.358.g5c06bcf
