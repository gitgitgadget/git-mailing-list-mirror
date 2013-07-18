From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] describe: fix --contains when a tag is given as input
Date: Thu, 18 Jul 2013 15:16:08 -0700
Message-ID: <1374185768-7537-3-git-send-email-gitster@pobox.com>
References: <1374185768-7537-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 00:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzwUm-0007gJ-Mw
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 00:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933964Ab3GRWQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 18:16:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933668Ab3GRWQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 18:16:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2D93322DB
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ZUSN
	fBbGwEI2Crdb27QW6Cojbc8=; b=d+9RuB43TeTmUFwKaazkhGq36aDkzDtxVL1z
	PhO1wedHe/1i/FWWzc65Q47VWMfgEn5sai05TCJIwB9/lfa4Ru//pbCKSH+GfB+H
	oMhD3p2656+ymN1Q2VvnIQ7BfJGKQUFd95TB9aW93sBGCcJ6w14j1wHEd8IbDkp4
	CX5cZV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jaLT+r
	W8VrK155ImahMggQdoMBCyKctoPG3MMNRdOfagV8E9DN8s4I+gxY0sX9RaY8QDTk
	YeAAIjd0WeGKFvpLZR+XHbKNF9sUJmjlb4AdTShlQFeVq9RXI6X7u1FtcMhGZSKB
	YQO/4z4CaT7R4XGJOMMn/1HcsUkO+rf7jNQBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B75F7322DA
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 22:16:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7B94322D5
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 22:16:14 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-992-gf0e5e44
In-Reply-To: <1374185768-7537-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A92EEDB4-EFF7-11E2-AA41-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230757>

"git describe" takes a commit and gives it a name based on tags in
its neighbourhood.  The command does take a commit-ish but when
given a tag that points at a commit, it should dereference the tag
before computing the name for the commit.

As the whole processing is internally delegated to name-rev, if we
unwrap tags down to the underlying commit when invoking name-rev, it
will make the name-rev issue an error message based on the unwrapped
object name (i.e. either 40-hex object name, or "$tag^0") that is
different from what the end-user gave to the command when the commit
cannot be described.  Introduce an internal option --peel-tag to the
name-rev to tell it to unwrap a tag in its input from the command
line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c  |  3 ++-
 builtin/name-rev.c  | 17 ++++++++++++++++-
 t/t6120-describe.sh | 12 ++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index db41cd7..7d73722 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -446,7 +446,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		struct argv_array args;
 
 		argv_array_init(&args);
-		argv_array_pushl(&args, "name-rev", "--name-only", "--no-undefined",
+		argv_array_pushl(&args, "name-rev",
+				 "--peel-tag", "--name-only", "--no-undefined",
 				 NULL);
 		if (always)
 			argv_array_push(&args, "--always");
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 4c7cc62..0aaa19e 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -307,7 +307,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
-	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0;
+	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, NULL };
 	struct option opts[] = {
 		OPT_BOOLEAN(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
@@ -320,6 +320,12 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "undefined", &allow_undefined, N_("allow to print `undefined` names")),
 		OPT_BOOLEAN(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
+		{
+			/* A Hidden OPT_BOOL */
+			OPTION_SET_INT, 0, "peel-tag", &peel_tag, NULL,
+			N_("dereference tags in the input (internal use)"),
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1,
+		},
 		OPT_END(),
 	};
 
@@ -361,6 +367,15 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			if (cutoff > commit->date)
 				cutoff = commit->date;
 		}
+
+		if (peel_tag) {
+			if (!commit) {
+				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
+					*argv);
+				continue;
+			}
+			object = (struct object *)commit;
+		}
 		add_object_array(object, *argv, &revs);
 	}
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1d20854..c0e5b2a 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -186,4 +186,16 @@ test_expect_success 'name-rev with exact tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'describe --contains with the exact tags' '
+	echo "A^0" >expect &&
+	tag_object=$(git rev-parse refs/tags/A) &&
+	git describe --contains $tag_object >actual &&
+	test_cmp expect actual &&
+
+	echo "A^0" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	git describe --contains $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.3-992-gf0e5e44
