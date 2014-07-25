From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC PATCH 3/3] commit: advertize config --global --edit on guessed identity
Date: Fri, 25 Jul 2014 15:44:51 +0200
Message-ID: <1406295891-7316-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 15:45:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAfo6-00069V-08
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 15:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbaGYNpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 09:45:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58207 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbaGYNo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 09:44:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PDisn8027506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 15:44:54 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PDitsf020233;
	Fri, 25 Jul 2014 15:44:55 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XAfnr-0002Gy-Rj; Fri, 25 Jul 2014 15:44:55 +0200
X-Mailer: git-send-email 2.0.2.737.gfb43bde
In-Reply-To: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Jul 2014 15:44:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PDisn8027506
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1406900695.5784@3hqUJlAgOUF6hfMh3vwCLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254218>

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
index f2d7979..52ef5a8 100644
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
@@ -1403,6 +1416,23 @@ int cmd_status(int argc, const char **argv, const char *prefix)
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
@@ -1441,7 +1471,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
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
