From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty-format: add append line-feed format specifier
Date: Tue, 9 Sep 2014 17:45:21 -0400
Message-ID: <20140909214520.GA13603@peff.net>
References: <540F426E.6080908@exec64.co.uk>
 <xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com>
 <540F554C.5010301@exec64.co.uk>
 <xmqqegvkk2k3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Harry Jeffery <harry@exec64.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:45:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRTE8-0000Gt-M8
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 23:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbaIIVpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 17:45:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:46190 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751673AbaIIVpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 17:45:24 -0400
Received: (qmail 18105 invoked by uid 102); 9 Sep 2014 21:45:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 16:45:24 -0500
Received: (qmail 10978 invoked by uid 107); 9 Sep 2014 21:45:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 17:45:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2014 17:45:21 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegvkk2k3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256711>

On Tue, Sep 09, 2014 at 12:37:48PM -0700, Junio C Hamano wrote:

> Harry Jeffery <harry@exec64.co.uk> writes:
> 
> > On 09/09/14 20:15, Junio C Hamano wrote:
> >> Is this different from "%n%-d"?
> >>
> >
> > Yes. "%n%-d" will place the newline before the expansion, not after.
> 
> Maybe "%[-+ ]" needs to be rethought, instead of making things worse
> by turning it into "%[-_+ ]", as the next person who comes would
> want to add space after the expansion and would need to find yet
> another letter like you did with '_'.

Yeah, that was my thought on reading the initial patch, too. Why limit
ourselves to newlines and spaces. I'd much rather have full conditional
expansion, like "${foo:+prefix $foo suffix}" in the shell.

Something like the patch below might work, but I didn't test it very
thoroughly (and note the comments, which might need dealing with). Maybe
it would make a sensible base for Harry to build on if he wants to
pursue this.

With it, you can do:

  git log --format='%h %s%if(%d,%n  Decoration:%d)' origin

to get:

  85f0837 Start the post-2.1 cycle
    Decoration: (origin/master, origin/HEAD, github/foo)
  f655651 Merge branch 'rs/strbuf-getcwd'
  51eeaea Merge branch 'ta/pretty-parse-config'
  4740891 Merge branch 'bc/archive-pax-header-mode'
  0e28161 Merge branch 'pr/remotes-in-hashmap'
  44ceb79 Merge branch 'jk/pretty-empty-format'
  56f214e Merge branch 'ta/config-set'
  e8e4ce7 Merge branch 'rs/init-no-duplicate-real-path'
  1d8a6f6 Merge branch 'mm/config-edit-global'
  c518279 Merge branch 'jc/reopen-lock-file'
  96db324 Merge git://github.com/git-l10n/git-po
    Decoration: (origin/maint)

You could also make "%d" more flexible with it. We unconditionally
include the " (...)" wrapper when expanding it. But assuming we
introduced a "%D" that is _just_ the decoration names, you could do:

  %if(%D, (%D))

to get the same effect with much more flexibility.

---
diff --git a/pretty.c b/pretty.c
index fe34ddc..96cd512 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1398,6 +1398,42 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 		ADD_SP_BEFORE_NON_EMPTY
 	} magic = NO_MAGIC;
 
+	if (starts_with(placeholder, "if(")) {
+		const char *cond_beg, *cond_end;
+		const char *data_beg, *data_end;
+		char *buf;
+		struct strbuf scratch = STRBUF_INIT;
+
+		/* can't handle commas in conditions; allow backslash-escaping? */
+		cond_beg = cond_end = placeholder + 3;
+		for (cond_end = cond_beg; *cond_end != ','; cond_end++)
+			if (!*cond_end)
+				return 0;
+
+		/* ditto for nested parentheses; backslash escaping? */
+		data_beg = cond_end + 1;
+		for (data_end = data_beg; *data_end != ')'; data_end++)
+			if (!*data_end)
+				return 0;
+
+		/*
+		 * Should teach formatters to return size only without
+		 * actually writing to scratch buffer?
+		 */
+		buf = xmemdupz(cond_beg, cond_end - cond_beg);
+		strbuf_expand(&scratch, buf, format_commit_item, context);
+		free(buf);
+
+		if (scratch.len) {
+			buf = xmemdupz(data_beg, data_end - data_beg);
+			strbuf_expand(sb, buf, format_commit_item, context);
+			free(buf);
+		}
+		strbuf_release(&scratch);
+
+		return data_end - placeholder + 1;
+	}
+
 	switch (placeholder[0]) {
 	case '-':
 		magic = DEL_LF_BEFORE_EMPTY;
