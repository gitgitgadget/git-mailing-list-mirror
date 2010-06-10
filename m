From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH next] log_ref_setup: don't return stack-allocated array
Date: Thu, 10 Jun 2010 14:43:35 +0200
Message-ID: <e888313d5a782585f4a5e7ee8914302953c187e2.1276173576.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Erick Mattos <erick.mattos@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 14:44:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMh73-0006ck-CH
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 14:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759130Ab0FJMn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 08:43:56 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:24079 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470Ab0FJMny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 08:43:54 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 14:43:54 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 14:43:36 +0200
X-Mailer: git-send-email 1.7.1.553.ga798e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148862>

859c301 (refs: split log_ref_write logic into log_ref_setup,
2010-05-21) refactors the stack allocation of the log_file array into
the new log_ref_setup() function, but passes it back to the caller.

Since the original intent seems to have been to split the work between
log_ref_setup and log_ref_write, make it the caller's responsibility
to allocate the buffer.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---

Causes t5516 to fail, but only if I run it under valgrind.  (=C3=86var
managed to trigger it in other ways apparently.)

 refs.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 3436649..2a3eeec 100644
--- a/refs.c
+++ b/refs.c
@@ -1262,13 +1262,11 @@ static int copy_msg(char *buf, const char *msg)
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
--=20
1.7.1.553.ga798e
