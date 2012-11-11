From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] diff: introduce diff.submodule configuration variable
Date: Sun, 11 Nov 2012 10:09:22 -0500
Message-ID: <20121111150922.GA10140@sigill.intra.peff.net>
References: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
 <1351766630-4837-3-git-send-email-artagnon@gmail.com>
 <20121108205110.GB8376@sigill.intra.peff.net>
 <CALkWK0=zTCXki2c=ugRXE485ps2=OWag7mdzVJW93cnsypwkiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 16:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXZAL-0001tJ-TW
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 16:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab2KKPJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 10:09:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43866 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577Ab2KKPJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 10:09:27 -0500
Received: (qmail 32437 invoked by uid 107); 11 Nov 2012 15:10:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 10:10:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 10:09:22 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0=zTCXki2c=ugRXE485ps2=OWag7mdzVJW93cnsypwkiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209392>

On Sun, Nov 11, 2012 at 08:20:27PM +0530, Ramkumar Ramachandra wrote:

> >> diff --git a/builtin/diff.c b/builtin/diff.c
> >> index 9650be2..6d00311 100644
> >> --- a/builtin/diff.c
> >> +++ b/builtin/diff.c
> >> @@ -297,6 +297,10 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
> >>       DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
> >>       DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
> >>
> >> +     /* Set SUBMODULE_LOG if diff.submodule config var was set */
> >> +     if (submodule_format_cfg && !strcmp(submodule_format_cfg, "log"))
> >> +             DIFF_OPT_SET(&rev.diffopt, SUBMODULE_LOG);
> >> +
> >
> > Yuck. Why is this parsing happening in cmd_diff?
> 
> Blame Jens- see this thread |
> http://thread.gmane.org/gmane.comp.version-control.git/206816/focus=206815

I don't think that is the right path, as at means that the option can
only ever affect diff, not other porcelains. I was thinking something
more like this (completely untested):

diff --git a/diff.c b/diff.c
index e89a201..74f4fc6 100644
--- a/diff.c
+++ b/diff.c
@@ -37,6 +37,13 @@ static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 
+/*
+ * 0 for "short", 1 for "log". This should probably just be an enum, and
+ * SUBMODULE_LOG lifted up from being a bit in the options to being its own
+ * struct member.
+ */
+static int diff_submodule_default;
+
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_NORMAL,	/* PLAIN */
@@ -178,6 +185,19 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.ignoresubmodules"))
 		handle_ignore_submodules_arg(&default_diff_options, value);
 
+	if (!strcmp(var, "diff.submodule")) {
+		/* XXX this should be factored out from the command-line parser */
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(var, "short"))
+			diff_submodule_default = 0;
+		else if (!strcmp(var, "log"))
+			diff_submodule_default = 1;
+		else
+			return error("unknown %s value: %s", var, value);
+		return 0;
+	}
+
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
@@ -3193,6 +3213,9 @@ void diff_setup(struct diff_options *options)
 		options->a_prefix = "a/";
 		options->b_prefix = "b/";
 	}
+
+	if (diff_submodule_default)
+		DIFF_OPT_SET(options, SUBMODULE_LOG);
 }
 
 void diff_setup_done(struct diff_options *options)
