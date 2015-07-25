From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 18:36:36 -0700
Message-ID: <20150725013634.GA7269@peff.net>
References: <20150723012343.GA21000@peff.net>
 <CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
 <20150724074028.GE2111@peff.net>
 <xmqq4mkto9lg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 03:36:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIoOR-0001HX-US
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 03:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbbGYBgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 21:36:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:34756 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753083AbbGYBgk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 21:36:40 -0400
Received: (qmail 13361 invoked by uid 102); 25 Jul 2015 01:36:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 20:36:40 -0500
Received: (qmail 24303 invoked by uid 107); 25 Jul 2015 01:36:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 21:36:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 18:36:36 -0700
Content-Disposition: inline
In-Reply-To: <xmqq4mkto9lg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274607>

On Fri, Jul 24, 2015 at 08:31:55AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Whoops. Usually I "format-patch -s" and then add any notes while
> > sending. But the wifi at OSCON was so abysmal that instead I wrote the
> > notes directly into the commit message to send the whole thing later.
> > And of course format-patch is not smart enough to know that I meant
> > everything after the "---" as notes. :)
> 
> I think in the cycle we merged Couder's trailer stuff we updated the
> helper functions to locate where the S-o-b should go in an existing
> message and consolidated (or, at least "talked about consolidating")
> them into a single helper.  I do not think we wrote any special case
> for "a line with three-dashes and nothing else on it" when we did
> so, but that function would be the logical place to do so.

Yeah, it nicely has the concept of "ignore this footer". But we would
want it only to kick in when doing emails (where the "---" is
syntactically significant), I would think. So something like the patch
below (no commit message because I'm in an airport right now; I'll add
tests and repost in the next day or two).

diff --git a/log-tree.c b/log-tree.c
index 7b1b57a..8a9c35b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -688,8 +688,16 @@ void show_log(struct rev_info *opt)
 		ctx.from_ident = &opt->from_ident;
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
-	if (opt->add_signoff)
-		append_signoff(&msgbuf, 0, APPEND_SIGNOFF_DEDUP);
+	if (opt->add_signoff) {
+		int ignore = 0;
+		if (ctx.fmt == CMIT_FMT_EMAIL) {
+			const char *dashes = strstr(msgbuf.buf, "---\n");
+			if (dashes &&
+			    (dashes == msgbuf.buf || dashes[-1] == '\n'))
+				ignore = msgbuf.len - (dashes - msgbuf.buf);
+		}
+		append_signoff(&msgbuf, ignore, APPEND_SIGNOFF_DEDUP);
+	}
 
 	if ((ctx.fmt != CMIT_FMT_USERFORMAT) &&
 	    ctx.notes_message && *ctx.notes_message) {
