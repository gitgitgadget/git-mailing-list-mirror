From: dturner@twopensource.com
Subject: [PATCH 1/3] After chdir to run grep, return to old directory
Date: Fri,  2 May 2014 19:14:09 -0400
Message-ID: <1399072451-15561-2-git-send-email-dturner@twopensource.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 01:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgMfH-0005b5-N1
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 01:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbaEBXOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 19:14:42 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:60959 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbaEBXOk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 19:14:40 -0400
Received: by mail-qa0-f41.google.com with SMTP id dc16so3216617qab.14
        for <git@vger.kernel.org>; Fri, 02 May 2014 16:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s+CNSYbCq3GPRRF0OP7BVU93lNWWJCrSzzyqADvmGKg=;
        b=IzN6/oUBJlcFlJmxlfDOYFdKtRwWRJ4QZPmDNN9+Tk3nF9pM+6/oE/51i2/sRb0DNh
         vGqQE1Hu+K3bHX7enJT/Wi6vuN62Qzr7o496bRqHL6FslfNU+m70GUrv+wIOdpw91SL5
         QK6uBQF6pjP8SBAb6LBvWa5aT6dR/BH55FeMvdiM/guuEfUAFqhQu85ZDUL6U1Eb5KO1
         08wI7WmbeoB6U3vS6zrnCKGTFTWOarEHoSxDGNoUc+3Y/1P/nmunHpkfPNTHT1vOU/9i
         nXrQdWrzJGx9TvbOtu0J5vaViFLdl8y0AE6QU7gfXOqvpd2uoMUrO2WrfPiASakxxYfK
         7zsQ==
X-Gm-Message-State: ALoCoQmNNo37Afa3PRPIe0GEvxYIqILOw++XHgm1JpFmuQEPROyJSjd2C0Iz2LYH0ynO3hFRiU++
X-Received: by 10.224.51.2 with SMTP id b2mr26134764qag.49.1399072480008;
        Fri, 02 May 2014 16:14:40 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id q62sm598071qgd.0.2014.05.02.16.14.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 May 2014 16:14:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.31.g69c1a2d
In-Reply-To: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248005>

From: David Turner <dturner@twitter.com>

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/grep.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 69ac2d8..e9fe040 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -355,15 +355,25 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 {
 	struct string_list *path_list = opt->output_priv;
 	const char **argv = xmalloc(sizeof(const char *) * (path_list->nr + 1));
+	static char old_directory[PATH_MAX+1];
 	int i, status;
 
 	for (i = 0; i < path_list->nr; i++)
 		argv[i] = path_list->items[i].string;
 	argv[path_list->nr] = NULL;
 
-	if (prefix && chdir(prefix))
-		die(_("Failed to chdir: %s"), prefix);
+
+	if (prefix) {
+		if (!getcwd(old_directory, PATH_MAX+1))
+			die(_("Failed to get cwd: %s"), prefix);
+		if (chdir(prefix))
+			die(_("Failed to chdir: %s"), prefix);
+	}
 	status = run_command_v_opt(argv, RUN_USING_SHELL);
+	if (prefix)
+		if (chdir(old_directory))
+			die(_("Failed to chdir: %s"), old_directory);
+
 	if (status)
 		exit(status);
 	free(argv);
-- 
2.0.0.rc0.31.g69c1a2d
