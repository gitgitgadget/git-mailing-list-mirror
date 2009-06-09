From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-options: add parse_options_check to validate option specs.
Date: Tue,  9 Jun 2009 10:23:44 +0200
Message-ID: <1244535824-11970-1-git-send-email-madcoder@debian.org>
References: <7vd49ewfsi.fsf@alter.siamese.dyndns.org>
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 11:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDxc6-0006oI-6J
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 11:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638AbZFIJ1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 05:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbZFIJ1O
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 05:27:14 -0400
Received: from pan.madism.org ([88.191.52.104]:33159 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154AbZFIJ1O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 05:27:14 -0400
Received: by hermes.madism.org (Postfix, from userid 1000)
	id 4731D3C8FD; Tue,  9 Jun 2009 11:27:15 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.323.gcd28f
In-Reply-To: <7vd49ewfsi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121159>

It only searches for now for the dreaded LASTARG_DEFAULT | OPTARG
combination, but can be extended to check for any other forbidden
combination.

Options are checked each time we call parse_options_start.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e469fc0..34282ad 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -306,6 +306,28 @@ static void check_typos(const char *arg, const struct option *options)
 	}
 }
 
+static void parse_options_check(const struct option *opts)
+{
+	int err = 0;
+
+	for (; opts->type != OPTION_END; opts++) {
+		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
+		    (opts->flags & PARSE_OPT_OPTARG)) {
+			if (opts->long_name) {
+				error("`--%s` uses incompatible flags "
+				      "LASTARG_DEFAULT and OPTARG", opts->long_name);
+			} else {
+				error("`-%c` uses incompatible flags "
+				      "LASTARG_DEFAULT and OPTARG", opts->short_name);
+			}
+			err |= 1;
+		}
+	}
+
+	if (err)
+		exit(129);
+}
+
 void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 int argc, const char **argv, const char *prefix,
 			 int flags)
@@ -331,6 +353,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
 
+	parse_options_check(options);
+
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt = NULL;
 
-- 
1.6.3.2.323.gcd28f
