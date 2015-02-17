From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] read-cache.c: free cache entry when refreshing fails
Date: Tue, 17 Feb 2015 10:06:14 -0800
Message-ID: <1424196374-29509-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 17 19:06:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNmXU-0002dZ-Em
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 19:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbbBQSGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 13:06:24 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33354 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbbBQSGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 13:06:23 -0500
Received: by iecar1 with SMTP id ar1so42919400iec.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 10:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=86yiAyqkXio62ZnDGrcAAQMz8TRjdOk6BIWnzuG2Szg=;
        b=f8QFK5v7EjPS5HW1pTs1bp+5Qvbj/UVqpRMNwx6gknVo1M8JGkq03wt7MEJmQGBuEq
         OOB9MHSEjlUlr0wKcQYl5ubJtZsIWTwuZUf94I8SQernmnr24bNqDtRbFRmbt7qKz/Tl
         /Sn3wqzrFJ4/84BotkHD/eWUGh7NnkFzaBx+KVetXbmyVaDC2Uy+zbie6ZyUKtXqg2/I
         VJ1r7DLMaxexHHDQCRijaeIZxQepypxv3ryZvKm0geZmPYBeUhIE2kBIYosG7LlFRrUr
         dvV+Z8SFXmp+JmwGocdDVI41HT1jRx1iGcpqngBVvb0XM5S3LQqo4k1y0N0bUqN+RA1S
         iIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=86yiAyqkXio62ZnDGrcAAQMz8TRjdOk6BIWnzuG2Szg=;
        b=bjz0HhKVHZqj+ulUII4geljxUKrYf2dMmVeMfjT+vECBv8ejgVn+eBvKNuM7+iv/78
         u2MhnsYXaQkcLKvQsgW25AAFIhlzQC2Tp2/8Kf1JF11QSj2a5fYhTG31/+SxbsYvX2uW
         aqomEjeBDbaIOppyNwhv3nOI4m41gztEWI73QQanxyjNm3+YAhNYtdvy9w+N/mSxnHrX
         zUySX9KcYc2Yp/PCqETinOx6oCvyEoUmvPtCQlu4mAE0HGUWKIxj8Zn9kKBOaAZpdOgE
         poCV9mYFIMccaNS9RCFKKDMuwznM9iQ4n5Hh9ekmYXuI6izzJEbmVtSCVgkNjB+ogADL
         0cpw==
X-Gm-Message-State: ALoCoQniIhYD5kCYOksftlMJVB8T5ibbgi47Dbniqa0OysduUupbc0OInnxWTfvwmAIVoiepgp0u
X-Received: by 10.107.18.22 with SMTP id a22mr22752702ioj.48.1424196382625;
        Tue, 17 Feb 2015 10:06:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d457:48b:a341:557a])
        by mx.google.com with ESMTPSA id vk4sm10462924igc.11.2015.02.17.10.06.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Feb 2015 10:06:22 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263972>

This fixes a memory leak, when building the cache entries as
refresh_cache_entry may decide to return NULL in case of

I am not sure how severe this memory leak is as it was found by
scan.coverity.com, CID 290041.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9cff715..8d71860 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -725,7 +725,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 		unsigned int refresh_options)
 {
 	int size, len;
-	struct cache_entry *ce;
+	struct cache_entry *ce, *ret;
 
 	if (!verify_path(path)) {
 		error("Invalid path '%s'", path);
@@ -742,7 +742,13 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
-	return refresh_cache_entry(ce, refresh_options);
+	ret = refresh_cache_entry(ce, refresh_options);
+	if (!ret) {
+		free(ce);
+		return NULL;
+	} else {
+		return ret;
+	}
 }
 
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
-- 
2.3.0.81.gc37f363
