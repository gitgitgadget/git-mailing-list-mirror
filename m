From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] CMIT_FMT_EMAIL: Q-encode Subject: and display-name part of From: fields.
Date: Tue, 16 May 2006 03:18:24 -0700
Message-ID: <7vmzdi9ssv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 16 12:18:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfwdJ-0005vk-3a
	for gcvg-git@gmane.org; Tue, 16 May 2006 12:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWEPKS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 06:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWEPKSZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 06:18:25 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32482 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751749AbWEPKSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 06:18:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516101824.WSPW15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 06:18:24 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20112>

By convention, the commit message and the author/committer names
in the commit objects are UTF-8 encoded.  When formatting for
e-mails, Q-encode them according to RFC 2047.

While we are at it, generate the content-type and
content-transfer-encoding headers as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 With this patch, the output formatted with

	git show --pretty=email --patch-with-stat 9d7f73d4

 would start like this:

   From 9d7f73d43fa49d0d2f5a8cfcce9d659e8ad2d265  Thu Apr 7 15:13:13 2005
   From: =?utf-8?q?Lukas_Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
   Date: Sat, 25 Feb 2006 12:20:13 +0100
   Subject: [PATCH] git-fetch: print the new and old ref when fast-forwarding
   Content-Type: text/plain; charset=UTF-8
   Content-Transfer-Encoding: 8bit

 This is marked RFC because I am not convinced if this kind of
 header formatting should be done by format-patch; we might be
 better off leaving the proper massaging to whatever downstream
 program that reads its output (e.g. send-email or imap-send).
 We produce the mbox format (and that is a requirement -- its
 output should be consumable by git-am), so the downstream needs
 to strip off the initial UNIX-From line at least anyway.

 Thoughts?

 If we decide to do the header formatting here, there are two
 further enhancements that need to be done:

 (1) The charset must be configurable for projects that use
     encoding different from UTF-8, perhaps with the .git/config
     [i18n] commitEncoding.  It is only a convention, not a hard
     rule, to use UTF-8 for the metainformation.

 (2) Some projects, notably Wine, seem to prefer patches to be
     sent as attachments, and we have support for that in the
     script version of format-patch.  We would want to have the
     same here.  This needs to be an option; define a new
     format, CMIT_FMT_MIME, and invoke it with --pretty=mime.

     Ideally we would want to say, in the body part header for
     the attachment, that the type of the payload is a raw 8bit
     text/patch without any specific charset (if the upstream
     project has a UTF-8 encoded file, you should not send in a
     patch in iso-8859-1 and expect somebody to automagically
     transcode your patch -- the patch is applied as is and MTA
     should not molest it).

 The RFC2047 q-encoding code definitely needs to be audited by
 an RFC lawyer.  I used to be one myself but I lost my edge and
 patience these days.

diff --git a/commit.c b/commit.c
index 93b3903..dee5756 100644
--- a/commit.c
+++ b/commit.c
@@ -413,6 +413,46 @@ static int get_one_line(const char *msg,
 	return ret;
 }
 
+static int is_rfc2047_special(char ch)
+{
+	return ((ch & 0x80) || (ch == '=') || (ch == '?') || (ch == '_'));
+}
+
+static int add_rfc2047(char *buf, const char *line, int len)
+{
+	char *bp = buf;
+	int i, needquote;
+	static const char q_utf8[] = "=?utf-8?q?";
+
+	for (i = needquote = 0; !needquote && i < len; i++) {
+		unsigned ch = line[i];
+		if (ch & 0x80)
+			needquote++;
+		if ((i + 1 < len) &&
+		    (ch == '=' && line[i+1] == '?'))
+			needquote++;
+	}
+	if (!needquote)
+		return sprintf(buf, "%.*s", len, line);
+
+	memcpy(bp, q_utf8, sizeof(q_utf8)-1);
+	bp += sizeof(q_utf8)-1;
+	for (i = 0; i < len; i++) {
+		unsigned ch = line[i];
+		if (is_rfc2047_special(ch)) {
+			sprintf(bp, "=%02X", ch);
+			bp += 3;
+		}
+		else if (ch == ' ')
+			*bp++ = '_';
+		else
+			*bp++ = ch;
+	}
+	memcpy(bp, "?=", 2);
+	bp += 2;
+	return bp - buf;
+}
+
 static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf, const char *line)
 {
 	char *date;
@@ -431,12 +471,26 @@ static int add_user_info(const char *wha
 	tz = strtol(date, NULL, 10);
 
 	if (fmt == CMIT_FMT_EMAIL) {
-		what = "From";
+		char *name_tail = strchr(line, '<');
+		int display_name_length;
+		if (!name_tail)
+			return 0;
+		while (line < name_tail && isspace(name_tail[-1]))
+			name_tail--;
+		display_name_length = name_tail - line;
 		filler = "";
+		strcpy(buf, "From: ");
+		ret = strlen(buf);
+		ret += add_rfc2047(buf + ret, line, display_name_length);
+		memcpy(buf + ret, name_tail, namelen - display_name_length);
+		ret += namelen - display_name_length;
+		buf[ret++] = '\n';
+	}
+	else {
+		ret = sprintf(buf, "%s: %.*s%.*s\n", what,
+			      (fmt == CMIT_FMT_FULLER) ? 4 : 0,
+			      filler, namelen, line);
 	}
-	ret = sprintf(buf, "%s: %.*s%.*s\n", what,
-		      (fmt == CMIT_FMT_FULLER) ? 4 : 0,
-		      filler, namelen, line);
 	switch (fmt) {
 	case CMIT_FMT_MEDIUM:
 		ret += sprintf(buf + ret, "Date:   %s\n", show_date(time, tz));
@@ -575,14 +629,24 @@ unsigned long pretty_print_commit(enum c
 			int slen = strlen(subject);
 			memcpy(buf + offset, subject, slen);
 			offset += slen;
+			offset += add_rfc2047(buf + offset, line, linelen);
+		}
+		else {
+			memset(buf + offset, ' ', indent);
+			memcpy(buf + offset + indent, line, linelen);
+			offset += linelen + indent;
 		}
-		memset(buf + offset, ' ', indent);
-		memcpy(buf + offset + indent, line, linelen);
-		offset += linelen + indent;
 		buf[offset++] = '\n';
 		if (fmt == CMIT_FMT_ONELINE)
 			break;
-		subject = NULL;
+		if (subject) {
+			static const char header[] =
+				"Content-Type: text/plain; charset=UTF-8\n"
+				"Content-Transfer-Encoding: 8bit\n";
+			memcpy(buf + offset, header, sizeof(header)-1);
+			offset += sizeof(header)-1;
+			subject = NULL;
+		}
 	}
 	while (offset && isspace(buf[offset-1]))
 		offset--;
