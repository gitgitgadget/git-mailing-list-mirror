From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [RFC/ PATCH 2/5] unpack_trees: group errors by type
Date: Wed,  9 Jun 2010 14:44:03 +0200
Message-ID: <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 14:50:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMKjr-00063a-T5
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 14:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584Ab0FIMua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 08:50:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60501 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757391Ab0FIMu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 08:50:29 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2010 08:50:29 EDT
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o59Cb4DL022369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Jun 2010 14:37:04 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59Cin0N010553;
	Wed, 9 Jun 2010 14:44:49 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o59Cinvl025388;
	Wed, 9 Jun 2010 14:44:49 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o59Cinom025387;
	Wed, 9 Jun 2010 14:44:49 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 09 Jun 2010 14:37:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59Cb4DL022369
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148766>

=46rom: Diane <diane.gasselin@ensimag.imag.fr>

When an error is encountered, it calls add_rejected_file() which either
- directly displays the error message if in plumbing mode
- or stores it so that it will be displayed at the end of display_error=
_msgs(),

Storing the files by error type permits to have a list of files for
which there is the same error instead of having a serie of almost
identical errors.

As each bind_overlap error combines a file and an old file, a list cann=
ot be
done, therefore, theses errors are not stored but directly displayed.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
---
It appears that in verify_absent_sparse(), verify_absent_1() is called =
with
ERRORMSG(o, would_lose_orphaned) as the error message.
Yet, in verify_absent_1(), this error message error_msg does not
seem to be used and at the end of the function, a would_lose_untracked =
error
is treated (before displayed and now added). Is it normal?

 unpack-trees.c |  128 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++----
 unpack-trees.h |   12 +++++
 2 files changed, 132 insertions(+), 8 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index c29a9e0..1e2f48d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -45,6 +45,21 @@ static struct unpack_trees_error_msgs unpack_plumbin=
g_errors =3D {
 	? ((o)->msgs.fld) \
 	: (unpack_plumbing_errors.fld) )
=20
+/*
+ * Store error messages in an array, each case
+ * corresponding to a error message type
+ */
+typedef enum {
+	would_overwrite,
+	not_uptodate_file,
+	not_uptodate_dir,
+	would_lose_untracked,
+	would_lose_untracked_removed,
+	sparse_not_uptodate_file
+} unpack_trees_error;
+#define NB_UNPACK_TREES_ERROR 6
+struct rejected_files *unpack_rejects[NB_UNPACK_TREES_ERROR];
+
 static void add_entry(struct unpack_trees_options *o, struct cache_ent=
ry *ce,
 	unsigned int set, unsigned int clear)
 {
@@ -60,6 +75,88 @@ static void add_entry(struct unpack_trees_options *o=
, struct cache_entry *ce,
 }
=20
 /*
+ * add error messages on file <file> and action <action>
+ * corresponding to the type <e> with the message <msg>
+ * indicating if it should be display in porcelain or not
+ */
+static int add_rejected_file(unpack_trees_error e,
+			     const char *file,
+			     const char *action,
+			     int porcelain,
+			     const char *msg)
+{
+	struct rejected_files_list *newentry;
+	/*
+	 * simply display the given error message if in plumbing mode
+	 */
+	if (!porcelain) {
+		error(msg,file,action);
+		return -1;
+	}
+	/*
+	 * if there is a porcelain error message defined,
+	 * the error is stored in order to be nicely displayed later
+	 */
+	if (e =3D=3D would_lose_untracked && !strcmp(action,"removed"))
+		e =3D would_lose_untracked_removed;
+
+	if (!unpack_rejects[e]) {
+		unpack_rejects[e] =3D malloc(sizeof(struct rejected_files));
+		unpack_rejects[e]->list =3D NULL;
+		unpack_rejects[e]->size =3D 0;
+	}
+	newentry =3D malloc(sizeof(struct rejected_files_list));
+	newentry->file =3D (char *)file;
+	newentry->next =3D unpack_rejects[e]->list;
+	unpack_rejects[e]->list =3D newentry;
+	unpack_rejects[e]->msg =3D msg;
+	unpack_rejects[e]->action =3D (char *)action;
+	unpack_rejects[e]->size +=3D strlen(file)+strlen("\n")+strlen("\t");
+	return -1;
+}
+
+/*
+ * free all the structures allocated for the error <e>
+ */
+static void free_rejected_files(unpack_trees_error e)
+{
+	while(unpack_rejects[e]->list) {
+		struct rejected_files_list *del =3D unpack_rejects[e]->list;
+		unpack_rejects[e]->list =3D unpack_rejects[e]->list->next;
+		free(del);
+	}
+	free(unpack_rejects[e]);
+}
+
+/*
+ * display all the error messages stored in a nice way
+ */
+static void display_error_msgs()
+{
+	int i;
+	int hasPorcelain =3D 0;
+	for (i=3D0; i<NB_UNPACK_TREES_ERROR; i++) {
+		if (unpack_rejects[i] && unpack_rejects[i]->list) {
+			hasPorcelain =3D 1;
+			struct rejected_files_list *f =3D unpack_rejects[i]->list;
+			char *action =3D unpack_rejects[i]->action;
+			char *file =3D malloc(unpack_rejects[i]->size+1);
+			*file =3D '\0';
+			while (f) {
+				strcat(file,"\t");
+				strcat(file,f->file);
+				strcat(file,"\n");
+				f =3D f->next;
+			}
+			error(unpack_rejects[i]->msg,file,action);
+			free_rejected_files(i);
+		}
+	}
+	if (hasPorcelain)
+		printf("Aborting\n");
+}
+
+/*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
@@ -819,6 +916,7 @@ done:
 	return ret;
=20
 return_failed:
+	display_error_msgs();
 	mark_all_ce_unused(o->src_index);
 	ret =3D unpack_failed(o, NULL);
 	goto done;
@@ -828,7 +926,9 @@ return_failed:
=20
 static int reject_merge(struct cache_entry *ce, struct unpack_trees_op=
tions *o)
 {
-	return error(ERRORMSG(o, would_overwrite), ce->name);
+	return add_rejected_file(would_overwrite, ce->name, NULL,
+				 (o && (o)->msgs.would_overwrite),
+				 ERRORMSG(o, would_overwrite));
 }
=20
 static int same(struct cache_entry *a, struct cache_entry *b)
@@ -850,7 +950,7 @@ static int same(struct cache_entry *a, struct cache=
_entry *b)
  */
 static int verify_uptodate_1(struct cache_entry *ce,
 				   struct unpack_trees_options *o,
-				   const char *error_msg)
+				   unpack_trees_error error)
 {
 	struct stat st;
=20
@@ -874,8 +974,16 @@ static int verify_uptodate_1(struct cache_entry *c=
e,
 	}
 	if (errno =3D=3D ENOENT)
 		return 0;
-	return o->gently ? -1 :
-		error(error_msg, ce->name);
+	if (error =3D=3D sparse_not_uptodate_file)
+		return o->gently ? -1 :
+			add_rejected_file(sparse_not_uptodate_file, ce->name, NULL,
+					  (o && (o)->msgs.sparse_not_uptodate_file),
+					  ERRORMSG(o, sparse_not_uptodate_file));
+	else
+		return o->gently ? -1 :
+			add_rejected_file(not_uptodate_file, ce->name, NULL,
+					  (o && (o)->msgs.not_uptodate_file),
+					  ERRORMSG(o, not_uptodate_file));
 }
