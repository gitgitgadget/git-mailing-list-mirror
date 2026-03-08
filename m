Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9D35F17A
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772988935; cv=none; b=pA1FByy0H/PMkZKCN0cXCs1Qgq2vOLjjI4bAqNo78c72nNC6kl0uNMdLbXjWNPgIijZozmbvFZnKgdFeldA3L6cGIe3c98S8oQpkhfXwyNwMOFxJyqJOYreK5/1xPORZrPQxzXeBtgews9Juscku/57melymW9u5mg2iXVD13As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772988935; c=relaxed/simple;
	bh=I3vvXkzCKBUuSzGeBelcWOoqP3kRb6bQbYiyjXA9VC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPUxcGRzs2Mx6x234umNXJUPLZ7Q2D58y4jWo8wnIMkoMuKSzdHyyUwaqCaAmpUkktvcG/bfGAjDlc5wO0Im/UidmndtMrNg9UBk0A8e/SIS6dvWG0GL8YdNwZe8cMIrdHkqZBtLowM4v8D7h/0gwz6cHqKgJ3dpKqUdsoKzIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLVGE5gR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLVGE5gR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62006C116C6;
	Sun,  8 Mar 2026 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772988934;
	bh=I3vvXkzCKBUuSzGeBelcWOoqP3kRb6bQbYiyjXA9VC0=;
	h=From:To:Cc:Subject:Date:From;
	b=tLVGE5gR462al5n2vIztdG7h7BxDNIqU07E3H4fSKPbONaBpHQrKlTlFTlWYveDct
	 QNiFXft7uqAn5bwNfQjLqVqTn5p9iohr07MpJH1EH03m+mcPl7k9ZzT+apIgrJ4kGT
	 z+O19wmU7NRsIpmTj0hLmoiBCG7llnY09AcM8XGNdghGeEBUkkzDgJ16U7OBa1Hgl1
	 IhcbEPTcZ4ACH0gmG//cvJEiqbwY4b7riBEzAr4/F5Vj1IWsbU45HOWigIRdyhvX97
	 gBm4tAzO8CMXucRaLrlqnmCOcpLlgjRrz2ge0ruOss6fACLfHpVOD5XA9VQ9XXe8j4
	 Tuw6BunUjAs0Q==
From: Sasha Levin <sashal@kernel.org>
To: git@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH] quiltimport: fix backslash expansion in patch subjects
Date: Sun,  8 Mar 2026 12:55:31 -0400
Message-ID: <20260308165531.40655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

echo interprets backslash sequences, so a patch with "\0" in its
subject has that expanded into a NUL byte, which git commit-tree
rejects.

Use printf '%s\n' instead, which doesn't interpret the string.

Also quote $tmp_dir to handle paths with spaces.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 git-quiltimport.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index eb34cda409..38302d28c9 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -79,7 +79,7 @@ tmp_info="$tmp_dir/info"
 # Find the initial commit
 commit=$(git rev-parse HEAD)
 
-mkdir $tmp_dir || exit 2
+mkdir "$tmp_dir" || exit 2
 while read patch_name level garbage <&3
 do
 	case "$patch_name" in ''|'#'*) continue;; esac
@@ -101,7 +101,7 @@ do
 		echo "$patch_name doesn't exist. Skipping."
 		continue
 	fi
-	echo $patch_name
+	printf '%s\n' "$patch_name"
 	git mailinfo $MAILINFO_OPT "$tmp_msg" "$tmp_patch" \
 		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
 	test -s "$tmp_patch" || {
@@ -142,14 +142,14 @@ do
 	SUBJECT=$(sed -ne 's/Subject: //p' "$tmp_info")
 	export GIT_AUTHOR_DATE SUBJECT
 	if [ -z "$SUBJECT" ] ; then
-		SUBJECT=$(echo $patch_name | sed -e 's/.patch$//')
+		SUBJECT=$(printf '%s' "$patch_name" | sed -e 's/.patch$//')
 	fi
 
 	if [ -z "$dry_run" ] ; then
 		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
 		tree=$(git write-tree) &&
-		commit=$( { echo "$SUBJECT"; echo; cat "$tmp_msg"; } | git commit-tree $tree -p $commit) &&
+		commit=$( { printf '%s\n' "$SUBJECT"; echo; cat "$tmp_msg"; } | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
 done 3<"$QUILT_SERIES"
-rm -rf $tmp_dir || exit 5
+rm -rf "$tmp_dir" || exit 5

base-commit: 795c338de725e13bd361214c6b768019fc45a2c1
-- 
2.51.0

