From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] submodule foreach: correct path display in recursive submodules
Date: Tue, 29 Mar 2016 16:02:33 -0700
Message-ID: <1459292558-5840-2-git-send-email-sbeller@google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 01:02:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2ey-0000Sj-Lc
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbcC2XCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:02:48 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36675 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbcC2XCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:02:47 -0400
Received: by mail-pa0-f53.google.com with SMTP id tt10so24844559pab.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GsydnTrKdTapzye1u9Br/2s0K9SMPhgYBAPdWJ0h9TI=;
        b=bgdoes++74uK7KGm6g0KI1RLbZzil1GoSHDtcnxoMhEivdil8vnYThG+drkjdCjQUa
         tZh5OtvIxFm8wKZycgoFI54u7gZaF7vn1gg1cgbt/Cl35Q8mDRlH1t5BzCZtSydJ3uT1
         QUbH+JIbkVDI3g3dr6qE5OcNRzDX/P/5t/5yOjB/MYROB6W45eQ3xc3d/QALD3+avart
         aJs+pNCNf+UPQwd07wpBjbz9daP+zNYPJzcvo+rlZU4R5dlbFCMat1Xjdut8HPm31eG0
         kP7lwsNWi2OExtrYZVsG6z6vt2HeAfLZUuVL7tTi1d7Dxue6CFu2g2CFVJ2uvBv+eUu5
         r67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GsydnTrKdTapzye1u9Br/2s0K9SMPhgYBAPdWJ0h9TI=;
        b=FTAGBEUEen0+OlJKBFNEcLOrfbzIYNwEFMrHtLj9ZMcpSPQO5CRt7qP175mOSc53Hk
         gRUADMGc/mGDRc1Po/YHmrptW0Cu+ldl48a8mC+/fXtj0DtGwk7FU8xcb5gGdgAafCYh
         X6EGEdEaZhv2g0qN95QeXyp+1yfZSxphB8GkicUAuAq6YiE27/gio+IRIlyDRaKLMnD0
         lWK+UWf4ayXVrY63s3MFvceGBy+GBzQqxTmV8SCQtfG0f14RlIx2WES+zsNhOMbhq1tZ
         5wxX4uIwTRRKUdRqb9OxCyxcGk5Mm8wvEP/gAoudv31G/iFRfr6oQm1gMLT33q2yZ6yH
         9/eg==
X-Gm-Message-State: AD7BkJKzbGeqqEKAcjDuwsHPNOYzYQBrGucAsfLlxQU5udGFdEhDFntSW0SWznQ7uzLfUzws
X-Received: by 10.66.66.108 with SMTP id e12mr7610532pat.33.1459292565888;
        Tue, 29 Mar 2016 16:02:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id p75sm768609pfi.29.2016.03.29.16.02.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 16:02:45 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g3d0b0ba
In-Reply-To: <1459292558-5840-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290215>

The new test replicates the previous test with the difference of executing
from a sub directory. By executing from a sub directory all we would
expect all displayed paths to be prefixed by '../'.

Prior to this patch the test would report
    Entering 'nested1/nested2/../nested3'
instead of the expected
    Entering '../nested1/nested2/nested3'

because the prefix is put unconditionally in front and after that a
computed display path with is affected by `wt_prefix`. This is wrong as
any relative path computation would need to be at the front. By emptying
the `wt_prefix` in recursive submodules and adding the information of any
relative path into the `prefix` this is fixed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh             |  3 ++-
 t/t7407-submodule-foreach.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 43c68de..2838069 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -417,10 +417,11 @@ cmd_foreach()
 			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
 			name=$(git submodule--helper name "$sm_path")
 			(
-				prefix="$prefix$sm_path/"
+				prefix="$(relative_path $prefix$sm_path)/"
 				clear_local_git_env
 				cd "$sm_path" &&
 				sm_path=$(relative_path "$sm_path") &&
+				wt_prefix=
 				# we make $path available to scripts ...
 				path=$sm_path &&
 				if test $# -eq 1
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 7ca10b8..776b349 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -178,6 +178,26 @@ test_expect_success 'test messages from "foreach --recursive"' '
 '
 
 cat > expect <<EOF
+Entering '../nested1'
+Entering '../nested1/nested2'
+Entering '../nested1/nested2/nested3'
+Entering '../nested1/nested2/nested3/submodule'
+Entering '../sub1'
+Entering '../sub2'
+Entering '../sub3'
+EOF
+
+test_expect_success 'test messages from "foreach --recursive" from subdirectory' '
+	(
+		cd clone2 &&
+		mkdir untracked &&
+		cd untracked &&
+		git submodule foreach --recursive >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
+cat > expect <<EOF
 nested1-nested1
 nested2-nested2
 nested3-nested3
-- 
2.8.0.6.g3d0b0ba
