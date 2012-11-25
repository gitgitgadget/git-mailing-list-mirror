From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/8] imap-send: store all_msgs as a strbuf
Date: Sun, 25 Nov 2012 12:08:37 +0100
Message-ID: <1353841721-16269-5-git-send-email-mhagger@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:09:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tca5l-0004G0-Q6
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab2KYLJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:09:24 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:47191 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab2KYLJV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 06:09:21 -0500
X-AuditID: 12074411-b7fa36d0000008cc-7d-50b1fc61275f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D6.27.02252.16CF1B05; Sun, 25 Nov 2012 06:09:21 -0500 (EST)
Received: from michael.fritz.box (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAPB90UG002898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 06:09:19 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqJv4Z2OAwfaNnBZdV7qZLBp6rzBb
	9C/vYrO4fHIuo8XtFfOZHVg9/r7/wOTx5Wojk8eHj3EeFy8pe3zeJBfAGsVtk5RYUhacmZ6n
	b5fAnTGnfSl7Qa9Axa5HE1gbGB/zdDFyckgImEjMb33EAmGLSVy4t56ti5GLQ0jgMqPE9cv/
	WCGcM0wSK/4/YwWpYhPQlVjU08wEYosIqElMbDvEAlLELLCaUWLylvPsXYwcHMICVhI3N0eB
	mCwCqhJPd/iAlPMKuEh8fTUfapmcxIc9j9hBbE4BV4kf+x6wgdhCQDWbL+xnnMDIu4CRYRWj
	XGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSEAJ7mCccVLuEKMAB6MSD69RysYA
	IdbEsuLK3EOMkhxMSqK8c78ChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwhj4DyvGmJFZWpRbl
	w6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHhv/AJqFCxKTU+tSMvMKUFIM3Fwgggu
	kA08QBvegxTyFhck5hZnpkMUnWJUlBLn3QOSEABJZJTmwQ2Axf4rRnGgf4R5f4JU8QDTBlz3
	K6DBTECDk6+DDS5JREhJNTD2Bcz7vG9T/3u1pPBKY4/HR++pxzccXxeosi/H5Gyl4oRbpi/7
	M/ie2794t7avtahAKFJXYf3tWdu5zmjcbud98dL+7polfzcYdyzLnTaJ+3/aGtnfR5sWaqtO
	zLK4eHjREd627jehv8K32xS+7X9wMZAn3r3zv53nyrPLgm8qWvf9WR2rdOWhEktx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210358>

all_msgs is only used as a glorified string, therefore there is no
reason to declare it as a struct msg_data.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index c818b0c..50e223a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1391,26 +1391,20 @@ static void wrap_in_html(struct msg_data *msg)
 
 #define CHUNKSIZE 0x1000
 
-static int read_message(FILE *f, struct msg_data *msg)
+static int read_message(FILE *f, struct strbuf *all_msgs)
 {
-	struct strbuf buf = STRBUF_INIT;
-
-	memset(msg, 0, sizeof(*msg));
-
 	do {
-		if (strbuf_fread(&buf, CHUNKSIZE, f) <= 0)
+		if (strbuf_fread(all_msgs, CHUNKSIZE, f) <= 0)
 			break;
 	} while (!feof(f));
 
-	msg->len  = buf.len;
-	msg->data = strbuf_detach(&buf, NULL);
-	return msg->len;
+	return all_msgs->len;
 }
 
-static int count_messages(struct msg_data *msg)
+static int count_messages(struct strbuf *all_msgs)
 {
 	int count = 0;
-	char *p = msg->data;
+	char *p = all_msgs->buf;
 
 	while (1) {
 		if (!prefixcmp(p, "From ")) {
@@ -1431,7 +1425,7 @@ static int count_messages(struct msg_data *msg)
 	return count;
 }
 
-static int split_msg(struct msg_data *all_msgs, struct msg_data *msg, int *ofs)
+static int split_msg(struct strbuf *all_msgs, struct msg_data *msg, int *ofs)
 {
 	char *p, *data;
 
@@ -1439,7 +1433,7 @@ static int split_msg(struct msg_data *all_msgs, struct msg_data *msg, int *ofs)
 	if (*ofs >= all_msgs->len)
 		return 0;
 
-	data = &all_msgs->data[*ofs];
+	data = &all_msgs->buf[*ofs];
 	msg->len = all_msgs->len - *ofs;
 
 	if (msg->len < 5 || prefixcmp(data, "From "))
@@ -1509,7 +1503,8 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 
 int main(int argc, char **argv)
 {
-	struct msg_data all_msgs, msg;
+	struct strbuf all_msgs = STRBUF_INIT;
+	struct msg_data msg;
 	struct store *ctx = NULL;
 	int ofs = 0;
 	int r;
-- 
1.8.0
