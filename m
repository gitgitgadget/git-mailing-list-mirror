From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/23] refs.c: add a function to append a reflog entry to a fd
Date: Fri,  5 Dec 2014 00:08:15 +0100
Message-ID: <1417734515-11812-4-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWy-0003Mo-7T
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933375AbaLDXJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:48 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42800 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933289AbaLDXIr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:47 -0500
X-AuditID: 12074413-f79f26d0000030e7-87-5480e97ed313
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E9.A0.12519.E79E0845; Thu,  4 Dec 2014 18:08:46 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de0027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:45 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqFv3siHE4NAfFYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFv8m1Fhs3tzO4sDu8ff9ByaPnbPusnss2FTqcfGSssfnTXIBrFHc
	NkmJJWXBmel5+nYJ3BlLP35mLFglXnHt4TnmBsYDQl2MnBwSAiYSDz68Y4OwxSQu3FsPZHNx
	CAlcZpTYfmg6I4RzjEmib9dFJpAqNgFdiUU9zWC2iICaxMxVs8E6mAV+MEq8bljD3MXIwSEs
	4CfxZ3sGSA2LgKrEiW0PwTbwCrhILF55DqxEQkBOYus6b5Awp4CrxNSZrYwgthBQybNNC9kn
	MPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESYsI7GHedlDvEKMDB
	qMTDW7C7PkSINbGsuDL3EKMkB5OSKO/Zpw0hQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4jY8A
	5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErylL4AaBYtS01Mr0jJz
	ShDSTBycIMO5pESKU/NSUosSS0sy4kGREV8MjA2QFA/Q3jKQdt7igsRcoChE6ylGRSlx3nqQ
	hABIIqM0D24sLHG8YhQH+lIYYjsPMOnAdb8CGswENPhsQy3I4JJEhJRUAyOrYm7W18jiSc8W
	XNnxQtb+mEB6xf6dzV0hrvLdge07Sj91BuyL/5Ti8rM7mq/9qUeDmsyXvnj5eSvU/klIWxT7
	npVawP/874WJgTzaa9psp924p2i1b46U0ZXcxQKWYvPrFrHfSE/3PyTefNMpZ3GD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260830>

From: Ronnie Sahlberg <sahlberg@google.com>

Break out the code to create the string and writing it to the file
descriptor from log_ref_write and add it into a dedicated function
log_ref_write_fd. For now this is only used from log_ref_write,
but later on we will call this function from reflog transactions too,
which means that we will end up with only a single place,
where we write a reflog entry to a file instead of the current two
places (log_ref_write and builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 05cb299..150c980 100644
--- a/refs.c
+++ b/refs.c
@@ -2990,15 +2990,37 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 	return 0;
 }
 
+static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const char *committer, const char *msg)
+{
+	int msglen, written;
+	unsigned maxlen, len;
+	char *logrec;
+
+	msglen = msg ? strlen(msg) : 0;
+	maxlen = strlen(committer) + msglen + 100;
+	logrec = xmalloc(maxlen);
+	len = sprintf(logrec, "%s %s %s\n",
+		      sha1_to_hex(old_sha1),
+		      sha1_to_hex(new_sha1),
+		      committer);
+	if (msglen)
+		len += copy_msg(logrec + len - 1, msg) - 1;
+
+	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
+	free(logrec);
+	if (written != len)
+		return -1;
+
+	return 0;
+}
+
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
-	int logfd, result, written, oflags = O_APPEND | O_WRONLY;
-	unsigned maxlen, len;
-	int msglen;
+	int logfd, result, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
-	char *logrec;
-	const char *committer;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
@@ -3010,19 +3032,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	logfd = open(log_file, oflags);
 	if (logfd < 0)
 		return 0;
-	msglen = msg ? strlen(msg) : 0;
-	committer = git_committer_info(0);
-	maxlen = strlen(committer) + msglen + 100;
-	logrec = xmalloc(maxlen);
-	len = sprintf(logrec, "%s %s %s\n",
-		      sha1_to_hex(old_sha1),
-		      sha1_to_hex(new_sha1),
-		      committer);
-	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
-	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
-	free(logrec);
-	if (written != len) {
+	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
+				  git_committer_info(0), msg);
+	if (result) {
 		int save_errno = errno;
 		close(logfd);
 		error("Unable to append to %s", log_file);
-- 
2.1.3
