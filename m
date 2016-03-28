From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/7] submodule status: fix path handling in recursive submodules
Date: Mon, 28 Mar 2016 16:28:23 -0700
Message-ID: <1459207703-1635-8-git-send-email-sbeller@google.com>
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
	id 1akgaU-0004wc-KD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 01:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbcC1X2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 19:28:39 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32942 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308AbcC1X2f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 19:28:35 -0400
Received: by mail-pf0-f181.google.com with SMTP id 4so148757770pfd.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8dcRX6NWARSAJXB0xYQCxS7V8ecFlNuXkZ/LTpu6OdI=;
        b=RQJJwFPEQIIoPOrEYor1ZpUIVEAbGOKUS5XvPWeUYV6dRe9eaKqw0TKIXf+AIt40tR
         Tygio5zZtuE8Mm156tJImcfrFtDdcPCsyN7izKnurVFJKT4BiMoN7w81RQkQCqLMItoy
         XBu3HpUW7UEP7JSbsLZ2Nvum+VGC6u6lHDh9RZtEfsJdHn7mqYZZTxqO+DRJYB6dEoF4
         D6ESaicQJ/7Nl4ag1bKBvwKgFx46JVnyj6DDRNDWwbO5Kw3nBdXcQkqlwPqQAbQpBpzT
         0lgWsTbO6y4ykR7uLXJU7S6E6EeYWsBXqjS+X8ZpDwIzfllQG4+YWfmdADVFs+n3s3GK
         xpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8dcRX6NWARSAJXB0xYQCxS7V8ecFlNuXkZ/LTpu6OdI=;
        b=iNb6Y9YPHEAsg0eg31+MtQ+vKRpwTTRmHNxfwwnJ2+T8g7mnjqmn3Pu+WJTXO28kya
         oou19Qscbv06wQJyHp9YQk1tJuhMCWafEzkODgTHV7pSzxCZ4GomHs2/0uYGEjTXbzJy
         I/PpfesGKoY8WBaNwIMasxMOAFbXTgogeKnFYZb5CRUXN17ipSwgzHQdWLs5HJeyLra8
         Pd5+nCWM80VU0/Tcwz642JxE3v3vjPCqRQc6IwNlO0sfGoHzwsNo08TkKLFOYRUf+hA7
         ZAkkF7mmDO0c0HEo7ga1UFOQpis83ETZ/SAjS45/O54m+FYvRddj7a6eUOllzXeWSSek
         OV5w==
X-Gm-Message-State: AD7BkJJmwSuAcJGPwcChEHKqOrRO68aLoGgGRvtu1X91gizah5gS7P13eu9OqdiO9hbepH84
X-Received: by 10.98.70.197 with SMTP id o66mr47021058pfi.84.1459207714378;
        Mon, 28 Mar 2016 16:28:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e99f:70e4:359b:ad6b])
        by smtp.gmail.com with ESMTPSA id 83sm38129236pfn.46.2016.03.28.16.28.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 16:28:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.23.gd22361a.dirty
In-Reply-To: <1459207703-1635-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290088>

This fixes the test which was introduced in the parent commit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh             | 1 +
 t/t7407-submodule-foreach.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a7c8599..7503b27 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1161,6 +1161,7 @@ cmd_status()
 			(
 				prefix="$displaypath/"
 				clear_local_git_env
+				wt_prefix=
 				cd "$sm_path" &&
 				eval cmd_status
 			) ||
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 5c57151..91f9ca9 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -272,7 +272,7 @@ cat > expect <<EOF
  $sub3sha1 ../sub3 (heads/master)
 EOF
 
-test_expect_failure 'test "status --recursive" from sub directory' '
+test_expect_success 'test "status --recursive" from sub directory' '
 	(
 		cd clone3 &&
 		mkdir tmp && cd tmp &&
-- 
2.8.0.rc4.23.gd22361a.dirty
