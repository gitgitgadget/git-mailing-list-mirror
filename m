From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH 3/3] fetch --prune: Repair branchname DF conflicts
Date: Wed, 18 Dec 2013 15:22:56 -0600
Message-ID: <1387401776-30994-3-git-send-email-jackerran@gmail.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
Cc: Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 22:23:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtOaY-0005U0-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 22:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab3LRVXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 16:23:16 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:55342 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab3LRVXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 16:23:14 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so197750qcy.40
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 13:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Kwx3wKbfMy7pDjbaJHriR47gmKVleewn6MrR36PbG4=;
        b=f2YdF9oMdd8IkXTL2sA4NvmfPbz7e67AKZAKwjJcYMD+tFDZXv1ahEAm9N0Wxa0HNi
         4jgN6Z3cmhyf/wrbxxHaQNXD/CcSkzCN0QQyG1SQOK6js9F1SVhFM3/IyNnuqXcm+hZn
         82mK9oiqdZzg4rcWpWZfRCxkLAF2Bo2YWlUj/Xbv/RQ4vwAFlnk/pVOflWa2oprt+yjg
         8nG7N/h3EMqc7crFDSVQSb1kuRn872L2Yo6z/L5hHN76YRrTwvcxT0pmQ/hYZpjmb2X0
         mbwQG+8+zSAqm5kOkNQ2NRDB2WBR4HWSVBWdi24uNuMbb5gQjsjuF6TMJyVdx24J/nfV
         FGiQ==
X-Received: by 10.49.30.197 with SMTP id u5mr57544335qeh.33.1387401794054;
        Wed, 18 Dec 2013 13:23:14 -0800 (PST)
Received: from localhost.localdomain (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id 4sm3512957qak.11.2013.12.18.13.23.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 13:23:13 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.163.gd7aced9
In-Reply-To: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239488>

When a branchname DF conflict occurs during a fetch, --prune should
be able to fix it. When fetching with --prune, the fetching process
happens before pruning causing the branchname DF conflict to persist
and report an error. This patch prunes before fetching, thus
correcting DF conflicts during a fetch.

Signed-off-by: Tom Miller <jackerran@gmail.com>
Tested-by: Thomas Rast <tr@thomasrast.ch>
---
 builtin/fetch.c  | 10 +++++-----
 t/t5510-fetch.sh | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e50b697..845c687 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -868,11 +868,6 @@ static int do_fetch(struct transport *transport,
 
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
@@ -888,6 +883,11 @@ static int do_fetch(struct transport *transport,
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
index 5d4581d..a981125 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -614,4 +614,18 @@ test_expect_success 'all boundary commits are excluded' '
 	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
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
1.8.5.1.163.gd7aced9
