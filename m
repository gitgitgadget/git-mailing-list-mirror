Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F57BC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDAIsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDAIrm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4072293C
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:08 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id bl22so4432006oib.11
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSkIhf4M60HT4kf3h+QXf1EV4yyjB8kukzag9Y7TKO0=;
        b=lzGD5X1WBAu43kfWhpNOjlWQ6ROGdI/Vb+cFMg6zrOL0rWdeBE8oYsWLNKHOk+Tv3g
         2V7NuwdIiKARe+TgBFB4Bz7gFKw4T3W/adsvUB0sjOl5aj1ZOBk1vcjsNv7lamDq+aE1
         VsH5LJfts0CUS2FGuQ/2Q8tzbgCLXcD5mpLw6DV8e2DrcMrXYHewfrH7h1Di9oMrZk2t
         YllSE/zaHKejymz/BtebI9G/t8XilRyD2YSlj3zYLAcTRKWoCDqvjisKiWChO1vp7gob
         JmIGnxtzYQoCP4SaBMXzZoeKytdXisyfBFWO3vIapOyo6TgtKU6HXAcxENu9B0e4e6nJ
         kQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSkIhf4M60HT4kf3h+QXf1EV4yyjB8kukzag9Y7TKO0=;
        b=e+nVnffqkjlJC+TQAcwEkxSaVTmMgJCshGozUw5eTMm7wSU2ngY9J2lcapmvirOKae
         Bh/hs7uNMWYw47nJLINqzmt7eL+Lodr+V4sIjR3dhKjz/24VuV3+7Ffb+cDnFIiesljp
         sLJepsw4E9dq1gy4e638V3KHfatsqYzRQ7LrXlgcjB45ogw2Wz69OiRqaKHHhuZrJLzW
         dXqWOH+5fjmRtO7Dp7rwpwR7mUITkUzytbFflpc4MfbKiTe60ogPF7mtDW29H+a7tiL/
         Q6Q/LrJUEagSluXCtw0+R5TDD9lh5kobelA92Z9gwpcRjxhUYtG8FvkRmUQynGDZlEEM
         kZXQ==
X-Gm-Message-State: AO0yUKUXiqYNQwEyQ16tmqhHRnYTH61gLP/9oCNJO/4KpmwwnKcc/5UO
        AN4tjbPwSX8AOYZSkBU5KI1cWEY52DE=
X-Google-Smtp-Source: AK7set8yg/dZvunIKOx7wxiGdmUFotCOOzz1NJKKiQKphYDRKCXV0KR2f+k2V592F01ro4xbu9UC+g==
X-Received: by 2002:a05:6808:2345:b0:378:9c51:3ed6 with SMTP id ef5-20020a056808234500b003789c513ed6mr13598724oib.20.1680338827692;
        Sat, 01 Apr 2023 01:47:07 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d22-20020a4a5216000000b0053b56462336sm1783129oob.21.2023.04.01.01.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 29/49] completion: refactor __gitcomp
Date:   Sat,  1 Apr 2023 02:46:06 -0600
Message-Id: <20230401084626.304356-30-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have two chunks of code doing exactly the same, there's no need for
that.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 52 +++++++++-----------------
 contrib/completion/git-completion.zsh  | 52 ++++++++------------------
 2 files changed, 34 insertions(+), 70 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 187350dbfc..9de394b223 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -345,44 +345,28 @@ __gitcomp ()
 		return
 	fi
 
-	case "$cur_" in
-	--no-*)
-		local c i=0 IFS=$' \t\n'
-		for c in $1; do
-			if [[ $c == "--" ]]; then
+	local c i=0 IFS=$' \t\n'
+	for c in $1; do
+		if [[ $c == "--" ]]; then
+			if [[ "$cur_" == --no-* ]]; then
 				continue
 			fi
-			c="$c${4-}"
+
+			c="--no-...${4-}"
 			if [[ $c == "$cur_"* ]]; then
-				case $c in
-				*=|*.) ;;
-				*) c="$c " ;;
-				esac
-				COMPREPLY[i++]="${2-}$c"
+				COMPREPLY[i++]="${2-}$c "
 			fi
-		done
-		;;
-	*)
-		local c i=0 IFS=$' \t\n'
-		for c in $1; do
-			if [[ $c == "--" ]]; then
-				c="--no-...${4-}"
-				if [[ $c == "$cur_"* ]]; then
-					COMPREPLY[i++]="${2-}$c "
-				fi
-				break
-			fi
-			c="$c${4-}"
-			if [[ $c == "$cur_"* ]]; then
-				case $c in
-				*=|*.) ;;
-				*) c="$c " ;;
-				esac
-				COMPREPLY[i++]="${2-}$c"
-			fi
-		done
-		;;
-	esac
+			break
+		fi
+		c="$c${4-}"
+		if [[ $c == "$cur_"* ]]; then
+			case $c in
+			*=|*.) ;;
+			*) c="$c " ;;
+			esac
+			COMPREPLY[i++]="${2-}$c"
+		fi
+	done
 }
 
 # Clear the variables caching builtins' options when (re-)sourcing
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index c9520589db..029ca23e50 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -58,42 +58,22 @@ __gitcomp ()
 
 	[[ "$cur_" == *= ]] && return
 
-	case "$cur_" in
-	--no-*)
-		local c IFS=$' \t\n'
-		local -a array
-		for c in ${=1}; do
-			if [[ $c == "--" ]]; then
-				continue
-			fi
-			c="$c${4-}"
-			case $c in
-			*=|*.) ;;
-			*) c="$c " ;;
-			esac
-			array+=("$c")
-		done
-		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-		;;
-	*)
-		local c IFS=$' \t\n'
-		local -a array
-		for c in ${=1}; do
-			if [[ $c == "--" ]]; then
-				c="--no-...${4-}"
-				array+=("$c ")
-				break
-			fi
-			c="$c${4-}"
-			case $c in
-			*=|*.) ;;
-			*) c="$c " ;;
-			esac
-			array+=("$c")
-		done
-		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-		;;
-	esac
+	local c IFS=$' \t\n'
+	local -a array
+	for c in ${=1}; do
+		if [[ $c == "--" ]]; then
+			[[ "$cur_" == --no-* ]] && continue
+			array+=("--no-...${4-} ")
+			break
+		fi
+		c="$c${4-}"
+		case $c in
+		*=|*.) ;;
+		*) c="$c " ;;
+		esac
+		array+=("$c")
+	done
+	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_direct ()
-- 
2.33.0

