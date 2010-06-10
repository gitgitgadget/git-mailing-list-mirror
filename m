From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH next v2] log_ref_setup: don't return stack-allocated array
Date: Thu, 10 Jun 2010 14:54:03 +0200
Message-ID: <47daf53b6b2cc25cc013c5f2183e309a671dc9d3.1276174233.git.trast@student.ethz.ch>
References: <e888313d5a782585f4a5e7ee8914302953c187e2.1276173576.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Erick Mattos <erick.mattos@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 14:54:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMhHC-0003Uk-98
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 14:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758884Ab0FJMyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 08:54:24 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:17373 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab0FJMyX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 08:54:23 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 14:54:23 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 14:54:03 +0200
X-Mailer: git-send-email 1.7.1.553.ga798e
In-Reply-To: <e888313d5a782585f4a5e7ee8914302953c187e2.1276173576.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148864>

859c301 (refs: split log_ref_write logic into log_ref_setup,
2010-05-21) refactors the stack allocation of the log_file array into
the new log_ref_setup() function, but passes it back to the caller.

Since the original intent seems to have been to split the work between
log_ref_setup and log_ref_write, make it the caller's responsibility
to allocate the buffer.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---

Sorry for the first one, that was completely botched and didn't even
compile.

This one does, and as an added bonus also passes some tests.

 builtin/checkout.c |    4 ++--
 refs.c             |   26 ++++++++++++--------------
 refs.h             |    2 +-
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5107eda..1994be9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -496,12 +496,12 @@ static void update_refs_for_switch(struct checkou=
t_opts *opts,
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
 				int temp;
-				char *log_file;
+				char log_file[PATH_MAX];
 				char *ref_name =3D mkpath("refs/heads/%s", opts->new_orphan_branch=
);
=20
 				temp =3D log_all_ref_updates;
 				log_all_ref_updates =3D 1;
-				if (log_ref_setup(ref_name, &log_file)) {
+				if (log_ref_setup(ref_name, log_file, sizeof(log_file))) {
 					fprintf(stderr, "Can not do reflog for '%s'\n",
 					    opts->new_orphan_branch);
 					log_all_ref_updates =3D temp;
diff --git a/refs.c b/refs.c
index 3436649..6f486ae 100644
--- a/refs.c
+++ b/refs.c
@@ -1262,43 +1262,41 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
=20
-int log_ref_setup(const char *ref_name, char **log_file)
+int log_ref_setup(const char *ref_name, char *logfile, int bufsize)
 {
 	int logfd, oflags =3D O_APPEND | O_WRONLY;
-	char logfile[PATH_MAX];
=20
-	git_snpath(logfile, sizeof(logfile), "logs/%s", ref_name);
-	*log_file =3D logfile;
+	git_snpath(logfile, bufsize, "logs/%s", ref_name);
 	if (log_all_ref_updates &&
 	    (!prefixcmp(ref_name, "refs/heads/") ||
 	     !prefixcmp(ref_name, "refs/remotes/") ||
 	     !prefixcmp(ref_name, "refs/notes/") ||
 	     !strcmp(ref_name, "HEAD"))) {
-		if (safe_create_leading_directories(*log_file) < 0)
+		if (safe_create_leading_directories(logfile) < 0)
 			return error("unable to create directory for %s",
-				     *log_file);
+				     logfile);
 		oflags |=3D O_CREAT;
 	}
=20
-	logfd =3D open(*log_file, oflags, 0666);
+	logfd =3D open(logfile, oflags, 0666);
 	if (logfd < 0) {
 		if (!(oflags & O_CREAT) && errno =3D=3D ENOENT)
 			return 0;
=20
 		if ((oflags & O_CREAT) && errno =3D=3D EISDIR) {
-			if (remove_empty_directories(*log_file)) {
+			if (remove_empty_directories(logfile)) {
 				return error("There are still logs under '%s'",
-					     *log_file);
+					     logfile);
 			}
-			logfd =3D open(*log_file, oflags, 0666);
+			logfd =3D open(logfile, oflags, 0666);
 		}
=20
 		if (logfd < 0)
 			return error("Unable to append to %s: %s",
-				     *log_file, strerror(errno));
+				     logfile, strerror(errno));
 	}
=20
-	adjust_shared_perm(*log_file);
+	adjust_shared_perm(logfile);
 	close(logfd);
 	return 0;
 }
@@ -1309,14 +1307,14 @@ static int log_ref_write(const char *ref_name, =
const unsigned char *old_sha1,
 	int logfd, result, written, oflags =3D O_APPEND | O_WRONLY;
 	unsigned maxlen, len;
 	int msglen;
-	char *log_file;
+	char log_file[PATH_MAX];
 	char *logrec;
 	const char *committer;
=20
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates =3D !is_bare_repository();
=20
-	result =3D log_ref_setup(ref_name, &log_file);
+	result =3D log_ref_setup(ref_name, log_file, sizeof(log_file));
 	if (result)
 		return result;
=20
diff --git a/refs.h b/refs.h
index 594c9d9..762ce50 100644
--- a/refs.h
+++ b/refs.h
@@ -69,7 +69,7 @@ extern void unlock_ref(struct ref_lock *lock);
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *=
sha1, const char *msg);
=20
 /** Setup reflog before using. **/
-int log_ref_setup(const char *ref_name, char **log_file);
+int log_ref_setup(const char *ref_name, char *logfile, int bufsize);
=20
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *ref, unsigned long at_time, int cnt=
, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cut=
off_tz, int *cutoff_cnt);
--=20
1.7.1.553.ga798e
