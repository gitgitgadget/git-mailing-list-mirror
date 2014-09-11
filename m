From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/19] mv test: recreate mod/ directory instead of relying on
 stale copy
Date: Wed, 10 Sep 2014 20:04:03 -0700
Message-ID: <20140911030403.GE18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:04:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRug8-00083U-Sp
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbaIKDEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:04:08 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:51630 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbaIKDEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:04:07 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so10322072pdb.11
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q1mVz/8X9ScaB0Loai69Ew4vQAag6Uxxku+aYpJCNkM=;
        b=Bd9FuUYkLKm6jv4atvVyzCzDffPmmFZ016oIgC+D9IxHBi3WRq1Vz/JPXhRpzWLTIk
         D4Rbs3lRjbSpgkmdaN3PvhXtWMqm4FwajACDF+OkORTbCBDVZ9LoPz5fe2xEl7TERNBW
         fEQA1nbKaqhCVYnaVeGoAjP4TTCX+4eriJhvYGmwbGHTgq6ZDmsS+2nPvwRPm+cFfPe6
         s6RRjo8QDGVNuGjMXqlFUkC4sTuSNxw7F/4NrcsabB27Hv0Tx3HPTMaLq0oPjl4MTNl1
         N7R6Q8BpolTEPH95x4HQ0mvp96f7G8C8h64EhW4Nf081HQtHXCtggqabg7Yny05I3mkT
         jcxg==
X-Received: by 10.68.162.3 with SMTP id xw3mr8773267pbb.142.1410404646678;
        Wed, 10 Sep 2014 20:04:06 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id fn4sm16674829pab.39.2014.09.10.20.04.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:04:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256813>

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
