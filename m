From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: [PATCH] pretty.c: add %z specifier.
Date: Thu, 20 Mar 2008 19:45:26 -0500
Message-ID: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 01:46:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcVOc-00051m-QW
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 01:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbYCUAp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 20:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbYCUAp2
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 20:45:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:56635 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbYCUAp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 20:45:27 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1116691wra.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 17:45:27 -0700 (PDT)
Received: by 10.150.143.14 with SMTP id q14mr1258209ybd.44.1206060326476;
        Thu, 20 Mar 2008 17:45:26 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Thu, 20 Mar 2008 17:45:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77691>

This adds a %z format which prints out a null character.  This allows for
easier machine parsing of multiline data.  It is also necessary to use write
to print out the data since printf will terminate at a null.  That in turn
requires that an fflush be executed before the write to preserve the order
the data is printed.

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 log-tree.c |    7 +++++--
 pretty.c   |    3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 608f697..e116a1f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -308,8 +308,11 @@ void show_log(struct rev_info *opt, const char *sep)
 	if (opt->show_log_size)
 		printf("log size %i\n", (int)msgbuf.len);

-	if (msgbuf.len)
-		printf("%s%s%s", msgbuf.buf, extra, sep);
+	if (msgbuf.len) {
+		fflush(stdout);
+		write(STDOUT_FILENO, msgbuf.buf, msgbuf.len);
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
1.5.4.4.552.g9987b
