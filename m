Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFrVhmjE"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426B170F
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:24:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf7a8ab047so12743085ad.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701375867; x=1701980667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ela9c9mrQk2j555f2KgLQw43/H5v/SX70WTxP3yF5dw=;
        b=QFrVhmjEydZnCkyrFxNWSf4+cKtw+TRSRqvggl+tn7/iTBxKHolj/5t7IbLpTfbr+L
         L8TNu2YwB6Ecfh9DRMKEBoU0NiyRCv9aFtTkDv7wUoY02o3WShA5KYENOcnb8/We8RVq
         JqGpI0PIPQ8exB5Ojm43ploDXMBWywSZvBWrUmFFZLsJKcj9HJ+XFwZNL+X0vC2lsIUS
         zae/8QxclxmYydehkfNeup370XIFeB4MrUnEV02EX9P/Y1U8yQL1mUkwx1oGBM73n5z6
         0UikaIlOFlOu7lpStXDHQW31ujh5+vxrUvzLCSM+drA03sanq58Zvqy5D9qSls93hPvf
         V+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375867; x=1701980667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ela9c9mrQk2j555f2KgLQw43/H5v/SX70WTxP3yF5dw=;
        b=EjfB3qUWKi+p73lmWhlPAbYEyjYOoSDzsyGCy7LPboKl5kezfo/1GnYBdEPHQ15i66
         Ok7UHskORvu+v+727Vkc6SleY2SYrQX8EHo2PzmC+wRqNzvQ8V6KIXMDa16aio/3X3ac
         mBi5myZKWSMudnqhWLvcvkbVLnPun/zW9GFAO4MznmdqVXEMMqI1hfbKzuPyealqBQ1J
         7B557DT0DTWNaM2AlF7qfO3g1epAFwU4jfWOK4FcgLGTz2qlgqR8kpzFTdeTPuXRHvB/
         oXIhskgZtT+J//kHLf9LYtn5h7DL35tWFxFwh5MEvU2kSJ5HvUe2DSMBm99jACo0CroU
         h3hw==
X-Gm-Message-State: AOJu0YxKdsgoiQZRaZAwcem6Dhi/lWPf4w4B3GRKZSdSeffIn+hHUmNO
	Ap5O4AhAT2c5pflgonnpneqjOHJ+qvw=
X-Google-Smtp-Source: AGHT+IG9a8QVNMWns45Rq2Aqwzt/JUDBhqn4zSp5mIeZMPlbyspLkvd8HMxC/ze70e48Ho/nSEkh2Q==
X-Received: by 2002:a17:902:db03:b0:1cf:c518:fa70 with SMTP id m3-20020a170902db0300b001cfc518fa70mr19162611plx.34.1701375866846;
        Thu, 30 Nov 2023 12:24:26 -0800 (PST)
Received: from localhost.localdomain (192-184-144-144.fiber.dynamic.sonic.net. [192.184.144.144])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902b59400b001cc2ebd2c2csm1805509pls.256.2023.11.30.12.24.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Nov 2023 12:24:26 -0800 (PST)
From: Stan Hu <stanhu@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Stan Hu <stanhu@gmail.com>
Subject: [PATCH 2/2] completion: stop checking for reference existence via `test -f`
Date: Thu, 30 Nov 2023 12:24:04 -0800
Message-ID: <20231130202404.89791-3-stanhu@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130202404.89791-2-stanhu@gmail.com>
References: <20231130202404.89791-1-stanhu@gmail.com>
 <20231130202404.89791-2-stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In contrib/completion/git-completion.bash, there are a bunch of
instances where we read special refs like HEAD, MERGE_HEAD,
REVERT_HEAD, and others via the filesystem. However, the upcoming
reftable refs backend won't use '.git/HEAD' at all but instead will
write an invalid refname as placeholder for backwards compatibility,
which will break the git-completion script.

Update the '__git_ref_exists' function to:

1. Recognize the placeholder '.git/HEAD' written by the reftable
   backend (its content is specified in the reftable specs).
2. If reftable is in use, use 'git rev-parse' to determine whether the
    given ref exists.
3. Otherwise, continue to use 'test -f' to check for the ref's filename.

Reviewed-by: Patrick Steinhardt <ps@pks.im>
Reviewed-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 contrib/completion/git-completion.bash | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9fbdc13f9a..f5b630ba99 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -122,12 +122,35 @@ __git ()
 		${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
 }
 
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
 # Runs git in $__git_repo_path to determine whether a ref exists.
 # 1: The ref to search
 __git_ref_exists ()
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
 
-- 
2.42.0

