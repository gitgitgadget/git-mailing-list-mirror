From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/13] rerere: stop looping unnecessarily
Date: Tue, 30 Jun 2015 23:04:53 -0700
Message-ID: <1435730699-9124-8-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:05:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9L-0004LR-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbbGAGFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:30 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33922 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbbGAGFN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:13 -0400
Received: by iebmu5 with SMTP id mu5so27660419ieb.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=RQ4B0Lx1VRIMqjXYZlTfzLyS1T6o511hCDANIQlLxQs=;
        b=e4qBrhzMr35xCt5gqLnYfY+W0WLaZ6HJnMMUosU8DxEk0kJibvVPeORAf0sfs+quI4
         pBDFt9pK0gnPjKFXaQb4w+BTpS8q2ZXP1BF18pNWNZkCqHA6tEF/lEfhDzaks3BDPiPG
         rM0h66ZqTPng2KqLhsw3l7e9pwP0etgZsmPLKUtjwZKIIKpoBDSaowkg1d3ka8M/BFTt
         xsQPjxoorV1nN5GrI2AwgNjbapUT4mP4maq6jbLl0PRs3hgDWR6qm27W2eP8hiiS6hLk
         xgqW4Xeq/zOgHldeoRwge1PWs57uJDYzPp/NNYdJfv2sju3gogdW4hFDOy8cKv/ueH4p
         3VvQ==
X-Received: by 10.50.225.40 with SMTP id rh8mr2334914igc.39.1435730712483;
        Tue, 30 Jun 2015 23:05:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id y6sm979103igl.17.2015.06.30.23.05.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273124>

handle_cache() loops 3 times starting from an index entry that is
unmerged, while ignoring an entry for a path that is different from
what we are looking for.

As the index is sorted, once we see a different path, we know we saw
all stages for the path we are interested in.  Just loop while we
see the same path and then break, instead of continuing for 3 times.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/rerere.c b/rerere.c
index 4c45f55..7b1419c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -329,24 +329,21 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 		return -1;
 	pos = -pos - 1;
 
-	for (i = 0; i < 3; i++) {
+	while (pos < active_nr) {
 		enum object_type type;
 		unsigned long size;
-		int j;
 
-		if (active_nr <= pos)
-			break;
 		ce = active_cache[pos++];
 		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
-			continue;
-		j = ce_stage(ce) - 1;
-		mmfile[j].ptr = read_sha1_file(ce->sha1, &type, &size);
-		mmfile[j].size = size;
+			break;
+		i = ce_stage(ce) - 1;
+		mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
+		mmfile[i].size = size;
 	}
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 3; i++)
 		if (!mmfile[i].ptr && !mmfile[i].size)
 			mmfile[i].ptr = xstrdup("");
-	}
+
 	/*
 	 * NEEDSWORK: handle conflicts from merges with
 	 * merge.renormalize set, too
-- 
2.5.0-rc0-209-g5e1f148
