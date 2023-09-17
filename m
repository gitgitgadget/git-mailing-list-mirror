Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BE2CD13CF
	for <git@archiver.kernel.org>; Sun, 17 Sep 2023 19:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbjIQTZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Sep 2023 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbjIQTYq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2023 15:24:46 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0856D9
        for <git@vger.kernel.org>; Sun, 17 Sep 2023 12:24:39 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-576918d0a42so2339639eaf.3
        for <git@vger.kernel.org>; Sun, 17 Sep 2023 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694978679; x=1695583479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd2KWJyuRhrk0+vaz1G3192U+6/mB/ow0neMfCTO64I=;
        b=PtDnEFKQH8yv0D1FQxAL/KHUT0HJwiEL/afa2xmx/Mx08vh8EKwzhBR41SLOQfB/aS
         vFvH7q3QSpk1oMvD8nlqxDSalChHZw9ByYwussXOUPLCtcLT7QXY5hBaY0h+YALFyW6M
         1HpNR0SvUIwPPN413EVFPCGEu7ip3Ar55gqphCl122D3K1zq/+8/xW4F+oFR1zK61ypM
         pE2W69XY/zueN66zcG8z75TYaOPamEZ0C6nZBuML0BmZ7iK6HyG6uU6U7G0yHaYnszsC
         H5apxcfctCtqmVicQN5subgH3jPARfC+GKaOLnOAzw3nyttl5CHcmhLp959GNs2d7GcR
         4i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694978679; x=1695583479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rd2KWJyuRhrk0+vaz1G3192U+6/mB/ow0neMfCTO64I=;
        b=YjpooZfQaaF9COW6B1p1et1YDQeRWrsbra5mADHSE8LFQuRn6dT5E0gkAs1H/w5rbl
         eB2d97oZDuXGm+gxwVoKrUvI+m0rSURsCrzHmBaiWiQbHnMpXbBjbz/plL8oGoEne+1Q
         7PRvIfJvAMvJ5Pwm8Dm6ZNScz53mDZtZ1KU2FkLn6rW7uduYfr1nR/KFN9qdXKF+GoWd
         i5ZMjTreoK7EtnBEnUoXo0NTiaaLEl7J6Xb8zpe5HifFBxBIGYYuO5d7yMhYieK+kKUd
         AXWSFtTwazFD7rK4Je3+KR8SdLEAMDzykHcN4v1he8QUXk10msqtCKViuXX44uGe9iZr
         mDqw==
X-Gm-Message-State: AOJu0YxflHV/FmrBwnGxDJZ2KkJsDkzP0GMjCiWcWFbKfZRBygzwCygy
        LZ8yg/Dkl6pkDvDJv7IAuzM=
X-Google-Smtp-Source: AGHT+IHKEfxXKJc1r3cefnbbyTiqOs/Rsjba20EF558YafaCsa4UeNcIMu+n81D6NCNj2sPamgB3dg==
X-Received: by 2002:a05:6358:7251:b0:133:b42:69ca with SMTP id i17-20020a056358725100b001330b4269camr10059048rwa.18.1694978679021;
        Sun, 17 Sep 2023 12:24:39 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id y15-20020a0ce04f000000b0064743dd0633sm2844993qvk.106.2023.09.17.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 12:24:38 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     gitster@pobox.com, johannes.schindelin@gmx.de,
        me@yadavpratyush.com, git@vger.kernel.org
Cc:     Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-gui - use git-hook, honor core.hooksPath
Date:   Sun, 17 Sep 2023 15:24:31 -0400
Message-ID: <20230917192431.101775-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
References: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-gui currently runs some hooks directly using its own code written
before 2010, long predating git v2.9 that added the core.hooksPath
configuration to override the assumed location at $GIT_DIR/hooks.  Thus,
git-gui looks for and runs hooks including prepare-commit-msg,
commit-msg, pre-commit, post-commit, and post-checkout from
$GIT_DIR/hooks, regardless of configuration. Commands (e.g., git-merge)
that git-gui invokes directly do honor core.hooksPath, meaning the
overall behaviour is inconsistent.

Furthermore, since v2.36 git exposes its hook exection machinery via
git-hook run, eliminating the need for others to maintain code
duplicating that functionality.  Using git-hook will both fix git-gui's
current issues on hook configuration and (presumably) reduce the
maintenance burden going forward. So, teach git-gui to use git-hook.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8603437..3e5907a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -661,31 +661,8 @@ proc git_write {args} {
 }
 
 proc githook_read {hook_name args} {
-	set pchook [gitdir hooks $hook_name]
-	lappend args 2>@1
-
-	# On Windows [file executable] might lie so we need to ask
-	# the shell if the hook is executable.  Yes that's annoying.
-	#
-	if {[is_Windows]} {
-		upvar #0 _sh interp
-		if {![info exists interp]} {
-			set interp [_which sh]
-		}
-		if {$interp eq {}} {
-			error "hook execution requires sh (not in PATH)"
-		}
-
-		set scr {if test -x "$1";then exec "$@";fi}
-		set sh_c [list $interp -c $scr $interp $pchook]
-		return [_open_stdout_stderr [concat $sh_c $args]]
-	}
-
-	if {[file executable $pchook]} {
-		return [_open_stdout_stderr [concat [list $pchook] $args]]
-	}
-
-	return {}
+	set cmd [concat git hook run --ignore-missing $hook_name -- $args 2>@1]
+	return [_open_stdout_stderr $cmd]
 }
 
 proc kill_file_process {fd} {
-- 
2.41.0.99.19

