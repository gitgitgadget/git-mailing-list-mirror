From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/3] config --global --edit: create a template file if needed
Date: Fri, 25 Jul 2014 20:00:05 +0200
Message-ID: <1406311207-8276-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 25 20:00:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjn3-0005yy-Tr
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 20:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760827AbaGYSAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 14:00:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51704 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbaGYSAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 14:00:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PI07bg013582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 20:00:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PI09vr022863;
	Fri, 25 Jul 2014 20:00:09 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XAjmr-0002KC-7u; Fri, 25 Jul 2014 20:00:09 +0200
X-Mailer: git-send-email 2.0.2.737.gfb43bde
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 20:00:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PI07bg013582
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1406916008.23787@LaeIU0sJwA9CeVFkihmA6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254251>

When the user has no ~/.gitconfig file, git config --global --edit used
to launch an editor on an nonexistant file name.

Instead, create a file with a default content before launching the
editor. The template contains only commented-out entries, to save a few
keystrokes for the user. If the values are guessed properly, the user
will only have to uncomment the entries.

Advanced users teaching newbies can create a minimalistic configuration
faster for newbies. Beginners reading a tutorial advising to run "git
config --global --edit" as a first step will be slightly more guided for
their first contact with Git.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Hopefully, all remarks applied. I went for "Git's user configuration", but
I can change it to whatever native speakers think is better.

 builtin/config.c | 31 ++++++++++++++++++++++++++++---
 cache.h          |  1 +
 ident.c          |  2 +-
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index fcd8474..1363478 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -445,6 +445,20 @@ static int get_urlmatch(const char *var, const char *url)
 	return 0;
 }
 
+static char *default_user_config(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_addf(&buf,
+		    _("# This is Git's user configuration file.\n"
+		      "[core]\n"
+		      "# Please adapt and uncomment the following lines:\n"
+		      "#	user = %s\n"
+		      "#	email = %s\n"),
+		    ident_default_name(),
+		    ident_default_email());
+	return strbuf_detach(&buf, NULL);
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
@@ -551,6 +565,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		}
 	}
 	else if (actions == ACTION_EDIT) {
+		const char *config_file = given_config_source.file ?
+			given_config_source.file : git_path("config");
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
 			die("not in a git directory");
@@ -559,9 +575,18 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (given_config_source.blob)
 			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
-		launch_editor(given_config_source.file ?
-			      given_config_source.file : git_path("config"),
-			      NULL, NULL);
+		if (use_global_config) {
+			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
+			if (fd) {
+				char *content = default_user_config();
+				write_str_in_full(fd, content);
+				free(content);
+				close(fd);
+			}
+			else if (errno != EEXIST)
+				die_errno(_("cannot create configuration file %s"), config_file);
+		}
+		launch_editor(config_file, NULL, NULL);
 	}
 	else if (actions == ACTION_SET) {
 		int ret;
diff --git a/cache.h b/cache.h
index fcb511d..b06cbb2 100644
--- a/cache.h
+++ b/cache.h
@@ -1061,6 +1061,7 @@ extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
+extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
diff --git a/ident.c b/ident.c
index 1d9b6e7..77bc882 100644
--- a/ident.c
+++ b/ident.c
@@ -102,7 +102,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
 	add_domainname(email);
 }
 
-static const char *ident_default_name(void)
+const char *ident_default_name(void)
 {
 	if (!git_default_name.len) {
 		copy_gecos(xgetpwuid_self(), &git_default_name);
-- 
2.0.2.737.gfb43bde
