From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Thu, 9 Dec 2010 12:27:08 -0500
Message-ID: <20101209172708.GA1817@sigill.intra.peff.net>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
 <20101205073938.GB15233@sigill.intra.peff.net>
 <7v8w04vvvr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aleksi Aalto <aga@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 18:27:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQkH3-0004nl-RH
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 18:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab0LIR1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 12:27:13 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35031 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603Ab0LIR1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 12:27:11 -0500
Received: (qmail 8876 invoked by uid 111); 9 Dec 2010 17:27:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Dec 2010 17:27:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Dec 2010 12:27:08 -0500
Content-Disposition: inline
In-Reply-To: <7v8w04vvvr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163296>

On Sun, Dec 05, 2010 at 11:54:00AM -0800, Junio C Hamano wrote:

> >> * aa/status-hilite-branch (2010-11-18) 1 commit
> >>  - status: show branchname with a configurable color
> [...]
> > I am not particularly interested, either, but FWIW, the gitcommit syntax
> > highlighting that ships with vim does highlight this, so there are at
> > least other people who think this is a good idea.
> 
> As you already know, when I say "'Meh' personally", I am not saying "I
> want to forbid others to want it".
> 
> How does vim highlight the other parts of that particular line?  Does it
> keep them intact, or paint them in some other color?

It colors everything marked with a "#" as blue (which is also how I have
my color.status.header configured).

> > However, I'm not sure about the default. The original patch defaulted to
> > magenta. Your fixup defaults to "plain", but that is a regression
> > (albeit a minor one) for people who have status.header set.
> 
> This patch is a regression for them either way, isn't it?  Except for
> those who chose to use magenta to paint status.header, that is.

Yes, I should have been more clear. _Both_ cases can be a regression,
depending on the user's config; the only way to avoid a regression is to
default to "same as color.status.header".

> I had this suspicion that the class of people who choose a non default
> status.header color and the class of people who choose plain there (or
> have been happy with the default) expect different things.  The former
> prefer louder output, different pieces of information painted in different
> colors to help them chromatically distinguish them.  The latter (including
> myself) favor subdued output, without too many colors distacting them
> while reading the output.
> 
> This suspicion further led me to think that the former would want this new
> feature to paint the branch name in a color different from status.header
> color, while the latter would want it in plain.  So the default of "plain"
> would be a win for both audiences.

I see your reasoning, but as someone in the "former" group of your
description, I consider the default of "plain" worse than not
highlighting it at all. Mostly because the _rest_ of my terminal output
tends to be plain, so rather than appearing highlighted, the branch name
appears to be connected to that output. It's hard to describe in words
how ugly it is, but try:

  mkdir foo && cd foo && git init
  git config color.status.header blue
  git status

Maybe we should put this on top?

-- >8 --
Subject: [PATCH] default color.status.branch to "same as header"

This gives it the same behavior as we had prior to 1d28232
(status: show branchname with a configurable color).

To do this we need the concept of a "NIL" color, which is
provided by color.[ch]. The implementation is very simple;
in particular, there are no precautions taken against code
accidentally printing the NIL. This should be fine in
practice because:

  1. You can't input a NIL color in the config, so it must
     come from the in-code defaults. Which means it is up
     the client code to handle the NILs it defines.

  2. If we do ever print a NIL, it will be obvious what the
     problem is, and the bug can be fixed.

Signed-off-by: Jeff King <peff@peff.net>
---
I resisted the urge to make a generic "same as $X" token, which would
allow users to do something like:

  [color "status"]
    branch = from:color.status.header

if they really wanted. But that would be a lot more code, and I'm not
sure it would be all that useful (it would be if people did stuff like
theming git colors like they do window managers, but I don't think we
are at quite that level).

This is simple, solves the current regression, and provides an easy
blueprint for handling the case in the future.

 color.c     |    5 +++++
 color.h     |    5 +++++
 wt-status.c |    7 +++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/color.c b/color.c
index 1b00554..6a5a54e 100644
--- a/color.c
+++ b/color.c
@@ -211,3 +211,8 @@ int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...)
 	va_end(args);
 	return r;
 }
+
+int color_is_nil(const char *c)
+{
+	return !strcmp(c, "NIL");
+}
diff --git a/color.h b/color.h
index 03ca064..170ff40 100644
--- a/color.h
+++ b/color.h
@@ -43,6 +43,9 @@
 #define GIT_COLOR_BG_MAGENTA	"\033[45m"
 #define GIT_COLOR_BG_CYAN	"\033[46m"
 
+/* A special value meaning "no color selected" */
+#define GIT_COLOR_NIL "NIL"
+
 /*
  * This variable stores the value of color.ui
  */
@@ -62,4 +65,6 @@ int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
 
+int color_is_nil(const char *color);
+
 #endif /* COLOR_H */
diff --git a/wt-status.c b/wt-status.c
index e62388c..123582b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -21,12 +21,15 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,    /* WT_STATUS_UNMERGED */
 	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
 	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
-	GIT_COLOR_NORMAL, /* WT_STATUS_ONBRANCH */
+	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
 };
 
 static const char *color(int slot, struct wt_status *s)
 {
-	return s->use_color > 0 ? s->color_palette[slot] : "";
+	const char *c = s->use_color > 0 ? s->color_palette[slot] : "";
+	if (slot == WT_STATUS_ONBRANCH && color_is_nil(c))
+		c = s->color_palette[WT_STATUS_HEADER];
+	return c;
 }
 
 void wt_status_prepare(struct wt_status *s)
-- 
1.7.3.3.713.gb2a8.dirty
