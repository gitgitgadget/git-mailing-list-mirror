From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/8] imap-send: change msg_data from storing (char *, len) to storing strbuf
Date: Sun, 25 Nov 2012 12:08:39 +0100
Message-ID: <1353841721-16269-7-git-send-email-mhagger@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:09:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tca5u-0004Na-G9
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab2KYLJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:09:31 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:46349 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab2KYLJa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 06:09:30 -0500
X-AuditID: 1207440f-b7fde6d00000095c-06-50b1fc690621
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A0.D9.02396.96CF1B05; Sun, 25 Nov 2012 06:09:29 -0500 (EST)
Received: from michael.fritz.box (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAPB90UI002898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 06:09:28 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqJv5Z2OAwb5WbYuuK91MFg29V5gt
	+pd3sVlcPjmX0eL2ivnMDqwef99/YPL4crWRyePDxziPi5eUPT5vkgtgjeK2SUosKQvOTM/T
	t0vgzpj4N7hgn1FFx7Z9LA2ML9W6GDk5JARMJCZ87mCEsMUkLtxbz9bFyMUhJHCZUWLLo1fM
	EM4ZJokfp8+ygFSxCehKLOppZgKxRQTUJCa2HWIBKWIWWM0oMXnLeXaQhLBAjMTc81/BbBYB
	VYnH7xYyg9i8Ai4Sz37uZYVYJyfxYc8jsBpOAVeJH/sesIHYQkA1my/sZ5zAyLuAkWEVo1xi
	Tmmubm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkhI8e9g7Fovc4hRgINRiYfXIGVjgBBr
	YllxZe4hRkkOJiVR3rlfgUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeEOfAeV4UxIrq1KL8mFS
	0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8/L+BGgWLUtNTK9Iyc0oQ0kwcnCDDuaRE
	ilPzUlKLEktLMuJBsRFfDIwOkBQP0F4NkHbe4oLEXKAoROspRl2OOTPbnzAKseTl56VKifOy
	gBQJgBRllObBrYAlkFeM4kAfC/P+/AVUxQNMPnCTXgEtYQJaknwdbElJIkJKqoFx1orfj427
	XgefsX3OtrQ7+vixIA8npr9G2Yn/lFmWTWy8JuWgdEzDRTDq/4o8w8dzus1Ds5UkIjmk+Zbx
	Kl225NikaXf0xZMPf5kdNz6yX7L52ZEfouXBvQVzFLVEAw7Xtl2ZEeOrfmyz79Nl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210361>

struct msg_data stored (char *, len) of the data to be included in a
message, kept the character data NUL-terminated, etc., much like a
strbuf would do.  So change it to use a struct strbuf.  This makes the
code clearer and reduces copying a little bit.

A side effect of this change is that the memory for each message is
freed after it is used rather than leaked, though that detail is
unimportant given that imap-send is a top-level command.

--

For some reason, there is a bunch of infrastructure in this file for
dealing with IMAP flags, although there is nothing in the code that
actually allows any flags to be set.  If there is no plan to add
support for flags in the future, a bunch of code could be ripped out
and "struct msg_data" could be completely replaced with strbuf.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 92 +++++++++++++++++++++++++++++++------------------------------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 86cf603..a5e0e33 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -69,12 +69,7 @@ struct store {
 };
 
 struct msg_data {
-	/* NUL-terminated data: */
-	char *data;
-
-	/* length of data (not including NUL): */
-	int len;
-
+	struct strbuf data;
 	unsigned char flags;
 };
 
@@ -1268,46 +1263,49 @@ static int imap_make_flags(int flags, char *buf)
 	return d;
 }
 
