From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] checkout -: make "-" to mean "previous branch"
 everywhere
Date: Mon, 23 Mar 2009 00:58:40 -0700
Message-ID: <a30b063fedceb6af2320798963980ca215d94d8b.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
 <431b1969fcde69959a23355fba6894fb69c8fa0c.1237791716.git.gitster@pobox.com>
 <a552de75eb01f78046feaf7dc88e5e4833624ad5.1237791716.git.gitster@pobox.com>
 <a31dca0393fefae894b7a155ae24000107bcc383.1237791716.git.gitster@pobox.com>
 <03d3aada5a2a68a7acdb6286fd72155f01626e41.1237791716.git.gitster@pobox.com>
 <a2fab531bbb00ff64335906e22854365be2eb5c7.1237791716.git.gitster@pobox.com>
 <345e795e1891c628ad8356b730fade9f7a81e2f6.1237791716.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 09:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llf5u-0003W2-TG
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938AbZCWH7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 03:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756920AbZCWH7J
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 03:59:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756855AbZCWH7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 03:59:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B80138698
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:59:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3B6338697 for
 <git@vger.kernel.org>; Mon, 23 Mar 2009 03:59:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.349.ga64c
In-Reply-To: <345e795e1891c628ad8356b730fade9f7a81e2f6.1237791716.git.gitster@pobox.com>
In-Reply-To: <cover.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
X-Pobox-Relay-ID: 79FB1922-1780-11DE-A858-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114259>

This is iffy, in that it teaches the very low level machinery to interpret
it as "the tip of the previous branch" when "-" is fed to it, and has a
high risk of unintended side effects.

This makes "git log ..-" to work as expected, which is marginally useful
because the revision parameter parser misinterprets the other direction
"git log -..".  It also makes "git check-ref-format --branch -" to work,
which is not very useful because Porcelains can always ask for @{-1}.

It also makes a refname whose last component is "-" forbidden.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    8 +++++---
 refs.c             |    3 +++
 sha1_name.c        |   21 +++++++++++++--------
 3 files changed, 21 insertions(+), 11 deletions(-)

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
diff --git a/refs.c b/refs.c
index e355489..7e27537 100644
--- a/refs.c
+++ b/refs.c
@@ -735,6 +735,9 @@ int check_ref_format(const char *ref)
 		if (!ch) {
 			if (ref <= cp - 2 && cp[-2] == '.')
 				return CHECK_REF_FORMAT_ERROR;
+			if (ref <= cp - 2 && cp[-2] == '-' &&
+			    (cp - 3 < ref || cp[-3] == '/'))
+				return CHECK_REF_FORMAT_ERROR;
 			if (level < 2)
 				return CHECK_REF_FORMAT_ONELEVEL;
 			return ret;
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
1.6.2.1.349.ga64c
