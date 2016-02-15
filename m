From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/4] remote: use skip_prefix
Date: Mon, 15 Feb 2016 18:42:27 +0100
Message-ID: <1455558150-30267-2-git-send-email-t.gummerer@gmail.com>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 18:43:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNBa-0001Qe-NE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 18:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbcBORnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 12:43:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34668 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbcBORnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 12:43:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id b205so9442999wmb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1htY4hLrSXNj5AZ4b7xaA2kfhCBVjaZuMtllQXh4bvw=;
        b=rcyKKsBdDx1KqJYkQ8HL6zaeDFu+Z/S+ZZ88EnQeV0EZ8Ga40whIjGZu1pOY1Tm0Hx
         mPCylipiU0jHbxALN2EVq4gVod9JxMRMsvzZVW51Eje3zfqUfuFcd3IkJmmyiOzMh2ub
         wnkMMAGcO4Zwc4ylKOXXlqj0UJiSxUV3UqI1nWGVOkpQES6yD3vYbsBoJZc3h2wcRLzu
         0VNO6Px0JeZhygfvCFXMHAutb2Np2dIIQageV441q8poz4wLqtwYlw2bblHIKN7vymTe
         JKs0gnIa7QXF+tNRPHhV5tGCDuY8E7Tl++no4rKLxzyNuakX0jySz4qNJFOXRvXlVuNz
         tmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1htY4hLrSXNj5AZ4b7xaA2kfhCBVjaZuMtllQXh4bvw=;
        b=HIXZtUhv3WuW+uramhtJELDCMzjpJKZyzEJ6aQC/6TRCqnQqp0eUbWRxNJrwvLnjbb
         yvpiEWcOlynn7slNiamtA0yNxtlVw3N/KfRUcJjYQsQK8fK6Vilf4h+M8uD1t1RZHHo/
         9J15aI+/g68JNV4t7fjxO1myQ84n0T6j2j6MDbl+gi6D1ynqPLTepmejVGdCIC5kKnMq
         uYHyOVsyQueykMvZWP5OZuJbdmL7oYYKwvCsCNkeL2ZgOKqwIRVqJvwrn9ghoOVVxmZj
         iJI1MsnAw8Y0kZejtqJB4hcuVrAQ83LPJ0JYc72Sp+ae9lVnSD1piwNzFhTNr2u09IZH
         4rgw==
X-Gm-Message-State: AG10YORGa79Y72qiSnd5qnoY3hDb+CUyC1NLPY3nMa44DFnTdfQo3yAlhvxcdQAlalPJ7Q==
X-Received: by 10.195.13.16 with SMTP id eu16mr19527383wjd.140.1455558220431;
        Mon, 15 Feb 2016 09:43:40 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id b203sm16638709wmh.8.2016.02.15.09.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 09:43:39 -0800 (PST)
X-Mailer: git-send-email 2.7.1.410.g6faf27b
In-Reply-To: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286215>

95b567c7 ("use skip_prefix to avoid repeating strings") transformed
calls using starts_with() and then skipping the length of the prefix to
skip_prefix() calls.  In remote.c there are a few calls like:

  if (starts_with(foo, "bar"))
      foo += 3

These calls weren't touched by the commit mentioned above, but can
benefit from the same treatment to avoid magic numbers.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 remote.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 02e698a..4b5b576 100644
--- a/remote.c
+++ b/remote.c
@@ -321,8 +321,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
-	if (starts_with(key, "branch.")) {
-		name = key + 7;
+	if (skip_prefix(key, "branch.", &name)) {
 		subkey = strrchr(name, '.');
 		if (!subkey)
 			return 0;
@@ -338,9 +337,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		}
 		return 0;
 	}
-	if (starts_with(key, "url.")) {
+	if (skip_prefix(key, "url.", &name)) {
 		struct rewrite *rewrite;
-		name = key + 4;
 		subkey = strrchr(name, '.');
 		if (!subkey)
 			return 0;
@@ -357,9 +355,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		}
 	}
 
-	if (!starts_with(key,  "remote."))
+	if (!skip_prefix(key, "remote.", &name))
 		return 0;
-	name = key + 7;
 
 	/* Handle remote.* variables */
 	if (!strcmp(name, "pushdefault"))
-- 
2.7.1.410.g6faf27b
