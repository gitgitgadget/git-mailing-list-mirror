From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/2] pretty: support right alignment
Date: Fri, 21 Sep 2012 20:03:49 +0700
Message-ID: <20120921130349.GA17999@lanh>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
 <1348143976-4506-3-git-send-email-pclouds@gmail.com>
 <20120920143803.GA9527@lanh>
 <7v392cd4vi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 15:03:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF2tb-0001pI-4N
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 15:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab2IUNDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 09:03:42 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48858 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab2IUNDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 09:03:41 -0400
Received: by pbbrr4 with SMTP id rr4so2586932pbb.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KKHKPweeSw+QYPOH6e2s3BsKxqRBA2UNSMzJMctBwhQ=;
        b=ZFKub8qJDC4aVSwfo29hRTDlyO0FnUChcNg/TRpDaIMKvFFriDDbQNzuZzPx0PdvFY
         7XgNYPMJToEL6pBLoqbzZAbg1QVf3Yoh/GznKLzVCU07tjxrIvCg3OCei15LZg4otjKF
         D46969MazidtM892enWgkmzkkibeQpk1Gewo5NBpkfnX9jf6T2hyMzrG8xcSrvuFAv40
         OMdMPBmshZu0H5FXGrMkpipWbxWzwxoZ1j5REEt9B/IW9/qRHyUG3k+psoKvUOr+FODN
         mHvPFtC8L41GMWjWNCpGDIv3aRuBIcHHJOs8jVpu1BY/oikR6kF4qHxI418jDKSkAYQg
         A4FA==
Received: by 10.66.83.8 with SMTP id m8mr13121845pay.48.1348232620783;
        Fri, 21 Sep 2012 06:03:40 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id g1sm4112438paz.18.2012.09.21.06.03.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 06:03:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Sep 2012 20:03:49 +0700
Content-Disposition: inline
In-Reply-To: <7v392cd4vi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206119>

On Thu, Sep 20, 2012 at 09:40:49AM -0700, Junio C Hamano wrote:
>  - I am wondering if somebody ever want to do this with a follow-up
>    patch:
> 
> 	Left %h%|Center %cd%|Right %ad
> 
>    Is %| a sensible choice for "flush right"?  I am wondering if it
>    makes more sense to make %|, %< and %> as "multi-column
>    introducer" (the example defines output with three columns) that
>    also tells how text inside each column is flushed inside the
>    column, e.g.
> 
> 	%>col 1 right flushed%|col 2 centered%< col 3 left flushed
> 
>    or something like that (we may want explicit "column width"
>    specifiers if we were to do this kind of thing).

Instead of thinking of "columns", we could go back to "placeholders",
or in printf terms, an "%s". In addition to plain %s, we need
something similar to "%*s" and "%-*s" to pad right and left.

Conceptually it's simpler. We don't have to deal with a bunch of
problems in your quotes that I cut out. Still it allows users to do
flush right, flush left and so on within limits. They just need to
think in terms of fixed-size cells. So...

%>(N)%? is transformed roughly to printf("%-*s", N, %?). Similarly
%<(N)%? becomes printf("%*s", N, %?). We could have %|(N) to pad both
%left and right (aka centered).

Better?

We might need a modifier or something to allow cutting (and maybe
putting ellipsis in place) to keep oversized cells from breaking the
layout.

The demonstration patch follows. You can't build because I don't post
the whole series.

-- 8< --
diff --git a/pretty.c b/pretty.c
index b1cec71..543c309 100644
--- a/pretty.c
+++ b/pretty.c
@@ -617,6 +617,12 @@ struct chunk {
 	size_t len;
 };
 
+enum flush_type {
+	no_flush,
+	flush_right,
+	flush_left
+};
+
 struct format_commit_context {
 	const struct commit *commit;
 	const struct pretty_print_context *pretty_ctx;
@@ -624,13 +630,14 @@ struct format_commit_context {
 	unsigned commit_message_parsed:1;
 	unsigned commit_signature_parsed:1;
 	unsigned use_color:1;
+	enum flush_type flush_type;
 	struct {
 		char *gpg_output;
 		char good_bad;
 		char *signer;
 	} signature;
 	char *message;
-	size_t width, indent1, indent2;
+	size_t width, indent1, indent2, padding;
 
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -944,6 +951,24 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			return end - placeholder + 1;
 		} else
 			return 0;
+
+	case '<':
+	case '>':
+		if (placeholder[1] == '(') {
+			const char *start = placeholder + 2;
+			const char *end = strchr(start, ')');
+			char *next;
+			int width;
+			if (!end || end == start)
+				return 0;
+			width = strtoul(start, &next, 10);
+			if (next == start || width == 0)
+				return 0;
+			c->padding = width;
+			c->flush_type = *placeholder == '<' ? flush_right : flush_left;
+			return end - placeholder + 1;
+		}
+		return 0;
 	}
 
 	/* these depend on the commit */
@@ -1102,6 +1127,8 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 				 void *context)
 {
+	struct format_commit_context *c = context;
+	struct strbuf local_sb = STRBUF_INIT;
 	int consumed;
 	size_t orig_len;
 	enum {
@@ -1127,10 +1154,23 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	if (magic != NO_MAGIC)
 		placeholder++;
 
-	orig_len = sb->len;
-	consumed = format_commit_one(sb, placeholder, context);
-	if (magic == NO_MAGIC)
-		return consumed;
+	if (c->flush_type != no_flush) {
+		int len;
+		consumed = format_commit_one(&local_sb, placeholder, context);
+		/* the number of column, esc seq skipped */
+		len = utf8_strnwidth(local_sb.buf, -1, 1);
+		strbuf_addf(sb,
+			    c->flush_type == flush_right ? "%-*s" : "%*s",
+			    (int)(c->padding + (local_sb.len - len)),
+			    local_sb.buf);
+		strbuf_release(&local_sb);
+		c->flush_type = no_flush;
+	} else {
+		orig_len = sb->len;
+		consumed = format_commit_one(sb, placeholder, context);
+		if (magic == NO_MAGIC)
+			return consumed;
+	}
 
 	if ((orig_len == sb->len) && magic == DEL_LF_BEFORE_EMPTY) {
 		while (sb->len && sb->buf[sb->len - 1] == '\n')
-- 8< --
