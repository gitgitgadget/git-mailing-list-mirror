From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/12] git submodule update: Handle unmerged submodules in C
Date: Thu, 15 Oct 2015 18:52:07 -0700
Message-ID: <1444960333-16003-7-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCQ-0002W9-SH
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbbJPBwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:46 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33664 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbbJPBwX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:23 -0400
Received: by pabrc13 with SMTP id rc13so104121478pab.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bJYR/de2fC3VMy4MVpjJGce8+e02Ek/ifVuQyAoLooc=;
        b=KOl6raChTcOYXSyJnbvQqArncGcWTlVpcGsLngSLfPnhxEx/FmYJux215F3V05WtuS
         m5qpIo7zBPaHOOA2YTq2nRaO80gg8Xpd1Gk+w1efbQ/GU4f4EYheTmZ2dqGPJtdsyKlQ
         xeJZq7yrR8gruBhOOF/opSCP2EWBYPeyOLfY03sdpZdPXTCkeRfX6LFdMi0rlLyUgryW
         sqTuvvUxkkzX7Zu2d7IML32EqS2sfvKfHvK896OvVjCiyayHKUv5dIm/Lr0BNupEZVeC
         aGSQx7z1cw+uFnAOyEtG6UW5d89kQAp8pLPZSaty8mSKWONwV3gNW8aR8hzmmjBy0KIR
         f0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bJYR/de2fC3VMy4MVpjJGce8+e02Ek/ifVuQyAoLooc=;
        b=h8rWQEpX7derUUH2F4CESqM+abPFKiqGs+hhbLB0bJxxk4GpA99VuDB3mE3JqHlqHx
         jfbe0WdKuO/TmtF/d/VZvdngUGhD0ljcbbXTIzTjwXsrdqLgKHI1ioWFF6FWgwOHi9YS
         1IXbYQ7Jnj+PDtBhkVZPAgl9zvVH8AtWksU3NzIIgoRyvfBjKEEEDcfP/f5QX/sI/cJA
         0WTGU+UJuWYCiEYoM2UtexKX2yWOE7kk8puZmEPK8wYVgT/FfXilQM1UiGixGmxAIpQ1
         dVfp3CVeqndA8Gok5HMKKZopLyn/1XHdXfmlOQq582eskd64r2EF92yGXPqsyo/1FTEm
         6sBQ==
X-Gm-Message-State: ALoCoQmz49N/P7sGjUiKvONKz1vtVNF8Rw5O8rjzBjabnGA9adVPqFMnQOwQZR0gru4zWpHOiZrq
X-Received: by 10.69.26.101 with SMTP id ix5mr13335476pbd.144.1444960343166;
        Thu, 15 Oct 2015 18:52:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id zk3sm570512pbb.41.2015.10.15.18.52.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:22 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279723>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 15 +++++++++++----
 git-submodule.sh            |  6 +-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 47dc9cb..f81f37a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -284,11 +284,18 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < list.nr; i++) {
 		const struct cache_entry *ce = list.entries[i];
 
-		if (ce_stage(ce))
-			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
-		else
-			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
+		char *env_prefix = getenv("prefix");
+		if (ce_stage(ce)) {
+			if (env_prefix)
+				fprintf(stderr, "Skipping unmerged submodule %s/%s",
+					env_prefix, ce->name);
+			else
+				fprintf(stderr, "Skipping unmerged submodule %s",
+					ce->name);
+			continue;
+		}
 
+		printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
 		utf8_fprintf(stdout, "%s\n", ce->name);
 	}
 	return 0;
diff --git a/git-submodule.sh b/git-submodule.sh
index d2d80e2..0754ecd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -661,11 +661,7 @@ cmd_update()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		if test "$stage" = U
-		then
-			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
-			continue
-		fi
+
 		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		if ! test -z "$update"
-- 
2.5.0.277.gfdc362b.dirty
