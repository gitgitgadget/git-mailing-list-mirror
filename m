Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2fLwFGN"
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CB5D73
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 22:06:53 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1fadb9ac169so382296fac.0
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 22:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701929212; x=1702534012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28ZpjUsAA27IY1u5Vccn4FdaG9SJH6/U4u5KC+PKkf4=;
        b=e2fLwFGNPwkSu97x55Hlu0Tc+QmA7S824gC4mWbHHzORExIXW36lBogdncegN6pF0F
         pt09DC5hfdyzzdMKLley6mCXWrlK5NPh8vsC6qyTIBfbJNpZkY7/r8csb3IlmFiu0PHG
         mzGDqVLMQlnPBbIPnsHoXYmsDofAuCJ0PuBfnw/F386hqFZbKvx9/oU+AR/AxHoX0thO
         YY75tBckGUji4Nw/XOCun6EGL6TclPg8xZfBwPg3037JplIfBmdE4Snbu4a61lxnji7r
         /zuFinpAL6snNW3/+1FdlJx6S2SaG+rf+f0GN85sZ1tbEJsHqT8miPsqbubuxGUt/ObI
         zZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701929212; x=1702534012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28ZpjUsAA27IY1u5Vccn4FdaG9SJH6/U4u5KC+PKkf4=;
        b=aDjb+a6KU/9tJAVuUbhGbsQJzn3HVmz39CEwpagMCqFpEvAwGSVUIwBYqIOk3io2iy
         HDsSoEUR8E79af95AQR+Rwiz3MFupV2kQXIWcNM8fQPpIHzOLG2tN5Arhg8lr0aJ7JzW
         dFhVm1yq6lo5K/cTnGmGHn6z+kUJDz3CvOnHGIlfRUAiG7Wopj6Rql5jMNFeUOM9Mh8S
         66I5CQ4OsrrT820WjhpAy0JbaH/r1wFfLtY68XsjD4Y+/vA6TauqV9NIDYi7aOMp9SzK
         g2+Qgjnaabu5rAtf3oz6b9hc4s06LhCFTuHmYMQqmjP9AZPYYs2uUY7rfd2PQLEnlo6a
         fw1g==
X-Gm-Message-State: AOJu0YzD+i90Bi0br3gv2KhVxrwTMZX4KBdIkVOZeYf/tT9Nj1sTIBP9
	IhOOa+NtEnKb9jTXaxSwLGxhI+tLW1I=
X-Google-Smtp-Source: AGHT+IGzANIwQA4+DaWmRJePxNQKBwvD7F8lEJ5mIliG6T1pDDXP7dB7Bpv5jB/bUlTS+rfcj/YCVQ==
X-Received: by 2002:a05:6870:280a:b0:1fb:75a:6d17 with SMTP id gz10-20020a056870280a00b001fb075a6d17mr2735569oab.62.1701929212527;
        Wed, 06 Dec 2023 22:06:52 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id v65-20020a632f44000000b005b82611378bsm449428pgv.52.2023.12.06.22.06.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Dec 2023 22:06:51 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>
Subject: [PATCH v2 1/2] completion: refactor existence checks for pseudorefs
Date: Wed,  6 Dec 2023 22:06:39 -0800
Message-ID: <1c6a747691f36ede4224b6d4c2e0c8fd4c0575fd.1701928891.git.stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701928891.git.stanhu@gmail.com>
References: <cover.1701928891.git.stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for the reftable backend, this commit introduces a
'__git_pseudoref_exists' function that continues to use 'test -f' to
determine whether a given pseudoref exists in the local filesystem.

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

