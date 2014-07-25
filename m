From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 3/3] commit: advertise config --global --edit on guessed identity
Date: Fri, 25 Jul 2014 20:00:07 +0200
Message-ID: <1406311207-8276-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1406311207-8276-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 25 20:00:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjnA-00065w-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 20:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934274AbaGYSAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 14:00:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51708 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933322AbaGYSAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 14:00:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PI09JA013595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 20:00:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PI0B4w022869;
	Fri, 25 Jul 2014 20:00:11 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XAjms-0002Kc-Vu; Fri, 25 Jul 2014 20:00:11 +0200
X-Mailer: git-send-email 2.0.2.737.gfb43bde
In-Reply-To: <1406311207-8276-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 20:00:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PI09JA013595
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1406916013.29841@z5glC8ZWxmNPmaxsd9It7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254252>

When the user has no user-wide configuration file, it's faster to use the
newly introduced config file template than to run two commands to set
user.name and user.email. Advise this to the user.

The old advice is kept if the user already has a configuration file since
the template feature would not trigger in this case.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/commit.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..7502b0e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -42,7 +42,20 @@ static const char * const builtin_status_usage[] = {
 	NULL
 };
 
-static const char implicit_ident_advice[] =
+static const char implicit_ident_advice_noconfig[] =
+N_("Your name and email address were configured automatically based\n"
+"on your username and hostname. Please check that they are accurate.\n"
+"You can suppress this message by setting them explicitly. Run the\n"
+"following command and follow the instructions in your editor to edit\n"
+"your configuration file:\n"
+"\n"
+"    git config --global --edit\n"
+"\n"
+"After doing this, you may fix the identity used for this commit with:\n"
+"\n"
+"    git commit --amend --reset-author\n");
+
+static const char implicit_ident_advice_config[] =
 N_("Your name and email address were configured automatically based\n"
 "on your username and hostname. Please check that they are accurate.\n"
 "You can suppress this message by setting them explicitly:\n"
@@ -1402,6 +1415,23 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static const char *implicit_ident_advice() {
+	char *user_config = NULL;
+	char *xdg_config = NULL;
+	int config_exists;
+
+	home_config_paths(&user_config, &xdg_config, "config");
+	config_exists = file_exists(user_config) || file_exists(xdg_config);
+	free(user_config);
+	free(xdg_config);
+
+	if (config_exists)
+		return _(implicit_ident_advice_config);
+	else
+		return _(implicit_ident_advice_noconfig);
+
+}
+
 static void print_summary(const char *prefix, const unsigned char *sha1,
 			  int initial_commit)
 {
@@ -1440,7 +1470,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 		strbuf_addbuf_percentquote(&format, &committer_ident);
 		if (advice_implicit_identity) {
 			strbuf_addch(&format, '\n');
-			strbuf_addstr(&format, _(implicit_ident_advice));
+			strbuf_addstr(&format, implicit_ident_advice());
 		}
 	}
 	strbuf_release(&author_ident);
-- 
2.0.2.737.gfb43bde
