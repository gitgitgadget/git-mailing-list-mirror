From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH V2 2/2] fetch --prune: Run prune before fetching
Date: Thu, 19 Dec 2013 16:57:12 -0600
Message-ID: <1387493832-13588-2-git-send-email-jackerran@gmail.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
 <1387493832-13588-1-git-send-email-jackerran@gmail.com>
Cc: Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 19 23:57:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtmX4-0000dt-Tg
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 23:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab3LSW52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 17:57:28 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:46396 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab3LSW50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 17:57:26 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so1736944qec.9
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 14:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3rBtt23xN6zTDe6oMli3JvQ01pV560wOEwLC5o0PFhI=;
        b=hzz+Fd+3z9fjT2fR4znUN7brl0iSuHz6QptLu6EF9k8oE4pqxMLu1jTUlgHRlPofIk
         LwNDPPbr99CLOMpaQ9sd4WpSlBvLQOOtLQzqhAsoFcYinHhxZj9LoS2dQ+XgDSKcEzt+
         7Oe+fBBKtLAbvNVrIuCR4aiW+F1bGgf83/4uIeTmJJwUYWIu1RTPF6d+ahJf4S647v2w
         0bVu7ibvgulFKaKTEIBFIXnfVpBKkMqGhQUkl+/lHV7IZMoo2VGnQl3IyxjZPb/B1Q6o
         kW00Lpo39CnoF5toOD4Up/MwKbvX15CcRUliBZnMI6PbTXCo/y6AG43/NgLa0T04/4Li
         d0+g==
X-Received: by 10.224.8.132 with SMTP id h4mr7914985qah.103.1387493845857;
        Thu, 19 Dec 2013 14:57:25 -0800 (PST)
Received: from localhost.localdomain (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id c6sm3068737qev.15.2013.12.19.14.57.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 14:57:25 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.194.g00457d4
In-Reply-To: <1387493832-13588-1-git-send-email-jackerran@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239552>

When we have a remote-tracking branch named "frotz/nitfol" from a
previous fetch, and the upstream now has a branch named "frotz". Prior
to this patch fetch would fail to remove "frotz/nitfol" with a "git
fetch --prune" from the upstream. git would inform the user to use "git
remote prune" to fix the problem.

This patch changes the way "fetch --prune" works by moving the pruning
operation before the fetching operation. Instead of warning the user of
a conflict, it autmatically fixes it.

Signed-off-by: Tom Miller <jackerran@gmail.com>
Tested-by: Thomas Rast <tr@thomasrast.ch>
---
 builtin/fetch.c  | 10 +++++-----
 t/t5510-fetch.sh | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e6dc2d6..ef3f0bb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -855,11 +855,6 @@ static int do_fetch(struct transport *transport,
 
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
-	if (fetch_refs(transport, ref_map)) {
-		free_refs(ref_map);
-		retcode = 1;
-		goto cleanup;
-	}
 	if (prune) {
 		/*
 		 * We only prune based on refspecs specified
@@ -875,6 +870,11 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
+	if (fetch_refs(transport, ref_map)) {
+		free_refs(ref_map);
+		retcode = 1;
+		goto cleanup;
+	}
 	free_refs(ref_map);
 
 	/* if neither --no-tags nor --tags was specified, do automated tag
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 08a4841..3e64af4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -626,4 +626,18 @@ test_expect_success 'fetch --prune prints the remotes full url' '
 	test_cmp expect actual
 '
 
+test_expect_success 'branchname D/F conflict resolved by --prune' '
+	git branch dir/file &&
+	git clone . prune-df-conflict &&
+	git branch -D dir/file &&
+	git branch dir &&
+	(
+		cd prune-df-conflict &&
+		git fetch --prune &&
+		git rev-parse origin/dir >../actual
+	) &&
+	git rev-parse dir >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.5.2.194.g00457d4
