From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "git tag -u keyname" broken
Date: Mon, 10 Dec 2007 20:08:06 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712101950110.28293@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 05:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1wQC-00070t-Rh
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 05:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbXLKEIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 23:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbXLKEIS
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 23:08:18 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54957 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751983AbXLKEIR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2007 23:08:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBB487jO003303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Dec 2007 20:08:08 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBB4862R001600;
	Mon, 10 Dec 2007 20:08:07 -0800
X-Spam-Status: No, hits=-2.718 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67784>


Commit 396865859918e9c7bf8ce74aae137c57da134610 broke signed tags using 
the "-u" flag when it made builtin-tag.c use parse_options() to parse its
arguments (but it quite possibly was broken even before that, by the 
builtin rewrite).

It used to be that passing the signing ID with the -u parameter also 
(obviously!) implied that you wanted to sign and annotate the tag, but 
that logic got dropped. It also totally ignored the actual key ID that was 
passed in.

This reinstates it all.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This has gotten only very minimal testing. Somebody should double-check it 
all, and adding a test would probably be great too.

 builtin-tag.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 517419f..274901a 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -236,14 +236,18 @@ static const char tag_template[] =
 	"# Write a tag message\n"
 	"#\n";
 
+static void set_signingkey(const char *value)
+{
+	if (strlcpy(signingkey, value, sizeof(signingkey)) >= sizeof(signingkey))
+		die("signing key value too long (%.10s...)", value);
+}
+
 static int git_tag_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
 			die("user.signingkey without value");
-		if (strlcpy(signingkey, value, sizeof(signingkey))
-						>= sizeof(signingkey))
-			die("user.signingkey value too long");
+		set_signingkey(value);
 		return 0;
 	}
 
@@ -396,6 +400,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, git_tag_usage, 0);
 
+	if (keyid) {
+		sign = 1;
+		set_signingkey(keyid);
+	}
 	if (sign)
 		annotate = 1;
 
