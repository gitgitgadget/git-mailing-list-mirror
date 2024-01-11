Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BD75810E
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ+xYzGj"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33761e291c1so3411085f8f.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705006076; x=1705610876; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ6ynp6YlOud3VSpbq1yHFP/74q2b9EehPL5WEVtu/8=;
        b=nJ+xYzGjo9n7np6e7Ij14iG9yRfJ1nzuVTCVXl9b5vbKnJudG7nnUhrH7XUs/vPH6f
         S6YxLNhbqKHv1YNCFWp5iFIWqodrJMWPEDJ3bCZPyNY2HFBKJvyh7d0sqsCRVP7vZhXe
         O+wnXJr/ou2pK4wRB39OCigN1dlfJu3qURfBPf6raDA73WDbZUHL+wHnMVq1mFK8RkQw
         9Y9KgMGWWq/0PcddRBzERf+x+QM6X4a3OOaRJ79oTtaajAPWltsotSjCBz0lFIgBReoD
         yDef2ndlvP4AfJqICrNVIQjMwRamH7IHGUC2dCJy1q8q1fD5yWtsyM1KU1lSMUbmRYuz
         L73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705006076; x=1705610876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQ6ynp6YlOud3VSpbq1yHFP/74q2b9EehPL5WEVtu/8=;
        b=Gw0eTwVoknJr1IYBq4CUNt6XRIBymLzWOVvBsVpp8RuH6taZqoTNdHPcfwwHcKTsyg
         iaLX+MupxwRjS0iY9J0+YzJ/QiloOC4pYfpoKTBhFKZGnWxSNSOBSylxHrsT4swwsB9Q
         Bwq+MznRgiqXUh++beMz/JlsD5a2ZBq+Ki0Cuxp2EhN1psyxTeRYEtvpNNTWgt3rn3XE
         PQT3x2inh+sGC6uHeUKfbmYZKHoMAZY1RHzLEnJfVatQx+cFfw9TbHqQu2r60CelxoHv
         BiJ4Gby83s5/V55cy30bbrNatnOob3eOKp9gfE+9EFiVwGUZH0KisbxXptbNLlbZKzBb
         1Saw==
X-Gm-Message-State: AOJu0YxWlc/OAbIEJj9azJb0IjH0fKociI8YLK2TTvgJOF2ve+X5M/Zq
	hRDM9qyZOsZcrRN03AyslgPLSoa1W2I=
X-Google-Smtp-Source: AGHT+IEZKbY9VcKrXRBuPgm2TVYGLDavZX0g12mtLoqzsaAICsQgb/Rzp6KMJGBHfc05/hae91CSTg==
X-Received: by 2002:a05:600c:474c:b0:40e:53ee:bedf with SMTP id w12-20020a05600c474c00b0040e53eebedfmr200486wmo.101.1705006075572;
        Thu, 11 Jan 2024 12:47:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b0040e39cbf2a4sm7212531wmo.42.2024.01.11.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:47:55 -0800 (PST)
Message-ID: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jan 2024 20:47:54 +0000
Subject: [PATCH] diffcore-delta: avoid ignoring final 'line' of file
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

hash_chars() would hash lines to integers, and store them in a spanhash,
but cut lines at 64 characters.  Thus, whenever it reached 64 characters
or a newline, it would create a new spanhash.  The problem is, the final
part of the file might not end 64 characters after the previous 'line'
and might not end with a newline.  This could, for example, cause an
85-byte file with 12 lines and only the first character in the file
differing to appear merely 23% similar rather than the expected 97%.
Ensure the last line is included, and add a testcase that would have
caught this problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    diffcore-delta: avoid ignoring final 'line' of file
    
    Found while experimenting with converting portions of diffcore-delta to
    Rust.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1637%2Fnewren%2Ffix-diffcore-final-line-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1637/newren/fix-diffcore-final-line-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1637

 diffcore-delta.c       |  4 ++++
 t/t4001-diff-rename.sh | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index c30b56e983b..7136c3dd203 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -159,6 +159,10 @@ static struct spanhash_top *hash_chars(struct repository *r,
 		n = 0;
 		accum1 = accum2 = 0;
 	}
+	if (n > 0) {
+		hashval = (accum1 + accum2 * 0x61) % HASHBASE;
+		hash = add_spanhash(hash, hashval, n);
+	}
 	QSORT(hash->data, (size_t)1ul << hash->alloc_log2, spanhash_cmp);
 	return hash;
 }
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 85be1367de6..29299acbce7 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -286,4 +286,23 @@ test_expect_success 'basename similarity vs best similarity' '
 	test_cmp expected actual
 '
 
+test_expect_success 'last line matters too' '
+	test_write_lines a 0 1 2 3 4 5 6 7 8 9 >nonewline &&
+	printf "git ignores final up to 63 characters if not newline terminated" >>nonewline &&
+	git add nonewline &&
+	git commit -m "original version of file with no final newline" &&
+
+	# Change ONLY the first character of the whole file
+	test_write_lines b 0 1 2 3 4 5 6 7 8 9 >nonewline &&
+	printf "git ignores final up to 63 characters if not newline terminated" >>nonewline &&
+	git add nonewline &&
+	git mv nonewline still-no-newline &&
+	git commit -a -m "rename nonewline -> still-no-newline" &&
+	git diff-tree -r -M01 --name-status HEAD^ HEAD >actual &&
+	cat >expected <<-\EOF &&
+	R097	nonewline	still-no-newline
+	EOF
+	test_cmp expected actual
+'
+
 test_done

base-commit: 055bb6e9969085777b7fab83e3fee0017654f134
-- 
gitgitgadget
