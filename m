From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH V3 2/2] fetch --prune: Run prune before fetching
Date: Thu,  2 Jan 2014 20:28:52 -0600
Message-ID: <1388716132-71437-2-git-send-email-jackerran@gmail.com>
References: <1388716132-71437-1-git-send-email-jackerran@gmail.com>
Cc: gitster@pobox.com, Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 03 03:29:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyuW6-0000yx-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 03:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbaACC3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 21:29:24 -0500
Received: from mail-qe0-f42.google.com ([209.85.128.42]:46406 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbaACC3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 21:29:18 -0500
Received: by mail-qe0-f42.google.com with SMTP id b4so15126758qen.15
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 18:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48hdfkGhCKCoThpo35R9iHweZXrz9asIZBL+4iBmz2Y=;
        b=PO5vxEPXFl03J0lYfBRukM5OE9jnfHPIJCU8TPJgk9bD4I++ybOLxmqSh91QuEWBmX
         9FVjB7FchKIVkQe373NbhqWfFxB3Kwl9Xwj2mp6e/dk0naOX1XNV92wb+a0tV2jO5uVN
         kaMPm4pMeUBer0pw/Re8NkAX8ilsijRaarXqKnArs+9fo9FchOf5Uuj4Uhxw4h2jTml+
         KTpbcURa5KND9SE20xHf1jdyrObdgF4F4Bm9AEj5eAAwefU7ROTtCPFNFvccFsWOWCVq
         uobOV3+HbQWLlndHJaBhmDarYusQquBxa5ufF7NnYg96/PhEME8tUkdtKy1YdkwPJnD/
         /Axg==
X-Received: by 10.49.36.161 with SMTP id r1mr147273649qej.4.1388716158029;
        Thu, 02 Jan 2014 18:29:18 -0800 (PST)
Received: from localhost.localdomain (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id l17sm77375236qej.13.2014.01.02.18.29.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 18:29:17 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.231.g4834e63.dirty
In-Reply-To: <1388716132-71437-1-git-send-email-jackerran@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239901>

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
Acked-by: Junio C Hamano <gitster@pobox.com>
---

I did change the commit message according to Junio's suggestion in the
first patch.

 builtin/fetch.c  | 10 +++++-----
 t/t5510-fetch.sh | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1b81cf9..09825c8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -863,11 +863,6 @@ static int do_fetch(struct transport *transport,
 
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
@@ -883,6 +878,11 @@ static int do_fetch(struct transport *transport,
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
index 87e896d..12674ac 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -626,4 +626,18 @@ test_expect_success 'fetch --prune prints the remotes url' '
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
1.8.5.2.231.g4834e63.dirty
