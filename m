From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/14] shortlog: replace hand-parsing of author with
 pretty-printer
Date: Mon, 4 Jan 2016 05:17:13 -0500
Message-ID: <20160104101712.GA32086@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
 <20151229072953.GF8842@sigill.intra.peff.net>
 <CAPig+cRxBHp9hRBbFPYtEdytnmGdVYVMfJLKzjT6qoQ8EOSxQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 11:17:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG2Cc-00061N-OY
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 11:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbcADKRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 05:17:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:48207 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752481AbcADKRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 05:17:16 -0500
Received: (qmail 6364 invoked by uid 102); 4 Jan 2016 10:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 05:17:16 -0500
Received: (qmail 1093 invoked by uid 107); 4 Jan 2016 10:17:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 05:17:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2016 05:17:13 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cRxBHp9hRBbFPYtEdytnmGdVYVMfJLKzjT6qoQ8EOSxQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283294>

On Mon, Jan 04, 2016 at 04:43:23AM -0500, Eric Sunshine wrote:

> > +       format_commit_message(commit, "%an <%ae>", &author, &ctx);
> > +       if (author.len <= 3) {
> 
> I suppose magic number 3 is the space, '<', and '>'...

Yeah. That's worthy of a comment, I think (see below).

I don't think we will detect a case with just a missing name _or_ email,
but neither did the original.

> >                 warning(_("Missing author: %s"),
> >                     oid_to_hex(&commit->object.oid));
> >                 return;
> 
> Is this leaking strbuf 'author'?

Yes. Looks like the original leaked "buf" in the same way.

Rather than repeat the strbuf_release, I think we can introduce a goto,
like:

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 10c92fa..4180a2d 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -124,10 +124,11 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.output_encoding = get_log_output_encoding();
 
 	format_commit_message(commit, "%an <%ae>", &author, &ctx);
+	/* we can detect a total failure only by seeing " <>" in the output */
 	if (author.len <= 3) {
 		warning(_("Missing author: %s"),
 		    oid_to_hex(&commit->object.oid));
-		return;
+		goto out;
 	}
 
 	if (log->user_format)
@@ -136,6 +137,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		format_commit_message(commit, "%s", &oneline, &ctx);
 
 	insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
+
+out:
 	strbuf_release(&author);
 	strbuf_release(&oneline);
 }

That should make it easier to handle the cases added later in the
series, too.

-Peff
