From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 4/4] builtin/apply.c: replace `git_config()` with `git_config_get_string_const()`
Date: Wed, 13 Aug 2014 01:22:02 -0700
Message-ID: <1407918122-29973-4-git-send-email-tanayabh@gmail.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:30:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHTx3-0006qS-NG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 10:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaHMIW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 04:22:58 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35013 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbaHMIWy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 04:22:54 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so14394030pad.24
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gEESpT7CxbXHyXsJM0r9gvUqoyJOnTX0plNpl6/tVE4=;
        b=Boa8wZqVPfHm5kNNZ1mZOdKMejj2z1TD8gpBUc8h4lyTW/2FE4vJJIRoiRU3gVJv2r
         xZqFWv7HUK6g3cit3HKSh4+LWj+H/qkQKGaS7DrrZdXd9VOy857lXBpcQHXHxSYCFiZU
         dN24jQPzEfxe+trpG8SmbqyzcY89freyx8K2T8NeMIwtYHu77Fxbrz83V8FQE8cfExJv
         qsyNBYXKJXk+HrB6QyeDUrPYXOzvZTgTrTc59dkoiF8qdaN921cQVUUpumaQJltC9hjB
         lAHPzJnECjeOTAc2iiIRKCe1s/JsuqstYiDcH5sZXLEy+Pr7c+756SoLQnFnoIOSMamq
         URUg==
X-Received: by 10.70.102.66 with SMTP id fm2mr2731548pdb.102.1407918174328;
        Wed, 13 Aug 2014 01:22:54 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.211])
        by mx.google.com with ESMTPSA id fm12sm1919517pdb.46.2014.08.13.01.22.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 01:22:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255189>

Use `git_config_get_string_const()` instead of `git_config()` to take
advantage of the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 builtin/apply.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index be2b4ce..66acf32 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4269,13 +4269,11 @@ static int apply_patch(int fd, const char *filename, int options)
 	return 0;
 }
 
-static int git_apply_config(const char *var, const char *value, void *cb)
+static void git_apply_config(void)
 {
-	if (!strcmp(var, "apply.whitespace"))
-		return git_config_string(&apply_default_whitespace, var, value);
-	else if (!strcmp(var, "apply.ignorewhitespace"))
-		return git_config_string(&apply_default_ignorewhitespace, var, value);
-	return git_default_config(var, value, cb);
+	git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
+	git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
+	git_config(git_default_config, NULL);
 }
 
 static int option_parse_exclude(const struct option *opt,
@@ -4423,7 +4421,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 
 	prefix = prefix_;
 	prefix_length = prefix ? strlen(prefix) : 0;
-	git_config(git_apply_config, NULL);
+	git_apply_config();
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
 	if (apply_default_ignorewhitespace)
-- 
1.9.0.GIT
