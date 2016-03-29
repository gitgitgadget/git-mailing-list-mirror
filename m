From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] submodule status: correct path handling in recursive submodules
Date: Tue, 29 Mar 2016 16:02:35 -0700
Message-ID: <1459292558-5840-4-git-send-email-sbeller@google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 01:03:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2fH-0000cT-VT
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355AbcC2XDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:03:00 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35549 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbcC2XCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:02:49 -0400
Received: by mail-pa0-f41.google.com with SMTP id td3so24682764pab.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 16:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQin+kyHZUrGvdaQxmfDPHJJ5hDZFj+gJqoNVGHNi94=;
        b=IEpkZ7eWe/3VEOWzphlNReAZc3RS3qebJAmO67d0EtXl0WDRmfSWbtzZTFNcQfDaWN
         Tn2fLgmPE2LMfEJy6OGAxJIlx6pKFRuznLE/2NAl8arhb6N0m/YN+pi0DPLj2D02z6w3
         wVpEZeAfhXKRUjTJf6hss9hlq37aEXQuraZEtdbnqMOL40xu51E+aARSo5WJQVcZvCLq
         CyyCt6jqP0x6oOCq58+Auv8O1pcFTg4sr3pqLdp8ua3vLt2b94aZjX7Uxe27ZctgZgtS
         3vtUh/jk/xVOU8NCs0E2Q2SQ8O13SL8jNOe943K0Q/x8zbhTtA7BPDo9x3FvYeJ9YdDm
         CbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQin+kyHZUrGvdaQxmfDPHJJ5hDZFj+gJqoNVGHNi94=;
        b=OhtJf9+16Bz5edzOauy6uQCA4hIggdsfXa3vCBeUqzyhGs9jaHsLXBf3q3hLIkL39D
         N0iEi87uazo9WifSPpEcdgblPCnDlG8DkL9wqfOOv4UJBIra4maCklLiiWplnYo9jTz5
         f75clUjAuQ13OuI8hPFLI1Iw6PwL0nsp8EX+6wLYCbXMgLynS21NrlgZEAGb6HQ/d4Hw
         M3hPAlRaV5wfCJaAJjwo9GoxmdgWJCx7qNE1S5GQZVxsHI4moVdI0HZAIxZA/wZRMksX
         NED+d1ECh2EbRTqq705zTpa+yeHhFNSkQQ1ilZU0OihTO2eAHTd0hZpA2rAKCmX/hIr/
         aa0Q==
X-Gm-Message-State: AD7BkJKb9o1PQC+f7MmeqOIpem9q4ahZg0gBmaqm6l73+NV6HgzyfBio6QrXJbvuiGtJ5MGT
X-Received: by 10.66.164.39 with SMTP id yn7mr7536319pab.107.1459292568458;
        Tue, 29 Mar 2016 16:02:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id t87sm750373pfa.54.2016.03.29.16.02.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 16:02:47 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g3d0b0ba
In-Reply-To: <1459292558-5840-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290219>

The new test which is a replica of the previous test except
that it executes from a sub directory. Prior to this patch
the test failed by having too many '../' prefixed:

  --- expect	2016-03-29 19:02:33.087336115 +0000
  +++ actual	2016-03-29 19:02:33.359343311 +0000
  @@ -1,7 +1,7 @@
    b23f134787d96fae589a6b76da41f4db112fc8db ../nested1 (heads/master)
  -+25d56d1ddfb35c3e91ff7d8f12331c2e53147dcc ../nested1/nested2 (file2)
  - 5ec83512b76a0b8170b899f8e643913c3e9b72d9 ../nested1/nested2/nested3 (heads/master)
  - 509f622a4f36a3e472affcf28fa959174f3dd5b5 ../nested1/nested2/nested3/submodule (heads/master)
  ++25d56d1ddfb35c3e91ff7d8f12331c2e53147dcc ../../nested1/nested2 (file2)
  + 5ec83512b76a0b8170b899f8e643913c3e9b72d9 ../../../nested1/nested2/nested3 (heads/master)
  + 509f622a4f36a3e472affcf28fa959174f3dd5b5 ../../../../nested1/nested2/nested3/submodule (heads/master)
    0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f ../sub1 (0c90624)
    0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f ../sub2 (0c90624)
    509f622a4f36a3e472affcf28fa959174f3dd5b5 ../sub3 (heads/master)

The path code in question:
  displaypath=$(relative_path "$prefix$sm_path")
  prefix=$displaypath
  if recursive:
    eval cmd_status

That way we change `prefix` each iteration to contain another
'../', because of the the relative_path computation is done
on an already computed relative path.

We must call relative_path exactly once with `wt_prefix` non empty.
Further calls in recursive instances to to calculate the displaypath
already incorporate the correct prefix from before. Fix the issue by
clearing `wt_prefix` in recursive calls.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh             |  1 +
 t/t7407-submodule-foreach.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index fdb5fbd..11ed32a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1160,6 +1160,7 @@ cmd_status()
 			(
 				prefix="$displaypath/"
 				clear_local_git_env
+				wt_prefix=
 				cd "$sm_path" &&
 				eval cmd_status
 			) ||
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 776b349..4b35e12 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -277,6 +277,27 @@ test_expect_success 'ensure "status --cached --recursive" preserves the --cached
 	test_cmp expect actual
 '
 
+nested2sha1=$(git -C clone3/nested1/nested2 rev-parse HEAD)
+
+cat > expect <<EOF
+ $nested1sha1 ../nested1 (heads/master)
++$nested2sha1 ../nested1/nested2 (file2)
+ $nested3sha1 ../nested1/nested2/nested3 (heads/master)
+ $submodulesha1 ../nested1/nested2/nested3/submodule (heads/master)
+ $sub1sha1 ../sub1 ($sub1sha1_short)
+ $sub2sha1 ../sub2 ($sub2sha1_short)
+ $sub3sha1 ../sub3 (heads/master)
+EOF
+
+test_expect_success 'test "status --recursive" from sub directory' '
+	(
+		cd clone3 &&
+		mkdir tmp && cd tmp &&
+		git submodule status --recursive > ../../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'use "git clone --recursive" to checkout all submodules' '
 	git clone --recursive super clone4 &&
 	(
-- 
2.8.0.6.g3d0b0ba
