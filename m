From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory
 configuration
Date: Thu, 18 Jun 2015 15:57:51 -0400
Message-ID: <20150618195751.GA14550@peff.net>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
 <xmqq616ley7y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 21:58:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5fwu-0001Um-Tq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 21:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbbFRT6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 15:58:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:48315 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755940AbbFRT5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 15:57:55 -0400
Received: (qmail 23798 invoked by uid 102); 18 Jun 2015 19:57:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 14:57:54 -0500
Received: (qmail 6876 invoked by uid 107); 18 Jun 2015 19:57:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 15:57:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jun 2015 15:57:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqq616ley7y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272038>

On Thu, Jun 18, 2015 at 10:13:37AM -0700, Junio C Hamano wrote:

> > -static const char *set_outdir(const char *prefix, const char *output_directory)
> > +static const char *set_outdir(const char *prefix, const char *output_directory,
> > +			      const char *config_output_directory)
> 
> This change looks ugly and unnecessary.  All the machinery after and
> including the point set_outdir() is called, including reopen_stdout(),
> work on output_directory variable and only that variable.
> 
> Wouldn't it work equally well to have
> 
> 	if (!output_directory)
>         	output_directory = config_output_directory;
> 
> before a call to set_outdir() is made but after the configuration is
> read (namely, soon after parse_options() returns), without making
> any change to this function?

Don't we load the config before parsing options here? In that case, we
can use our usual strategy to just set output_directory (which is
already a static global) from the config callback, and everything Just
Works.

We do have to bump the definition of output_directory up above the
config callback, like so (while we are here, we might also want to
drop the unnecessary static initializers, which violate our style guide):

diff --git a/builtin/log.c b/builtin/log.c
index e67671e..77c06f7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -37,6 +37,10 @@ static int use_mailmap_config;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
+static FILE *realstdout = NULL;
+static const char *output_directory = NULL;
+static int outdir_offset;
+
 static const char * const builtin_log_usage[] = {
 	N_("git log [<options>] [<revision-range>] [[--] <path>...]"),
 	N_("git show [<options>] <object>..."),
@@ -752,14 +756,12 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.outputdirectory"))
+		return git_config_string(&output_directory, var, value);
 
 	return git_log_config(var, value, cb);
 }
 
-static FILE *realstdout = NULL;
-static const char *output_directory = NULL;
-static int outdir_offset;
-
 static int reopen_stdout(struct commit *commit, const char *subject,
 			 struct rev_info *rev, int quiet)
 {
