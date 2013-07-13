From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RESEND][PATCH 00/15] Towards a more awesome git branch
Date: Sat, 13 Jul 2013 19:31:39 +0700
Message-ID: <20130713123139.GA19512@lanh>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 14:31:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxyzP-0007et-0K
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 14:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140Ab3GMMbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 08:31:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48235 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab3GMMbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 08:31:31 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so9921175pbb.33
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MGriNqeJ+pfpYbGb0bv+5+sCmZFViKR7cok82OX10Fg=;
        b=C5Wy4TzUIi3ix3YNwYhutbg3NiPzdVHYLZCoYBbGj666d2PJK7stoy167QRm7I/CGe
         uK9miy8XuxJiHu+oBhmX6SzMU88139oncY4gCbeWXcbi93qRU22lMSSeu7HM7q04Cng8
         duLvJyG1J4OJ7K4gkNDhTYujiJnDkmlhbvoADbyKHi7PJGCEreR+4E/eJBVCrJxBjsuK
         BlntQgD73G9Ygvcbqwq2WJ1RYiCYOtBxegIinxt4gSxcHQ0heuW5BSmEGxUuveDf43T+
         AQX39/8YuxKlOeeIndOBwVInGYRGERf9wa6GYAwknMFWGmKR6uxaU0mmwOUyz8T+YdYr
         Ix1Q==
X-Received: by 10.69.0.168 with SMTP id az8mr2861475pbd.51.1373718688994;
        Sat, 13 Jul 2013 05:31:28 -0700 (PDT)
Received: from lanh ([115.73.199.234])
        by mx.google.com with ESMTPSA id z14sm37440902pbt.0.2013.07.13.05.31.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Jul 2013 05:31:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 13 Jul 2013 19:31:39 +0700
Content-Disposition: inline
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230280>

On Tue, Jul 09, 2013 at 04:02:11PM +0530, Ramkumar Ramachandra wrote:
> Hi,
> 
> I'm sending this out in the hope of attracting some reviews.  It's an
> unedited resend, and there were zero conflicts from the rebase.

I still don't like my callback idea. How about this? It's refactoring
a bit so that you can now extract the color parsing and alignment code
from pretty.c and add them to for-each-ref as new atoms in --format.
As this is simply extending --format, the syntax unification idea is
put back on the shelf and won't hinder your work.

parse_color() can be used to generate color escape sequences. For
alignment, you can do something like this:

pad_an_item();
process_following_atom_after_the_alignment_atom();
align_an_item();

I'm afraid it needs a bit more work on the for-each-ref side and may
even need some fixups (I tested t4205 only and it passed, but I may
have left some bugs)

-- 8< --
diff --git a/pretty.c b/pretty.c
index 9e43154..40a30a4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -766,19 +766,23 @@ enum trunc_type {
 	trunc_right
 };
 
+struct alignment {
+	enum flush_type flush_type;
+	enum trunc_type truncate;
+	int padding;
+};
+
 struct format_commit_context {
 	const struct commit *commit;
 	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
 	struct signature_check signature_check;
-	enum flush_type flush_type;
-	enum trunc_type truncate;
 	char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
 	int auto_color;
-	int padding;
+	struct alignment alignment;
 
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -957,7 +961,7 @@ static int format_reflog_person(struct strbuf *sb,
 
 static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 			  const char *placeholder,
-			  struct format_commit_context *c)
+			  int color_setting)
 {
 	if (placeholder[1] == '(') {
 		const char *begin = placeholder + 2;
@@ -967,7 +971,7 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 		if (!end)
 			return 0;
 		if (!prefixcmp(begin, "auto,")) {
-			if (!want_color(c->pretty_ctx->color))
+			if (!want_color(color_setting))
 				return end - placeholder + 1;
 			begin += 5;
 		}
@@ -995,7 +999,7 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 
 static size_t parse_padding_placeholder(struct strbuf *sb,
 					const char *placeholder,
-					struct format_commit_context *c)
+					struct alignment *c)
 {
 	const char *ch = placeholder;
 	enum flush_type flush_type;
@@ -1076,7 +1080,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			c->auto_color = 1;
 			return 7; /* consumed 7 bytes, "C(auto)" */
 		} else {
-			int ret = parse_color(sb, placeholder, c);
+			int ret = parse_color(sb, placeholder,
+					      c->pretty_ctx->color);
 			if (ret)
 				c->auto_color = 0;
 			/*
@@ -1126,7 +1131,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	case '<':
 	case '>':
-		return parse_padding_placeholder(sb, placeholder, c);
+		return parse_padding_placeholder(sb, placeholder, &c->alignment);
 	}
 
 	/* these depend on the commit */
@@ -1291,12 +1296,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	return 0;	/* unknown placeholder */
 }
 
-static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
-				    const char *placeholder,
-				    struct format_commit_context *c)
+static int pad_an_item(struct strbuf *sb, int padding)
 {
-	struct strbuf local_sb = STRBUF_INIT;
-	int total_consumed = 0, len, padding = c->padding;
 	if (padding < 0) {
 		const char *start = strrchr(sb->buf, '\n');
 		int occupied;
@@ -1305,9 +1306,17 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		occupied = utf8_strnwidth(start, -1, 1);
 		padding = (-padding) - occupied;
 	}
+	return padding;
+}
+
+static int format_an_item(const char *placeholder,
+			  struct strbuf *local_sb,
+			  struct format_commit_context *c)
+{
+	int total_consumed = 0;
 	while (1) {
 		int modifier = *placeholder == 'C';
-		int consumed = format_commit_one(&local_sb, placeholder, c);
+		int consumed = format_commit_one(local_sb, placeholder, c);
 		total_consumed += consumed;
 
 		if (!modifier)
@@ -1319,9 +1328,19 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		placeholder++;
 		total_consumed++;
 	}
-	len = utf8_strnwidth(local_sb.buf, -1, 1);
+	return total_consumed;
+}
 
