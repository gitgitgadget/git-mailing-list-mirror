Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZc5+uW4"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E410DE
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:12 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso662119f8f.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700761450; x=1701366250; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OqsDbCE8j+Lny46tUTWAxtnemlTWw9DECnHUnT/N4g=;
        b=aZc5+uW4GIx/yjJIfae9P+neHvq7G6/xGbjuD2eI3avWip00xXiW8pOg7Q5Boz/Dzu
         MUOznY+FBR3owDYIdEICzim/6QidKp0HoXZBKOUS6A/oIfKduSGmMyVuN/oqt0yYeec6
         GX7O1YNrJE7WmaAYyRCMgv+O1Q1zJ9TRFYvDv5ga2PiekpWbmZvR7RhZ28xmwn+bZX/E
         IiLyfVD7lDdF0ZlEct6pWgfojtiOb4lyo+3zWcDkrV/YUJXVHHCA77+xHQWfmoKS5QB6
         113SCyVit/cQG4rl8hDfRMrHSL+3G/1PgTBUGiT1791SSFFADZWijFbqkhLGxgboHB2T
         diQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700761450; x=1701366250;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OqsDbCE8j+Lny46tUTWAxtnemlTWw9DECnHUnT/N4g=;
        b=u/DJELw0LCWZtV6PwvS9vtO+d5QymbwuKxGwc/2E+X/VX/H6sj8DVReKUDKoB8ZhD0
         IMJinpsMGqheVq71FExlfRoK9QyNlDSnfkD6lqKqkqnZ+3GwVokPVhS5pFdmFWGW4gcN
         Npuxuvnln37NhOF+7gNO2666uyrzuSkE82w67wMzHrMP3UIFfCPXQPcsXCaUBoQLXXzW
         2HdeUeYx2WYh7tkbgnlYiiG/7YKO3BZs3bo86ACvFh+W8Tl+6hSsZjtfWboSCVHN+n7T
         7pUMRWwb2B2GAaxXN1J+BSZ0SCC2x8D5XK+KpuxXNX7+mWT6/+aW7ybhDQPmNgoWXaez
         jx8Q==
X-Gm-Message-State: AOJu0YxqApEXDha2BraW69Ui+v2rr6jLVbqbkH1Akft/oPuhhFNQn/r6
	Jhk07sGTQO3tKDVb9CVRZ/+yQi0sHEs=
X-Google-Smtp-Source: AGHT+IHOYyLrTRIBPLdawt3py7HjEJGFgbLTjKW+OzH/I7I+SxGryke9LD7vxG0yKcTQqmnxWX1fHw==
X-Received: by 2002:a5d:4ece:0:b0:332:e2e5:46a5 with SMTP id s14-20020a5d4ece000000b00332e2e546a5mr2499680wrv.7.1700761450568;
        Thu, 23 Nov 2023 09:44:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9-20020adfef49000000b00331698cb263sm2243183wrp.103.2023.11.23.09.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:44:10 -0800 (PST)
Message-ID: <a15fb054579b13c6ee949ca1506d3e380da06d55.1700761448.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Nov 2023 17:44:06 +0000
Subject: [PATCH 2/4] completion: fix logic for determining whether cone mode
 is active
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
index 6fced40d04c..42e9e0cba8f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3027,6 +3027,7 @@ _git_sparse_checkout ()
 {
 	local subcommands="list init set disable add reapply"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	local using_cone=true
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 		return
@@ -3037,8 +3038,15 @@ _git_sparse_checkout ()
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

