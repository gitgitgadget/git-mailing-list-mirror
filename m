From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2] Make error message after failing commit_lock_file() less confusing
Date: Thu,  3 Dec 2015 11:31:27 +0100
Message-ID: <1449138687-23675-1-git-send-email-szeder@ira.uka.de>
References: <20151203113034.Horde.-yFsRNWlpgbiVEym_u1l1wY@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 11:32:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4RBK-0004A1-M1
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 11:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759647AbbLCKcF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2015 05:32:05 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:51149 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759643AbbLCKcD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 05:32:03 -0500
Received: from x4db27217.dyn.telefonica.de ([77.178.114.23] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a4RB2-0002B3-8S; Thu, 03 Dec 2015 11:31:53 +0100
X-Mailer: git-send-email 2.6.3.420.g7bbb372
In-Reply-To: <20151203113034.Horde.-yFsRNWlpgbiVEym_u1l1wY@webmail.informatik.kit.edu>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1449138713.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281949>

The error message after a failing commit_lock_file() call sometimes
looks like this, causing confusion:

  $ git remote add remote git@server.com/repo.git
  error: could not commit config file .git/config
  # Huh?!
  # I didn't want to commit anything, especially not my config file!

While in the narrow context of the lockfile module using the verb
'commit' in the error message makes perfect sense, in the broader
context of git the word 'commit' already has a very specific meaning,
hence the confusion.

Reword these error messages to say "could not write" instead of "could
not commit".

While at it, include strerror in the error messages after writing the
config file fails, to provide some information about the cause of the
failure, and update the style of the error message after writing the
reflog fails, to match surrounding error messages (i.e. no '' around
the pathname and no () around the error description).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

Notes:
    Changes since v1:
    * Don't pass strerror() to die_errno().

 config.c           | 6 ++++--
 credential-store.c | 2 +-
 fast-import.c      | 2 +-
 refs.c             | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 248a21ab94..86a5eb2571 100644
--- a/config.c
+++ b/config.c
@@ -2144,7 +2144,8 @@ int git_config_set_multivar_in_file(const char *c=
onfig_filename,
 	}
=20
 	if (commit_lock_file(lock) < 0) {
-		error("could not commit config file %s", config_filename);
+		error("could not write config file %s: %s", config_filename,
+		      strerror(errno));
 		ret =3D CONFIG_NO_WRITE;
 		lock =3D NULL;
 		goto out_free;
@@ -2330,7 +2331,8 @@ int git_config_rename_section_in_file(const char =
*config_filename,
 	fclose(config_file);
 unlock_and_out:
 	if (commit_lock_file(lock) < 0)
-		ret =3D error("could not commit config file %s", config_filename);
+		ret =3D error("could not write config file %s: %s",
+			    config_filename, strerror(errno));
 out:
 	free(filename_buf);
 	return ret;
diff --git a/credential-store.c b/credential-store.c
index 00aea3aa30..54c4e04737 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -64,7 +64,7 @@ static void rewrite_credential_file(const char *fn, s=
truct credential *c,
 		print_line(extra);
 	parse_credential_file(fn, c, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
-		die_errno("unable to commit credential store");
+		die_errno("unable to write credential store");
 }
=20
 static void store_credential_file(const char *fn, struct credential *c=
)
diff --git a/fast-import.c b/fast-import.c
index e3b421d514..3c65edb5c4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1824,7 +1824,7 @@ static void dump_marks(void)
=20
 	dump_marks_helper(f, 0, marks);
 	if (commit_lock_file(&mark_lock)) {
-		failure |=3D error("Unable to commit marks file %s: %s",
+		failure |=3D error("Unable to write file %s: %s",
 			export_marks_file, strerror(errno));
 		return;
 	}
diff --git a/refs.c b/refs.c
index 132eff52ca..b1c7b229b7 100644
--- a/refs.c
+++ b/refs.c
@@ -4684,7 +4684,7 @@ int reflog_expire(const char *refname, const unsi=
gned char *sha1,
 					get_lock_file_path(lock->lk));
 			rollback_lock_file(&reflog_lock);
 		} else if (commit_lock_file(&reflog_lock)) {
-			status |=3D error("unable to commit reflog '%s' (%s)",
+			status |=3D error("unable to write reflog %s: %s",
 					log_file, strerror(errno));
 		} else if (update && commit_ref(lock)) {
 			status |=3D error("couldn't set %s", lock->ref_name);
--=20
2.6.3.420.g7bbb372
