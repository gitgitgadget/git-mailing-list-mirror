From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 19/24] Let 'git http-fetch -h' show usage outside any git repository
Date: Mon,  9 Nov 2009 09:04:59 -0600
Message-ID: <1257779104-23884-19-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfD-0002nn-Gi
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbZKIOzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755643AbZKIOzp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:45 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64393 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712AbZKIOzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:42 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179582ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1xk9mD5kOrrn1Qn5aYA4iLfuwv04xGDgSVXxuLQ1pPM=;
        b=LRp/7zYWSSdNikOg3pAexc2sKWXq33AxHeHHXXY0yx9Atn7qtKNyqmANX6R2k/m+mV
         1R21qDsdCbKkpx/698uWiomy+/L7KEUHz4OxbYF2+2crOBWBfTxFRi3THimLkDBAZN32
         Xga81D7MDwUM/Wkn0+GRtNX99aZFfMFSreb70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZmM7EWfXsORh/6+HzRoa3JRk7UuAQGjDH5s8jspBKqLVIuYsqsHOj3QSQxsTQwYWdg
         A5/WP4wtIFNT0OxYiiG5VfjqaNzO5Yb5qwyZX1cnDQFLvOlen+tHmyToaYacROX1o02E
         mEFNrdukCCXPKB9405ikvDafowsBazXrR/724=
Received: by 10.216.93.14 with SMTP id k14mr2476513wef.152.1257778548060;
        Mon, 09 Nov 2009 06:55:48 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:47 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132478>

Delay search for a git directory until option parsing has finished.
None of the functions used in option parsing look for or read any
files other than stdin, so this is safe.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 http-fetch.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index e8f44ba..52a4f6d 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,6 +1,10 @@
 #include "cache.h"
+#include "exec_cmd.h"
 #include "walker.h"
 
+static const char http_fetch_usage[] = "git http-fetch "
+"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
+
 int main(int argc, const char **argv)
 {
 	const char *prefix;
@@ -19,10 +23,6 @@ int main(int argc, const char **argv)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
-	prefix = setup_git_directory();
-
-	git_config(git_default_config, NULL);
-
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
 			get_tree = 1;
@@ -37,6 +37,8 @@ int main(int argc, const char **argv)
 		} else if (argv[arg][1] == 'w') {
 			write_ref = &argv[arg + 1];
 			arg++;
+		} else if (argv[arg][1] == 'h') {
+			usage(http_fetch_usage);
 		} else if (!strcmp(argv[arg], "--recover")) {
 			get_recover = 1;
 		} else if (!strcmp(argv[arg], "--stdin")) {
@@ -44,10 +46,8 @@ int main(int argc, const char **argv)
 		}
 		arg++;
 	}
-	if (argc < arg + 2 - commits_on_stdin) {
-		usage("git http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url");
-		return 1;
-	}
+	if (argc != arg + 2 - commits_on_stdin)
+		usage(http_fetch_usage);
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
 	} else {
@@ -55,6 +55,11 @@ int main(int argc, const char **argv)
 		commits = 1;
 	}
 	url = argv[arg];
+
+	prefix = setup_git_directory();
+
+	git_config(git_default_config, NULL);
+
 	if (url && url[strlen(url)-1] != '/') {
 		rewritten_url = xmalloc(strlen(url)+2);
 		strcpy(rewritten_url, url);
-- 
1.6.5.2
