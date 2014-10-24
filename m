From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge & sequencer: unify codepaths that write "Conflicts:" hint
Date: Fri, 24 Oct 2014 14:22:31 -0700
Message-ID: <xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 23:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhmJp-0005qP-8k
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 23:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372AbaJXVWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 17:22:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756355AbaJXVWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 17:22:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB26218131;
	Fri, 24 Oct 2014 17:22:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DgLTTfeZZ8vAkKMqUdZLd3xSfu8=; b=R2z7l3
	Dph+NlMnJ+ag5gT4dq+RJNzFG50nHUwP1H5q/70w5qbszLCWq8Od8jZ9UYOiH4L4
	o/7U8ltEcm1NCvpYs8s9C/XglbKn6GDNH/fJKq6loWEKDy/nW22m87JyIFIoCcMR
	Qq2Fxz0PlSjtLqePce1TOSmkq591NZbEDl/Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mgut8QccgtcbbIkZbgZ7tL9X/X/PCXil
	R+Yn5lL7lUqV0wd9UoFgFeUoe/TKsPJzsI6ocKtawCt6kj6z1XBgOgiknywpQIM5
	JDhnY5Y1MXbYPW4SCh5N//LP9mHzIQ81MNmVBDb3jkxN420cNoIafCgAzGU65tW0
	xJjCywuSgUg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C300F18130;
	Fri, 24 Oct 2014 17:22:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5637E1812F;
	Fri, 24 Oct 2014 17:22:32 -0400 (EDT)
In-Reply-To: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 24 Oct 2014 11:27:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDAA2322-5BC3-11E4-AB61-855A93717476-77302942!pb-smtp1.pobox.com
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
2.1.2-595-g1568c45
