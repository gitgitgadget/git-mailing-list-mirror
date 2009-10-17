From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/3] Generalized "string function" syntax
Date: Sat, 17 Oct 2009 23:04:19 +0200
Message-ID: <4ADA3153.7070606@lsrfire.ath.cx>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 23:04:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzGS1-00069L-Le
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 23:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbZJQVEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 17:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbZJQVEX
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 17:04:23 -0400
Received: from india601.server4you.de ([85.25.151.105]:34622 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZJQVEW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 17:04:22 -0400
Received: from [10.0.1.101] (p57B7C517.dip.t-dialin.net [87.183.197.23])
	by india601.server4you.de (Postfix) with ESMTPSA id 30E3D2F803D;
	Sat, 17 Oct 2009 23:04:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1255681702-5215-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130577>

Junio C Hamano schrieb:
> I mentioned an idea to enhance the pretty=format language with a
> string function syntax that people can extend by adding new functions
> in one of the "What's cooking" messages earlier.  The general syntax
> would be like
> 
> %[function(args...)any string here%]
> 
> where "any string here" part would have the usual pretty=format
> strings. E.g.  git show -s --format='%{w(72,8,4)%s%+b%]' should give
> you a line wrapped commit log message if w(width,in1,in2) is such a
> function.

I pondered line wrapping with format strings briefly a long time ago, and
I always considered it to be more similar to a colour, i.e. a state that
one can change and that is applied to all following text until the next
state change.  (Except that it's always reset at the end of the format
string.)  The example above would then turn into '%w(72,8,4)%s%+b'.

Here's a patch to implement this behaviour.  It leaves the implementation
of the actual wrap function as an exercise to the reader, too. ;-)


 pretty.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index f5983f8..33464f1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -445,6 +445,7 @@ struct format_commit_context {
 	enum date_mode dmode;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
+	size_t width, indent1, indent2;
 
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -458,6 +459,7 @@ struct format_commit_context {
 	struct chunk abbrev_commit_hash;
 	struct chunk abbrev_tree_hash;
 	struct chunk abbrev_parent_hashes;
+	size_t wrap_start;
 };
 
 static int add_again(struct strbuf *sb, struct chunk *chunk)
@@ -595,6 +597,44 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 		strbuf_addch(sb, ')');
 }
 
+static void strbuf_wrap(struct strbuf *sb, size_t pos, size_t len,
+			size_t width, size_t indent1, size_t indent2)
+{
+	struct strbuf tmp = STRBUF_INIT;
+
+	if (!len)
+		return;
+	if (pos)
+		strbuf_add(&tmp, sb->buf, pos);
+
+	/* XXX: all that's missing is the wrapping code itself.. */
+	strbuf_addf(&tmp, "w(%u,%u,%u)[\n",
+		    (unsigned)width, (unsigned)indent1, (unsigned)indent2);
+	strbuf_add(&tmp, sb->buf + pos, len);
+	strbuf_addstr(&tmp, "\n]");
+
+	if (pos + len < sb->len)
+		strbuf_add(&tmp, sb->buf + pos + len, sb->len - pos - len);
+	strbuf_swap(&tmp, sb);
+	strbuf_release(&tmp);
+}
+
+static void rewrap_message_tail(struct strbuf *sb,
+				struct format_commit_context *c,
+				size_t new_width, size_t new_indent1,
+				size_t new_indent2)
+{
+	if (c->width == new_width && c->indent1 == new_indent1 &&
+	    c->indent2 == new_indent2)
+		return;
+	strbuf_wrap(sb, c->wrap_start, sb->len - c->wrap_start, c->width,
+		    c->indent1, c->indent2);
+	c->wrap_start = sb->len;
+	c->width = new_width;
+	c->indent1 = new_indent1;
+	c->indent2 = new_indent2;
+}
+
 static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
@@ -645,6 +685,30 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 			return 3;
 		} else
 			return 0;
+	case 'w':
+		if (placeholder[1] == '(') {
+			unsigned long width = 0, indent1 = 0, indent2 = 0;
+			char *next;
+			const char *start = placeholder + 2;
+			const char *end = strchr(start, ')');
+			if (!end)
+				return 0;
+			if (end > start) {
+				width = strtoul(start, &next, 10);
+				if (*next == ',') {
+					indent1 = strtoul(next + 1, &next, 10);
+					if (*next == ',') {
+						indent2 = strtoul(next + 1,
+								 &next, 10);
+					}
+				}
+				if (*next != ')')
+					return 0;
+			}
+			rewrap_message_tail(sb, c, width, indent1, indent2);
+			return end - placeholder + 1;
+		} else
+			return 0;
 	}
 
 	/* these depend on the commit */
@@ -748,7 +812,9 @@ void format_commit_message(const struct commit *commit,
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
 	context.dmode = dmode;
+	context.wrap_start = sb->len;
 	strbuf_expand(sb, format, format_commit_item, &context);
+	rewrap_message_tail(sb, &context, 0, 0, 0);
 }
 
 static void pp_header(enum cmit_fmt fmt,
