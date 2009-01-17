From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/5] Fix parsing of @{-1}@{1}
Date: Sat, 17 Jan 2009 19:08:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901171907530.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de> <1232208597-29249-1-git-send-email-trast@student.ethz.ch> <1232208597-29249-2-git-send-email-trast@student.ethz.ch> <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-4-git-send-email-trast@student.ethz.ch> <1232208597-29249-5-git-send-email-trast@student.ethz.ch> <1232208597-29249-6-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 17 19:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOFcb-0007zB-2N
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 19:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbZAQSHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 13:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756059AbZAQSHh
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 13:07:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:38542 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755303AbZAQSHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 13:07:36 -0500
Received: (qmail invoked by alias); 17 Jan 2009 18:07:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 17 Jan 2009 19:07:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/U/uk7/Y3UOg+wEjtgRXZ4b3HBNiLsTaQY9M6DD7
	jWTKvtiOHxLcn5
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232208597-29249-6-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106090>


To do that, Git no longer looks forward for the '@{' corresponding to the
closing '}' but backward, and dwim_ref() as well as dwim_log() learnt
about the @{-<N>} notation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	The modifications of dwim_ref() and dwim_log() are probably
	more important than the issue I tried to fix...

 sha1_name.c               |   25 ++++++++++++++++++++++++-
 t/t1505-rev-parse-last.sh |    2 +-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 306d04b..ee0c456 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -240,8 +240,28 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
+/*
+ * *string and *len will only be substituted, and *string returned (for
+ * later free()ing) if the string passed in is of the form @{-<n>}.
+ */
+static char *substitute_nth_last_branch(const char **string, int *len)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = interpret_nth_last_branch(*string, &buf);
+
+	if (ret == *len) {
+		size_t size;
+		*string = strbuf_detach(&buf, &size);
+		*len = size;
+		return (char *)*string;
+	}
+
+	return NULL;
+}
+
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
+	char *last_branch = substitute_nth_last_branch(&str, &len);
 	const char **p, *r;
 	int refs_found = 0;
 
@@ -261,11 +281,13 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 				break;
 		}
 	}
+	free(last_branch);
 	return refs_found;
 }
 
 int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 {
+	char *last_branch = substitute_nth_last_branch(&str, &len);
 	const char **p;
 	int logs_found = 0;
 
@@ -296,6 +318,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		if (!warn_ambiguous_refs)
 			break;
 	}
+	free(last_branch);
 	return logs_found;
 }
 
@@ -314,7 +337,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len = at = 0;
 	if (str[len-1] == '}') {
-		for (at = 0; at < len - 1; at++) {
+		for (at = len-2; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
 				reflog_len = (len-1) - (at+2);
 				len = at;
diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index 72e8322..2d6b31e 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -58,7 +58,7 @@ test_expect_success '@{-1}^2 works' '
 	test_rev_equivalent side^2 @{-1}^2
 '
 
-test_expect_failure '@{-1}@{1} works' '
+test_expect_success '@{-1}@{1} works' '
 	test_rev_equivalent side@{1} @{-1}@{1}
 '
 
-- 
1.6.1.332.g9a59d
