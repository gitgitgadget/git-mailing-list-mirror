Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D27j9sC8"
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2B010C7
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 22:06:54 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c206572eedso442273a12.0
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 22:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701929213; x=1702534013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjlBdNRyKL0XTuxHPH0kOXKMZPgn6/k3KGDfbJAONag=;
        b=D27j9sC8Hf2cq16JEGOzaq2JwXnEE/nAgIe7urxp8UsQd0t39t1e+qyc57cEYeiEZs
         ZsdApT7EpvA3X1HNoagfLaJk5twe8xMo1WMigJUQ2C7SzNeLlexYsTYaQm4Wm1DYBjjs
         Gz/i21j31mpz5aY47Rc4xP2hiZW9jEGhgWTExgHjK9Rx3/+6U/5C4R47lfsptATAeYec
         qxNVlB6ajMZIeNyGR2VUkcRVteJgCSWYnUXrUgCNQieI71ot4rAK691xfHV88AqH/VRZ
         k8VlUC5WK0QyIe7jxeeITygR0wLX9CbCRYJAEPJpByJBHYGpPGnRTPtPQZS1Ndkj0snL
         Qhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701929213; x=1702534013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjlBdNRyKL0XTuxHPH0kOXKMZPgn6/k3KGDfbJAONag=;
        b=oXnfTa4w3WGnLA1BjNZCx0UoT5OB5bQe8IkvfFz/f9uSDwuJpJV5lZjnYz5A3Hsfj/
         f/NNFyyi2/aMtWmVs8oQcfO05O2CVtYsVhipavf5wQ+zqKQNiRSdOVnKW71q/6FTpg3j
         sYSdNTkrGIL43MziwurBDn/GhXGjOdOBHLgRyfUcgAAlu0A42PgP+6yS/VX9IGSmrvil
         yGiyQXWibNtQAi3DmR+Kk8zjXuKrj8rDeMivfmXOkeo2tv00izGyaJNdPAEy2JlCMnNd
         Dv5bPz/zwKyT4InGzyEpZg+0TjjZUURwgZwHZd461zLRzgZMEXUAlxJt36dX103ZQgsh
         JcOQ==
X-Gm-Message-State: AOJu0Yy8kyz/NZC0ISMlBTgzdXxP8yilB0hMnLdWphS0Vrgo6CVrnSWi
	CfHSaIFshGjoA6w795IGXAuGI0xtgjc=
X-Google-Smtp-Source: AGHT+IGcYobtUSex8me6p8HuqUfYcHI/356FiYnhQQbh3Mya4SUbVE/HJrrkJgyghJor6IIUI5OOhg==
X-Received: by 2002:a05:6a20:3d13:b0:18d:1790:56be with SMTP id y19-20020a056a203d1300b0018d179056bemr2275428pzi.39.1701929213474;
        Wed, 06 Dec 2023 22:06:53 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id v65-20020a632f44000000b005b82611378bsm449428pgv.52.2023.12.06.22.06.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Dec 2023 22:06:53 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>
Subject: [PATCH v2 2/2] completion: support pseudoref existence checks for reftables
Date: Wed,  6 Dec 2023 22:06:40 -0800
Message-ID: <9b0e090d91f99a1a0cd78f2a93939630ab44abd1.1701928891.git.stanhu@gmail.com>
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

In contrib/completion/git-completion.bash, there are a bunch of
instances where we read pseudorefs, such as HEAD, MERGE_HEAD,
REVERT_HEAD, and others via the filesystem. However, the upcoming
reftable refs backend won't use '.git/HEAD' at all but instead will
write an invalid refname as placeholder for backwards compatibility,
which will break the git-completion script.

Update the '__git_pseudoref_exists' function to:

1. Recognize the placeholder '.git/HEAD' written by the reftable
   backend (its content is specified in the reftable specs).
2. If reftable is in use, use 'git rev-parse' to determine whether the
    given ref exists.
3. Otherwise, continue to use 'test -f' to check for the ref's filename.

Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 contrib/completion/git-completion.bash | 39 ++++++++++++++++++++------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9fbdc13f9a..b2e407c7e7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -122,12 +122,35 @@ __git ()
 		${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
 }
 
-# Runs git in $__git_repo_path to determine whether a ref exists.
-# 1: The ref to search
-__git_ref_exists ()
+# Helper function to read the first line of a file into a variable.
+# __git_eread requires 2 arguments, the file path and the name of the
+# variable, in that order.
+#
+# This is taken from git-prompt.sh.
+__git_eread ()
+{
+	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
+}
+
+# Runs git in $__git_repo_path to determine whether a pseudoref exists.
+# 1: The pseudo-ref to search
+__git_pseudoref_exists()
 {
 	local ref=$1
 
+	# If the reftable is in use, we have to shell out to 'git rev-parse'
+	# to determine whether the ref exists instead of looking directly in
+	# the filesystem to determine whether the ref exists. Otherwise, use
+	# Bash builtins since executing Git commands are expensive on some
+	# platforms.
+	if __git_eread "$__git_repo_path/HEAD" head; then
+		b="${head#ref: }"
+		if [ "$b" == "refs/heads/.invalid" ]; then
+			__git -C "$__git_repo_path" rev-parse --verify --quiet "$ref" 2>/dev/null
+			return $?
+		fi
+	fi
+
 	[ -f "$__git_repo_path/$ref" ]
 }
 
@@ -1634,7 +1657,7 @@ __git_cherry_pick_inprogress_options=$__git_sequencer_inprogress_options
 _git_cherry_pick ()
 {
 	__git_find_repo_path
-	if __git_ref_exists CHERRY_PICK_HEAD; then
+	if __git_pseudoref_exists CHERRY_PICK_HEAD; then
 		__gitcomp "$__git_cherry_pick_inprogress_options"
 		return
 	fi
@@ -2076,7 +2099,7 @@ _git_log ()
 	__git_find_repo_path
 
 	local merge=""
-	if __git_ref_exists MERGE_HEAD; then
+	if __git_pseudoref_exists MERGE_HEAD; then
 		merge="--merge"
 	fi
 	case "$prev,$cur" in
@@ -2962,7 +2985,7 @@ _git_restore ()
 		__gitcomp_builtin restore
 		;;
 	*)
-		if __git_ref_exists HEAD; then
+		if __git_pseudoref_exists HEAD; then
 			__git_complete_index_file "--modified"
 		fi
 	esac
@@ -2973,7 +2996,7 @@ __git_revert_inprogress_options=$__git_sequencer_inprogress_options
 _git_revert ()
 {
 	__git_find_repo_path
-	if __git_ref_exists REVERT_HEAD; then
+	if __git_pseudoref_exists REVERT_HEAD; then
 		__gitcomp "$__git_revert_inprogress_options"
 		return
 	fi
@@ -3602,7 +3625,7 @@ __gitk_main ()
 	__git_find_repo_path
 
 	local merge=""
-	if __git_ref_exists MERGE_HEAD; then
+	if __git_pseudoref_exists MERGE_HEAD; then
 		merge="--merge"
 	fi
 	case "$cur" in
-- 
2.42.0

