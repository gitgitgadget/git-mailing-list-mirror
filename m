From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] var: provide explicit/implicit ident information
Date: Tue, 13 Nov 2012 11:53:08 -0500
Message-ID: <20121113165308.GD12626@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:53:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJjv-0007ge-Ij
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345Ab2KMQxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:53:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47554 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab2KMQxN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:53:13 -0500
Received: (qmail 26558 invoked by uid 107); 13 Nov 2012 16:54:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 11:54:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 11:53:08 -0500
Content-Disposition: inline
In-Reply-To: <20121113164845.GD20361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209637>

Internally, we keep track of whether the author or committer
ident information was provided by the user, or whether it
was implicitly determined by the system. However, there is
currently no way for external programs or scripts to get
this information without re-implementing the ident logic
themselves. Let's provide a way for them to do so.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-var.txt |  8 ++++++++
 builtin/var.c             | 27 +++++++++++++++++++++++++++
 t/t0007-git-var.sh        | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 53abba5..963b8d4 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -39,9 +39,17 @@ VARIABLES
 GIT_AUTHOR_IDENT::
     The author of a piece of code.
 
+GIT_AUTHOR_EXPLICIT::
+    Outputs "1" if the author identity was provided explicitly by the
+    user (in the config or environment), or "0" if it was determined
+    implicitly from the system.
+
 GIT_COMMITTER_IDENT::
     The person who put a piece of code into git.
 
+GIT_COMMITTER_EXPLICIT::
+    Like GIT_AUTHOR_EXPLICIT, but for the committer ident.
+
 GIT_EDITOR::
     Text editor for use by git commands.  The value is meant to be
     interpreted by the shell when it is used.  Examples: `~/bin/vi`,
diff --git a/builtin/var.c b/builtin/var.c
index 49b48f5..ce28101 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -26,13 +26,40 @@ static const char *pager(int flag)
 	return pgm;
 }
 
+static const char *explicit_ident(const char * (*get_ident)(int),
+				  int (*check_ident)(void))
+{
+	/*
+	 * Prime the "explicit" flag by getting the identity.
+	 * We do not want to be strict here, because we would not want
+	 * to die on bogus implicit values, but instead just report that they
+	 * are not explicit.
+	 */
+	get_ident(0);
+	return check_ident() ? "1" : "0";
+}
+
+static const char *committer_explicit(int flag)
+{
+	return explicit_ident(git_committer_info,
+			      committer_ident_sufficiently_given);
+}
+
+static const char *author_explicit(int flag)
+{
+	return explicit_ident(git_author_info,
+			      author_ident_sufficiently_given);
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
 };
 static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
+	{ "GIT_COMMITTER_EXPLICIT", committer_explicit },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
+	{ "GIT_AUTHOR_EXPLICIT", author_explicit },
 	{ "GIT_EDITOR", editor },
 	{ "GIT_PAGER", pager },
 	{ "", NULL },
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 45a5f66..66b9810 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -26,4 +26,40 @@ test_expect_success 'git var can show multiple values' '
 	test_cmp expect actual
 '
 
+for type in AUTHOR COMMITTER; do
+	test_expect_success "$type ident can detect implicit values" "
+		echo 0 >expect &&
+		(
+			sane_unset GIT_${type}_NAME &&
+			sane_unset GIT_${type}_EMAIL &&
+			sane_unset EMAIL &&
+			git var GIT_${type}_EXPLICIT >actual
+		) &&
+		test_cmp expect actual
+	"
+
+	test_expect_success "$type ident is explicit via environment" "
+		echo 1 >expect &&
+		(
+			GIT_${type}_NAME='A Name' &&
+			export GIT_${type}_NAME &&
+			GIT_${type}_EMAIL='name@example.com' &&
+			export GIT_${type}_EMAIL &&
+			git var GIT_${type}_EXPLICIT >actual
+		) &&
+		test_cmp expect actual
+	"
+
+	test_expect_success "$type ident is explicit via config" "
+		echo 1 >expect &&
+		test_config user.name 'A Name' &&
+		test_config user.email 'name@example.com' &&
+		(
+			sane_unset GIT_${type}_NAME &&
+			sane_unset GIT_${type}_EMAIL &&
+			git var GIT_${type}_EXPLICIT >actual
+		)
+	"
+done
+
 test_done
-- 
1.8.0.207.gdf2154c
