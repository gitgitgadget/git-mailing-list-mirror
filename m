From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --format: teach %C(auto,black) to paint it black
 only on terminals
Date: Mon, 17 Dec 2012 07:40:29 -0500
Message-ID: <20121217124029.GC21858@sigill.intra.peff.net>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
 <20121213131329.GA5042@sigill.intra.peff.net>
 <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
 <20121215101659.GB21577@sigill.intra.peff.net>
 <7v7gojtbgr.fsf@alter.siamese.dyndns.org>
 <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Srb, Michal" <michal.srb11@imperial.ac.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:40:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tka02-0002QV-7u
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 13:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab2LQMkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 07:40:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56670 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab2LQMkc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 07:40:32 -0500
Received: (qmail 5912 invoked by uid 107); 17 Dec 2012 12:41:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 07:41:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 07:40:29 -0500
Content-Disposition: inline
In-Reply-To: <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211683>

On Mon, Dec 17, 2012 at 12:40:55AM -0800, Junio C Hamano wrote:

> +# %C(auto,...) should trump --color=always
> +#
> +# NEEDSWORK: --color=never should also be tested but we need to run a
> +# similar test under pseudo-terminal with test_terminal which is too
> +# much hassle for its worth.
> +
> +test_format advanced-colors-forced \
> +	'%C(auto,red yellow bold)foo%C(auto,reset)' --color=always <<'EOF'
> +commit 131a310eb913d107dd3c09a65d1651175898735d
> +foo
> +commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
> +foo
> +EOF

Hmm. I would have expected this to output colors. In other words, for
"auto" to work just like the config-respecting colorization that is
built into git.

Yes, in this toy example, one could always just drop the "auto" when
using --color=always. But part of the point of this is that I could do:

  git config pretty.fake-oneline "%C(auto,yellow)%h%C(auto,reset) %s"

and have it behave like "--oneline", no matter what the user has in
their color.ui config or --color option on the command line.

I think the patch below (on top of yours) does the right thing by
copying the color option from the rev_info diff options into the
pretty-print context, which is the same place that the graph and
log-tree code look. That means you'll get consistent colorization
(either all or nothing) with:

  git log --graph -p --format='%C(auto,blue)%s%C(auto,reset)'

no matter what your setting of color.diff, color.ui, or --color on the
command line.

It also means that pretty-print defaults to "no colors, do not even
check stdout" when people initialize it to all-zeroes. That's probably a
good thing, as it means any callers of format_commit_message have to
consciously opt into allowing colorization in their format messages.

diff --git a/commit.h b/commit.h
index b6ad8f3..0f469e5 100644
--- a/commit.h
+++ b/commit.h
@@ -89,6 +89,7 @@ struct pretty_print_context {
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
+	int color;
 };
 
 struct userformat_want {
diff --git a/log-tree.c b/log-tree.c
index 4f86def..8876c73 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -671,6 +671,7 @@ void show_log(struct rev_info *opt)
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
+	ctx.color = opt->diffopt.use_color;
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index 9e51fec..e6a2886 100644
--- a/pretty.c
+++ b/pretty.c
@@ -967,7 +967,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			if (!end)
 				return 0;
 			if (!memcmp(begin, "auto,", 5)) {
-				if (!want_color(-1))
+				if (!want_color(c->pretty_ctx->color))
 					return end - placeholder + 1;
 				begin += 5;
 			}
