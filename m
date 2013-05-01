From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: [PATCH 1/2] help: add help_unknown_ref
Date: Wed,  1 May 2013 16:52:06 +0530
Message-ID: <1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
Cc: Vikrant Varma <vikrant.varma94@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 13:24:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXV96-0004ps-07
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 13:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759485Ab3EALYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 07:24:15 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:65168 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758356Ab3EALYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 07:24:14 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so700396pbc.37
        for <git@vger.kernel.org>; Wed, 01 May 2013 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=p7VYBhjzlknh7CvcLH6zR9ttGvoBe+YFlLOcFYmCQ8U=;
        b=yNskVjzsGTUSQuiFOJu/lhtfxzh124QznyX7ESwyYeZctcCjU/iun+zRt8Mt0De/db
         mnfrTigcbRG9j3W1gnJkWDglQLz2mHIfl3AMJEoxo3vpjEFoc+cG8LumbqwUnkR1YThC
         cp2qpNd67n+0ukI9TBGs0WfafYeLaGRwxYTyPy+HVz1Yg+w/ay3Ot8ONDflhsFLVn8va
         OAE//DPDn0PBs2/AMP0wCaqJsCNmdMkRrnfBp8F7gcZJEMe/kNChN+Hw524J31YFiuDI
         /e9juNu6DydgxxDONrly3WFPaELCVrhLdi7KCK485HSonozgyXpaPXDz7y3RLzxBAG1C
         qeig==
X-Received: by 10.68.216.37 with SMTP id on5mr3757384pbc.35.1367407453967;
        Wed, 01 May 2013 04:24:13 -0700 (PDT)
Received: from localhost.localdomain (triband-mum-59.183.189.195.mtnl.net.in. [59.183.189.195])
        by mx.google.com with ESMTPSA id ea15sm3299675pad.16.2013.05.01.04.24.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 04:24:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3-rc0
In-Reply-To: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223087>

Give better advice when trying to merge a branch that doesn't exist. If
the branch exists in any remotes, display a list of suggestions.

Example:
	$ git merge foo
	fatal: foo - not something we can merge

	Did you mean this?
	    bar/foo

Signed-off-by: Vikrant Varma <vikrant.varma94@gmail.com>
---
 help.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 help.h |  6 ++++++
 2 files changed, 50 insertions(+)

diff --git a/help.c b/help.c
index 02ba043..faf18b9 100644
--- a/help.c
+++ b/help.c
@@ -7,6 +7,7 @@
 #include "string-list.h"
 #include "column.h"
 #include "version.h"
+#include "refs.h"
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -404,3 +405,46 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	printf("git version %s\n", git_version_string);
 	return 0;
 }
+
+struct similar_ref_cb {
+        const char *base_ref;
+        struct string_list similar_refs;
+};
+
+static int append_similar_ref(const char* refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+        int i;
+        struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
+        for (i = strlen(refname); refname[i] != '/'; i--)
+	        ;
+        /* A remote branch of the same name is deemed similar */
+        if (!prefixcmp(refname, "refs/remotes/") && !strcmp(refname + i + 1, cb->base_ref))
+	       	string_list_append(&(cb->similar_refs), refname + 13);
+        return 0;
+}
+
+void help_unknown_ref(const char* ref) {
+        int i;
+        struct similar_ref_cb ref_cb;
+        ref_cb.similar_refs = (struct string_list)STRING_LIST_INIT_NODUP;
+        ref_cb.base_ref = ref;
+
+        for_each_ref(append_similar_ref, &ref_cb);
+
+        fprintf_ln(stderr, _("fatal: %s - not something we can merge"), ref);
+
+        if (ref_cb.similar_refs.nr > 0) {
+	        fprintf_ln(stderr,
+		           Q_("\nDid you mean this?",
+		              "\nDid you mean one of these?",
+		              ref_cb.similar_refs.nr));
+
+	        for (i = 0; i < ref_cb.similar_refs.nr; i++)
+		        fprintf(stderr, "\t%s\n", ref_cb.similar_refs.items[i].string);
+        }
+        exit(1);
+}
+	
+			
+
+
diff --git a/help.h b/help.h
index 0ae5a12..613cb45 100644
--- a/help.h
+++ b/help.h
@@ -27,4 +27,10 @@ extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
 extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
 
+/* 
+ * ref is not something that can be merged. Print a list of remote branches of the
+ * same name that the user might have meant. 
+ */
+extern void help_unknown_ref(const char* ref);
+
 #endif /* HELP_H */
-- 
1.8.3-rc0
