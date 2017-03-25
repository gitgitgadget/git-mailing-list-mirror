Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C5120966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbdCYVSt (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:18:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbdCYVSs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 17:18:48 -0400
Received: (qmail 14843 invoked by uid 109); 25 Mar 2017 21:11:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Mar 2017 21:11:52 +0000
Received: (qmail 13668 invoked by uid 111); 25 Mar 2017 21:12:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Mar 2017 17:12:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Mar 2017 17:11:49 -0400
Date:   Sat, 25 Mar 2017 17:11:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: add extra headers and MIME boundary directly
Message-ID: <20170325211149.yyvocmdfw4zbjyoi@sigill.intra.peff.net>
References: <6f3d0b54-7a9f-8088-3675-bd2980f69735@web.de>
 <20170325161705.wh4zueasik6iwktv@sigill.intra.peff.net>
 <c5591beb-8cb2-dc19-7820-c8b9c68aad15@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5591beb-8cb2-dc19-7820-c8b9c68aad15@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 05:56:55PM +0100, René Scharfe wrote:

> Am 25.03.2017 um 17:17 schrieb Jeff King:
> > On Sat, Mar 25, 2017 at 01:16:42PM +0100, René Scharfe wrote:
> > > @@ -374,26 +372,9 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
> > >  		graph_show_oneline(opt->graph);
> > >  	}
> > >  	if (opt->mime_boundary) {
> > > -		static char subject_buffer[1024];
> > >  		static char buffer[1024];
> > 
> > We still have this other buffer, which ends up in stat_sep. It should
> > probably get the same treatment, though I think the module boundaries
> > make it a little more awkward. We look at it in diff_flush(), which
> > otherwise doesn't need to know much about the pretty-printing.
> > 
> > Perhaps stat_sep should be a callback?
> 
> Yes, it would be nice to avoid it, but I haven't found a clean way, yet.  In
> diff.c, where it's used, we don't have commit and rev_info available (which
> we'd have to pass to a callback, or consume right there), and that's
> probably how it should be.  Perhaps preparing the filename in advance and
> passing that as a string together with mime_boundary and no_inline might be
> the way to go.

I think the no-allocation way with a callback would be something like
the patch at the end of this email. Having to stuff the commit into
rev_info is horrible, because rev_info shouldn't be carrying data
specific to individual commits. But it's really no different than what's
there now, which is stuffing a filled-out commit-specific buffer into
the same struct.

Doing it with a single allocated buffer would involve less callback
rigmarole, but it doesn't change the fact that we are stuffing
commit-specific data into the rev_info (via the diff_options member).
And then you add on top the question of who is supposed to free it
(which is punted on in the original by using a static; yech).

The most correct way is that the caller of log_write_email_headers() and
diff_flush() should have a function-local strbuf which holds the data,
gets passed to diff_flush() as some kind opaque context, and then is
freed afterwards. We don't have such a context, but if we were to abuse
diff_options.stat_sep _temporarily_, that would still be a lot cleaner.
I.e., something like this:

  struct strbuf stat_sep = STRBUF_INIT;

  /* may write into stat_sep, depending on options */
  log_write_email_headers(..., &stat_sep);
  opt->diffopt.stat_sep = stat_sep.buf;

  diff_flush(&opt->diffopt);
  opt->diffopt.stat_sep = NULL;
  strbuf_release(&stat_sep);

But it's a bit tricky because those two hunks happen in separate
functions, which means passing the strbuf around.

> > > +	if (pp->print_email_subject && pp->rev && pp->rev->mime_boundary) {
> > > +		strbuf_addf(sb,
> > > +			    "MIME-Version: 1.0\n"
> > 
> > In the original, this would have been in "after_subject". Which means we
> > would print it even if print_email_subject is not true. Why do we need
> > to check it in the new conditional?
> 
> No, we only would have printed it if log_write_email_headers() was called to
> append it to the static buffer.  print_email_subject is only set when we
> call log_write_email_headers(), so checking it makes sure that we get the
> same behavior as before.

OK. So your logic is "you would always set print_email_subject alongside
log_write_email_headers()", and mine is "you would always call
log_write_email_headers() when opt->mime_boundary is set". Both are true
today, and I do not see a big chance of them becoming untrue.

So I'm OK with it either way.

> > Not that I expect the behavior to be wrong either way; why would we have
> > a mime boundary without setting print_email_subject? But I would think
> > that "do we have a mime boundary" would be the right conditional to
> > trigger printing it.
> 
> FWIW, the test suite still passes with the print_email_subject check
> removed.  And currently only cmd_format_patch() sets mime_boundary, so we
> don't need the check indeed.

Yeah, while working on the other patch I looked at all the callers
(there are only 2), and I think it's fine. I thought at first there
might be problems with:

  git format-patch --attach --format=not-email:%s

but we skip this code when it's a non-email format (and anyway,
format-patch always sets print_email_subject whether the format is email
or not).  That command _does_ generate nonsense, because
cmd_format_patch() insists on showing the trailing mime boundary even if
the format is not email. I'm not sure there's a good reason to use a
non-email format with format-patch in the first place, let alone with
--attach. Arguably it should bail as soon as it sees the incompatible
options.

Anyway. Here's my attempt at the callback version of stat_sep.

---
diff --git a/diff.c b/diff.c
index a628ac3a9..d061f9e18 100644
--- a/diff.c
+++ b/diff.c
@@ -4819,10 +4819,9 @@ void diff_flush(struct diff_options *options)
 			fprintf(options->file, "%s%c",
 				diff_line_prefix(options),
 				options->line_termination);
-			if (options->stat_sep) {
-				/* attach patch instead of inline */
-				fputs(options->stat_sep, options->file);
-			}
+			if (options->stat_sep)
+				options->stat_sep(options->file,
+						  options->stat_sep_data);
 		}
 
 		for (i = 0; i < q->nr; i++) {
diff --git a/diff.h b/diff.h
index e9ccb38c2..4785f3b23 100644
--- a/diff.h
+++ b/diff.h
@@ -154,9 +154,11 @@ struct diff_options {
 	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
-	const char *stat_sep;
 	long xdl_opts;
 
+	void (*stat_sep)(FILE *, void *);
+	void *stat_sep_data;
+
 	int stat_width;
 	int stat_name_width;
 	int stat_graph_width;
diff --git a/log-tree.c b/log-tree.c
index 7049a1778..5cf825c41 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -348,6 +348,31 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 	}
 }
 
+static void show_mime_attachment(FILE *out, void *data)
+{
+	struct rev_info *opt = data;
+	struct strbuf filename = STRBUF_INIT;
+
+	if (opt->numbered_files)
+		strbuf_addf(&filename, "%d", opt->nr);
+	else
+		fmt_output_commit(&filename, opt->commit_for_mime, opt);
+
+	fprintf(out,
+		"\n--%s%s\n"
+		"Content-Type: text/x-patch;"
+		" name=\"%s\"\n"
+		"Content-Transfer-Encoding: 8bit\n"
+		"Content-Disposition: %s;"
+		" filename=\"%s\"\n\n",
+		mime_boundary_leader, opt->mime_boundary,
+		filename.buf,
+		opt->no_inline ? "attachment" : "inline",
+		filename.buf);
+
+	strbuf_release(&filename);
+}
+
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     int *need_8bit_cte_p)
 {
@@ -372,27 +397,10 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary) {
-		static char buffer[1024];
-		struct strbuf filename =  STRBUF_INIT;
 		*need_8bit_cte_p = -1; /* NEVER */
-
-		if (opt->numbered_files)
-			strbuf_addf(&filename, "%d", opt->nr);
-		else
-			fmt_output_commit(&filename, commit, opt);
-		snprintf(buffer, sizeof(buffer) - 1,
-			 "\n--%s%s\n"
-			 "Content-Type: text/x-patch;"
-			 " name=\"%s\"\n"
-			 "Content-Transfer-Encoding: 8bit\n"
-			 "Content-Disposition: %s;"
-			 " filename=\"%s\"\n\n",
-			 mime_boundary_leader, opt->mime_boundary,
-			 filename.buf,
-			 opt->no_inline ? "attachment" : "inline",
-			 filename.buf);
-		opt->diffopt.stat_sep = buffer;
-		strbuf_release(&filename);
+		opt->diffopt.stat_sep = show_mime_attachment;
+		opt->diffopt.stat_sep_data = opt;
+		opt->commit_for_mime = commit;
 	}
 }
 
diff --git a/revision.h b/revision.h
index 14886ec92..46ca45d96 100644
--- a/revision.h
+++ b/revision.h
@@ -156,6 +156,7 @@ struct rev_info {
 	struct log_info *loginfo;
 	int		nr, total;
 	const char	*mime_boundary;
+	struct commit *commit_for_mime;
 	const char	*patch_suffix;
 	int		numbered_files;
 	int		reroll_count;
