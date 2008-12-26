From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] merge-file: handle freopen() failure
Date: Fri, 26 Dec 2008 11:17:04 +0100
Message-ID: <1230286624.6728.56.camel@ubuntu.ubuntu-domain>
References: <1230284785.6728.26.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 11:18:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG9lz-0005vT-Is
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 11:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbYLZKRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 05:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753661AbYLZKRH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 05:17:07 -0500
Received: from india601.server4you.de ([85.25.151.105]:33084 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbYLZKRG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 05:17:06 -0500
Received: from [10.0.1.101] (p57B7E108.dip.t-dialin.net [87.183.225.8])
	by india601.server4you.de (Postfix) with ESMTPSA id A5BDF2F8003;
	Fri, 26 Dec 2008 11:17:04 +0100 (CET)
In-Reply-To: <1230284785.6728.26.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103930>

Report the error if redirection of stderr to /dev/null failed.

This silences a compiler warning about ignoring the return value
of freopen() on Ubuntu 8.10.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-merge-file.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 9d4e874..96edb97 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -51,8 +51,11 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, options, merge_file_usage, 0);
 	if (argc != 3)
 		usage_with_options(merge_file_usage, options);
-	if (quiet)
-		freopen("/dev/null", "w", stderr);
+	if (quiet) {
+		if (!freopen("/dev/null", "w", stderr))
+			return error("failed to redirect stderr to /dev/null: "
+				     "%s\n", strerror(errno));
+	}
 
 	for (i = 0; i < 3; i++) {
 		if (!names[i])
