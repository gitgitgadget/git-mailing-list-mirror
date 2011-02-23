From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line
 subject.
Date: Wed, 23 Feb 2011 11:35:58 -0500
Message-ID: <20110223163558.GA10042@sigill.intra.peff.net>
References: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
 <7vsjvfby0z.fsf@alter.siamese.dyndns.org>
 <20110223080854.GB2724@sigill.intra.peff.net>
 <20110223094844.GA9205@sigill.intra.peff.net>
 <AANLkTimUXqKdTDcSVDK44XPhxWbHtQuDWHMED3PKqWE4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: xzer <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 17:36:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsHhB-000150-W3
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 17:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab1BWQgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 11:36:04 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44678 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754753Ab1BWQgC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 11:36:02 -0500
Received: (qmail 14240 invoked by uid 111); 23 Feb 2011 16:36:01 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 16:36:01 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 11:35:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimUXqKdTDcSVDK44XPhxWbHtQuDWHMED3PKqWE4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167699>

On Thu, Feb 24, 2011 at 12:16:04AM +0900, xzer wrote:

> To the first point, I really want to find a way that we can remain the
> line breaker
> after import a formatted patch. That's why I add a new function to product multi
> line header, I want to do something which is special to subject. In my usage,
> I told my men every day that don't write too long in the first
> paragraph, but there
> are always somebody who forgets it, then I will get a patch with a
> very long subject
> just like a nightmare(yes, I gave them my temporary fix which I submitted here,
> so they can write as long as they want).
> 
> So I want to know whether we can generate a 2047 compatible header so
> that mailer
> can catch it correctly and the git-am can import it with line breaker
> correctly too.

Yes. With my patches, if you feed a subject with linebreaks to
add_rfc2047, they will be encoded. So you just need an extra patch on
top of mine that will use straight linebreaks (_not_ linebreaks with an
extra space) in pp_title_line.  Below is a quick and dirty patch to do
that when "-k" is specified. You will also need to specify "-k" with
applying it with "git am", but other than that it seems to work.

However, I'm still not sure it's a good idea. Other parts of git will
try to treat your paragraph as a single line (e.g., git log --oneline).
Plus this patch is ugly because of the number of layers of abstraction
we have to pass the keep-subject through. I'm not sure there's a good
way around that.

---
diff --git a/builtin/log.c b/builtin/log.c
index d8c6c28..3fdf488 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -768,7 +768,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
 		     encoding);
 	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
-		      encoding, need_8bit_cte);
+		      encoding, need_8bit_cte, 0);
 	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0);
 	printf("%s\n", sb.buf);
 
@@ -1130,6 +1130,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die ("-n and -k are mutually exclusive.");
 	if (keep_subject && subject_prefix)
 		die ("--subject-prefix and -k are mutually exclusive.");
+	rev.preserve_subject = keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
diff --git a/commit.h b/commit.h
index 659c87c..6eace1c 100644
--- a/commit.h
+++ b/commit.h
@@ -73,6 +73,7 @@ struct pretty_print_context
 	int abbrev;
 	const char *subject;
 	const char *after_subject;
+	int preserve_subject;
 	enum date_mode date_mode;
 	int need_8bit_cte;
 	int show_notes;
@@ -107,7 +108,8 @@ void pp_title_line(enum cmit_fmt fmt,
 		   const char *subject,
 		   const char *after_subject,
 		   const char *encoding,
-		   int need_8bit_cte);
+		   int need_8bit_cte,
+		   int preserve_lines);
 void pp_remainder(enum cmit_fmt fmt,
 		  const char **msg_p,
 		  struct strbuf *sb,
diff --git a/log-tree.c b/log-tree.c
index b46ed3b..9b9aaf2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -504,6 +504,7 @@ void show_log(struct rev_info *opt)
 	ctx.date_mode = opt->date_mode;
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
+	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
 
diff --git a/pretty.c b/pretty.c
index 65d20a7..315f1d2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1121,12 +1121,13 @@ void pp_title_line(enum cmit_fmt fmt,
 		   const char *subject,
 		   const char *after_subject,
 		   const char *encoding,
-		   int need_8bit_cte)
+		   int need_8bit_cte,
+		   int preserve_lines)
 {
 	struct strbuf title;
 
 	strbuf_init(&title, 80);
-	*msg_p = format_subject(&title, *msg_p, " ");
+	*msg_p = format_subject(&title, *msg_p, preserve_lines ? "\n" : " ");
 
 	strbuf_grow(sb, title.len + 1024);
 	if (subject) {
@@ -1254,7 +1255,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	/* These formats treat the title line specially. */
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
 		pp_title_line(fmt, &msg, sb, context->subject,
-			      context->after_subject, encoding, need_8bit_cte);
+			      context->after_subject, encoding, need_8bit_cte,
+			      context->preserve_subject);
 
 	beginning_of_body = sb->len;
 	if (fmt != CMIT_FMT_ONELINE)
diff --git a/revision.h b/revision.h
index 05659c6..f8ddd83 100644
--- a/revision.h
+++ b/revision.h
@@ -90,7 +90,8 @@ struct rev_info {
 			abbrev_commit:1,
 			use_terminator:1,
 			missing_newline:1,
-			date_mode_explicit:1;
+			date_mode_explicit:1,
+			preserve_subject:1;
 	unsigned int	disable_stdin:1;
 
 	enum date_mode date_mode;
