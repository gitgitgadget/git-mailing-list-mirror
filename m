From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] submodule update --init: correct path handling in recursive submodules
Date: Mon, 28 Mar 2016 16:28:20 -0700
Message-ID: <1459207703-1635-5-git-send-email-sbeller@google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 29 01:28:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akgaV-0004wc-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 01:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbcC1X2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 19:28:43 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35636 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485AbcC1X2b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 19:28:31 -0400
Received: by mail-pa0-f48.google.com with SMTP id td3so108339241pab.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+iJ2pZtoqRDtWbMuXoV1mjEmws/6fQ51A1d+ONEBIyU=;
        b=Hs3fWNVq0odR6fC4hxYrMAF2OJ2kBxq7HkyAVoACJCVgrwzfNdVs7icBhFNXNZsfbN
         Qz4q1ulaODpCavnPLI+zFRctR5x7S88yUxhwprZJNYVoAIYnQGVUuOhdGffMvsZYziyx
         zL7kj8jW3zB13UewBlCw/JESSmXNToOk6aSy8TvHnJK0hPlEuhJwGu4dkzEc1xxa89ly
         OIvJi2iC3I4eM7V26SiaSRUCouAYmjsSmeCFMUNRpxMYfEWcdQcsR0TAileaz5Vwqa20
         7g1g8gq7wPDfFJTFSX/TjTwJKHRvhqfpILnwhzNiMGMi1G+/sG0z0KUjeIacCj+fDBb4
         JoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+iJ2pZtoqRDtWbMuXoV1mjEmws/6fQ51A1d+ONEBIyU=;
        b=d8p5orek5vZ5O/7RXqxyJiBD+7wXZiz+2aR4PjsKBHNZmUjBbGpey2miaM4c3YmAW/
         S/PHdoBTBWbqWdrDzxu6Q5nqmhEIEs6MdWeUuZurN72Ftkg+mFnDxujYhU11NmOLzmGV
         Gm71n5WUF8hZrl367e0bQp5lnJrQSquMs1UtF5oM1ek52Jw2gVS6yu6l3HZyfjEN4icb
         NccIThn0L50rSAiFwA2YX2NnrqyQNE51d2bwxZbkdEO1M5rCr23t2HquGi9rnFR3HkB7
         ENbmCCGTfvovQhf5GeoTNtLIlKiRyQWIIybTOCoCmv+uoiAZusY3D6GT9TB+b6bNTI39
         cfqA==
X-Gm-Message-State: AD7BkJJTQSIfGa8cKWwenXBAAc04OmL/0GD/7FnnAtU+FVmL4DALwXYf3IwE9JhwwZ5lRKRW
X-Received: by 10.66.222.129 with SMTP id qm1mr46371444pac.22.1459207710751;
        Mon, 28 Mar 2016 16:28:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e99f:70e4:359b:ad6b])
        by smtp.gmail.com with ESMTPSA id c18sm38151246pfj.41.2016.03.28.16.28.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 16:28:30 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.23.gd22361a.dirty
In-Reply-To: <1459207703-1635-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290091>

This fixes the test introduced by the parent commit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh            | 5 +++--
 t/t7406-submodule-update.sh | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2838069..a7c8599 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -474,7 +474,7 @@ cmd_init()
 		die_if_unmatched "$mode"
 		name=$(git submodule--helper name "$sm_path") || exit
 
-		displaypath=$(relative_path "$sm_path")
+		displaypath=$(relative_path "$prefix$sm_path")
 
 		# Copy url setting when it is not set yet
 		if test -z "$(git config "submodule.$name.url")"
@@ -826,8 +826,9 @@ Maybe you want to use 'update --init'?")"
 		if test -n "$recursive"
 		then
 			(
-				prefix="$prefix$sm_path/"
+				prefix="$(relative_path $prefix$sm_path)/"
 				clear_local_git_env
+				wt_prefix=
 				cd "$sm_path" &&
 				eval cmd_update
 			)
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c1b9ffa..3bd1552 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -118,7 +118,7 @@ Submodule path '../super/rebasing': checked out '${rebasingsha1}'
 Submodule path '../super/submodule': checked out '${submodulesha1}'
 EOF
 
-test_expect_failure 'submodule update --init --recursive from subdirectory' '
+test_expect_success 'submodule update --init --recursive from subdirectory' '
 	git -C recursivesuper/super reset --hard HEAD^ &&
 	(cd recursivesuper &&
 	 mkdir tmp &&
-- 
2.8.0.rc4.23.gd22361a.dirty
