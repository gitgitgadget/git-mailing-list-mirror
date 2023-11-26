Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeFQO5KF"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939A101
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332c0c32d19so2241072f8f.3
        for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700985090; x=1701589890; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gDsstomIT0hYG7RuKOvZTnJ9cX/gRG40cwI2P+Nco0=;
        b=YeFQO5KFFjdz6/jgSZnZsGMuYEqqPo9oYIARgFPG7ceyTz7CV5PMokTposqR+bnpXU
         7mgTS1c/oNe6AlJV8+zMnL9RT+9YExQuoHMW+h7aIPVgXxblSTKWfzkj9vhdNFkL30E5
         EqOf6f2hPXx9arGTmmRxCV15VZFWuipH84SMOMkvesHZuQiyWpxhAnfsflgtFLzkLekE
         BjR/FXDQyC97LapyhzYzpSH4aJur+tpYLYcoeapRYUvXjit+CSpCzgmCdW3OsyJ2xOHo
         UtBXty8s+O8LUvOhG1QLXPWZS/WZUgNM1Jmw0lRZsB1fG8Q/DONeKwhcy4XcBwtXEpho
         TGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700985090; x=1701589890;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gDsstomIT0hYG7RuKOvZTnJ9cX/gRG40cwI2P+Nco0=;
        b=TSIkBkj9xpvS/sDVLXWAfGT4yrqtMvg7fsSQNenTs67VVlZWT6hXjDCmvHWrP7dxo/
         Q8FnRHleuCFnH1V3p+l5TzhmH59BgxRm6sXUhZk1G7CwRy/5s02vjLsmvnaJHtffL+f5
         mhlTt1GsXriomHxuWli3wNBBSHOkSGBi6p8MsXYqVeH5mPDgyUAOHr10R4bJ3lU/rqJx
         ZlCuEkJVuAYb3nznrcTO+Yg7mFHyYhtpETaGw3XRwVhQv27ibc3ZulVOawtCuDzXKJUP
         73+TOzb7xXkj1+lYS9md7yTUHlvKUQmeTwPyxSH/s9iQDp1/qbMP3VZu5zuOmZNodATX
         zDXg==
X-Gm-Message-State: AOJu0YyAdayS7ISPUTIX83kn4XXENF9CbKf+/B/GXNZp4b2jsN0SaMKc
	z1M/7NR9IzvxLP7ivI/Uz+SgRN2t4dI=
X-Google-Smtp-Source: AGHT+IEV7NmrZwdddxuzsF5CpvfERvJ9BrUNxYC+7z4SwLq4TDqTQ1qMyZSYOAiFYWoEZbRItoT4nw==
X-Received: by 2002:a5d:6a42:0:b0:32f:8a7f:f00f with SMTP id t2-20020a5d6a42000000b0032f8a7ff00fmr6074451wrw.60.1700985089718;
        Sat, 25 Nov 2023 23:51:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2-20020a5d47a2000000b00332ff137c29sm326822wrb.79.2023.11.25.23.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 23:51:28 -0800 (PST)
Message-ID: <212ba35ed469b63fc75c51b61588025c303a162d.1700985086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
	<pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Nov 2023 07:51:24 +0000
Subject: [PATCH v2 2/4] completion: fix logic for determining whether cone
 mode is active
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
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

_git_sparse_checkout() was checking whether we were in cone mode by
checking whether either:

    A) core.sparseCheckoutCone was "true"
    B) "--cone" was specified on the command line

This code has 2 bugs I didn't catch in my review at the time

    1) core.sparseCheckout must be "true" for core.sparseCheckoutCone to
       be relevant (which matters since "git sparse-checkout disable"
       only unsets core.sparseCheckout, not core.sparseCheckoutCone)
    2) The presence of "--no-cone" should override any config setting

Further, I forgot to update this logic as part of 2d95707a02
("sparse-checkout: make --cone the default", 2022-04-22) for the new
default.

Update the code for the new default and make it be more careful in
determining whether to complete based on cone mode or non-cone mode.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b8661701718..7aa66c19ede 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3097,6 +3097,7 @@ _git_sparse_checkout ()
 {
 	local subcommands="list init set disable add reapply"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	local using_cone=true
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 		return
@@ -3107,8 +3108,15 @@ _git_sparse_checkout ()
 		__gitcomp_builtin sparse-checkout_$subcommand "" "--"
 		;;
 	set,*|add,*)
-		if [ "$(__git config core.sparseCheckoutCone)" == "true" ] ||
-		[ -n "$(__git_find_on_cmdline --cone)" ]; then
+		if [[ "$(__git config core.sparseCheckout)" == "true" &&
+		      "$(__git config core.sparseCheckoutCone)" == "false" &&
+		      -z "$(__git_find_on_cmdline --cone)" ]]; then
+			using_cone=false
+		fi
+		if [[ -n "$(__git_find_on_cmdline --no-cone)" ]]; then
+			using_cone=false
+		fi
+		if [[ "$using_cone" == "true" ]]; then
 			__gitcomp_directories
 		fi
 	esac
-- 
gitgitgadget

