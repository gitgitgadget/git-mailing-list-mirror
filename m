From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: [PATCH v2 1/2] help: add help_unknown_ref
Date: Sat,  4 May 2013 05:34:19 +0530
Message-ID: <1367625860-20746-2-git-send-email-vikrant.varma94@gmail.com>
References: <1367625860-20746-1-git-send-email-vikrant.varma94@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Vikrant Varma <vikrant.varma94@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:06:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYPzE-0000sT-4E
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762228Ab3EDAFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:05:53 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:48142 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932Ab3EDAFw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:05:52 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so1153747pdj.41
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sbgs0/HnLSwRc9/vNyqUspNdbRWJuOOLZ5v23FPHB8Q=;
        b=m3ywv2Uin/DStzsxjfBwOn5iQq6xxflnxf55ey0hP6rOZVu71B6Q0vvhJceYEFqHIn
         icEsMok//iwZkQWw8CqRKJfyqTjJxmDfqac3RyVYrKR+qtOcJcVbChVuqMv6CEp2WyWH
         BKGD3X7bFJklWHws1ju9wZJRXpEu86XWEH6KvU+FXyfMZM8Ilt4GH2kwVGa2YKa2lA+9
         NWbkt2z6CnowJatq4LTgnCKXraFBoN62eAj32DXgCvySaIq+Ub7BlBhE4pFA2lHSxCc+
         JGj0L/mYsloZdkI6ANK+F0lEDWBPuTRGi97K/8fmeCMkgjTT6QP8gK6VjyQpnvLOJ69K
         k/mw==
X-Received: by 10.68.172.5 with SMTP id ay5mr16229528pbc.73.1367625952287;
        Fri, 03 May 2013 17:05:52 -0700 (PDT)
Received: from localhost.localdomain (triband-mum-59.183.134.119.mtnl.net.in. [59.183.134.119])
        by mx.google.com with ESMTPSA id ea15sm14689710pad.16.2013.05.03.17.05.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 17:05:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1367625860-20746-1-git-send-email-vikrant.varma94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223338>

When a ref is not known, currently functions call die() with an error message.
Add helper function help_unknown_ref to take care of displaying an error
message along with a list of suggested refs the user might have meant.

Example:
	$ git merge foo
	merge: foo - not something we can merge

	Did you mean one of these?
	    origin/foo
	    upstream/foo

Signed-off-by: Vikrant Varma <vikrant.varma94@gmail.com>
---
 help.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 help.h |    5 +++++
 2 files changed, 55 insertions(+)

diff --git a/help.c b/help.c
index 02ba043..fe5fe67 100644
--- a/help.c
+++ b/help.c
@@ -7,6 +7,7 @@
 #include "string-list.h"
 #include "column.h"
 #include "version.h"
+#include "refs.h"
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -404,3 +405,52 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	printf("git version %s\n", git_version_string);
 	return 0;
 }
+
+struct similar_ref_cb {
+	const char *base_ref;
+	struct string_list *similar_refs;
+};
+
+static int append_similar_ref(const char *refname, const unsigned char *sha1,
+			      int flags, void *cb_data)
+{
+	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
+	char *branch = strrchr(refname, '/') + 1;
+	/* A remote branch of the same name is deemed similar */
+	if (!prefixcmp(refname, "refs/remotes/") &&
+	    !strcmp(branch, cb->base_ref))
+		string_list_append(cb->similar_refs,
+				   refname + strlen("refs/remotes/"));
+	return 0;
+}
+
+struct string_list guess_refs(const char *ref)
+{
+	struct similar_ref_cb ref_cb;
+	struct string_list similar_refs = STRING_LIST_INIT_NODUP;
+
+	ref_cb.base_ref = ref;
+	ref_cb.similar_refs = &similar_refs;
+	for_each_ref(append_similar_ref, &ref_cb);
+	return similar_refs;
+}
+
+void help_unknown_ref(const char *ref, const char *cmd, const char *error)
+{
+	int i;
+	struct string_list suggested_refs = guess_refs(ref);
+
+	fprintf_ln(stderr, _("%s: %s - %s"), cmd, ref, error);
+
+	if (suggested_refs.nr > 0) {
+		fprintf_ln(stderr,
+			   Q_("\nDid you mean this?",
+			      "\nDid you mean one of these?",
+			      suggested_refs.nr));
+		for (i = 0; i < suggested_refs.nr; i++)
+			fprintf(stderr, "\t%s\n", suggested_refs.items[i].string);
+	}
+
+	string_list_clear(&suggested_refs, 0);
+	exit(1);
+}
diff --git a/help.h b/help.h
index 0ae5a12..5003423 100644
--- a/help.h
+++ b/help.h
@@ -27,4 +27,9 @@ extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
 extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
 
+/*
+ * This function has been called because ref is not known.
+ * Print a list of refs that the user might have meant, and exit.
+ */
+extern void help_unknown_ref(const char *ref, const char *cmd, const char *error);
 #endif /* HELP_H */
-- 
1.7.10.4
