From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 17/21] git notes merge: List conflicting notes in notes merge commit message
Date: Sat,  9 Oct 2010 03:15:52 +0200
Message-ID: <1286586956-3714-18-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:17:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4O3X-0004Cm-8J
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760130Ab0JIBQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 21:16:36 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:53158 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab0JIBQf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:16:35 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4O38-0001yv-6k; Sat, 09 Oct 2010 03:16:34 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158567>

This brings notes merge in line with regular merge's behaviour.

This patch has been improved by the following contributions:
- =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason: Don't use C99 comments.

Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c                       |    2 +-
 notes-merge.c                         |   11 ++++++++++-
 notes-merge.h                         |    2 +-
 t/t3310-notes-merge-manual-resolve.sh |   12 ++++++++++++
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index f604eec..3c373ec 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -902,7 +902,7 @@ static int merge(int argc, const char **argv, const=
 char *prefix)
=20
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
 		    remote_ref.buf, default_notes_ref());
-	o.commit_msg =3D msg.buf + 7; // skip "notes: " prefix
+	strbuf_add(&(o.commit_msg), msg.buf + 7, msg.len - 7); /* skip "notes=
: " */
=20
 	result =3D notes_merge(&o, t, result_sha1);
=20
diff --git a/notes-merge.c b/notes-merge.c
index 51dfbd6..a66c60b 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -7,6 +7,7 @@
 #include "dir.h"
 #include "notes.h"
 #include "notes-merge.h"
+#include "strbuf.h"
=20
 struct notes_merge_pair {
 	unsigned char obj[20], base[20], local[20], remote[20];
@@ -15,6 +16,7 @@ struct notes_merge_pair {
 void init_notes_merge_options(struct notes_merge_options *o)
 {
 	memset(o, 0, sizeof(struct notes_merge_options));
+	strbuf_init(&(o->commit_msg), 0);
 	o->verbosity =3D NOTES_MERGE_VERBOSITY_DEFAULT;
 }
=20
@@ -383,6 +385,12 @@ static int merge_one_change_manual(struct notes_me=
rge_options *o,
 	       sha1_to_hex(p->obj), sha1_to_hex(p->base),
 	       sha1_to_hex(p->local), sha1_to_hex(p->remote));
=20
+	/* add "Conflicts:" section to commit message first time through */
+	if (!o->has_worktree)
+		strbuf_addstr(&(o->commit_msg), "\n\nConflicts:\n");
+
+	strbuf_addf(&(o->commit_msg), "\t%s\n", sha1_to_hex(p->obj));
+
 	OUTPUT(o, 2, "Auto-merging notes for %s", sha1_to_hex(p->obj));
 	check_notes_merge_worktree(o);
 	if (is_null_sha1(p->local)) {
@@ -622,12 +630,13 @@ int notes_merge(struct notes_merge_options *o,
 		struct commit_list *parents =3D NULL;
 		commit_list_insert(remote, &parents); /* LIFO order */
 		commit_list_insert(local, &parents);
-		create_notes_commit(local_tree, parents, o->commit_msg,
+		create_notes_commit(local_tree, parents, o->commit_msg.buf,
 				    result_sha1);
 	}
=20
 found_result:
 	free_commit_list(bases);
+	strbuf_release(&(o->commit_msg));
 	trace_printf("notes_merge(): result =3D %i, result_sha1 =3D %.7s",
 	       result, sha1_to_hex(result_sha1));
 	return result;
diff --git a/notes-merge.h b/notes-merge.h
index e0702b5..5669836 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -11,7 +11,7 @@ enum notes_merge_verbosity {
 struct notes_merge_options {
 	const char *local_ref;
 	const char *remote_ref;
-	const char *commit_msg;
+	struct strbuf commit_msg;
 	int verbosity;
 	enum {
 		NOTES_MERGE_RESOLVE_MANUAL =3D 0,
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merg=
e-manual-resolve.sh
index 1db0649..8568307 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -333,6 +333,12 @@ EOF
 	git log -1 --format=3D%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
 	grep -q refs/notes/z merge_commit_msg &&
+	# Merge commit mentions conflicting notes
+	grep -q "Conflicts" merge_commit_msg &&
+	( for sha1 in $(cat expect_conflicts); do
+		grep -q "$sha1" merge_commit_msg ||
+		exit 1
+	done ) &&
 	# Verify contents of merge result
 	verify_notes m &&
 	# Verify that other notes refs has not changed (w, x, y and z)
@@ -456,6 +462,12 @@ EOF
 	git log -1 --format=3D%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
 	grep -q refs/notes/z merge_commit_msg &&
+	# Merge commit mentions conflicting notes
+	grep -q "Conflicts" merge_commit_msg &&
+	( for sha1 in $(cat expect_conflicts); do
+		grep -q "$sha1" merge_commit_msg ||
+		exit 1
+	done ) &&
 	# Verify contents of merge result
 	verify_notes m &&
 	# Verify that other notes refs has not changed (w, x, y and z)
--=20
1.7.3.1.104.g92b87a
