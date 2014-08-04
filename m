From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 03/11] read-cache.c: replace `git_config()` with `git_config_get_*()` family
Date: Mon,  4 Aug 2014 11:33:41 -0700
Message-ID: <1407177229-30081-4-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:35:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN5x-0007lT-0j
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbaHDSer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:34:47 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50524 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaHDSeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:34:44 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so10517202pad.13
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgWpILg19c//jivMhLCVnH3LtNjiFZyt2MH9YA1rJ6Y=;
        b=PyGH7/k1SkE/oXxXtrPIlzoEgajbRV+fQ2XQ1tp//bLvekYaipBm/jgNdBtG8DvfXR
         vtHZA4nlZOuR4Me/tPFqN2zQXIhQ5MVWTzVaIZ9Tc8QaI2mAkzfK0lVz2OobQcf3HxKs
         K4kHrYyprb3yIfnxwfW6xz3L5PTejicDQ3fSFB/xJfDZtatBEKoLOvkIlNNfFMQHGA4h
         INUbG9DIOgUZ5hWv7a/eY0S+alrhhQ8HKWTasE1gT3oJTz16ZwXft60uDyMDOUZ8YzzO
         mQhrAxcf239/WL7IgZFZqov4D0vX27ThJ8NUZeSW47VYPp7tWG2KfpEsL4Hivhe3gaYT
         gDRw==
X-Received: by 10.68.129.99 with SMTP id nv3mr4514176pbb.128.1407177284436;
        Mon, 04 Aug 2014 11:34:44 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.34.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:34:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254758>

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
