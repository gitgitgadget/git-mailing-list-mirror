From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] checkout -: make "-" to mean "previous branch"
 everywhere
Date: Sat, 21 Mar 2009 15:13:39 -0700
Message-ID: <1237673619-12608-8-git-send-email-gitster@pobox.com>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
 <1237673619-12608-2-git-send-email-gitster@pobox.com>
 <1237673619-12608-3-git-send-email-gitster@pobox.com>
 <1237673619-12608-4-git-send-email-gitster@pobox.com>
 <1237673619-12608-5-git-send-email-gitster@pobox.com>
 <1237673619-12608-6-git-send-email-gitster@pobox.com>
 <1237673619-12608-7-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 23:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9U8-0007f9-Ac
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbZCUWOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481AbZCUWOB
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:14:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbZCUWN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:13:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 680ADA3180
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C6FF4A317F for
 <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:56 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.299.gda643a
In-Reply-To: <1237673619-12608-7-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 928EA600-1665-11DE-B92C-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114083>

This is iffy, in that it teaches the very low level machinery to interpret
it as "the tip of the previous branch" when "-" is fed to it, and may have
a high risk of unintended side effects.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    8 +++++---
 sha1_name.c        |   21 +++++++++++++--------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 66df0c0..6b3b450 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -666,9 +666,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		arg = argv[0];
 		has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
 
-		if (!strcmp(arg, "-"))
-			arg = "@{-1}";
-
+		{
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_branchname(&sb, arg);
+			arg = strbuf_detach(&sb, NULL);
+		}
 		if (get_sha1(arg, rev)) {
 			if (has_dash_dash)          /* case (1) */
 				die("invalid reference: %s", arg);
diff --git a/sha1_name.c b/sha1_name.c
index 904bcd9..3972f4c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -758,14 +758,19 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	const char *brace;
 	char *num_end;
 
-	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
-		return -1;
-	brace = strchr(name, '}');
-	if (!brace)
-		return -1;
-	nth = strtol(name+3, &num_end, 10);
-	if (num_end != brace)
-		return -1;
+	if (name[0] == '-' && !name[1]) {
+		nth = 1;
+		brace = name; /* "end of branch name expression" */
+	} else {
+		if (name[0] != '@' || name[1] != '{' || name[2] != '-')
+			return -1;
+		brace = strchr(name, '}');
+		if (!brace)
+			return -1;
+		nth = strtol(name+3, &num_end, 10);
+		if (num_end != brace)
+			return -1;
+	}
 	if (nth <= 0)
 		return -1;
 	cb.alloc = nth;
-- 
1.6.2.1.299.gda643a
