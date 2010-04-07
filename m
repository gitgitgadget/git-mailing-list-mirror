From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Initialize notes trees if %N is used and no
 --show-notes given
Date: Wed, 7 Apr 2010 02:36:42 -0400
Message-ID: <20100407063642.GA5399@coredump.intra.peff.net>
References: <20100405115548.GA19971@macbook.lan.lan>
 <201004061127.01471.trast@student.ethz.ch>
 <20100406111904.GA46425@macbook.lan.lan>
 <201004061352.21945.trast@student.ethz.ch>
 <7v39z7g4zp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Gilger <heipei@hackvalue.de>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 08:37:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzOsy-0000h1-KU
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 08:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412Ab0DGGhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 02:37:07 -0400
Received: from peff.net ([208.65.91.99]:53765 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071Ab0DGGhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 02:37:05 -0400
Received: (qmail 1013 invoked by uid 107); 7 Apr 2010 06:37:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Apr 2010 02:37:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Apr 2010 02:36:42 -0400
Content-Disposition: inline
In-Reply-To: <7v39z7g4zp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144202>

On Tue, Apr 06, 2010 at 11:18:34PM -0700, Junio C Hamano wrote:

> As Peff pointed out, %d does things lazily, but I suspect it might be hard
> to do a similar initialization for %N.

I think you would just have to stuff the notes-related options from the
rev-list options into the pretty-print context, which would then make
them available to the user-format callback.

> I wonder if we can inspect-but-not-use format string before we even start
> walking, to see if we need notes (when we see %N).

I have considered something like the patch below before, but it is not
100% accurate. Part of the parsing happens in strbuf_expand, but parsing
of things like %w(...) happens ad-hoc inside the formatting callback (so
we would see "%w(%N)" as wanting notes, when it doesn't really. In
theory it would be nicer if we separated syntax and semantics, so I
could parse %X(...) as "the %X placeholder with ... as arguments"
without having to actually understand what %X does. In practice, it
doesn't matter here because we don't have very many placeholders that
take arbitrary arguments.

The patch below is totally untested and just meant to illustrate the
approach. Use caution.

diff --git a/commit.h b/commit.h
index 2b7fd89..5081389 100644
--- a/commit.h
+++ b/commit.h
@@ -74,11 +74,16 @@ struct pretty_print_context
 	struct reflog_walk_info *reflog_info;
 };
 
+struct userformat_want {
+	unsigned notes:1;
+};
+
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
+extern void userformat_fill_want(const char *format, struct userformat_want *w);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
diff --git a/pretty.c b/pretty.c
index 6ba3da8..8ed3d36 100644
--- a/pretty.c
+++ b/pretty.c
@@ -855,6 +855,24 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	return consumed + 1;
 }
 
+static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
+				 void *context)
+{
+	struct userformat_want *w = context;
+	switch (*placeholder) {
+		case 'N': w->notes = 1;
+	}
+	return 0;
+}
+
+void userformat_fill_want(const char *format, struct userformat_want *w)
+{
+	struct strbuf dummy = STRBUF_INIT;
+	memset(w, 0, sizeof(*w));
+	strbuf_expand(&dummy, format, userformat_want_item, w);
+	strbuf_release(&dummy);
+}
+
 void format_commit_message(const struct commit *commit,
 			   const char *format, struct strbuf *sb,
 			   const struct pretty_print_context *pretty_ctx)
