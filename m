From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 04/11] archive.c: replace `git_config()` with `git_config_get_bool()` family
Date: Mon,  4 Aug 2014 11:33:42 -0700
Message-ID: <1407177229-30081-5-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:34:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN5x-0007lT-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbaHDSet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:34:49 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:64447 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaHDSes (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:34:48 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so10549968pad.10
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SWduK/SNCIXmZHZbmZIT3Mj2UBSXoR5qbnObetIfmsI=;
        b=uIR9qz985q7EOAR3E+hpKSp/m0+K3pYiGY8k4lDdBhnE9zpiFjOM0/Vi0iE6oh9Bq8
         cZeVPrAGrRT0zQOax6znWh/bIjFgISmj9leXDx5yW1aCIR8E+2TNtrLm7gWQ2vVHrtEC
         bafReB2jIF1Tckekp+4cKSLAw4Hzy4AOW4/LDe1UoqgkMLaAEpfc0N23exUF51PR0JlZ
         k3bnDmYXk3dqwbLw6dq+HiOa49Z44pELGMUOKhRg1gLZnssVIOLqNAamElWTEm3JOES4
         uH0e0PaXWlQb3u6bnI2lYjCcLZevNsim8jmOJARkGSN/D8bgnXd+/ClkVgliRfixMf4p
         LU2A==
X-Received: by 10.68.178.194 with SMTP id da2mr3880474pbc.151.1407177287561;
        Mon, 04 Aug 2014 11:34:47 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.34.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:34:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254755>

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
