Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D883D0D0
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6Y/c13T"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28a5d0ebf1fso119138a91.0
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 14:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703024075; x=1703628875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUhOfDZxVjSsDlP64iQ+y3H7isiJC09Z10V1w0Y4eiY=;
        b=m6Y/c13Two0Z3c1YZVUPmQy6xSztkKlCY+5HTkXidBUT8WVrjmSIq4n1lykk04VrBE
         ibHAGDk25u+9ouR4x0US+euYlPP1CM4QHrMiagpBVb+eh8/wO5mKDRRI0/Kyv1LDgVfZ
         GJSs3Wvv9S12hhOn1k9q6KIwpsQC3cXX0Guelt+MYIMGKIgtkFmXdtKX1hyptylOU3lu
         63MuMaXhi26fDR/7e05R+14A/SVsBW+JwYsFE094GmELkjJEVnifXgVUWxpNkuxs/CI2
         onZsvNDYN9XsNdRVmZkOKd3uGmcVqWlAZ84malfp1nLQ05OxbEduUAlbiCIJnt6QQQGj
         qbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703024075; x=1703628875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUhOfDZxVjSsDlP64iQ+y3H7isiJC09Z10V1w0Y4eiY=;
        b=GFVVY1eol40ucCVjBp/XoSu3P5U9AB2KQpWfoq7fE7n09fPHhBwtoIcLWYkjIP7dXD
         moTA8RkP7Z7/LijcGkuUW+WK/ype07pqqFLMgYPiqK1aLyYcb1yatW1UPKtoRybol194
         IazE5RevXDimxYfDKClWLJLr9MxnKcKRJ8W5p+zI/UukJ3PJc/n0hrG2Pa6AZwtHXZwO
         roEfYmXmXRgHSj4XisZvoN/AZJFhMNxcNMSDgPelvdowdoY5axNqKPrrdGHkB6JHbAvx
         SO6xE1lrSV33Vv2s0JQBRH1amqnhxvSN5hb6c1pkC6QigX4f5xhLAWUBsmKGeqml+QZQ
         ZgIw==
X-Gm-Message-State: AOJu0YyrhCGEnnUnqMOVRuI4ctddJAahysTw+GQCjkd+F08ouMNu25/z
	VA+ZMZuwweBgwwUKmRM3OZ7Q4vnBGo8=
X-Google-Smtp-Source: AGHT+IGFLp1KIbrnM0KrNHz3jXkIvayPsNPN0AeTt+LFy+HzMdaotLRKwYdc/oZESfzIHY7bhHDwRQ==
X-Received: by 2002:a17:90a:fa96:b0:28b:48:ffe4 with SMTP id cu22-20020a17090afa9600b0028b0048ffe4mr2196881pjb.36.1703024075470;
        Tue, 19 Dec 2023 14:14:35 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a190400b00288622137dfsm2360255pjg.5.2023.12.19.14.14.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Dec 2023 14:14:35 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Stan Hu <stanhu@gmail.com>
Subject: [PATCH v3 1/2] completion: refactor existence checks for pseudorefs
Date: Tue, 19 Dec 2023 14:14:17 -0800
Message-ID: <29c928649aba7dfce4dab1b5d923bc23b7af2d32.1703022850.git.stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1703022850.git.stanhu@gmail.com>
References: <cover.1703022850.git.stanhu@gmail.com>
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
index 13a39ebd2e..8edd002eed 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -122,6 +122,15 @@ __git ()
 		${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
 }
 
+# Runs git in $__git_repo_path to determine whether a pseudoref exists.
+# 1: The pseudo-ref to search
+__git_pseudoref_exists ()
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
+	if __git_pseudoref_exists CHERRY_PICK_HEAD; then
 		__gitcomp "$__git_cherry_pick_inprogress_options"
 		return
 	fi
@@ -2067,7 +2076,7 @@ _git_log ()
 	__git_find_repo_path
 
 	local merge=""
-	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
+	if __git_pseudoref_exists MERGE_HEAD; then
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
+		if __git_pseudoref_exists HEAD; then
 			__git_complete_index_file "--modified"
 		fi
 	esac
@@ -2963,7 +2973,7 @@ __git_revert_inprogress_options=$__git_sequencer_inprogress_options
 _git_revert ()
 {
 	__git_find_repo_path
-	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
+	if __git_pseudoref_exists REVERT_HEAD; then
 		__gitcomp "$__git_revert_inprogress_options"
 		return
 	fi
@@ -3592,7 +3602,7 @@ __gitk_main ()
 	__git_find_repo_path
 
 	local merge=""
-	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
+	if __git_pseudoref_exists MERGE_HEAD; then
 		merge="--merge"
 	fi
 	case "$cur" in
-- 
2.42.0

