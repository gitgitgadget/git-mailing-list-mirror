Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdXz95vt"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA654114
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 21:57:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40bda47c489so12377675e9.3
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 21:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701583027; x=1702187827; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gDsstomIT0hYG7RuKOvZTnJ9cX/gRG40cwI2P+Nco0=;
        b=YdXz95vtKrkrwjNGqkrYul0v0M40E4CvKsByPEOIMhI78KmB/dIllmWXDXhN6MJ9eD
         ysUbvEwo/X15YtVENAl3uSiuUjbfhgZcBgnWlSVe6d9HeU8uU/RA0sYF0JqA1e87no9A
         bq2GKylJ3HyVr7xW4h/5tQWSCqCqb4P8CPZweM8zN4tAqGLmC5mwbXLDHf1B1ZDI4jVZ
         QAxzr4E78mOZ2e3leMfJ2HPls8KoIVYWXdtQ+ONGAPJj1I1dXSd3L0IHMrMFToXMprsI
         dUvydzy0PvopzBFegVO7EUQ9DcDBH8mI5wd7MnE+eU+v89WUF0j9hkdDZrnpn8dx/b2I
         JE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701583027; x=1702187827;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gDsstomIT0hYG7RuKOvZTnJ9cX/gRG40cwI2P+Nco0=;
        b=HtRJFvU32iaf6KAjPN3CpgHKVPIbeTy25skZ7glENqn635emLfweVa298zlVRVuX5T
         uKwkC/63WpZw9cwdf7VUlRT/rcYCVDDWOCIW+EHzikI9HKpw2ZDZnSxKqXSODR4pmWMU
         n2DOItmq56wra/h4lsFw5F3LMqSDCdD3i9MaFz7gCd2OHLSSmJR7QMaHj7Xdt57g7k8V
         YCwYK8O5hTUv5Y7R9WQ1A5NvwfSRAZnxG42aT86+oPLLyhny1ijtzgLZ3hAWdRbOlR/H
         X8hekxISv9Fq4YBGbF3U0IuoiGd+MGfj6ILSYS8Bq6ZNShww64quu2CJ2CMOolx6xhy+
         ni0A==
X-Gm-Message-State: AOJu0YzigxPNWWCUJVXVXcMIctTF9S1ukeevGvocXOkxHJW9kvxieDmZ
	Gmuj1rWQKvRozq5pW05BkMEfcm3NfvY=
X-Google-Smtp-Source: AGHT+IGiIdZQLNewzHw6vr+/5wnMIDcjhwn1N/A2lWvCPIKs1ZBv4rfvgZfRk89J93mD4r8reLQQng==
X-Received: by 2002:a05:600c:1383:b0:40b:5e59:c57f with SMTP id u3-20020a05600c138300b0040b5e59c57fmr1597868wmf.169.1701583026998;
        Sat, 02 Dec 2023 21:57:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b0040849ce7116sm14404177wmq.43.2023.12.02.21.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 21:57:06 -0800 (PST)
Message-ID: <212ba35ed469b63fc75c51b61588025c303a162d.1701583024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
References: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
	<pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 05:57:02 +0000
Subject: [PATCH v3 2/4] completion: fix logic for determining whether cone
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

