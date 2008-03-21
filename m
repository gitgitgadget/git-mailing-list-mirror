From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PATCH v2] pretty.c: add %z specifier.
Date: Thu, 20 Mar 2008 21:30:35 -0500
Message-ID: <5d46db230803201930r66d1331dw571aec7114f5fd51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 03:31:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcX2O-0005Ak-5q
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 03:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbYCUCai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 22:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbYCUCai
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 22:30:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:62717 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbYCUCag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 22:30:36 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1146955wra.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 19:30:35 -0700 (PDT)
Received: by 10.151.38.12 with SMTP id q12mr1290071ybj.174.1206066635758;
        Thu, 20 Mar 2008 19:30:35 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Thu, 20 Mar 2008 19:30:35 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 2df35c2a19b6c2a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77698>

This adds a %z format which prints out a null character.  This allows for
easier machine parsing of multiline data.  It is also necessary to use fwrite
to print out the data since printf will terminate at a null.

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 Documentation/pretty-formats.txt |    1 +
 log-tree.c                       |    6 ++++--
 pretty.c                         |    3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0193c3c..f4b3134 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,3 +123,4 @@ The placeholders are:
 - '%Creset': reset color
 - '%m': left, right or boundary mark
 - '%n': newline
+- '%z': null character
diff --git a/log-tree.c b/log-tree.c
index 608f697..3bb6e49 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -308,8 +308,10 @@ void show_log(struct rev_info *opt, const char *sep)
 	if (opt->show_log_size)
 		printf("log size %i\n", (int)msgbuf.len);

-	if (msgbuf.len)
-		printf("%s%s%s", msgbuf.buf, extra, sep);
+	if (msgbuf.len) {
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		printf("%s%s", extra, sep);
+	}
 	strbuf_release(&msgbuf);
 }

diff --git a/pretty.c b/pretty.c
index 703f521..fd155ec 100644
--- a/pretty.c
+++ b/pretty.c
@@ -478,6 +478,9 @@ static size_t format_commit_item(struct strbuf
*sb, const char *placeholder,
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
+	case 'z':		/* null */
+		strbuf_addch(sb, '\0');
+		return 1;
 	}

 	/* these depend on the commit */
-- 
1.5.4.4.552.g1d39e.dirty
