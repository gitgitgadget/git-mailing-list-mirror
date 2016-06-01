From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 24/39] i18n: bisect: enable l10n of bisect terms in messages
Date: Wed,  1 Jun 2016 16:41:14 +0000
Message-ID: <1464799289-7639-25-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:45:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Gs-0005vB-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbcFAQoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:44:39 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:47139 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932357AbcFAQoi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:44:38 -0400
Received: (qmail 12919 invoked from network); 1 Jun 2016 16:44:31 -0000
Received: (qmail 31259 invoked from network); 1 Jun 2016 16:44:31 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:44:26 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296129>

Enable localization (l10n) of bisect terms in messages for the user.

Use an array to explicitly list and mark bisect terms for translation
using the no-op N_(). Additionally, this catches at compile time errors
such as wrongly writing the bisect terms, e.g., writing "god" instead of
"good", since now we would use term_names[GOOD] syntax.

Triggering the retrieval of the term translation is done at runtime
with _(term_bad) and  _(term_good).

There are 2 messages that can't be marked for translation at this point,
because they're grep'ed by bisect_run function in git-bisect.sh.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 bisect.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index a8713a8..293d7ec 100644
--- a/bisect.c
+++ b/bisect.c
@@ -23,6 +23,15 @@ static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *term_bad;
 static const char *term_good;
 
+enum term { BAD, GOOD, OLD, NEW };
+static const char *term_names[] = {
+/* TRANSLATORS: in bisect.c source code file, the following terms are
+   used to describe a "bad commit", "good commit", "new revision", etc.
+   Please, if you can, check the source when you are not sure if a %s
+   would be replaced by one of the following terms. */
+	N_("bad"), N_("good"), N_("old"), N_("new"),  NULL
+};
+
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
 
@@ -725,12 +734,12 @@ static void handle_bad_merge_base(void)
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
-		if (!strcmp(term_bad, "bad") && !strcmp(term_good, "good")) {
+		if (!strcmp(term_bad, term_names[BAD]) && !strcmp(term_good, term_names[GOOD])) {
 			fprintf(stderr, _("The merge base %s is bad.\n"
 				"This means the bug has been fixed "
 				"between %s and [%s].\n"),
 				bad_hex, bad_hex, good_hex);
-		} else if (!strcmp(term_bad, "new") && !strcmp(term_good, "old")) {
+		} else if (!strcmp(term_bad, term_names[NEW]) && !strcmp(term_good, term_names[OLD])) {
 			fprintf(stderr, _("The merge base %s is new.\n"
 				"The property has changed "
 				"between %s and [%s].\n"),
@@ -739,7 +748,7 @@ static void handle_bad_merge_base(void)
 			fprintf(stderr, _("The merge base %s is %s.\n"
 				"This means the first '%s' commit is "
 				"between %s and [%s].\n"),
-				bad_hex, term_bad, term_good, bad_hex, good_hex);
+				bad_hex, _(term_bad), _(term_good), bad_hex, good_hex);
 		}
 		exit(3);
 	}
@@ -747,7 +756,7 @@ static void handle_bad_merge_base(void)
 	fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
 		"Maybe you mistook %s and %s revs?\n"),
-		term_good, term_bad, term_good, term_bad);
+		_(term_good), _(term_bad), _(term_good), _(term_bad));
 	exit(1);
 }
 
@@ -762,7 +771,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 		"So we cannot be sure the first %s commit is "
 		"between %s and %s.\n"
 		"We continue anyway."),
-		bad_hex, good_hex, term_bad, mb_hex, bad_hex);
+		bad_hex, good_hex, _(term_bad), mb_hex, bad_hex);
 	free(good_hex);
 }
 
@@ -843,7 +852,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	int fd;
 
 	if (!current_bad_oid)
-		die(_("a %s revision is needed"), term_bad);
+		die(_("a %s revision is needed"), _(term_bad));
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -906,8 +915,8 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 
 	if (!fp) {
 		if (errno == ENOENT) {
-			*read_bad = "bad";
-			*read_good = "good";
+			*read_bad = term_names[BAD];
+			*read_good = term_names[GOOD];
 			return;
 		} else {
 			die_errno(_("could not read file '%s'"), filename);
@@ -962,8 +971,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
-		       term_good,
-		       term_bad);
+		       _(term_good),
+		       _(term_bad));
 		exit(1);
 	}
 
-- 
2.7.3
