Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D51E20958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935898AbdCWVJd (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:09:33 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36385 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932579AbdCWVJb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:09:31 -0400
Received: by mail-pg0-f47.google.com with SMTP id g2so129052973pge.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vFPqiOkGii2OxBSgW4QscLl1aMDEhU0GV/fhpWh+ZWQ=;
        b=WA8JnOd3zH015yQO/KFWrZT41Jozu/3rb+MTOUQhzDhUylJgyhknT1TAJr41QAL190
         HHRYnxvXLqpFYUO6gMRiAmUeZBx2Sv0WeJKQkm7gsi57wPmXgK8SLhG7PWr10NFbmE0F
         eh6UAaDgo8mf84WFlWICLxqPRVGAd/uqW9oABk9TmfByt+y4hNCBzX7KTZhMqtAFaK0M
         Shi1yYIAj878BFvh0kaxp4OGAx5V3Ay1vgBUZGj+tlaFfGDnFRXjU1+laIreKq/95sRT
         P2Py+JALIZ4yO1YWACqLPadQL+hv+ZcaFXN2/0QZaClsoyVvEsdl4tWb5QjUOJrOZ/pJ
         KWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vFPqiOkGii2OxBSgW4QscLl1aMDEhU0GV/fhpWh+ZWQ=;
        b=Z7emVb7ZGRa+8UvR7cAPcEkvbsic49E6TSRSjpjj/CCwcGn5FSEr/aGxFhFWZQHC0p
         TGScJ2IN2rlrmsLFYmv9ghnsxBU985qeHEzAhaU9glhXBe+jZ5+iyCfmPUy+DVwZDEwi
         M9gG/j9McqYnnkOch9x9ShP+cNlJsbTQ9To9VLqSOvHCHh+cIaLU7MSC5X+fYM4OfjbP
         fynvrlual0o/rZW2sUstLrgFszxHewVx2mvVCnhi/LkernWEy/M/BOmBgrOHWMiYH3lb
         igD/IGJhSjngn+IND9IZ557DIttL46+p3tyzYCAGJaD+rMOJktHfMTux4GXj04ASy47w
         cH4Q==
X-Gm-Message-State: AFeK/H1XfFHmuXoDxG9S2ptOzLsmKKK9Jc/5kyhy2N8F9GDMoP3iPunDqBVXAa19+UdMlL4D
X-Received: by 10.84.141.36 with SMTP id 33mr566609plu.81.1490303370338;
        Thu, 23 Mar 2017 14:09:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id q64sm184244pfi.69.2017.03.23.14.09.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 14:09:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/8] submodule.c: convert is_submodule_modified to use strbuf_getwholeline_fd
Date:   Thu, 23 Mar 2017 14:09:19 -0700
Message-Id: <20170323210924.26818-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323210924.26818-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323210924.26818-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of implementing line reading yet again, make use of our beautiful
library functions.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/submodule.c b/submodule.c
index dc61ca7103..f01e84faff 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1041,11 +1041,9 @@ int fetch_populated_submodules(const struct argv_array *options,
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
-	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	unsigned dirty_submodule = 0;
-	const char *line, *next_line;
 	const char *git_dir;
 
 	strbuf_addf(&buf, "%s/.git", path);
@@ -1072,10 +1070,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	if (start_command(&cp))
 		die("Could not run 'git status --porcelain' in submodule %s", path);
 
-	len = strbuf_read(&buf, cp.out, 1024);
-	line = buf.buf;
-	while (len > 2) {
-		if ((line[0] == '?') && (line[1] == '?')) {
+	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
+		if ((buf.buf[0] == '?') && (buf.buf[1] == '?')) {
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
 				break;
@@ -1085,12 +1081,6 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
 				break;
 		}
-		next_line = strchr(line, '\n');
-		if (!next_line)
-			break;
-		next_line++;
-		len -= (next_line - line);
-		line = next_line;
 	}
 	close(cp.out);
 
-- 
2.12.1.438.gb674c4c09c