=20
 static int verify_uptodate(struct cache_entry *ce,
@@ -883,13 +991,13 @@ static int verify_uptodate(struct cache_entry *ce=
,
 {
 	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
 		return 0;
-	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
+	return verify_uptodate_1(ce, o, not_uptodate_file);
 }
=20
 static int verify_uptodate_sparse(struct cache_entry *ce,
 				  struct unpack_trees_options *o)
 {
-	return verify_uptodate_1(ce, o, ERRORMSG(o, sparse_not_uptodate_file)=
);
+	return verify_uptodate_1(ce, o, sparse_not_uptodate_file);
 }
=20
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
@@ -976,7 +1084,9 @@ static int verify_clean_subdirectory(struct cache_=
entry *ce, const char *action,
 	i =3D read_directory(&d, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
-			error(ERRORMSG(o, not_uptodate_dir), ce->name);
+			add_rejected_file(not_uptodate_dir, ce->name, NULL,
+					  (o && (o)->msgs.not_uptodate_dir),
+					  ERRORMSG(o, not_uptodate_dir));
 	free(pathbuf);
 	return cnt;
 }
@@ -1058,7 +1168,9 @@ static int verify_absent_1(struct cache_entry *ce=
, const char *action,
 		}
=20
 		return o->gently ? -1 :
-			error(ERRORMSG(o, would_lose_untracked), ce->name, action);
+			add_rejected_file(would_lose_untracked, ce->name, action,
+					  (o && (o)->msgs.would_lose_untracked),
+					  ERRORMSG(o, would_lose_untracked));
 	}
 	return 0;
 }
diff --git a/unpack-trees.h b/unpack-trees.h
index ef70eab..49cc1ee 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -19,6 +19,18 @@ struct unpack_trees_error_msgs {
 	const char *would_lose_orphaned;
 };
=20
+struct rejected_files_list {
+	char *file;
+	struct rejected_files_list *next;
+};
+
+struct rejected_files {
+	char *action;
+	const char *msg;
+	size_t size;
+	struct rejected_files_list *list;
+};
+
 struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
--=20
1.6.6.7.ga5fe3
