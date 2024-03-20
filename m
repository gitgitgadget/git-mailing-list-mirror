Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34672629
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894647; cv=none; b=al83y4iYqoA3d2Zdm7Rjm7uIcihAt4eJwa4jxQBX8rQK6y+NOAFM+pEd1/NQsQQuoFWlSrvf5s3qbvWlbEDMSOYe0rVCjr7AsAA9bSFMzqTN6bABgptg9HqH7wWATkeDMryohkSLSCC7g9Qn3HJCxWdpDoVP7mPUGjH8Yy5UrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894647; c=relaxed/simple;
	bh=Uld+TwzKkhqULzrSjtuuxtNC9odtYfQTzUrb7OB2Ht4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNRViF/nHSQ1OkdIR8HBWr1rwCHIk1QpjYRn+HOl7v2JamWAFrt5aHkrIxlwDWwXV5G5gq5NZPFDhzvZpO5yOqcFlf6POVxPwDSrWrWM1GRNf23bGxrFQDrUuRw1xEQ1upzNg8cwBj3+MGeyTwvGsz/9OCZj19pHp/TG6vrtU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5640 invoked by uid 109); 20 Mar 2024 00:30:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 00:30:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13371 invoked by uid 111); 20 Mar 2024 00:30:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 20:30:47 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 20:30:44 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: [PATCH 3/6] pretty: drop print_email_subject flag
Message-ID: <20240320003044.GC904136@coredump.intra.peff.net>
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

With one exception, the print_email_subject flag is set if and only if
the commit format is email based:

  - in make_cover_letter() we set it along with CMIT_FMT_EMAIL
    explicitly

  - in show_log(), we set it if cmit_fmt_is_mail() is true. That covers
    format-patch as well as "git log --format=email" (or mboxrd).

The one exception is "rev-list --format=email", which somewhat
nonsensically prints the author and date as email headers, but no
subject, like:

  $ git rev-list --format=email HEAD
  commit 64fc4c2cdd4db2645eaabb47aa4bac820b03cdba
  From: Jeff King <peff@peff.net>
  Date: Tue, 19 Mar 2024 19:39:26 -0400

  this is the subject

  this is the body

It's doubtful that this is a useful format at all (the "commit" lines
replace the "From" lines that would make it work as an actual mbox).
But I think that printing the subject as a header (like this patch does)
is the least surprising thing to do.

So let's drop this field, making the code a little simpler and easier to
reason about. Note that we do need to set the "rev" field of the
pretty_print_context in rev-list, since that is used to check for
subject_prefix, etc. It's not possible to set those fields via rev-list,
so we'll always just print "Subject: ". But unless we pass in our
rev_info, fmt_output_email_subject() would segfault trying to figure it
out.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is not strictly necessary for building your series, but it
seemed like a useful simplification/cleanup made possible by the
previous commits.

I didn't bother with tests here or in the previous commit, because I
think the commands I've shown are basically nonsense. So while there are
user-visible changes, to me they are more "this is slightly less
nonsensical than the previous behavior", and the main motivation is the
cleanup.

 builtin/log.c      |  1 -
 builtin/rev-list.c |  1 +
 log-tree.c         |  1 -
 pretty.c           | 21 ++++++++-------------
 pretty.h           |  1 -
 5 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 89cce9c29d..071a7f3131 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1364,7 +1364,6 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	pp.fmt = CMIT_FMT_EMAIL;
 	pp.date_mode.type = DATE_RFC2822;
 	pp.rev = rev;
-	pp.print_email_subject = 1;
 	pp.encode_email_headers = rev->encode_email_headers;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
 	prepare_cover_text(&pp, description_file, branch_name, &sb,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ec455aa972..77803727e0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -219,6 +219,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.fmt = revs->commit_format;
 		ctx.output_encoding = get_log_output_encoding();
 		ctx.color = revs->diffopt.use_color;
+		ctx.rev = revs;
 		pretty_print_commit(&ctx, commit, &buf);
 		if (buf.len) {
 			if (revs->commit_format != CMIT_FMT_ONELINE)
diff --git a/log-tree.c b/log-tree.c
index e5438b029d..c27240a533 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -742,7 +742,6 @@ void show_log(struct rev_info *opt)
 		log_write_email_headers(opt, commit, &extra_headers,
 					&ctx.need_8bit_cte, 1);
 		ctx.rev = opt;
-		ctx.print_email_subject = 1;
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), opt->diffopt.file);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
diff --git a/pretty.c b/pretty.c
index be0f2f566d..eecbce82cf 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2091,19 +2091,14 @@ void pp_email_subject(struct pretty_print_context *pp,
 				pp->preserve_subject ? "\n" : " ");
 
 	strbuf_grow(sb, title.len + 1024);
-	if (pp->print_email_subject) {
-		if (pp->rev)
-			fmt_output_email_subject(sb, pp->rev);
-		if (pp->encode_email_headers &&
-		    needs_rfc2047_encoding(title.buf, title.len))
-			add_rfc2047(sb, title.buf, title.len,
-						encoding, RFC2047_SUBJECT);
-		else
-			strbuf_add_wrapped_bytes(sb, title.buf, title.len,
+	fmt_output_email_subject(sb, pp->rev);
+	if (pp->encode_email_headers &&
+	    needs_rfc2047_encoding(title.buf, title.len))
+		add_rfc2047(sb, title.buf, title.len,
+			    encoding, RFC2047_SUBJECT);
+	else
+		strbuf_add_wrapped_bytes(sb, title.buf, title.len,
 					 -last_line_length(sb), 1, max_length);
-	} else {
-		strbuf_addbuf(sb, &title);
-	}
 	strbuf_addch(sb, '\n');
 
 	if (need_8bit_cte == 0) {
@@ -2319,7 +2314,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	}
 
 	pp_header(pp, encoding, commit, &msg, sb);
-	if (pp->fmt != CMIT_FMT_ONELINE && !pp->print_email_subject) {
+	if (pp->fmt != CMIT_FMT_ONELINE && !cmit_fmt_is_mail(pp->fmt)) {
 		strbuf_addch(sb, '\n');
 	}
 
diff --git a/pretty.h b/pretty.h
index d4ff79deb3..021bc1d658 100644
--- a/pretty.h
+++ b/pretty.h
@@ -39,7 +39,6 @@ struct pretty_print_context {
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
-	int print_email_subject;
 	int expand_tabs_in_log;
 	int need_8bit_cte;
 	char *notes_message;
-- 
2.44.0.643.g35f318e502

