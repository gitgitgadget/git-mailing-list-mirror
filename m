From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH] add: Use struct argv_array in run_add_interactive()
Date: Sat, 15 Mar 2014 12:14:40 +0100
Message-ID: <53243620.8080401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 12:15:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOmYU-0002Ni-7f
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 12:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756290AbaCOLOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 07:14:49 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:53820 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270AbaCOLOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 07:14:47 -0400
Received: by mail-la0-f52.google.com with SMTP id ec20so2454947lab.39
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=9Jzp3LmKdencHB3oCPdUfV4PB8spq1zaTIlwSgF8SNE=;
        b=dxwy9kvMp+kk9N3bzTgnpd0cGKYHgGxv4grIZ4SAxGuMBAeB/eCUY1NbUxRH7WYG2l
         Af3DG6VQeae91KN3Gr9aG3hHIOsZlB/egkGEc4kv3BvJDLFyCkaA3PAsGiptHDNYrcJa
         E7qM4gbmIdg22BVPoXyftvCKITEFcHJnyt8zfnEZemTTXPbk84t/N9D9VVlLPl3SK/ED
         z8zK8qANf3VBO1nLjQ0wnkTC6PWNdepzXg4WKnyEQ1yaKVSpiAkPOLqBgD3rR0aM67B4
         L8/yxEzHNnOfE9h/xOpGuOHX1p31kZPB7RX349DAr1qB4jd6Ccare7nUVB9Mj35th2a7
         N2zw==
X-Received: by 10.152.120.168 with SMTP id ld8mr9371842lab.12.1394882085935;
        Sat, 15 Mar 2014 04:14:45 -0700 (PDT)
Received: from chra.localdomain (c80-217-227-248.bredband.comhem.se. [80.217.227.248])
        by mx.google.com with ESMTPSA id jy5sm7830017lac.9.2014.03.15.04.14.44
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Mar 2014 04:14:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244151>

run_add_interactive() in builtin/add.c manually computes array bounds
and allocates a static args array to build the add--interactive command
line, which is error-prone. Use the argv-array helper functions instead.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 builtin/add.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4b045ba..459208a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -15,6 +15,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "bulk-checkin.h"
+#include "argv-array.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [options] [--] <pathspec>..."),
@@ -141,23 +142,21 @@ static void refresh(int verbose, const struct pathspec *pathspec)
 int run_add_interactive(const char *revision, const char *patch_mode,
 			const struct pathspec *pathspec)
 {
-	int status, ac, i;
-	const char **args;
+	int status, i;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
-	ac = 0;
-	args[ac++] = "add--interactive";
+	argv_array_push(&argv, "add--interactive");
 	if (patch_mode)
-		args[ac++] = patch_mode;
+		argv_array_push(&argv, patch_mode);
 	if (revision)
-		args[ac++] = revision;
-	args[ac++] = "--";
+		argv_array_push(&argv, revision);
+	argv_array_push(&argv, "--");
 	for (i = 0; i < pathspec->nr; i++)
 		/* pass original pathspec, to be re-parsed */
-		args[ac++] = pathspec->items[i].original;
+		argv_array_push(&argv, pathspec->items[i].original);
 
-	status = run_command_v_opt(args, RUN_GIT_CMD);
-	free(args);
+	status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+	argv_array_clear(&argv);
 	return status;
 }
 
-- 
1.9.0
