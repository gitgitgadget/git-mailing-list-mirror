From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] submodule status: correct path handling in recursive submodules
Date: Tue, 29 Mar 2016 15:23:45 -0700
Message-ID: <1459290228-9069-4-git-send-email-sbeller@google.com>
References: <1459290228-9069-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 00:24:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al23V-0002JJ-LV
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071AbcC2WYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:24:04 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34085 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753AbcC2WX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:23:59 -0400
Received: by mail-pa0-f52.google.com with SMTP id fe3so24383492pab.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4gu1Vx/k991Gz2tvL3DZw5CFyffLn/zaRZ4nF6+Mqtk=;
        b=TjAs9zfbs7QnubnOeKNi1UIx7BhlEaBFFFcXEZTdCsvvpJuZ2pEvDdR6JxcPxDwJad
         k59Fqz3nkwsgLyKt74YiWN2n2UwDoefGqAXNMCaUwMiTZxjzeaejCtKZ15zIiCGbqLuP
         f20Pe3O5CdrQphvlzw+FDl6FclawG1w0jsAZbWsNFByeKSk7Zqu05DcJsosyYkU5WZrc
         xAtPG3MRI/3j2r81W0nzTHXU+un7hVY3XhBbAP5YvOS86QDTGbljfTOBJY52prwyJ/EF
         Krrl4JDjFaME6gI5JSlWueTNKLS5lINzDclbP5aCMu5p1yHXphurVISwLwWhHC1Z9FYf
         mY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4gu1Vx/k991Gz2tvL3DZw5CFyffLn/zaRZ4nF6+Mqtk=;
        b=TfrWThR0027vEGqUeHLiVeOlUQC4xeQWavu5KcR4IwIQMS4EAw3OZxBDirw76eiWmv
         Udt+eCtc8RNKs+L7cPl1io77805VPiDc8BQtsxB/EPs46ot0HrlYNjG+DSxcTvcZmEI1
         Baj63QWumYKqiV91tVQl4J2Ig9+I57TYkgGZ/5j7L17i4x1+d2Ld+qhp1HZAHkIMBtYy
         ip8d5Fhrtljvs9ouwd3qIBXP7rSRDlYAF/NVr0ZTLX3Qbd4xE9sAcTYDsTxGNK3E0j8f
         kTEuepziZ73L885ASdkEcPqFbxYZhweEIkoeevIyXlQ2slSOUzI7HTs6O7/DMjhG6td0
         udlA==
X-Gm-Message-State: AD7BkJIn1U0YOBbwprEfaPC8a5UwloojRH/DEKsphiEYgjdXUtUjdA6lxLjjFHrjH05H6qjo
X-Received: by 10.66.255.39 with SMTP id an7mr7429355pad.2.1459290238081;
        Tue, 29 Mar 2016 15:23:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id p85sm682244pfj.16.2016.03.29.15.23.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 15:23:57 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.4.g5639dee.dirty
In-Reply-To: <1459290228-9069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290204>

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
2.8.0.4.g5639dee.dirty
