From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] merge & sequencer: unify codepaths that write "Conflicts:" hint
Date: Tue, 28 Oct 2014 14:36:50 -0700
Message-ID: <1414532212-9016-3-git-send-email-gitster@pobox.com>
References: <1414532212-9016-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 22:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjElM-0007Wl-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 22:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbaJ1V5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 17:57:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932071AbaJ1V5D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 17:57:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7025F1AFD1;
	Tue, 28 Oct 2014 17:57:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=nF7r
	drTQ9hbFbCRFkWzGKfWqFHk=; b=enHKXCq3rS/IvS7i0t5cAqrN02pr3afdPxOK
	3vxz4h8a2KUAAFdJKNCO1W9G/lcpi9FNTuHX7y/GvC1gd/xn1ROZ1sKfPy8jNqS8
	DnQ3ugLhVr3kvZv8Ow4b5otTaEvU6SACviF5HcDLmQgffwiN1Rko3cfpR4ukiQu9
	jUSOE50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wrAhOd
	SmEKyf+ZoDGQsnyXhDy9U47nyn6A6hvN2WhSDbtJfuDi341nuowO/vN7VIFQhFoq
	zAjsqOwGvxxnChDuCeYdiuU1YOaTursQhfu3WfmATEfQ6Cks7H1uDir7gVpDsLGz
	iHeOis90b4OuhXnNuQtocVwuzhTXMCnRaE57Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 650961AFD0;
	Tue, 28 Oct 2014 17:57:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54FBF1AAAB;
	Tue, 28 Oct 2014 17:37:00 -0400 (EDT)
X-Mailer: git-send-email 2.1.2-620-g33c52cb
In-Reply-To: <1414532212-9016-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8CB03BC6-5EEA-11E4-A408-527C6E758C04-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two identical loops in suggest_conflicts() in merge, and
do_recursive_merge() in sequencer, can use a single helper function
extracted from the latter that prepares the "Conflicts:" hint that
is meant to remind the user the paths for which merge conflicts had
to be resolved to write a better commit log message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 18 +++++-------------
 sequencer.c     | 35 ++++++++++++++++++++---------------
 sequencer.h     |  1 +
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f6894c7..d30cb60 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -28,6 +28,7 @@
 #include "remote.h"
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
+#include "sequencer.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -888,24 +889,15 @@ static int suggest_conflicts(void)
 {
 	const char *filename;
 	FILE *fp;
-	int pos;
+	struct strbuf msgbuf = STRBUF_INIT;
 
 	filename = git_path("MERGE_MSG");
 	fp = fopen(filename, "a");
 	if (!fp)
 		die_errno(_("Could not open '%s' for writing"), filename);
-	fprintf(fp, "\nConflicts:\n");
-	for (pos = 0; pos < active_nr; pos++) {
-		const struct cache_entry *ce = active_cache[pos];
-
-		if (ce_stage(ce)) {
-			fprintf(fp, "\t%s\n", ce->name);
-			while (pos + 1 < active_nr &&
-					!strcmp(ce->name,
-						active_cache[pos + 1]->name))
-				pos++;
-		}
-	}
+
+	append_conflicts_hint(&msgbuf);
+	fputs(msgbuf.buf, fp);
 	fclose(fp);
 	rerere(allow_rerere_auto);
 	printf(_("Automatic merge failed; "
diff --git a/sequencer.c b/sequencer.c
index 06e52b4..0f84bbe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -287,6 +287,24 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	return ret;
 }
 
+void append_conflicts_hint(struct strbuf *msgbuf)
+{
+	int i;
+
+	strbuf_addstr(msgbuf, "\nConflicts:\n");
+	for (i = 0; i < active_nr;) {
+		const struct cache_entry *ce = active_cache[i++];
+		if (ce_stage(ce)) {
+			strbuf_addch(msgbuf, '\t');
+			strbuf_addstr(msgbuf, ce->name);
+			strbuf_addch(msgbuf, '\n');
+			while (i < active_nr && !strcmp(ce->name,
+							active_cache[i]->name))
+				i++;
+		}
+	}
+}
+
 static int do_recursive_merge(struct commit *base, struct commit *next,
 			      const char *base_label, const char *next_label,
 			      unsigned char *head, struct strbuf *msgbuf,
@@ -328,21 +346,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (opts->signoff)
 		append_signoff(msgbuf, 0, 0);
 
-	if (!clean) {
-		int i;
-		strbuf_addstr(msgbuf, "\nConflicts:\n");
-		for (i = 0; i < active_nr;) {
-			const struct cache_entry *ce = active_cache[i++];
-			if (ce_stage(ce)) {
-				strbuf_addch(msgbuf, '\t');
-				strbuf_addstr(msgbuf, ce->name);
-				strbuf_addch(msgbuf, '\n');
-				while (i < active_nr && !strcmp(ce->name,
-						active_cache[i]->name))
-					i++;
-			}
-		}
-	}
+	if (!clean)
+		append_conflicts_hint(msgbuf);
 
 	return !clean;
 }
diff --git a/sequencer.h b/sequencer.h
index 1fc22dc..c53519d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -51,5 +51,6 @@ int sequencer_pick_revisions(struct replay_opts *opts);
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
+void append_conflicts_hint(struct strbuf *msgbuf);
 
 #endif
-- 
2.1.2-620-g33c52cb
