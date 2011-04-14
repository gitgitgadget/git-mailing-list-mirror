From: Jeff King <peff@peff.net>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 13:50:34 -0400
Message-ID: <20110414175034.GA23342@sigill.intra.peff.net>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:50:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAQh1-0003xk-1s
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 19:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933379Ab1DNRuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 13:50:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39890
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933192Ab1DNRug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 13:50:36 -0400
Received: (qmail 1624 invoked by uid 107); 14 Apr 2011 17:51:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 13:51:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 13:50:34 -0400
Content-Disposition: inline
In-Reply-To: <7v39lkiwoj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171528>

On Thu, Apr 14, 2011 at 10:12:44AM -0700, Junio C Hamano wrote:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
> > With certain combinations of author name and email lengths, git
> > format-patch does not correctly wrap the From line to be below 78
> > characters, violating rfc2047.
> 
> Didn't we have this fixed quite a while ago with the series that ends at
> c22e7de (format-patch: rfc2047-encode newlines in headers, 2011-02-23)?
> 
> What version of git do you use?

No, that doesn't fix it. The problem is a short name and a long email
address. We rfc2047-encode and wrap the name, but then tack the email
onto the end without caring about line length.

According to rfc2047, we are specifically forbidden to use an
encoded-word in an addr-spec. So it would not make sense to assemble the
header first and then feed the whole thing to add_rfc2047.

Fortunately, this is an easy thing to wrap, since we can't actually
break the addr-spec across lines. We can just check if the line is long,
and if so, wrap the whole address to the next line, which is the best we
can do (and presumably nobody has an address portion over 78
characters). That patch looks something like:

diff --git a/pretty.c b/pretty.c
index e1d8a8f..63a7c2f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -287,6 +287,7 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 	if (fmt == CMIT_FMT_EMAIL) {
 		char *name_tail = strchr(line, '<');
 		int display_name_length;
+		int final_line;
 		if (!name_tail)
 			return;
 		while (line < name_tail && isspace(name_tail[-1]))
@@ -294,6 +295,11 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		display_name_length = name_tail - line;
 		strbuf_addstr(sb, "From: ");
 		add_rfc2047(sb, line, display_name_length, encoding);
+		for (final_line = 0; final_line < sb->len; final_line++)
+			if (sb->buf[sb->len - final_line - 1] == '\n')
+				break;
+		if (namelen - display_name_length + final_line > 78)
+			strbuf_addch(sb, '\n');
 		strbuf_add(sb, name_tail, namelen - display_name_length);
 		strbuf_addch(sb, '\n');
 	} else {

Note that it relies on the commit header having a space before the "<",
which forms the continuation whitespace for the header. This is probably
reasonable, but we could double-check if we want to handle malformed
commit headers better.

Or we could just ignore it. AFAICS, this doesn't actually violate
rfc2047, nor rfc5322. The 78-character limit is simply a SHOULD, and
we have up to 998 for MUST. For a single-address header[1], this seems
kind of unlikely to me.

-Peff

[1] For multi-address headers like "format-patch --cc=foo --cc=bar", it
looks like we already break them across lines. No idea if "send-email"
is sensible in this area or not.
