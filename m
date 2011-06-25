From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] submodule sync: do not auto-vivify uninteresting submodule
Date: Sat, 25 Jun 2011 22:41:25 +0200
Message-ID: <4E0647F5.2070802@web.de>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com> <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E0390A7.8040505@web.de> <7vboxo2ne9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Maarten Billemont <lhunath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Andreas_K=F6hler?= <andi5.py@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 25 22:44:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QaZin-0003It-U4
	for gcvg-git-2@lo.gmane.org; Sat, 25 Jun 2011 22:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab1FYUl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jun 2011 16:41:28 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:48517 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1FYUl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2011 16:41:27 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id B85811A3BDDD9;
	Sat, 25 Jun 2011 22:41:25 +0200 (CEST)
Received: from [93.246.44.86] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QaZfR-00051k-00; Sat, 25 Jun 2011 22:41:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vboxo2ne9.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19CMede4Mvv0IrdvNRk3q1V9MC8VhJaYlwwS+3c
	kuUR8FcM8+SoyqGGoIgJaSVJXXl+IVPF11bzdtb0Zrcts40ZP0
	OHEnM98cwIbYhHR8RN+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176319>

From: Junio C Hamano <gitster@pobox.com>

Earlier 33f072f (submodule sync: Update "submodule.<name>.url" for empty
directories, 2010-10-08) attempted to fix a bug where "git submodule sync"
command does not update the URL if the current superproject does not have
a checkout of the submodule.

However, it did so by unconditionally registering submodule.$name.url to
every submodule in the project, even the ones that the user has never
showed interest in at all by running 'git submodule init' command. This
caused subsequent 'git submodule update' to start cloning/updating submodules
that are not interesting to the user at all.

Update the code so that the URL is updated from the .gitmodules file only
for submodules that already have submodule.$name.url entries, i.e. the
ones the user has showed interested in having a checkout.

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Am 24.06.2011 00:28, schrieb Junio C Hamano:
> Actually, shouldn't the fix be more like this patch, which is directly on
> top of 33f072f?  I think this is more in line with what the end user wants
> to tell the system with "submodule init", namely "I am interested in this
> submodule".

Yes, I am convinced your patch is the doing Right Thing. I squashed in a
change to the git submodule sync documentation (explicitly stating that a
sync only affects submodules which have an url entry in .git/config) and
two more lines in the test you added to make sure that explicitly giving
a submodule on the command line uses the same logic.

What do you think?

(I'll send another patch shortly addressing the failing tests when
jl/submodule-add-relurl-wo-upstream is merged into this one)


 Documentation/git-submodule.txt |    4 +++-
 git-submodule.sh                |   23 +++++++++++++----------
 t/t7403-submodule-sync.sh       |   15 +++++++++++++--
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 5e7a413..2b31d5f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -167,7 +167,9 @@ commit for each submodule.

 sync::
 	Synchronizes submodules' remote URL configuration setting
-	to the value specified in .gitmodules.  This is useful when
+	to the value specified in .gitmodules. It will only affect those
+	submodules which already have an url entry in .git/config (that is the
+	case when they are initialized or freshly added). This is useful when
 	submodule URLs change upstream and you need to update your local
 	repositories accordingly.
 +
diff --git a/git-submodule.sh b/git-submodule.sh
index d189a24..543f1d0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -874,17 +874,20 @@ cmd_sync()
 			;;
 		esac

-		say "Synchronizing submodule url for '$name'"
-		git config submodule."$name".url "$url"
-
-		if test -e "$path"/.git
+		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
-		(
-			clear_local_git_env
-			cd "$path"
-			remote=$(get_default_remote)
-			git config remote."$remote".url "$url"
-		)
+			say "Synchronizing submodule url for '$name'"
+			git config submodule."$name".url "$url"
+
+			if test -e "$path"/.git
+			then
+			(
+				clear_local_git_env
+				cd "$path"
+				remote=$(get_default_remote)
+				git config remote."$remote".url "$url"
+			)
+			fi
 		fi
 	done
 }
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index d600583..95ffe34 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -25,7 +25,8 @@ test_expect_success setup '
 	git clone super super-clone &&
 	(cd super-clone && git submodule update --init) &&
 	git clone super empty-clone &&
-	(cd empty-clone && git submodule init)
+	(cd empty-clone && git submodule init) &&
+	git clone super top-only-clone
 '

 test_expect_success 'change submodule' '
@@ -66,7 +67,7 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	)
 '

-test_expect_success '"git submodule sync" should update submodule URLs if not yet cloned' '
+test_expect_success '"git submodule sync" should update known submodule URLs' '
 	(cd empty-clone &&
 	 git pull &&
 	 git submodule sync &&
@@ -74,4 +75,14 @@ test_expect_success '"git submodule sync" should update submodule URLs if not ye
 	)
 '

+test_expect_success '"git submodule sync" should not vivify uninteresting submodule' '
+	(cd top-only-clone &&
+	 git pull &&
+	 git submodule sync &&
+	 test -z "$(git config submodule.submodule.url)" &&
+	 git submodule sync submodule &&
+	 test -z "$(git config submodule.submodule.url)"
+	)
+'
+
 test_done
-- 
1.7.6.rc3.1.g8fd6
