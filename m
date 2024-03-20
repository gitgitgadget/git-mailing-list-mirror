Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A405384
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 00:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894535; cv=none; b=RKZJn+dTI58VNcUUM5GHBgj8tP6eRcxgg3m2p2jameRlG7uz1kLCqEW+VxOGh5+X2lqfrG6q2C2+xFG8DDszTEi8JqPa46qWnXigMoKSGQyhGLIJAo4rUiygFj0Pw19PepzRvkC4diAfFiTf3LBWkVwEC5kXuptsUaJ+H4Zw7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894535; c=relaxed/simple;
	bh=Dij6tc3LjuuRKUCtAUX7D5jZHH6sMLrd85HlqYJeOrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKeQuJ1AAHJRvYodpWo8NRvKctNQslKm7VLED3QnkYbdBYlcs+DbF8prvHwsFLLHIZ18G4pMHv6BCWCPz+iufQGWMhdObBVYRozH17Di1hVHIbwkrd9kez0UqJ6wjRJwemR+qfQKYi6Isk++Cv19D668PDN8HXxsNqpvROoQTS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5634 invoked by uid 109); 20 Mar 2024 00:28:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 00:28:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13335 invoked by uid 111); 20 Mar 2024 00:28:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 20:28:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 20:28:51 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: [PATCH 2/6] pretty: split oneline and email subject printing
Message-ID: <20240320002851.GB904136@coredump.intra.peff.net>
References: <20240320002555.GB903718@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320002555.GB903718@coredump.intra.peff.net>

The pp_title_line() function is used for two formats: the oneline format
and the subject line of the email format. But most of the logic in the
function does not make any sense for oneline; it is about special
formatting of email headers.

Lumping the two formats together made sense long ago in 4234a76167
(Extend --pretty=oneline to cover the first paragraph, 2007-06-11), when
there was a lot of manual logic to paste lines together. But later,
88c44735ab (pretty: factor out format_subject(), 2008-12-27) pulled that
logic into its own function.

We can implement the oneline format by just calling that one function.
This makes the intention of the code much more clear, as we know we only
need to worry about those extra email options when dealing with actual
email.

While the intent here is cleanup, it is possible to trigger these cases
in practice by running format-patch with an explicit --oneline option.
But if you did, the results are basically nonsense. For example, with
the preserve_subject flag:

  $ printf "%s\n" one two three | git commit --allow-empty -F -
  $ git format-patch -1 --stdout -k | grep ^Subject
  Subject: =?UTF-8?q?one=0Atwo=0Athree?=
  $ git format-patch -1 --stdout -k --oneline --no-signature
  2af7fbe one
  two
  three

Or with extra headers:

  $ git format-patch -1 --stdout --cc=me --oneline --no-signature
  2af7fbe one two three
  Cc: me

So I'd actually consider this to be an improvement, though you are
probably crazy to use other formats with format-patch in the first place
(arguably it should forbid non-email formats entirely, but that's a
bigger change).

As a bonus, it eliminates some pointless extra allocations for the
oneline output. The email code, since it has to deal with wrapping,
formats into an extra auxiliary buffer. The speedup is tiny, though like
"rev-list --no-abbrev --format=oneline" seems to improve by a consistent
1-2% for me.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c |  2 +-
 pretty.c      | 22 ++++++++++++----------
 pretty.h      |  8 ++++----
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e5da0d1043..89cce9c29d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1297,7 +1297,7 @@ static void prepare_cover_text(struct pretty_print_context *pp,
 		subject = subject_sb.buf;
 
 do_pp:
-	pp_title_line(pp, &subject, sb, encoding, need_8bit_cte);
+	pp_email_subject(pp, &subject, sb, encoding, need_8bit_cte);
 	pp_remainder(pp, &body, sb, 0);
 
 	strbuf_release(&description_sb);
diff --git a/pretty.c b/pretty.c
index bdbed4295a..be0f2f566d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2077,11 +2077,11 @@ static void pp_header(struct pretty_print_context *pp,
 	}
 }
 
-void pp_title_line(struct pretty_print_context *pp,
-		   const char **msg_p,
-		   struct strbuf *sb,
-		   const char *encoding,
-		   int need_8bit_cte)
+void pp_email_subject(struct pretty_print_context *pp,
+		      const char **msg_p,
+		      struct strbuf *sb,
+		      const char *encoding,
+		      int need_8bit_cte)
 {
 	static const int max_length = 78; /* per rfc2047 */
 	struct strbuf title;
@@ -2126,9 +2126,8 @@ void pp_title_line(struct pretty_print_context *pp,
 	if (pp->after_subject) {
 		strbuf_addstr(sb, pp->after_subject);
 	}
-	if (cmit_fmt_is_mail(pp->fmt)) {
-		strbuf_addch(sb, '\n');
-	}
+
+	strbuf_addch(sb, '\n');
 
 	if (pp->in_body_headers.nr) {
 		int i;
@@ -2328,8 +2327,11 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	msg = skip_blank_lines(msg);
 
 	/* These formats treat the title line specially. */
-	if (pp->fmt == CMIT_FMT_ONELINE || cmit_fmt_is_mail(pp->fmt))
-		pp_title_line(pp, &msg, sb, encoding, need_8bit_cte);
+	if (pp->fmt == CMIT_FMT_ONELINE) {
+		msg = format_subject(sb, msg, " ");
+		strbuf_addch(sb, '\n');
+	} else if (cmit_fmt_is_mail(pp->fmt))
+		pp_email_subject(pp, &msg, sb, encoding, need_8bit_cte);
 
 	beginning_of_body = sb->len;
 	if (pp->fmt != CMIT_FMT_ONELINE)
diff --git a/pretty.h b/pretty.h
index 421209e9ec..d4ff79deb3 100644
--- a/pretty.h
+++ b/pretty.h
@@ -96,13 +96,13 @@ void pp_user_info(struct pretty_print_context *pp, const char *what,
 			const char *encoding);
 
 /*
- * Format title line of commit message taken from "msg_p" and
+ * Format subject line of commit message taken from "msg_p" and
  * put it into "sb".
  * First line of "msg_p" is also affected.
  */
-void pp_title_line(struct pretty_print_context *pp, const char **msg_p,
-			struct strbuf *sb, const char *encoding,
-			int need_8bit_cte);
+void pp_email_subject(struct pretty_print_context *pp, const char **msg_p,
+		      struct strbuf *sb, const char *encoding,
+		      int need_8bit_cte);
 
 /*
  * Get current state of commit message from "msg_p" and continue formatting
-- 
2.44.0.643.g35f318e502

