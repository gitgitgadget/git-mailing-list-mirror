From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] pathspec: get non matching arguments without reporting.
Date: Thu,  5 May 2016 15:59:57 -0700
Message-ID: <1462489197-30616-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 06 01:00:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aySFz-0001ex-61
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812AbcEEXAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:00:23 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34616 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011AbcEEXAB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:00:01 -0400
Received: by mail-pf0-f179.google.com with SMTP id y69so42126627pfb.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 16:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+E2PalMDV33dah69ho1OD8zG8Bsvhw29R1HD0xTewUA=;
        b=af7HmTLWVgE+8sdBTdgn+ljxKg2wVH+BRByEnZQYd4kzmcQQQ/0P0SOErmBhiD0QIM
         CbqXsAPSfV3903U6EnCdPkZqVubdfaepRct8U6dv7uqCQZYvGau+FoH8slv31ztFtKlP
         yXBp4woxWw0k7UtMkPJvRomWSrIu/JRGf93BQRLMiVQFjMpkiIEeR5SHjIyaCIk2kUVf
         9G8ZdxI+Dy4cJtvh+BQx+BTWpbwq1iYE2riJvAx4M+DG+tcagmaYMIGCpnQYePdCzv/W
         TwcD3K215iy55yDxzfixJ/0E0sF8dUuqoL0ELu3bMmASUBXpyaSSgENxf7fAVImtSZ48
         OfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+E2PalMDV33dah69ho1OD8zG8Bsvhw29R1HD0xTewUA=;
        b=hYwUMQ0ptzmKUEbcnogKXyECeh2cPLZXg/uQ/54k5niI4c9ZQEDLnmZc+zzMahHvL8
         iF2UO+g+pQkgdJQt3jhEn9sSRqNdW2QhOsAutUo1czLxfgrs23IAA8XlaP07+5wzDc4n
         l/y3yfUAh9QsBtS+dIg+rKflCfrWEXxUQXo2Wh8JL2JaxjeTRxXQYamd7WXzC2Gfk+SE
         OYXfYWDwOPBDejlPxHKr7E0/qb74OJKs+eIjjRH8CBfzLcYhtIYnHcaYyiwpsuUYkaWz
         /iMvv/3xO+9aoGbbXwkT9SPCpZ9jCY92mWaShdgzCF375bo5Xygi2TlrBTPzw6335ZC0
         mpDg==
X-Gm-Message-State: AOPr4FUuWCl7Qdjhqw0J8JO6EWJi7S34EC+JlDZYSJIwYHQHeXi6MOSIxSjKHKrPhx2H384h
X-Received: by 10.98.50.67 with SMTP id y64mr24444122pfy.128.1462489200280;
        Thu, 05 May 2016 16:00:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:35ed:c390:3d1b:b3bd])
        by smtp.gmail.com with ESMTPSA id g84sm16036415pfj.42.2016.05.05.15.59.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 May 2016 15:59:59 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.1.g3af9c03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293720>

When giving more than just pathspec arguments (e.g. submodule labels),
we need a way to check all non-matching arguments for the pathspec parsing
if these are the submodule labels or typos.

This patch prepares for that use case by splitting up `report_path_error`
into a new checking function `unmatched_pathspec_items` and a
reporting callback.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  So I imagine the unmatched_pathspec_items to be used later similar as
  in report_path_error, maybe just like this:

void submodule_list_fn(const struct pathspec *pathspec,
			  int pathspec_index,
			  void *data_cb)
{
	if (submodule_label_exist(pathspec->items[pathspec_index].original))
		// ok, record in data_cb
	else
		error(" '%s' is neither recognized as matching pathspec nor did it
			match any submodule label",
			pathspec->items[pathspec_index].original);
}

submodule_list(const char *ps_matched,
		 const struct pathspec *pathspec,
		 const char *prefix)
{
	struct string_list detected_labels;
	unmatched_pathspec_items(ps_matched, pathspec, prefix,
				submodule_list_fn, &detected_labels);
	
	foreach (submodule s) { 
		if matches_pathspec(s, pathspec) or label_match(s, detected_labels)
			// do a thing
		else
			continue
	}
}

What do you think of such a design? Is it worth carrying and polishing or
would there be another way to do it which matches the pathspec mechanism better?

Thanks,
Stefan

 dir.c | 36 ++++++++++++++++++++++++++----------
 dir.h |  8 ++++++++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index a4a9d9f..bc8b199 100644
--- a/dir.c
+++ b/dir.c
@@ -394,14 +394,13 @@ int match_pathspec(const struct pathspec *ps,
 	return negative ? 0 : positive;
 }
 
-int report_path_error(const char *ps_matched,
-		      const struct pathspec *pathspec,
-		      const char *prefix)
+void unmatched_pathspec_items(const char *ps_matched,
+			     const struct pathspec *pathspec,
+			     const char *prefix,
+			     unmatched_pathspec_items_fn fn,
+			     void *data_cb)
 {
-	/*
-	 * Make sure all pathspec matched; otherwise it is an error.
-	 */
-	int num, errors = 0;
+	int num;
 	for (num = 0; num < pathspec->nr; num++) {
 		int other, found_dup;
 
@@ -428,10 +427,27 @@ int report_path_error(const char *ps_matched,
 		if (found_dup)
 			continue;
 
-		error("pathspec '%s' did not match any file(s) known to git.",
-		      pathspec->items[num].original);
-		errors++;
+		fn(pathspec, num, data_cb);
 	}
+}
+
+void report_path_error_fn(const struct pathspec *pathspec,
+			  int pathspec_index,
+			  void *data_cb)
+{
+	int *errors = data_cb;
+	error("pathspec '%s' did not match any file(s) known to git.",
+	      pathspec->items[pathspec_index].original);
+	(*errors)++;
+}
+
+int report_path_error(const char *ps_matched,
+		      const struct pathspec *pathspec,
+		      const char *prefix)
+{
+	int errors = 0;
+	unmatched_pathspec_items(ps_matched, pathspec, prefix,
+				report_path_error_fn, &errors);
 	return errors;
 }
 
diff --git a/dir.h b/dir.h
index cd46f30..ea222eb 100644
--- a/dir.h
+++ b/dir.h
@@ -211,6 +211,14 @@ extern char *common_prefix(const struct pathspec *pathspec);
 extern int match_pathspec(const struct pathspec *pathspec,
 			  const char *name, int namelen,
 			  int prefix, char *seen, int is_dir);
+typedef void (*unmatched_pathspec_items_fn)(const struct pathspec *pathspec,
+					    int pathspec_index,
+					    void *data_cb);
+void unmatched_pathspec_items(const char *ps_matched,
+			     const struct pathspec *pathspec,
+			     const char *prefix,
+			     unmatched_pathspec_items_fn fn,
+			     void *data_cb);
 extern int report_path_error(const char *ps_matched, const struct pathspec *pathspec, const char *prefix);
 extern int within_depth(const char *name, int namelen, int depth, int max_depth);
 
-- 
2.8.0.1.g3af9c03
