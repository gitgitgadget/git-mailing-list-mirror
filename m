From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/6] submodule status: correct path handling in recursive submodules
Date: Tue, 29 Mar 2016 18:27:43 -0700
Message-ID: <1459301266-12403-4-git-send-email-sbeller@google.com>
References: <1459301266-12403-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 03:28:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4ve-0004Eo-KE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbcC3B2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:28:09 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32784 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbcC3B1z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:27:55 -0400
Received: by mail-pa0-f51.google.com with SMTP id zm5so27426935pac.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2setqj13UITCbL8IAaxegg8yiVgyxVfPzq21vE98sYE=;
        b=jkStXBppjeK6Q+N1eJyGC7Q9Sjlcrb+7aI5bcCzZDLgLGnDl1qYmgQBUBck6xVfvFR
         GrUtMmjNOu+dJSspgBtdulTN85Vj0b+VVh9rHu1sJpeObuJ1G1hLl0wOWo+fOHMlW2sW
         rdhDBzO7YH4TWa2Lkm10VgXOqCvoVY1KTiF5SSZixOj2ZpYK8mKpR3WCFpOBoh2623JX
         9fdhSKzQ6dgrjiuH5iyGeizoDoO9gzXFmzt5DUMpPEIK4xfUIfCBm9+blFXWz463rFwc
         ziScneTXtM1PZ/ChCUnTNsTt7IoghrdTmm56sHG9UimTNHDcHjUYtPXijLZ1DDGSRk6e
         JGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2setqj13UITCbL8IAaxegg8yiVgyxVfPzq21vE98sYE=;
        b=gEDnKL7DIHEU8Z7yPD7jhAmx3L1F90Dw64nkdooaa7zcbp39xabuGjIA0q3ftsmf0T
         +ugtB9cFtRidE5habhFkJgdKWyWQGE+6gpHONVu5RA/ny3cEmFPUtSOZJGSl7r7voDtr
         /UsNxooKz5Veau2EHREhfgICqNxTURQQGAG88EdXhR3q6x6FZzDYCM8X1Sd1yAfJx5VQ
         e7zydjae8IdVPGCoWf1Ok3C+Ybx3NmqSTTqfRCNCGqQlclCDa360H38mDlKHZ8awv3NI
         gTg+GE8vVzql5NH+f9F14FuC11aMW1yvymaK6ESM3rJMC3ANIGn2ZVoXYbY+ciVy9Ars
         9WwA==
X-Gm-Message-State: AD7BkJKdCN2SABSw5MbIcPuMBHHWWdPWGw8gBDK0B5mUF368r86NiCt7M9l8s76bjvX58UFc
X-Received: by 10.66.65.137 with SMTP id x9mr8409640pas.137.1459301274880;
        Tue, 29 Mar 2016 18:27:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id f8sm1128937pfj.49.2016.03.29.18.27.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 18:27:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459301266-12403-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290257>

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
index 9fffa5c..1024774 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1159,6 +1159,7 @@ cmd_status()
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
2.8.0.2.gb331331
