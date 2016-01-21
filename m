From: David Turner <dturner@twopensource.com>
Subject: [PATCH] unpack-trees: fix accidentally quadratic behavior
Date: Wed, 20 Jan 2016 23:05:56 -0500
Message-ID: <1453349156-12553-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 05:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM6Vp-0004p1-UE
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 05:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbcAUEGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 23:06:18 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37994 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbcAUEGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 23:06:16 -0500
Received: by mail-ig0-f176.google.com with SMTP id mw1so26100533igb.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 20:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/t0cKXRIU3IjeFv3X0HOWevUC99SuDQ3BMXcN6eRNlg=;
        b=GtffbBbFXZ0LpOCU8h78/Ou/afK0uHGYOZtwDt4qSn2dyzGIe6l/npJdfRXuWjTzFu
         u9Zk+n7Wt1DuuNhVabldDl9vqiTJAyE9iqtAyufCDW1/kzws7nDyh4dAM+xrHHY2na2W
         ig0WpUvjOkeGkEaX26PXAbDG5f1qvksm0290NF5j6Cqjv3H7OBWQGQBcsAm4zqWZoFBn
         e4SZM5RB5hrqTVy1rN1tugJ8oCgn+AUDR5ZAUxTJPNaEKCgNVYaO2YPb+fPpGhfZokYS
         DTXQRFyQIRVeeSfgrrZ+m8loV1Dsr4hSbzDuyWFpQBgq1iCqveI/EOt4iF4ZFPDzPEif
         LRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/t0cKXRIU3IjeFv3X0HOWevUC99SuDQ3BMXcN6eRNlg=;
        b=D8DOkeyIi8B9r+KQQIXfnIYMXBVqN5I5UkbEkWyMOrj5OJwf2/W1VkCUCOnlyU7cII
         oFG/2/5QB6DjcnX0sx0C1LgBh2X6VVv0oWI7Aa6f9H3Ylm61S7hJVaaCuwzFb5xOSaXX
         3LsNbW0UgtvemF15dN/Zrjc5axnKPjri2GoDxt0xD5s1hi2ortWV26lxlj6k2OY+KqOB
         +Ygc7NuF3qeT9KH21KMEvtJ4zsxzXitIsZ4FlWQ5C5JrWnu0wL54NaOWdEFt6fNetbQi
         eOERjPm+HLacVLZwixW1Kqvz8ZLBpc/ZcrJYp8Hnyd9aez+gOE8VAKjrIh041mGKM9le
         DhVA==
X-Gm-Message-State: AG10YOTM7JBrMgPKmE6+sWa3sd/CrHy4VK/hMlh37cMMr8ZjiQccy4Eld+9qP1CtrCfy8w==
X-Received: by 10.50.61.234 with SMTP id t10mr7703063igr.20.1453349176176;
        Wed, 20 Jan 2016 20:06:16 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id p8sm517636ioe.38.2016.01.20.20.06.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jan 2016 20:06:15 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284500>

While unpacking trees (e.g. during git checkout), when we hit a cache
entry that's past and outside our path, we cut off iteration.

This provides about a 45% speedup on git checkout between master and
master^20000 on Twitter's monorepo.  Speedup in general will depend on
repostitory structure, number of changes, and packfile packing
decisions.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 unpack-trees.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5f541c2..b18a611 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -695,8 +695,25 @@ static int find_cache_pos(struct traverse_info *info,
 				++o->cache_bottom;
 			continue;
 		}
-		if (!ce_in_traverse_path(ce, info))
+		if (!ce_in_traverse_path(ce, info)) {
+			/*
+			 * Check if we can skip future cache checks
+			 * (because we're already past all possible
+			 * entries in the traverse path).
+			 */
+			if (info->prev && info->traverse_path) {
+				int prefix_cmp = strncmp(ce->name, info->traverse_path, info->pathlen);
+				if (prefix_cmp > 0)
+					break;
+				else if (prefix_cmp == 0 &&
+					 ce_namelen(ce) >= info->pathlen &&
+					 strcmp(ce->name + info->pathlen,
+						 info->name.path) > 0) {
+					break;
+				}
+			}
 			continue;
+		}
 		ce_name = ce->name + pfxlen;
 		ce_slash = strchr(ce_name, '/');
 		if (ce_slash)
-- 
2.4.2.749.g730654d-twtrsrc
