From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 1/5] builtin-mailinfo.c infrastrcture changes
Date: Wed, 14 Mar 2007 16:12:22 -0400
Message-ID: <11739031472131-git-send-email-dzickus@redhat.com>
References: <11739031463211-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 21:14:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRZrd-0003ZQ-Om
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 21:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933113AbXCNUN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 16:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933147AbXCNUN7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 16:13:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38231 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933113AbXCNUN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 16:13:56 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDtlx014218
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:56 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDqEG025151
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2EKDqu7007054;
	Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2EKCRei009142;
	Wed, 14 Mar 2007 16:12:27 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2EKCRUZ009141;
	Wed, 14 Mar 2007 16:12:27 -0400
X-Mailer: git-send-email 1.5.0.2.213.g18c8-dirty
In-Reply-To: <11739031463211-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42225>

I am working on a project that required parsing through regular mboxes that
didn't necessarily have patches embedded in them.  I started by creating my
own modified copy of git-am and working from there.  Very quickly, I noticed
git-mailinfo wasn't able to handle a big chunk of my email.

After hacking up numerous solutions and running into more limitations, I
decided it was just easier to rewrite a big chunk of it.  The following
patch has a bunch of fixes and features that I needed in order for me do
what I wanted.

Note: I'm didn't follow any email rfc papers but I don't think any of the
changes I did required much knowledge (besides the boundary stuff).

List of major changes/fixes:
- can't create empty patch files fix
- empty patch files don't fail, this failure will come inside git-am
- multipart boundaries are now handled
- only output inbody headers if a patch exists otherwise assume those
headers are part of the reply and instead output the original headers
- decode and filter base64 patches correctly
- various other accidental fixes

I believe I didn't break any existing functionality or compatibility (other
than what I describe above, which is really only the empty patch file).

I tested this through various mailing list archives and everything seemed to
parse correctly (a couple thousand emails).

Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 builtin-mailinfo.c |  520 +++++++++++++++++++++++++++------------------------
 git-am.sh          |    4 +
 git-applymbox.sh   |    4 +
 git-quiltimport.sh |    4 +
 4 files changed, 287 insertions(+), 245 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 766a37e..dacdf77 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -11,19 +11,22 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
 static int keep_subject;
 static const char *metainfo_charset;
 static char line[1000];
-static char date[1000];
 static char name[1000];
 static char email[1000];
-static char subject[1000];
 
 static enum  {
 	TE_DONTCARE, TE_QP, TE_BASE64,
 } transfer_encoding;
-static char charset[256];
+static enum  {
+	TYPE_TEXT, TYPE_OTHER,
+} message_type;
 
-static char multipart_boundary[1000];
-static int multipart_boundary_len;
+static char charset[256];
 static int patch_lines;
+static char **p_hdr_data, **s_hdr_data;
+
+#define MAX_HDR_PARSED 10
+#define MAX_BOUNDARIES 5
 
 static char *sanity_check(char *name, char *email)
 {
@@ -137,15 +140,13 @@ static int handle_from(char *in_line)
 	return 1;
 }
 
-static int handle_date(char *line)
+static int handle_header(char *line, char *data, int ofs)
 {
-	strcpy(date, line);
-	return 0;
-}
+	if (!line || !data)
+		return 1;
+
+	strcpy(data, line+ofs);
 
-static int handle_subject(char *line)
-{
-	strcpy(subject, line);
 	return 0;
 }
 
@@ -177,17 +178,35 @@ static int slurp_attr(const char *line, const char *name, char *attr)
 	return 1;
 }
 
