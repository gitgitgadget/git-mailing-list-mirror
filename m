From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Feb 2013, #03; Wed, 6)
Date: Wed, 06 Feb 2013 20:25:40 +0100
Message-ID: <5112AE34.6080107@web.de>
References: <7v8v71cn3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:26:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3AdD-0003Ei-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 20:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757790Ab3BFTZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 14:25:44 -0500
Received: from mout.web.de ([212.227.15.3]:51652 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757553Ab3BFTZn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 14:25:43 -0500
Received: from [192.168.178.41] ([79.193.84.147]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LnB1F-1UbPZp2A6H-00hnNA; Wed, 06 Feb 2013 20:25:40
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v8v71cn3m.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:BKcLX5GA8txxjnbkZgG0O0N/V90pzvJg6N2lXORbUJj
 LDPxWH4qQeKe229CcUSq6g/C76Co2sL0id+OH7yuhql8L3/XCw
 RdK5eCgtmocEAYaJFkIhvqv1moQcwnBe1SJ0RgYTmxjzFclqqT
 G5VdqCZGiEc7oJpRbWq4a42U7GvKm1o0zNuM15mStHDI1LgJ2m
 y83NLUsenr3DCTXk/CPAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215624>

Am 06.02.2013 19:29, schrieb Junio C Hamano:
> * jl/submodule-deinit (2013-02-04) 1 commit
>  - submodule: add 'deinit' command
> 
>  There was no Porcelain way to say "I no longer am interested in
>  this submodule", once you express your interest in a submodule with
>  "submodule init".  "submodule deinit" is the way to do so.
> 
>  Will merge to 'next'.

Oops, I though you were waiting for a reroll. Currently I'm having the
appended interdiff compared to your version. Changes are:

- Add deinit to the --force documentation of "git submodule"
- Never remove submodules containing a .git dir, even when forced
- diagnostic output when "rm -rf" or "mkdir" fails
- More test cases

And I wanted to add three more test cases for modified submodules before
sending v4. You could squash in the first two hunks into the commit you
have in pu and I'll send a follow up patch with the extra tests soon or
you could wait for me sending an updated patch. What do you think?

---------------8<------------------
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 7a149eb..45ee12b 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -227,8 +227,10 @@ OPTIONS

 -f::
 --force::
-	This option is only valid for add and update commands.
+	This option is only valid for add, deinit and update commands.
 	When running add, allow adding an otherwise ignored submodule path.
+	When running deinit the submodule work trees will be removed even if
+	they contain local changes.
 	When running update, throw away local changes in submodules when
 	switching to a different commit; and always run a checkout operation
 	in the submodule, even if the commit listed in the index of the
diff --git a/git-submodule.sh b/git-submodule.sh
index f05b597..365c6de 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -595,14 +595,25 @@ cmd_deinit()
 			continue
 		fi

-		# Remove the submodule work tree
-		if test -z "$force"
+		# Remove the submodule work tree (unless the user already did it)
+		if test -d "$sm_path"
 		then
-			git rm -n "$sm_path" ||
-			die "$(eval_gettext "Submodule work tree $sm_path contains local modifications, use '-f' to discard them")"
+			# Protect submodules containing a .git directory
+			if test -d "$sm_path/.git"
+			then
+				echo >&2 "$(eval_gettext "Submodule work tree $sm_path contains a .git directory")"
+				die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
+			fi
+
+			if test -z "$force"
+			then
+				git rm -n "$sm_path" ||
+				die "$(eval_gettext "Submodule work tree $sm_path contains local modifications, use '-f' to discard them")"
+			fi
+			rm -rf "$sm_path" || say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
 		fi
-		rm -rf "$sm_path"
-		mkdir "$sm_path"
+
+		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$sm_path'")"

 		# Remove the whole section so we have a clean state when the
 		# user later decides to init this submodule again
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 34d8274..0567f1a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -757,20 +757,46 @@ test_expect_success 'submodule add with an existing name fails unless forced' '
 	)
 '

+test_expect_success 'set up a second submodule' '
+	git submodule add ./init2 example2 &&
+	git commit -m "submodle example2 added"
+'
+
 test_expect_success 'submodule deinit should remove the whole submodule section from .git/config' '
 	git config submodule.example.foo bar &&
+	git config submodule.example2.frotz nitfol &&
 	git submodule deinit init &&
 	test -z "$(git config submodule.example.url)" &&
-	test -z "$(git config submodule.example.foo)"
+	test -z "$(git config submodule.example.foo)" &&
+	test -n "$(git config submodule.example2.url)" &&
+	test -n "$(git config submodule.example2.frotz)" &&
+	rmdir init
 '

 test_expect_success 'submodule deinit . deinits all initialized submodules' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
+	git config submodule.example2.frotz nitfol &&
 	test_must_fail git submodule deinit &&
 	git submodule deinit . &&
 	test -z "$(git config submodule.example.url)" &&
-	test -z "$(git config submodule.example.foo)"
+	test -z "$(git config submodule.example.foo)" &&
+	test -z "$(git config submodule.example2.url)" &&
+	test -z "$(git config submodule.example2.frotz)" &&
+	rmdir init example2
+'
+
+test_expect_success 'submodule deinit deinits a submodule when its work tree is missing or empty' '
+	git submodule update --init &&
+	rm -rf init example2/* example2/.git &&
+	git config submodule.example.foo bar &&
+	git config submodule.example2.frotz nitfol &&
+	git submodule deinit init example2 &&
+	test -z "$(git config submodule.example.url)" &&
+	test -z "$(git config submodule.example.foo)" &&
+	test -z "$(git config submodule.example2.url)" &&
+	test -z "$(git config submodule.example2.frotz)" &&
+	rmdir init
 '

 test_expect_success 'submodule deinit complains when explicitly used on an uninitialized submodule' '
@@ -778,7 +804,24 @@ test_expect_success 'submodule deinit complains when explicitly used on an unini
 	git submodule deinit init >actual &&
 	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" actual
 	git submodule deinit init >actual &&
-	test_i18ngrep "No url found for submodule path .init. in .git/config" actual
+	test_i18ngrep "No url found for submodule path .init. in .git/config" actual &&
+	git submodule deinit . >actual &&
+	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual
+	rmdir init example2
+'
+
+test_expect_success 'submodule deinit fails when submodule has a .git directory even when forced' '
+	git submodule update --init &&
+	(
+		cd init &&
+		rm .git &&
+		cp -R ../.git/modules/example .git &&
+		GIT_WORK_TREE=. git config --unset core.worktree
+	) &&
+	test_must_fail git submodule deinit init &&
+	test_must_fail git submodule deinit -f init &&
+	test -d init/.git &&
+	test -n "$(git config submodule.example.url)"
 '

 test_done