-	if (c->flush_type == flush_left_and_steal) {
+static void align_an_item(struct strbuf *sb, /* in UTF-8 */
+			  struct strbuf *item,
+			  enum flush_type flush_type,
+			  enum trunc_type truncate,
+			  int padding)
+{
+	int len;
+
+	len = utf8_strnwidth(item->buf, -1, 1);
+	if (flush_type == flush_left_and_steal) {
 		const char *ch = sb->buf + sb->len - 1;
 		while (len > padding && ch > sb->buf) {
 			const char *p;
@@ -1343,55 +1362,68 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 			 * got a good ansi sequence, put it back to
 			 * local_sb as we're cutting sb
 			 */
-			strbuf_insert(&local_sb, 0, p, ch + 1 - p);
+			strbuf_insert(item, 0, p, ch + 1 - p);
 			ch = p - 1;
 		}
 		strbuf_setlen(sb, ch + 1 - sb->buf);
-		c->flush_type = flush_left;
+		flush_type = flush_left;
 	}
 
 	if (len > padding) {
-		switch (c->truncate) {
+		switch (truncate) {
 		case trunc_left:
-			strbuf_utf8_replace(&local_sb,
+			strbuf_utf8_replace(item,
 					    0, len - (padding - 2),
 					    "..");
 			break;
 		case trunc_middle:
-			strbuf_utf8_replace(&local_sb,
+			strbuf_utf8_replace(item,
 					    padding / 2 - 1,
 					    len - (padding - 2),
 					    "..");
 			break;
 		case trunc_right:
-			strbuf_utf8_replace(&local_sb,
+			strbuf_utf8_replace(item,
 					    padding - 2, len - (padding - 2),
 					    "..");
 			break;
 		case trunc_none:
 			break;
 		}
-		strbuf_addstr(sb, local_sb.buf);
+		strbuf_addstr(sb, item->buf);
 	} else {
 		int sb_len = sb->len, offset = 0;
-		if (c->flush_type == flush_left)
+		if (flush_type == flush_left)
 			offset = padding - len;
-		else if (c->flush_type == flush_both)
+		else if (flush_type == flush_both)
 			offset = (padding - len) / 2;
 		/*
 		 * we calculate padding in columns, now
 		 * convert it back to chars
 		 */
-		padding = padding - len + local_sb.len;
+		padding = padding - len + item->len;
 		strbuf_grow(sb, padding);
 		strbuf_setlen(sb, sb_len + padding);
 		memset(sb->buf + sb_len, ' ', sb->len - sb_len);
-		memcpy(sb->buf + sb_len + offset, local_sb.buf,
-		       local_sb.len);
+		memcpy(sb->buf + sb_len + offset, item->buf,
+		       item->len);
 	}
+}
+
+static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
+				    const char *placeholder,
+				    struct format_commit_context *c)
+{
+	int consumed, padding;
+	struct strbuf local_sb = STRBUF_INIT;
+
+	padding = pad_an_item(sb, c->alignment.padding);
+	consumed = format_an_item(placeholder, &local_sb, c);
+	align_an_item(sb, &local_sb, c->alignment.flush_type,
+		      c->alignment.truncate, padding);
 	strbuf_release(&local_sb);
-	c->flush_type = no_flush;
-	return total_consumed;
+	c->alignment.flush_type = no_flush;
+	return consumed;
 }
 
 static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
@@ -1424,7 +1456,7 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 		placeholder++;
 
 	orig_len = sb->len;
-	if (((struct format_commit_context *)context)->flush_type != no_flush)
+	if (((struct format_commit_context *)context)->alignment.flush_type != no_flush)
 		consumed = format_and_pad_commit(sb, placeholder, context);
 	else
 		consumed = format_commit_one(sb, placeholder, context);
-- 8< --
