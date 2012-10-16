From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] status: add --long for default format
Date: Tue, 16 Oct 2012 13:22:04 -0400
Message-ID: <20121016172204.GB27243@sigill.intra.peff.net>
References: <1350404569-9787-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAqR-0001IJ-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180Ab2JPRWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:22:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55119 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161Ab2JPRWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 13:22:08 -0400
Received: (qmail 17562 invoked by uid 107); 16 Oct 2012 17:22:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 13:22:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 13:22:04 -0400
Content-Disposition: inline
In-Reply-To: <1350404569-9787-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207853>

On Tue, Oct 16, 2012 at 11:22:49PM +0700, Nguyen Thai Ngoc Duy wrote:

> This could be useful when the user sets an alias to "status --short"
> and wants to get back the default format temporarily.

Makes sense, but...

> diff --git a/builtin/commit.c b/builtin/commit.c
> index a17a5df..5adab33 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1159,6 +1159,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  		OPT_SET_INT(0, "porcelain", &status_format,
>  			    N_("machine-readable output"),
>  			    STATUS_FORMAT_PORCELAIN),
> +		OPT_SET_INT(0, "long", &status_format,
> +			    N_("show status in long format (default)"), STATUS_FORMAT_LONG),
>  		OPT_BOOLEAN('z', "null", &s.null_termination,
>  			    N_("terminate entries with NUL")),
>  		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,

I'm pretty sure we use STATUS_FORMAT_LONG elsewhere as a synonym for
"the user has not set anything".

Ah, here it is:

  $ git grep -nA1 '== STATUS_FORMAT_LONG'
  1073:   if (s->null_termination && status_format == STATUS_FORMAT_LONG)
  1074-           status_format = STATUS_FORMAT_PORCELAIN;
  --
  1201:   if (s.null_termination && status_format == STATUS_FORMAT_LONG)
  1202-           status_format = STATUS_FORMAT_PORCELAIN;

I think you would want something like this. I had originally intended to
make it a refactoring patch that would come before yours, but some of
the cleanups are tied to actually adding --long. So I think you would
want to squash it together with your patch and combine the commit
messages.

-- >8 --
Subject: [PATCH] status: refactor output format to represent "default"

When deciding which output format to use, we default an
internal enum to STATUS_FORMAT_LONG and modify it if
"--porcelain" or "--short" is given. If this enum is set to
LONG, then we know the user has not specified any format,
and we can kick in default behaviors. This works because
there is no "--long" which they could use to explicitly
specify LONG.

Let's expand the enum to have an explicit STATUS_FORMAT_NONE,
in preparation for adding "--long". Then we can distinguish
between LONG and NONE when setting other defaults. There are
two such cases:

  1. The user has asked for NUL termination. With NONE, we
     currently default to turning on the porcelain mode.
     With an explicit --long, we would in theory use NUL
     termination with the long mode, but it does not support
     it. So we can just complain and die.

  2. When an output format is given to "git commit", we
     default to "--dry-run". This behavior would now kick in
     when "--long" is given, too.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 00ac35b..ec299f4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -112,10 +112,11 @@ static enum {
 static struct strbuf message = STRBUF_INIT;
 
 static enum {
+	STATUS_FORMAT_NONE = 0,
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN
-} status_format = STATUS_FORMAT_LONG;
+} status_format;
 
 static int mention_abandoned_message;
 static void maybe_mention_abandoned_message(void)
@@ -464,6 +465,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s);
 		break;
+	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
 		break;
@@ -1070,9 +1072,13 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (all && argc > 0)
 		die(_("Paths with -a does not make sense."));
 
-	if (s->null_termination && status_format == STATUS_FORMAT_LONG)
-		status_format = STATUS_FORMAT_PORCELAIN;
-	if (status_format != STATUS_FORMAT_LONG)
+	if (s->null_termination) {
+		if (status_format == STATUS_FORMAT_NONE)
+			status_format = STATUS_FORMAT_PORCELAIN;
+		else if (status_format == STATUS_FORMAT_LONG)
+			die("--long and -z are incompatible");
+	}
+	if (status_format != STATUS_FORMAT_NONE)
 		dry_run = 1;
 
 	return argc;
@@ -1198,8 +1204,12 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			     builtin_status_usage, 0);
 	finalize_colopts(&s.colopts, -1);
 
-	if (s.null_termination && status_format == STATUS_FORMAT_LONG)
-		status_format = STATUS_FORMAT_PORCELAIN;
+	if (s.null_termination) {
+		if (status_format == STATUS_FORMAT_NONE)
+			status_format = STATUS_FORMAT_PORCELAIN;
+		else if (status_format == STATUS_FORMAT_LONG)
+			die("--long and -z are incompatible");
+	}
 
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
@@ -1228,6 +1238,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s);
 		break;
+	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
 		s.ignore_submodule_arg = ignore_submodule_arg;
-- 
1.8.0.rc2.5.gecca26e
