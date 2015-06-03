From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 10/19] pull: support pull.ff config
Date: Wed,  3 Jun 2015 14:48:54 +0800
Message-ID: <1433314143-4478-11-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02VP-0004kk-2a
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbbFCGuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:22 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35673 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbbFCGuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:15 -0400
Received: by padjw17 with SMTP id jw17so697439pad.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cMt21iBfpNouIDPuQOJHO3jfncQUI8QZZLj4XoN3cjk=;
        b=Fms8RCppuGklErVO2PIi0sXJr8xT7WYspxZhrqkV9LILAwW6kEYev/pJF9p64s8Fut
         oP7qTFvhKfJuMW2Z03VvVGsOM9uSDpNovAi6IY7Qu+BbBpbrTezAUkerk4hzbHgrKl3R
         tv6WklNNQEzZzfBAgOCjq+v083SE2kxdu28Bymziw08u9jJDZsHNEkVo47VZ70CKVDEL
         AXmVrqY7neOwIeFm48rTBKbDzpnI/7DqzDvNEopsTzpm4AMoFhrcVv1qVmySyliTE14o
         VR2QNUwSmKwTU6afnfHjomhq0DvR+XJTPtKtsUPa2gkhPJXR/T9Vz8TBAG+jvqiwVzmJ
         kNHQ==
X-Received: by 10.68.205.67 with SMTP id le3mr19682772pbc.94.1433314214638;
        Tue, 02 Jun 2015 23:50:14 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:13 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270646>

Since b814da8 (pull: add pull.ff configuration, 2014-01-15), git-pull.sh
would lookup the configuration value of "pull.ff", and set the flag
"--ff" if its value is "true", "--no-ff" if its value is "false" and
"--ff-only" if its value is "only".

Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Yup, I did mean strcmp(value, "only")

 builtin/pull.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 42a061d..1c1883d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -167,6 +167,32 @@ static void argv_push_force(struct argv_array *arr)
 }
 
 /**
+ * If pull.ff is "true", sets sb to "--ff". If pull.ff is "false", sets sb to
+ * "--no-ff". If pull.ff is "only", sets sb to "--ff-only". If pull.ff is
+ * set to an invalid value, die with an error.
+ */
+static void config_get_ff(struct strbuf *sb)
+{
+	const char *value;
+
+	if (git_config_get_value("pull.ff", &value))
+		return;
+	switch (git_config_maybe_bool("pull.ff", value)) {
+		case 0:
+			strbuf_addstr(sb, "--no-ff");
+			return;
+		case 1:
+			strbuf_addstr(sb, "--ff");
+			return;
+	}
+	if (!strcmp(value, "only")) {
+		strbuf_addstr(sb, "--ff-only");
+		return;
+	}
+	die(_("Invalid value for pull.ff: %s"), value);
+}
+
+/**
  * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
  * into merge_heads.
  */
@@ -396,6 +422,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
+	if (!opt_ff.len)
+		config_get_ff(&opt_ff);
+
 	if (run_fetch(repo, refspecs))
 		return 1;
 
-- 
2.1.4