-static int handle_subcontent_type(char *line)
+struct content_type {
+	char *boundary;
+	int boundary_len;
+};
+
+static struct content_type content[MAX_BOUNDARIES];
+
+static struct content_type *content_top = content;
+
+static int handle_content_type(char *line)
 {
-	/* We do not want to mess with boundary.  Note that we do not
-	 * handle nested multipart.
+	char boundary[256];
+
+	/* the only time this return less than zero is when 
+	   /line/ does not contain "text/"
 	 */
-	if (strcasestr(line, "boundary=")) {
-		fprintf(stderr, "Not handling nested multipart message.\n");
-		exit(1);
+	if (strcasestr(line, "text/") == NULL)
+		 message_type = TYPE_OTHER;
+	if (slurp_attr(line, "boundary=", boundary + 2)) {
+		memcpy(boundary, "--", 2);
+		if (content_top++ >= &content[MAX_BOUNDARIES]) {
+			fprintf(stderr, "Too many boundaries to handle\n");
+			exit(1);
+		}
+		content_top->boundary_len = strlen(boundary);
+		content_top->boundary = xmalloc(content_top->boundary_len+1);
+		strcpy(content_top->boundary, boundary);
 	}
-	slurp_attr(line, "charset=", charset);
-	if (*charset) {
+	if (slurp_attr(line, "charset=", charset)) {
 		int i, c;
 		for (i = 0; (c = charset[i]) != 0; i++)
 			charset[i] = tolower(c);
@@ -195,17 +214,6 @@ static int handle_subcontent_type(char *line)
 	return 0;
 }
 
-static int handle_content_type(char *line)
-{
-	*multipart_boundary = 0;
-	if (slurp_attr(line, "boundary=", multipart_boundary + 2)) {
-		memcpy(multipart_boundary, "--", 2);
-		multipart_boundary_len = strlen(multipart_boundary);
-	}
-	slurp_attr(line, "charset=", charset);
-	return 0;
-}
-
 static int handle_content_transfer_encoding(char *line)
 {
 	if (strcasestr(line, "base64"))
@@ -219,7 +227,7 @@ static int handle_content_transfer_encoding(char *line)
 
 static int is_multipart_boundary(const char *line)
 {
-	return (!memcmp(line, multipart_boundary, multipart_boundary_len));
+	return (!memcmp(line, content_top->boundary, content_top->boundary_len));
 }
 
 static int eatspace(char *line)
@@ -230,62 +238,6 @@ static int eatspace(char *line)
 	return len;
 }
 
-#define SEEN_FROM 01
-#define SEEN_DATE 02
-#define SEEN_SUBJECT 04
-#define SEEN_BOGUS_UNIX_FROM 010
-#define SEEN_PREFIX  020
-
-/* First lines of body can have From:, Date:, and Subject: or empty */
-static void handle_inbody_header(int *seen, char *line)
-{
-	if (*seen & SEEN_PREFIX)
-		return;
-	if (isspace(*line)) {
-		char *cp;
-		for (cp = line + 1; *cp; cp++) {
-			if (!isspace(*cp))
-				break;
-		}
-		if (!*cp)
-			return;
-	}
-	if (!memcmp(">From", line, 5) && isspace(line[5])) {
-		if (!(*seen & SEEN_BOGUS_UNIX_FROM)) {
-			*seen |= SEEN_BOGUS_UNIX_FROM;
-			return;
-		}
-	}
-	if (!memcmp("From:", line, 5) && isspace(line[5])) {
-		if (!(*seen & SEEN_FROM) && handle_from(line+6)) {
-			*seen |= SEEN_FROM;
-			return;
-		}
-	}
-	if (!memcmp("Date:", line, 5) && isspace(line[5])) {
-		if (!(*seen & SEEN_DATE)) {
-			handle_date(line+6);
-			*seen |= SEEN_DATE;
-			return;
-		}
-	}
-	if (!memcmp("Subject:", line, 8) && isspace(line[8])) {
-		if (!(*seen & SEEN_SUBJECT)) {
-			handle_subject(line+9);
-			*seen |= SEEN_SUBJECT;
-			return;
-		}
-	}
-	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
-		if (!(*seen & SEEN_SUBJECT)) {
-			handle_subject(line);
-			*seen |= SEEN_SUBJECT;
-			return;
-		}
-	}
-	*seen |= SEEN_PREFIX;
-}
-
 static char *cleanup_subject(char *subject)
 {
 	if (keep_subject)
@@ -341,57 +293,62 @@ static void cleanup_space(char *buf)
 }
 
 static void decode_header(char *it);
-typedef int (*header_fn_t)(char *);
-struct header_def {
-	const char *name;
-	header_fn_t func;
-	int namelen;
+static char *header[MAX_HDR_PARSED] = {
+	"From","Subject","Date",
 };
 
-static void check_header(char *line, struct header_def *header)
+static int check_header(char *line, char **hdr_data)
 {
 	int i;
 
-	if (header[0].namelen <= 0) {
-		for (i = 0; header[i].name; i++)
-			header[i].namelen = strlen(header[i].name);
-	}
-	for (i = 0; header[i].name; i++) {
-		int len = header[i].namelen;
-		if (!strncasecmp(line, header[i].name, len) &&
+	/* search for the interesting parts */
+	for (i = 0; header[i]; i++) {
+		int len = strlen(header[i]);
+		if (!hdr_data[i] &&
+		    !strncasecmp(line, header[i], len) &&
 		    line[len] == ':' && isspace(line[len + 1])) {
 			/* Unwrap inline B and Q encoding, and optionally
 			 * normalize the meta information to utf8.
 			 */
 			decode_header(line + len + 2);
-			header[i].func(line + len + 2);
-			break;
+			hdr_data[i] = xmalloc(1000 * sizeof(char));
+			if (! handle_header(line, hdr_data[i], len + 2)) {
+				return 1;
+			}
 		}
 	}
-}
 
-static void check_subheader_line(char *line)
-{
-	static struct header_def header[] = {
-		{ "Content-Type", handle_subcontent_type },
-		{ "Content-Transfer-Encoding",
-		  handle_content_transfer_encoding },
-		{ NULL },
-	};
-	check_header(line, header);
-}
-static void check_header_line(char *line)
-{
-	static struct header_def header[] = {
-		{ "From", handle_from },
-		{ "Date", handle_date },
-		{ "Subject", handle_subject },
-		{ "Content-Type", handle_content_type },
-		{ "Content-Transfer-Encoding",
-		  handle_content_transfer_encoding },
-		{ NULL },
-	};
-	check_header(line, header);
+	/* Content stuff */
+	if (!strncasecmp(line, "Content-Type", 12) &&
+		line[12] == ':' && isspace(line[12 + 1])) {
+		decode_header(line + 12 + 2);
+		if (! handle_content_type(line)) {
+			return 1;
+		}
+	}
+	if (!strncasecmp(line, "Content-Transfer-Encoding", 25) &&
+		line[25] == ':' && isspace(line[25 + 1])) {
+		decode_header(line + 25 + 2);
+		if (! handle_content_transfer_encoding(line)) {
+			return 1;
+		}
+	}
+
+	/* for inbody stuff */
+	if (!memcmp(">From", line, 5) && isspace(line[5]))
+		return 1;
+	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
+		for (i=0; header[i]; i++) {
+			if (!memcmp("Subject: ", header[i], 9)) {
+				if (! handle_header(line, hdr_data[i], 0)) {
+					return 1;
+				}
+			}
+		}
+	}
+
+	/* no match */
+	return 0;
 }
 
 static int is_rfc2822_header(char *line)
@@ -647,147 +604,222 @@ static void decode_transfer_encoding(char *line)
 	}
 }
 
-static void handle_info(void)
+static int handle_filter(char *line);
+
+static int find_boundary(void)
 {
-	char *sub;
+	while(fgets(line, sizeof(line), fin) != NULL) {
+		if (is_multipart_boundary(line))
+			return 1;
+	}
+	return 0;
+}
+
+static int handle_boundary(void)
+{
+again:
+	if (!memcmp(line+content_top->boundary_len, "--", 2)) {
+		/* we hit an end boundary */
+		/* pop the current boundary off the stack */
+		free(content_top->boundary);
+		
+		/* technically won't happen as is_multipart_boundary()
+		   will fail first.  But just in case..
+		 */
+		if (content_top-- < content) {
+			fprintf(stderr, "Detected mismatched boundaries, "
+					"can't recover\n");
+			exit(1);
+		}
+		handle_filter("\n");
+
+		/* skip to the next boundary */
+		if (!find_boundary())
+			return 0;
+		goto again;
+	}
 
-	sub = cleanup_subject(subject);
-	cleanup_space(name);
-	cleanup_space(date);
-	cleanup_space(email);
-	cleanup_space(sub);
+	/* set some defaults */
+	transfer_encoding = TE_DONTCARE;
+	charset[0] = 0;
+	message_type = TYPE_TEXT;
 
-	fprintf(fout, "Author: %s\nEmail: %s\nSubject: %s\nDate: %s\n\n",
-	       name, email, sub, date);
+	/* slurp in this section's info */
+	while (read_one_header_line(line, sizeof(line), fin))
+		check_header(line, p_hdr_data);
+
+	/* eat the blank line after section info */
+	return (fgets(line, sizeof(line), fin) != NULL);
 }
 
-/* We are inside message body and have read line[] already.
- * Spit out the commit log.
- */
-static int handle_commit_msg(int *seen)
+static int handle_commit_msg(char *line)
 {
+	static int still_looking=1;
+
 	if (!cmitmsg)
 		return 0;
-	do {
-		if (!memcmp("diff -", line, 6) ||
-		    !memcmp("---", line, 3) ||
-		    !memcmp("Index: ", line, 7))
-			break;
-		if ((multipart_boundary[0] && is_multipart_boundary(line))) {
-			/* We come here when the first part had only
-			 * the commit message without any patch.  We
-			 * pretend we have not seen this line yet, and
-			 * go back to the loop.
-			 */
-			return 1;
-		}
 
-		/* Unwrap transfer encoding and optionally
-		 * normalize the log message to UTF-8.
-		 */
-		decode_transfer_encoding(line);
-		if (metainfo_charset)
-			convert_to_utf8(line, charset);
+	if (still_looking) {
+		char *cp=line;
+		if (isspace(*line)) {
+			for (cp = line + 1; *cp; cp++) {
+				if (!isspace(*cp))
+					break;
+			}
+			if (!*cp)
+				return 0;
+		}
+		if ((still_looking = check_header(cp, s_hdr_data)) != 0)
+			return 0;
+	}
 
-		handle_inbody_header(seen, line);
-		if (!(*seen & SEEN_PREFIX))
-			continue;
+	if (!memcmp("diff -", line, 6) ||
+	    !memcmp("---", line, 3) ||
+	    !memcmp("Index: ", line, 7)) {
+		fclose(cmitmsg);
+		cmitmsg = NULL;
+		return 1;
+	}
 
-		fputs(line, cmitmsg);
-	} while (fgets(line, sizeof(line), fin) != NULL);
-	fclose(cmitmsg);
-	cmitmsg = NULL;
+	fputs(line, cmitmsg);
 	return 0;
 }
 
-/* We have done the commit message and have the first
- * line of the patch in line[].
- */
-static void handle_patch(void)
+static int handle_patch(char *line)
 {
-	do {
-		if (multipart_boundary[0] && is_multipart_boundary(line))
-			break;
-		/* Only unwrap transfer encoding but otherwise do not
-		 * do anything.  We do *NOT* want UTF-8 conversion
-		 * here; we are dealing with the user payload.
-		 */
-		decode_transfer_encoding(line);
-		fputs(line, patchfile);
-		patch_lines++;
-	} while (fgets(line, sizeof(line), fin) != NULL);
+	fputs(line, patchfile);
+	patch_lines++;
+	return 0;
 }
 
-/* multipart boundary and transfer encoding are set up for us, and we
- * are at the end of the sub header.  do equivalent of handle_body up
- * to the next boundary without closing patchfile --- we will expect
- * that the first part to contain commit message and a patch, and
- * handle other parts as pure patches.
- */
-static int handle_multipart_one_part(int *seen)
+static int handle_filter(char *line)
 {
-	int n = 0;
+	static int filter=0;
 
-	while (fgets(line, sizeof(line), fin) != NULL) {
-	again:
-		n++;
-		if (is_multipart_boundary(line))
+	/* filter tells us which part we left off on
+	 * a non-zero return indicates we hit a filter point
+	 */
+	switch (filter) {
+	case 0:
+		if (!handle_commit_msg(line))
 			break;
-		if (handle_commit_msg(seen))
-			goto again;
-		handle_patch();
-		break;
+		filter++;
+	case 1:
+		if (!handle_patch(line))
+			break;
+		filter++;
+	default:
+		return 1;
 	}
-	if (n == 0)
-		return -1;
+
 	return 0;
 }
 
-static void handle_multipart_body(void)
+static void handle_body(void)
 {
-	int seen = 0;
-	int part_num = 0;
+	int rc=0;
+	static char newline[2000];
+	static char *np=newline;
 
 	/* Skip up to the first boundary */
-	while (fgets(line, sizeof(line), fin) != NULL)
-		if (is_multipart_boundary(line)) {
-			part_num = 1;
+	if (content_top->boundary) {
+		if (!find_boundary())
+			return;
+	}
+
+	do {
+		/* process any boundary lines */
+		if (content_top->boundary && is_multipart_boundary(line)) {
+			/* flush any leftover */
+			if ((transfer_encoding == TE_BASE64)  &&
+			    (np != newline)) {
+				handle_filter(newline);
+			}
+			if (!handle_boundary())
+				return;
+		}
+
+		/* Unwrap transfer encoding and optionally
+		 * normalize the log message to UTF-8.
+		 */
+		decode_transfer_encoding(line);
+		if (metainfo_charset)
+			convert_to_utf8(line, charset);
+
+		switch (transfer_encoding) {
+		case TE_BASE64:
+		{
+			char *op=line;
+
+			/* binary data most likely doesn't have newlines */
+			if (message_type != TYPE_TEXT) {
+				rc=handle_filter(line);
+				break;
+			}
+
+			/* this is a decoded line that may contain
+			 * multiple new lines.  Pass only one chunk
+			 * at a time to handle_filter()
+			 */
+
+			do {
+				while (*op != '\n' && *op != 0)
+					*np++ = *op++;
+				*np = *op;
+				if (*np != 0) {
+					/* should be sitting on a new line */
+					*(++np) = 0;
+					op++;
+					rc=handle_filter(newline);
+					np=newline;
+				}
+			} while (*op != 0);
+			/* the partial chunk is saved in newline and
+			 * will be appended by the next iteration of fgets
+			 */
 			break;
 		}
-	if (!part_num)
-		return;
-	/* We are on boundary line.  Start slurping the subhead. */
-	while (1) {
-		int hdr = read_one_header_line(line, sizeof(line), fin);
-		if (!hdr) {
-			if (handle_multipart_one_part(&seen) < 0)
-				return;
-			/* Reset per part headers */
-			transfer_encoding = TE_DONTCARE;
-			charset[0] = 0;
+		default:
+			rc=handle_filter(line);
 		}
-		else
-			check_subheader_line(line);
-	}
-	fclose(patchfile);
-	if (!patch_lines) {
-		fprintf(stderr, "No patch found\n");
-		exit(1);
-	}
+		if (rc)
+			/* nothing left to filter */
+			break;
+	} while (fgets(line, sizeof(line), fin));
+
+	return;
 }
 
-/* Non multipart message */
-static void handle_body(void)
+static void handle_info(void)
 {
-	int seen = 0;
-
-	handle_commit_msg(&seen);
-	handle_patch();
-	fclose(patchfile);
-	if (!patch_lines) {
-		fprintf(stderr, "No patch found\n");
-		exit(1);
+	char *sub;
+	char *hdr;
+	int i;
+
+	for (i=0; header[i]; i++) {
+
+		/* only print inbody headers if we output a patch file */
+		if (patch_lines && s_hdr_data[i])
+			hdr=s_hdr_data[i];
+		else if (p_hdr_data[i])
+			hdr=p_hdr_data[i];
+		else
+			continue;
+
+		if (!memcmp(header[i], "Subject", 7)) {
+			sub = cleanup_subject(hdr);
+			cleanup_space(sub);
+			fprintf(fout, "Subject: %s\n", sub);
+		} else if (!memcmp(header[i], "From", 4)) {
+			handle_from(hdr);
+			fprintf(fout, "Author: %s\n", name);
+			fprintf(fout, "Email: %s\n", email);
+		} else {
+			cleanup_space(hdr);
+			fprintf(fout, "%s: %s\n", header[i], hdr);
+		}
 	}
+	fprintf(fout, "\n");
 }
 
 int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
@@ -809,18 +841,16 @@ int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 		fclose(cmitmsg);
 		return -1;
 	}
-	while (1) {
-		int hdr = read_one_header_line(line, sizeof(line), fin);
-		if (!hdr) {
-			if (multipart_boundary[0])
-				handle_multipart_body();
-			else
-				handle_body();
-			handle_info();
-			break;
-		}
-		check_header_line(line);
-	}
+
+	p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(char *));
+	s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(char *));
+
+	/* process the email header */
+	while (read_one_header_line(line, sizeof(line), fin))
+		check_header(line, p_hdr_data);
+
+	handle_body();
+	handle_info();
 
 	return 0;
 }
diff --git a/git-am.sh b/git-am.sh
index 2c73d11..847a44f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -290,6 +290,10 @@ do
 		git-mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
 			<"$dotest/$msgnum" >"$dotest/info" ||
 			stop_here $this
+		test -s $dotest/patch || { 
+			echo "Patch is empty.  Was is split wrong?"
+			stop_here $this
+		}
 		git-stripspace < "$dotest/msg" > "$dotest/msg-clean"
 		;;
 	esac
diff --git a/git-applymbox.sh b/git-applymbox.sh
index 1f68599..2cbdc7e 100755
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -77,6 +77,10 @@ do
     *)
 	    git-mailinfo $keep_subject $utf8 \
 		.dotest/msg .dotest/patch <$i >.dotest/info || exit 1
+	    test -s $dotest/patch || {
+		echo "Patch is empty.  Was is split wrong?"
+		stop_here $this
+	    }
 	    git-stripspace < .dotest/msg > .dotest/msg-clean
 	    ;;
     esac
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 671a5ff..08ac9bb 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -73,6 +73,10 @@ mkdir $tmp_dir || exit 2
 for patch_name in $(cat "$QUILT_PATCHES/series" | grep -v '^#'); do
 	echo $patch_name
 	(cat $QUILT_PATCHES/$patch_name | git-mailinfo "$tmp_msg" "$tmp_patch" > "$tmp_info") || exit 3
+	test -s $dotest/patch || {
+		echo "Patch is empty.  Was is split wrong?"
+		stop_here $this
+	}
 
 	# Parse the author information
 	export GIT_AUTHOR_NAME=$(sed -ne 's/Author: //p' "$tmp_info")
-- 
1.5.0.2.211.g2ca9-dirty
