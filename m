From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] submodule foreach: correct path computation in recursive submodules
Date: Mon, 28 Mar 2016 16:28:18 -0700
Message-ID: <1459207703-1635-3-git-send-email-sbeller@google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 29 01:28:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akgaK-0004rF-Af
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 01:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbcC1X2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 19:28:32 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36791 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbcC1X23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 19:28:29 -0400
Received: by mail-pa0-f41.google.com with SMTP id tt10so109074291pab.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 16:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pTIPfR6E3VHpjEGABCslOJhUnK8tnZlqgxHn44Parco=;
        b=PGCTea0qNnmmMAVhb1HVWYxl6J7MLZrYr4gD83kXD94UjwZVU4MBv/LZBJLnwQnRI8
         2+EBlaXFrkKG14s38oL+zvLX6fUPiH9JeoQNPt7g9R0r0CGGT37p3u6GMRh5cXCgCEum
         nErHpIoBWLzoeNBNU+7mny1yBq5GeetenKO1B/+nPdbfH8sgERkISQYrPoWXh9fn38HS
         Rm422ps1aUiLsHl8DbHUrKrhVYyoAIzXdsWyxHjkZA5lE3k6Bj9kL0hcxCwqvHasTQnO
         tTQEkVxq9d4/xs9CF+5RnC5xR9f0T68vs77OnaPnyJYADw8jcKLtJ7528nQc6BTYy/1i
         nwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pTIPfR6E3VHpjEGABCslOJhUnK8tnZlqgxHn44Parco=;
        b=jDG+MdbKYnF+GFAOoP38a6Svj+Qt0cLVERJ/HF7KMri5QIXvTfNXuWczHETHnd7dmz
         9UiRk5EcHzV3Uda5QTwfqRs5BHNBZvCgB5f4f0VbhPlTPDv8hgKS1mspAq/2Mo+65nV0
         TmKez4dKpo8HXuTHzI0vsH5GCrldr6MreemXgICsY/gj6eFCoyAx5uFi0+RXCY0lUEx7
         v2gzOvuSkhL44YZs2iR3YlP7d7Cm2yE1A8EPeqZphy2jZxxR9NXIfEpRkFrzXhbXQTmB
         vthRS4FMVxWc1H41GQh10tOhSeQuvxoIjG42FwGxaRNa2B20khxXtkru+rl0cTlo+MqS
         p1tQ==
X-Gm-Message-State: AD7BkJItZqXcMrLofD7XTkJ04CUpH0q4pkJMgV+QWFb2Kkx+06c4fz4trHo21NvA79swOrx5
X-Received: by 10.66.164.39 with SMTP id yn7mr47026081pab.107.1459207708338;
        Mon, 28 Mar 2016 16:28:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e99f:70e4:359b:ad6b])
        by smtp.gmail.com with ESMTPSA id 27sm38117650pfo.58.2016.03.28.16.28.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 16:28:27 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.23.gd22361a.dirty
In-Reply-To: <1459207703-1635-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290086>

The test which is fixed by this patch would report
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
 git-submodule.sh             | 3 ++-
 t/t7407-submodule-foreach.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index f868636..776b349 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -187,7 +187,7 @@ Entering '../sub2'
 Entering '../sub3'
 EOF
 
-test_expect_failure 'test messages from "foreach --recursive" from subdirectory' '
+test_expect_success 'test messages from "foreach --recursive" from subdirectory' '
 	(
 		cd clone2 &&
 		mkdir untracked &&
-- 
2.8.0.rc4.23.gd22361a.dirty
