From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 04/11] archive.c: replace `git_config()` with `git_config_get_bool()` family
Date: Thu,  7 Aug 2014 09:21:19 -0700
Message-ID: <1407428486-19049-5-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQTA-0005pf-MZ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbaHGQXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:23:08 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38720 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbaHGQXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:23:07 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so5668636pac.18
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SWduK/SNCIXmZHZbmZIT3Mj2UBSXoR5qbnObetIfmsI=;
        b=Q25+XzC4vfg0m1RyNPOHPEcJN9QXYOvE082YqXEgYGWGE7bCnyQQlvphvfVxte0Cyg
         WSmX+DvsJO9h2Z4Sdvo/J+Yv5b+o9r8YzhP/9gwcgJ9p14qmDdDFedijLwBjxQYL+pnR
         9bjhfdNDJvcdCvD5j+A+obBTRjFa5yf91gR4qsd46dCcBc3/TxaxuJHwGZlW5iPMI8Cd
         ZqvCqwZh2WEMfS28bLo5m86QHbx9uee8QOU9lGayTNqPFm6JZ42ql+nObW+/gJaNYERB
         QXxPcLlL2/xVASRRRtZcWfbMuGcn+xYEophl6h4JRxropVcs4BVw3jdMf1x7a7FSdnH0
         rMaA==
X-Received: by 10.70.61.103 with SMTP id o7mr18771407pdr.134.1407428587112;
        Thu, 07 Aug 2014 09:23:07 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.23.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:23:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254965>

Use `git_config_get_bool()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 archive.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/archive.c b/archive.c
index 3fc0fb2..952a659 100644
--- a/archive.c
+++ b/archive.c
@@ -402,14 +402,6 @@ static int parse_archive_args(int argc, const char **argv,
 	return argc;
 }
 
-static int git_default_archive_config(const char *var, const char *value,
-				      void *cb)
-{
-	if (!strcmp(var, "uploadarchive.allowunreachable"))
-		remote_allow_unreachable = git_config_bool(var, value);
-	return git_default_config(var, value, cb);
-}
-
 int write_archive(int argc, const char **argv, const char *prefix,
 		  int setup_prefix, const char *name_hint, int remote)
 {
@@ -420,7 +412,9 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	if (setup_prefix && prefix == NULL)
 		prefix = setup_git_directory_gently(&nongit);
 
-	git_config(git_default_archive_config, NULL);
+	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_unreachable);
+	git_config(git_default_config, NULL);
+
 	init_tar_archiver();
 	init_zip_archiver();
 
-- 
1.9.0.GIT
