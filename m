From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/7] strbuf: add "include_delim" parameter to "strbuf_split"
Date: Thu, 12 Mar 2009 08:51:03 +0100
Message-ID: <20090312085103.e83b34a5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 08:53:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhfjV-00079b-Vc
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 08:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbZCLHwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 03:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbZCLHwE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 03:52:04 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:46627 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbZCLHwC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 03:52:02 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 450C89400ED;
	Thu, 12 Mar 2009 08:51:50 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id D929E940180;
	Thu, 12 Mar 2009 08:51:47 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113012>

The "strbuf_split" function used to include the delimiter character
at the end of the splited strbufs it produced.

This behavior is not wanted in many cases, so this patch adds a new
"include_delim" parameter to the function to let us switch it on or
off as we want.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-mailinfo.c |    2 +-
 imap-send.c        |    2 +-
 strbuf.c           |    8 +++++---
 strbuf.h           |    2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 2789ccd..b96ea1a 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -814,7 +814,7 @@ static void handle_body(void)
 			 * multiple new lines.  Pass only one chunk
 			 * at a time to handle_filter()
 			 */
-			lines = strbuf_split(&line, '\n');
+			lines = strbuf_split(&line, '\n', 1);
 			for (it = lines; (sb = *it); it++) {
 				if (*(it + 1) == NULL) /* The last line */
 					if (sb->buf[sb->len - 1] != '\n') {
diff --git a/imap-send.c b/imap-send.c
index cb518eb..a27f744 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1289,7 +1289,7 @@ static void wrap_in_html(struct msg_data *msg)
 	int added_header = 0;
 
 	strbuf_attach(&buf, msg->data, msg->len, msg->len);
-	lines = strbuf_split(&buf, '\n');
+	lines = strbuf_split(&buf, '\n', 1);
 	strbuf_release(&buf);
 	for (p = lines; *p; p++) {
 		if (! added_header) {
diff --git a/strbuf.c b/strbuf.c
index 6ed0684..4ef9084 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -97,7 +97,9 @@ void strbuf_tolower(struct strbuf *sb)
 		sb->buf[i] = tolower(sb->buf[i]);
 }
 
-struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
+struct strbuf **strbuf_split(const struct strbuf *sb,
+			     int delim,
+			     int include_delim)
 {
 	int alloc = 2, pos = 0;
 	char *n, *p;
@@ -114,8 +116,8 @@ struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
 			ret = xrealloc(ret, sizeof(struct strbuf *) * alloc);
 		}
 		if (!n)
-			n = sb->buf + sb->len - 1;
-		len = n - p + 1;
+			n = sb->buf + sb->len - (include_delim ? 1 : 0);
+		len = n - p + (include_delim ? 1 : 0);
 		t = xmalloc(sizeof(struct strbuf));
 		strbuf_init(t, len);
 		strbuf_add(t, p, len);
diff --git a/strbuf.h b/strbuf.h
index 89bd36e..2202d28 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -83,7 +83,7 @@ extern void strbuf_ltrim(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 extern void strbuf_tolower(struct strbuf *);
 
-extern struct strbuf **strbuf_split(const struct strbuf *, int delim);
+extern struct strbuf **strbuf_split(const struct strbuf *, int delim, int include_delim);
 extern void strbuf_list_free(struct strbuf **);
 
 /*----- add data in your buffer -----*/
-- 
1.6.2.83.g012a16.dirty