-static void lf_to_crlf(struct msg_data *msg)
+static void lf_to_crlf(struct strbuf *msg)
 {
+	size_t new_len;
 	char *new;
 	int i, j, lfnum = 0;
 
-	if (msg->data[0] == '\n')
+	if (msg->buf[0] == '\n')
 		lfnum++;
 	for (i = 1; i < msg->len; i++) {
-		if (msg->data[i - 1] != '\r' && msg->data[i] == '\n')
+		if (msg->buf[i - 1] != '\r' && msg->buf[i] == '\n')
 			lfnum++;
 	}
 
-	new = xmalloc(msg->len + lfnum + 1);
-	if (msg->data[0] == '\n') {
+	new_len = msg->len + lfnum;
+	new = xmalloc(new_len + 1);
+	if (msg->buf[0] == '\n') {
 		new[0] = '\r';
 		new[1] = '\n';
 		i = 1;
 		j = 2;
 	} else {
-		new[0] = msg->data[0];
+		new[0] = msg->buf[0];
 		i = 1;
 		j = 1;
 	}
 	for ( ; i < msg->len; i++) {
-		if (msg->data[i] != '\n') {
-			new[j++] = msg->data[i];
+		if (msg->buf[i] != '\n') {
+			new[j++] = msg->buf[i];
 			continue;
 		}
-		if (msg->data[i - 1] != '\r')
+		if (msg->buf[i - 1] != '\r')
 			new[j++] = '\r';
 		/* otherwise it already had CR before */
 		new[j++] = '\n';
 	}
-	new[j] = '\0';
-	msg->len += lfnum;
-	free(msg->data);
-	msg->data = new;
+	strbuf_attach(msg, new, new_len, new_len + 1);
 }
 
-static int imap_store_msg(struct store *gctx, struct msg_data *data)
+/*
+ * Store msg to IMAP.  Also detach and free the data from msg->data,
+ * leaving msg->data empty.
+ */
+static int imap_store_msg(struct store *gctx, struct msg_data *msg)
 {
 	struct imap_store *ctx = (struct imap_store *)gctx;
 	struct imap *imap = ctx->imap;
@@ -1316,16 +1314,15 @@ static int imap_store_msg(struct store *gctx, struct msg_data *data)
 	int ret, d;
 	char flagstr[128];
 
-	lf_to_crlf(data);
+	lf_to_crlf(&msg->data);
 	memset(&cb, 0, sizeof(cb));
 
-	cb.dlen = data->len;
-	cb.data = xmalloc(cb.dlen);
-	memcpy(cb.data, data->data, data->len);
+	cb.dlen = msg->data.len;
+	cb.data = strbuf_detach(&msg->data, NULL);
 
 	d = 0;
-	if (data->flags) {
-		d = imap_make_flags(data->flags, flagstr);
+	if (msg->flags) {
+		d = imap_make_flags(msg->flags, flagstr);
 		flagstr[d++] = ' ';
 	}
 	flagstr[d] = 0;
@@ -1356,7 +1353,8 @@ static void encode_html_chars(struct strbuf *p)
 			strbuf_splice(p, i, 1, "&quot;", 6);
 	}
 }
-static void wrap_in_html(struct msg_data *msg)
+
+static void wrap_in_html(struct strbuf *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf **lines;
@@ -1366,9 +1364,7 @@ static void wrap_in_html(struct msg_data *msg)
 	static char *pre_close = "</pre>\n";
 	int added_header = 0;
 
-	strbuf_attach(&buf, msg->data, msg->len, msg->len);
-	lines = strbuf_split(&buf, '\n');
-	strbuf_release(&buf);
+	lines = strbuf_split(msg, '\n');
 	for (p = lines; *p; p++) {
 		if (! added_header) {
 			if ((*p)->len == 1 && *((*p)->buf) == '\n') {
@@ -1385,8 +1381,8 @@ static void wrap_in_html(struct msg_data *msg)
 	}
 	strbuf_addstr(&buf, pre_close);
 	strbuf_list_free(lines);
-	msg->len  = buf.len;
-	msg->data = strbuf_detach(&buf, NULL);
+	strbuf_release(msg);
+	*msg = buf;
 }
 
 #define CHUNKSIZE 0x1000
@@ -1425,34 +1421,39 @@ static int count_messages(struct strbuf *all_msgs)
 	return count;
 }
 
-static int split_msg(struct strbuf *all_msgs, struct msg_data *msg, int *ofs)
+/*
+ * Copy the next message from all_msgs, starting at offset *ofs, to
+ * msg.  Update *ofs to the start of the following message.  Return
+ * true iff a message was successfully copied.
+ */
+static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 {
 	char *p, *data;
+	size_t len;
 
-	memset(msg, 0, sizeof *msg);
 	if (*ofs >= all_msgs->len)
 		return 0;
 
 	data = &all_msgs->buf[*ofs];
-	msg->len = all_msgs->len - *ofs;
+	len = all_msgs->len - *ofs;
 
-	if (msg->len < 5 || prefixcmp(data, "From "))
+	if (len < 5 || prefixcmp(data, "From "))
 		return 0;
 
 	p = strchr(data, '\n');
 	if (p) {
-		p = &p[1];
-		msg->len -= p-data;
-		*ofs += p-data;
+		p++;
+		len -= p - data;
+		*ofs += p - data;
 		data = p;
 	}
 
 	p = strstr(data, "\nFrom ");
 	if (p)
-		msg->len = &p[1] - data;
+		len = &p[1] - data;
 
-	msg->data = xmemdupz(data, msg->len);
-	*ofs += msg->len;
+	strbuf_add(msg, data, len);
+	*ofs += len;
 	return 1;
 }
 
@@ -1504,7 +1505,7 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 int main(int argc, char **argv)
 {
 	struct strbuf all_msgs = STRBUF_INIT;
-	struct msg_data msg;
+	struct msg_data msg = {STRBUF_INIT, 0};
 	struct store *ctx = NULL;
 	int ofs = 0;
 	int r;
@@ -1564,11 +1565,12 @@ int main(int argc, char **argv)
 	ctx->name = imap_folder;
 	while (1) {
 		unsigned percent = n * 100 / total;
+
 		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
-		if (!split_msg(&all_msgs, &msg, &ofs))
+		if (!split_msg(&all_msgs, &msg.data, &ofs))
 			break;
 		if (server.use_html)
-			wrap_in_html(&msg);
+			wrap_in_html(&msg.data);
 		r = imap_store_msg(ctx, &msg);
 		if (r != DRV_OK)
 			break;
-- 
1.8.0
