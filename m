From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 03/11] read-cache.c: replace `git_config()` with `git_config_get_*()` family
Date: Thu,  7 Aug 2014 09:21:18 -0700
Message-ID: <1407428486-19049-4-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQTA-0005pf-5z
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbaHGQXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:23:05 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49291 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbaHGQXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:23:04 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so5439120pdb.41
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgWpILg19c//jivMhLCVnH3LtNjiFZyt2MH9YA1rJ6Y=;
        b=MdKZm6w0pAsJekkS9VUq97iaLjcnB5qGOZjodbV2nB5sXK7ynJoow9atKIhgx+imim
         jYtrHWujtALTpr9yxTLVhjnhorSvvn+XPuMRjHjf/LTgCHMxGaKdPPilPD/89Q6eARPg
         DYMxxbJm9a/vZ4dERCybgj8jZAEyRJnn8dibqrLDPewHOXAt3SeG6w5m5vDQ+DPAwXl7
         9VuKBG6u7VkHqdrfjqqpVMYQAnPFhw4slGNKM2RRPzs3XBYGVBIQkyqksX2DZZKn0Wnt
         QLiSGmHzJZYOD0HWLDOlv3cov1N8Pzu5Y4kWIURmHJWHFT2H19oWyQx987k64mgb0kWn
         78Gg==
X-Received: by 10.66.117.38 with SMTP id kb6mr18298708pab.37.1407428583911;
        Thu, 07 Aug 2014 09:23:03 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.23.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:23:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254966>

Use `git_config_get_*()` family instead of `git_config()` to take
advantage of the config-set API which provides a cleaner control flow.

Use an intermediate value, as `version` can not be used directly in
git_config_get_int() due to incompatible type.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 read-cache.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5d3c8bd..acb132d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1238,24 +1238,16 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 
 #define INDEX_FORMAT_DEFAULT 3
 
-static int index_format_config(const char *var, const char *value, void *cb)
-{
-	unsigned int *version = cb;
-	if (!strcmp(var, "index.version")) {
-		*version = git_config_int(var, value);
-		return 0;
-	}
-	return 1;
-}
-
 static unsigned int get_index_format_default(void)
 {
 	char *envversion = getenv("GIT_INDEX_VERSION");
 	char *endp;
+	int value;
 	unsigned int version = INDEX_FORMAT_DEFAULT;
 
 	if (!envversion) {
-		git_config(index_format_config, &version);
+		if (!git_config_get_int("index.version", &value))
+			version = value;
 		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
 			warning(_("index.version set, but the value is invalid.\n"
 				  "Using version %i"), INDEX_FORMAT_DEFAULT);
-- 
1.9.0.GIT
