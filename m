From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 6/7] parse-options: have a `use default value` wildcard.
Date: Mon, 17 Dec 2007 19:23:16 +0100
Message-ID: <1197915797-30679-7-git-send-email-madcoder@debian.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org>
 <1197915797-30679-2-git-send-email-madcoder@debian.org>
 <1197915797-30679-3-git-send-email-madcoder@debian.org>
 <1197915797-30679-4-git-send-email-madcoder@debian.org>
 <1197915797-30679-5-git-send-email-madcoder@debian.org>
 <1197915797-30679-6-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:26:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KdT-0003yo-La
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772AbXLQSXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756633AbXLQSXa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:23:30 -0500
Received: from pan.madism.org ([88.191.52.104]:54948 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756641AbXLQSXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:23:20 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 16D9D3095B;
	Mon, 17 Dec 2007 19:23:19 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3670E4C0D57; Mon, 17 Dec 2007 19:23:17 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.1148.ga3ab1-dirty
In-Reply-To: <1197915797-30679-6-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68594>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/gitcli.txt |   20 +++++++++++++++-----
 parse-options.c          |   10 ++++++++--
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index b7dcf9c..a304072 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -95,14 +95,24 @@ $ git foo -oArg
 $ git foo -o Arg
 ----------------------------
 
-However, this is *NOT* allowed for switches with an optionnal value, where the
-'sticked' form must be used:
+However, this may become ambiguous for switches with an optional value. The
+enhanced option parser provides a placeholder `{}` that tells to the option
+parser that it should not try to find an argument to this switch.  Though if
+you use '{}' sticked to the option, `{}` is passed as the value.
 ----------------------------
-$ git describe --abbrev HEAD     # correct
-$ git describe --abbrev=10 HEAD  # correct
-$ git describe --abbrev 10 HEAD  # NOT WHAT YOU MEANT
+# all the following uses work
+$ git describe --abbrev HEAD
+$ git describe --abbrev {} HEAD
+$ git describe --abbrev=10 HEAD
+$ git describe --abbrev 10 HEAD
+
+# doesn't work
+$ git describe --abbrev={} HEAD
 ----------------------------
 
+Note that an optional switch will never try to use the next token as an
+argument if it starts with a dash and is not `-`.
+
 
 Documentation
 -------------
diff --git a/parse-options.c b/parse-options.c
index 679a963..8734bb1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -69,8 +69,14 @@ static int run_callback(struct optparse_t *p, parse_opt_cb *cb,
 		return (*cb)(opt, NULL, flags);
 	if (!may_ign && !arg)
 		return opterror(opt, "requires a value", flags);
-	if (may_ign && arg && arg[0] == '-' && arg[1])
-		return (*cb)(opt, NULL, flags);
+	if (may_ign && arg) {
+		if (arg[0] == '-' && arg[1])
+			return (*cb)(opt, NULL, flags);
+		if (!strcmp(arg, "{}")) {
+			use_arg(p);
+			return (*cb)(opt, NULL, flags);
+		}
+	}
 	switch ((*cb)(opt, arg, flags | may_ign)) {
 	case PARSE_OPT_OK:
 		use_arg(p);
-- 
1.5.4.rc0.1148.ga3ab1-dirty
