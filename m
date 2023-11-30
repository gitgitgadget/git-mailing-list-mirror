Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDEQ6xYZ"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91A1712
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:24:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfc3f50504so12739575ad.3
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701375865; x=1701980665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0qe0jUziZXy/T3wO6y/hjgcYSR3PIAXB6KWk1Hr6QI=;
        b=EDEQ6xYZDlp9z5+bi9hGLRpbT46nG2Sqhm+dW5B4kpbzVQBsuPfnD9lmRHx+FlOkJd
         t201L7wKw2Wb/G91/yid/G7+4rKhCTjZGG0yIl/pQLXVJonqNB+MqYhAkqH8IGkPv3x/
         68cbNUiMLMtRWQDGR1E1XVVnx4MyhMhw7Tkx5S76kLesTkYvOZRfOPQtdRVzKz9fm+HA
         4Mjpx+CGFFVrpPk/iTaspNYB5kBNLrVuBv8bJTSht/bVXtc6g1qN1zdPiGwFyfO9epqH
         mrs0/GjjSh53/6kv7J4rMk9G8ZUvD4xa4wJelJAhDbcT9SwOP9m/RG3ZdpLYvZpaub6V
         3gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375865; x=1701980665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0qe0jUziZXy/T3wO6y/hjgcYSR3PIAXB6KWk1Hr6QI=;
        b=onb7NyT3Oed1M6oVsZ/m+UE7fcZoVGvaVnBw19u+rI8kmm7WpJ1dAtPugbjfIlo0yc
         zTQBXTj/pLFQjDRom2bej+6hG/6JIoGvWMg9NxiYVxnaNvjNO66uUdO+f77pv9gCB5D9
         p2c1F5BdPmtrcPIH23xy91eGrnQqQtdgC3Bq/Os8cWNS16/reABvKoPrzL5BeGDadWA7
         oBZWsPJwf+bQQeXa7kHRMKZULVyGwFQckTZ1cIfhsddGnTUGGwHEjMPhogDx2/1T2Qam
         9N8HfxgulToeb77vpYGp7ghK6RS54kPF2UNS8cIwwYy9M2PsTfTalgw6pKiRkjE5UCaC
         ORmA==
X-Gm-Message-State: AOJu0YxEhZMtubFqT64GHlx1y8VA5n75LpiFH65+isGBbnlLi1H+d2TE
	QvKC+J/7/50gJALA9ZFeMGIYo36JIR4=
X-Google-Smtp-Source: AGHT+IEz9sdGi2Yv8zSoX1ArPNWBSMDdnVFxF/b1MgA1655xD/rYMCLuUZl1+6T6T/3u8zqB9elLLA==
X-Received: by 2002:a17:902:e842:b0:1cf:cbe4:d286 with SMTP id t2-20020a170902e84200b001cfcbe4d286mr14441439plg.13.1701375865475;
        Thu, 30 Nov 2023 12:24:25 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902b59400b001cc2ebd2c2csm1805509pls.256.2023.11.30.12.24.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Nov 2023 12:24:25 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Stan Hu <stanhu@gmail.com>
Subject: [PATCH 1/2] completion: refactor existence checks for special refs
Date: Thu, 30 Nov 2023 12:24:03 -0800
Message-ID: <20231130202404.89791-2-stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130202404.89791-1-stanhu@gmail.com>
References: <20231130202404.89791-1-stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for the reftable backend, this commit introduces a
'__git_ref_exists' function that continues to use 'test -f' to
determine whether a given ref exists in the local filesystem.

Each caller of '__git_ref_exists' must call '__git_find_repo_path`
first. '_git_restore' already used 'git rev-parse HEAD', but to use
'__git_ref_exists' insert a '__git_find_repo_path' at the start.

Reviewed-by: Patrick Steinhardt <ps@pks.im>
Reviewed-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 contrib/completion/git-completion.bash | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 13a39ebd2e..9fbdc13f9a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -122,6 +122,15 @@ __git ()
 		${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
 }
 
+# Runs git in $__git_repo_path to determine whether a ref exists.
+# 1: The ref to search
+__git_ref_exists ()
+{
+	local ref=$1
+
+	[ -f "$__git_repo_path/$ref" ]
+}
+
 # Removes backslash escaping, single quotes and double quotes from a word,
 # stores the result in the variable $dequoted_word.
 # 1: The word to dequote.
@@ -1625,7 +1634,7 @@ __git_cherry_pick_inprogress_options=$__git_sequencer_inprogress_options
 _git_cherry_pick ()
 {
 	__git_find_repo_path
-	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
+	if __git_ref_exists CHERRY_PICK_HEAD; then
 		__gitcomp "$__git_cherry_pick_inprogress_options"
 		return
 	fi
@@ -2067,7 +2076,7 @@ _git_log ()
 	__git_find_repo_path
 
 	local merge=""
-	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
+	if __git_ref_exists MERGE_HEAD; then
 		merge="--merge"
 	fi
 	case "$prev,$cur" in
@@ -2934,6 +2943,7 @@ _git_reset ()
 
 _git_restore ()
 {
+	__git_find_repo_path
 	case "$prev" in
 	-s)
 		__git_complete_refs
@@ -2952,7 +2962,7 @@ _git_restore ()
 		__gitcomp_builtin restore
 		;;
 	*)
-		if __git rev-parse --verify --quiet HEAD >/dev/null; then
+		if __git_ref_exists HEAD; then
 			__git_complete_index_file "--modified"
 		fi
 	esac
@@ -2963,7 +2973,7 @@ __git_revert_inprogress_options=$__git_sequencer_inprogress_options
 _git_revert ()
 {
 	__git_find_repo_path
-	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
+	if __git_ref_exists REVERT_HEAD; then
 		__gitcomp "$__git_revert_inprogress_options"
 		return
 	fi
@@ -3592,7 +3602,7 @@ __gitk_main ()
 	__git_find_repo_path
 
 	local merge=""
-	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
+	if __git_ref_exists MERGE_HEAD; then
 		merge="--merge"
 	fi
 	case "$cur" in
-- 
2.42.0

