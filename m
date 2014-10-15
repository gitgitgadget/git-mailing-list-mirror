From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/25] mv test: recreate mod/ directory instead of relying on
 stale copy
Date: Tue, 14 Oct 2014 17:46:28 -0700
Message-ID: <20141015004628.GE32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:46:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCjc-0007dw-50
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592AbaJOAqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:46:32 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60806 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbaJOAqb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:46:31 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so233033pad.11
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ud06r4SGpwl0f/OZbMkpCsK7/zLPFER8Jtq7dASvtxs=;
        b=OLJtnju4huTZwo7mC4yytWDimbSZ4kE0uAJWKwno+Shrs2XuZAoyMMb6+AdoJPTNh7
         RYIZCOLP2IfeRLeoE48nqh8A5itVyN4g/gf8mG5AeeWX+JoMxcSoxvNWq9vCt9HQa24T
         YDGxPrvtgc2MjnByeznvJnDzgAYNgloUzxFnh6keP6IspmhzbWcVvUr2jrrlSn5OBzbs
         sbmMGy1G2PfHI8bfZIPaOGA6epCGkyQqF2Zt5LpcGD4SL+Riadxroj70lHeq5Bj3Camj
         eHGMx8CG7z2/YmdzRqMYYOo73bLqN4E7lro8n8oYYblmXgppUYDkGL3TS1bREhGYzRUJ
         UqUA==
X-Received: by 10.70.48.235 with SMTP id p11mr27090pdn.163.1413333991508;
        Tue, 14 Oct 2014 17:46:31 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id gu10sm15268957pbc.72.2014.10.14.17.46.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:46:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Wed, 10 Sep 2014 14:01:46 -0700

The tests for 'git mv moves a submodule' functionality often run
commands like

	git mv sub mod/sub

to move a submodule into a subdirectory.  Just like plain /bin/mv,
this is supposed to succeed if the mod/ parent directory exists
and fail if it doesn't exist.

Usually these tests mkdir the parent directory beforehand, but some
instead rely on it being left behind by previous tests.

More precisely, when 'git reset --hard' tries to move to a state where
mod/sub is not present any more, it would perform the following
operations:

	rmdir("mod/sub")
	rmdir("mod")

The first fails with ENOENT because the test script removed mod/sub
with "rm -rf" already, so 'reset --hard' doesn't bother to move on to
the second, and the mod/ directory is kept around.

Better to explicitly remove and re-create the mod/ directory so later
tests don't have to depend on the directory left behind by the earlier
ones at all (making it easier to rearrange or skip some tests in the
file or to tweak 'reset --hard' behavior without breaking unrelated
tests).

Noticed while testing a patch that fixes the reset --hard behavior
described above.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 t/t7001-mv.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 54d7807..69f11bd 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -350,10 +350,11 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 '
 
 test_expect_success 'git mv moves a submodule with gitfile' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	mkdir mod &&
 	(
 		cd mod &&
 		git mv ../sub/ .
@@ -372,11 +373,12 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 '
 
 test_expect_success 'mv does not complain when no .gitmodules file is found' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
 	git rm .gitmodules &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	! test -s actual.err &&
 	! test -e sub &&
@@ -390,11 +392,12 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 '
 
 test_expect_success 'mv will error out on a modified .gitmodules file unless staged' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
 	git config -f .gitmodules foo.bar true &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	mkdir mod &&
 	test_must_fail git mv sub mod/sub 2>actual.err &&
 	test -s actual.err &&
 	test -e sub &&
@@ -413,13 +416,14 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 '
 
 test_expect_success 'mv issues a warning when section is not found in .gitmodules' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
 	git config -f .gitmodules --remove-section submodule.sub &&
 	git add .gitmodules &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	echo "warning: Could not find section in .gitmodules where path=sub" >expect.err &&
+	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_i18ncmp expect.err actual.err &&
 	! test -e sub &&
@@ -433,9 +437,10 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 '
 
 test_expect_success 'mv --dry-run does not touch the submodule or .gitmodules' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
+	mkdir mod &&
 	git mv -n sub mod/sub 2>actual.err &&
 	test -f sub/.git &&
 	git diff-index --exit-code HEAD &&
-- 
2.1.0.rc2.206.gedb03e5
