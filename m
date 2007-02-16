From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [PATCH/RFC 1/3] t/t5515-fetch-merge-logic.sh: Added tests for the merge login in git-fetch
Date: Fri, 16 Feb 2007 09:23:02 +0100
Message-ID: <87mz3eo6jd.fsf@gmail.com>
References: <874ppmplw7.fsf@gmail.com> <87zm7eo78x.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 09:23:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHyNJ-0000OV-5O
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 09:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966203AbXBPIXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 03:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966206AbXBPIXU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 03:23:20 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:48090 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966203AbXBPIXT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 03:23:19 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l1G8NAB05154
	for <git@vger.kernel.org>; Fri, 16 Feb 2007 09:23:13 +0100
In-Reply-To: <87zm7eo78x.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 16 Feb
	2007 09:07:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39905>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi *,

   I think it didn't get to the list due to the size limit. So I send it
   as a gziped attatchment, with the test inline.

Regards,

Santi

---
 t/t5515-fetch-merge-logic.sh                       |  124 ++++++++++++++++++++

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
new file mode 100755
index 0000000..8d8a71f
--- /dev/null
+++ b/t/t5515-fetch-merge-logic.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Santi Béjar, based on t4013 by Junio C Hamano
+#
+#
+
+test_description='Merge logic in fetch'
+
+. ./test-lib.sh
+
+LF='
+'
+
+test_expect_success setup '
+	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
+	GIT_COMMITTER_DATE="2006-06-26 00:00:00 +0000" &&
+	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
+
+	echo >file original &&
+	git add file &&
+	git commit -a -m One &&
+	git branch one &&
+
+	echo two >> file &&
+	git commit -a -m Two &&
+	git branch two &&
+
+	echo three >> file &&
+	git commit -a -m Three &&
+	git branch three &&
+
+	echo master >> file &&
+	git commit -a -m Master
+
+	git checkout three
+
+	git clone . cloned &&
+	cd cloned &&
+
+	git config remote.config-explicit.url ../.git/ &&
+	git config remote.config-explicit.fetch refs/heads/master:remotes/rem/master &&
+	git config --add remote.config-explicit.fetch refs/heads/one:remotes/rem/one &&
+	git config --add remote.config-explicit.fetch two:remotes/rem/two &&
+	git config --add remote.config-explicit.fetch refs/heads/three:remotes/rem/three &&
+
+	git config remote.config-glob.url ../.git/ &&
+	git config remote.config-glob.fetch refs/heads/*:refs/remotes/rem/* &&
+
+	mkdir -p .git/remotes &&
+	{
+		echo "URL: ../.git/"
+		echo "Pull: refs/heads/master:remotes/rem/master"
+		echo "Pull: refs/heads/one:remotes/rem/one"
+		echo "Pull: two:remotes/rem/two"
+		echo "Pull: refs/heads/three:remotes/rem/three"
+	} >.git/remotes/remote-explicit &&
+
+	{
+		echo "URL: ../.git/"
+		echo "Pull: refs/heads/*:refs/remotes/rem/*"
+	} >.git/remotes/remote-glob &&
+
+	mkdir -p .git/branches &&
+	echo "../.git" > .git/branches/branches-default &&
+	echo "../.git#one" > .git/branches/branches-one &&
+
+	for remote in config-explicit config-glob remote-explicit remote-glob \
+		branches-default branches-one ; do
+		git config branch.br-$remote.remote $remote &&
+		git config branch.br-$remote-merge.remote $remote &&
+		git config branch.br-$remote-merge.merge refs/heads/three &&
+		git config branch.br-$remote-octopus.remote $remote &&
+		git config branch.br-$remote-octopus.merge refs/heads/one &&
+		git config --add branch.br-$remote-octopus.merge two &&
+		git config --add branch.br-$remote-octopus.merge remotes/rem/three &&
+		branches="$branches br-$remote br-$remote-merge br-$remote-octopus"
+	done
+'
+
+for branch in br-unconfig $branches ; do
+    echo $branch
+    for remote in config-explicit config-glob remote-explicit remote-glob \
+	branches-default branches-one ../.git
+    do
+cat <<EOF
+$branch $remote
+$branch $remote one
+$branch $remote one two
+EOF
+    done
+done > tests
+
+while read cmd
+do
+	case "$cmd" in
+	'' | '#'*) continue ;;
+	esac
+	test=`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
+	cnt=`expr $test_count + 1`
+	pfx=`printf "%04d" $cnt`
+	expect="../../t5515/fetch.$test"
+	actual="$pfx-fetch.$test"
+
+	test_expect_success "$cmd" '
+		{
+			echo "# $cmd"
+			set x $cmd; shift
+			git symbolic-ref HEAD refs/heads/$1 ; shift
+			git fetch "$@" >/dev/null
+			cut -f -2 .git/FETCH_HEAD
+		} >"$actual" &&
+		if test -f "$expect"
+		then
+			diff -u "$expect" "$actual" &&
+			rm -f "$actual"
+		else
+			# this is to help developing new tests.
+			cp "$actual" "$expect"
+			false
+		fi
+	'
+done < tests
+
+test_done


--=-=-=
Content-Type: application/x-gzip
Content-Disposition: attachment;
 filename*0*=us-ascii''0001-t-t5515-fetch-merge-logic.sh-Added-tests-for-t;
 filename*1*=he-merge-login-in-git-fetch.patch.gz
Content-Transfer-Encoding: base64

H4sICMBj1UUAAzAwMDEtdC10NTUxNS1mZXRjaC1tZXJnZS1sb2dpYy5zaC1BZGRlZC10ZXN0cy1m
b3ItdGhlLW1lcmdlLWxvZ2luLWluLWdpdC1mZXRjaC5wYXRjaADtfWuX3MaR5WfzV2Ap7Whsqpt4
PziWLFm21rNnfDzH1nyanUPjkSDbQ3Zz2c21fVb7g+Z3zB9bVPWD1VWJzBs3siB4VDy0ZHUj8hFI
3IjMe4H49v3V2yhpyritTVx1bdc0ZVIPXV2Ndd83nen7LE3ise27aoh+e3UZ/cG8i5IqiuMX279R
GsfJk2+nZl5EX/ziw814Vv/if//iD+3lzcXLX37xTfbF182f2ve/+CL6+XVnpv/31au37cWb8/7q
7ZdPftXemBfRd68/fB4lRfSt6TaNVVFSvsiaF0UWPYuTOH7yhw/dn0x/8yL613/++rtvfvP8999+
EyXPs3+Lbp7fFEVSnI3mpn999ta8f2XO3ly9uujPr1+/iL4eBjNEN+b65joar95HN69NtL0m2lxz
GU1/X13c3Bo/efLkDxevLs1wdjWOZ91fX0TbCUS//M//mIZsG/rZ2dkT5wAi+5/voyhJ8+iZ5c9D
e8+37Z1378+69+1l/9pcnw1mbD+8ubG2F0VphBjfDlBl/PL8/OX55LXHxufn56jhy6tLc2AssH15
8+erW+Pszthje+DBRz0LDLcjf2QsMDwcttdhDz++9dijngWmh8MWGB4O2zfq/upyvHh1Zv7y7s1F
f3Hn7eLOWGB4OGyBIeHtu1ZevbnqHpZnIZvzxvZw2AJDubffm7dXN4bw9p4h7m2LIeHtu1Yob+/Y
yry9Z7g3bD8AXvU3V+8+XHPoeWf8ET9R9NwzvMXPR8YCy8Nb5bF1o6fA8PBWCQxFK+ygoYOeBYaH
wxYYHg7bN2YnegoMLcPGDSlvP8LPR8MWWNpCLGwo97YTPQWGuLe16LnXDuFtJ3oKDKXouZs4itFz
P3mkjbejFg3bDYACw0NvCwzF3t5LHmUOcwOgwFA87H38e7y2cUM8SgIACA/7Pp3ZHbbI2DJs3FC+
tvfxD/a2Df8wb/sBEB425+19/IO9bcM/aNgPmLX/B3kkJ+PDXbvYeB98KWPrzh01vHVX5A10H40t
Jx/uLfC8qWcL7DaEl6elGcvOHTZ8iWz7502htOKj+QHwejdls7a+TZnTkPC2a+eOGoKnUrO2Qm8f
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
s+L8Vbv57syT/w/rIHNyEV8DAA==
--=-=-=--
