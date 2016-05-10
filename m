From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/6] t1500: avoid changing working directory outside of tests
Date: Tue, 10 May 2016 01:20:52 -0400
Message-ID: <20160510052055.32924-4-sunshine@sunshineco.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:21:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b007H-0003v6-95
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbcEJFVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:21:44 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33320 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbcEJFVe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:21:34 -0400
Received: by mail-io0-f193.google.com with SMTP id x35so415365ioi.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zn/yDv4/bDx3JcIxjgJ5BgZsZvu2n9ZTdcKruYs8Ssc=;
        b=e7cpye+DVv266lDap9Rkv/pxIuKA8aFd3CzUarStVWBtVkj2X21kAALbquewdRfKbS
         hds0wwRlE3c91MOm6Lhg/RpwsFJXagQMrk6k6P8hTmIC2XePfsiXPco3CJ2l9bsFRp7J
         2LP1bgVJyXWXY+Jo0qr2L1VlEBkC3jV3FDqKH1wZdqGDCRYh904c/Sa2uTmXs3YCfe5x
         0aT/Y9eXfnMOjEW881FjbkAzfHrF1zBsee5hmpeLj19J3rAJ0rLJ4DFvxFSGiiUc5K1O
         4DuNdjwQCBhprhe94QzzjfsEsoRpI02Hi7UToNmzdz1B50XSGy0kYJbPfWVXCrLNhixr
         lcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Zn/yDv4/bDx3JcIxjgJ5BgZsZvu2n9ZTdcKruYs8Ssc=;
        b=DTIQNBwC2hInQFR4vGAXieCbG+l2YoVxMyohn+VeWCKwYmXlk11Z0Nd7qluoSR3kZ3
         HE08Q56bycAyEYt9inPBKLiWCswkbQDKcixcuA3SSx3dXDYB4yxnL5vw6Wd7EiQO9PGk
         4HZ1BZR6DHhUAxYhv1B0RuJ07Rs9iAMUAlabK+EqQpW2N7nBTFdG/EdbDyE/f5nA3Nii
         0PXHCzCCXwrlsfDxhU+X7/1hXNvb5l2MF0cnXKDEdHfN7YwoeQNgFPJR3hr3zwBspShx
         Zpdf78i0M9732euSfy9EyJMBGFxcD/DqpQgHEUIz7fGCpk0VDxlrqYyW8XzIPf/3QRFn
         HCXA==
X-Gm-Message-State: AOPr4FWb5x4l8Spgy2V2EReB1/6L0kyoaxce3+PShngXmf7soTp9OerAlRKxM+x1Ia1r6w==
X-Received: by 10.107.38.79 with SMTP id m76mr46402942iom.7.1462857693463;
        Mon, 09 May 2016 22:21:33 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id vu8sm458336igb.1.2016.05.09.22.21.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 22:21:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.530.g51d527d
In-Reply-To: <20160510052055.32924-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294090>

Ideally, each test should be responsible for setting up state it needs
rather than relying upon transient global state. Toward this end, teach
test_rev_parse() to accept a "-C <dir>" option to allow callers to
instruct it explicitly in which directory its tests should be run, and
take advantage of this new option to avoid changing the working
directory outside of tests.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 3d79568..f294ecc 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,8 +3,18 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
-# usage: label is-bare is-inside-git is-inside-work prefix git-dir
+# usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir
 test_rev_parse () {
+	dir=
+	while :
+	do
+		case "$1" in
+		-C) dir="-C $2"; shift; shift ;;
+		-*) error "test_rev_parse: unrecognized option '$1'" ;;
+		*) break ;;
+		esac
+	done
+
 	name=$1
 	shift
 
@@ -17,7 +27,7 @@ test_rev_parse () {
 		expect="$1"
 		test_expect_success "$name: $o" '
 			echo "$expect" >expect &&
-			git rev-parse --$o >actual &&
+			git $dir rev-parse --$o >actual &&
 			test_cmp expect actual
 		'
 		shift
@@ -29,16 +39,11 @@ ROOT=$(pwd)
 
 test_rev_parse toplevel false false true '' .git
 
-cd .git || exit 1
-test_rev_parse .git/ false true false '' .
-cd objects || exit 1
-test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
-cd ../.. || exit 1
+test_rev_parse -C .git .git/ false true false '' .
+test_rev_parse -C .git/objects .git/objects/ false true false '' "$ROOT/.git"
 
-mkdir -p sub/dir || exit 1
-cd sub/dir || exit 1
-test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
-cd ../.. || exit 1
+test_expect_success 'setup untracked sub/dir' 'mkdir -p sub/dir'
+test_rev_parse -C sub/dir subdirectory false false true sub/dir/ "$ROOT/.git"
 
 git config core.bare true
 test_rev_parse 'core.bare = true' true false false
@@ -46,32 +51,31 @@ test_rev_parse 'core.bare = true' true false false
 git config --unset core.bare
 test_rev_parse 'core.bare undefined' false false true
 
-mkdir work || exit 1
-cd work || exit 1
+test_expect_success 'setup non-local database ../.git' 'mkdir work'
 GIT_DIR=../.git
 GIT_CONFIG="$ROOT/work/../.git/config"
 export GIT_DIR GIT_CONFIG
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_rev_parse -C work 'GIT_DIR=../.git, core.bare = false' false false true ''
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
+test_rev_parse -C work 'GIT_DIR=../.git, core.bare = true' true false false ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_rev_parse -C work 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
-mv ../.git ../repo.git || exit 1
+test_expect_success 'setup non-local database ../repo.git' 'mv .git repo.git'
 GIT_DIR=../repo.git
 GIT_CONFIG="$ROOT/work/../repo.git/config"
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true ''
+test_rev_parse -C work 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
+test_rev_parse -C work 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
+test_rev_parse -C work 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
 test_done
-- 
2.8.2.530.g51d527d
