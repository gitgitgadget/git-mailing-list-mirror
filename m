From: Jeff King <peff@peff.net>
Subject: Re: git diff flags
Date: Sat, 8 May 2010 00:24:26 -0400
Message-ID: <20100508042426.GB14998@coredump.intra.peff.net>
References: <19428.27908.870639.422432@winooski.ccs.neu.edu>
 <20100508040602.GA14998@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sat May 08 06:25:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAbbB-0004rJ-EP
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 06:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842Ab0EHEYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 00:24:30 -0400
Received: from peff.net ([208.65.91.99]:51025 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753Ab0EHEYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 00:24:30 -0400
Received: (qmail 2557 invoked by uid 107); 8 May 2010 04:24:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 May 2010 00:24:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 May 2010 00:24:26 -0400
Content-Disposition: inline
In-Reply-To: <20100508040602.GA14998@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146634>

On Sat, May 08, 2010 at 12:06:02AM -0400, Jeff King wrote:

> >   git diff --follow
> >   --> works but there's no mention of this in the man page, and it
> >       doesn't look like it's doing anything
> 
> --follow is a "diff option" even though it is about revision
> traversal. This is an artifact of the implementation, where
> rename-following happens at a low level where we have only diff_options.
> It should be possible to fix, though (parse the option at the revision
> layer, but have it set the diff_options flag).

Actually, that doesn't help. "git diff" actually uses setup_revisions,
so many revision traversal options are parsed and ignored. E.g.:

  $ git diff --pretty=short

will happily run and do nothing with the --pretty=short bit, as we are
not actually showing commits.

> >   git diff -CM
> >   --> doesn't say anything (but it does exit with an error code)
> 
> The revision and diff parsers do not use parse_options, and thus don't
> understand things like bundling. Even if they did, -C takes an optional
> argument. In this case, the argument format is bogus, so it aborts, but
> for some reason there is no error message (it is the same with -B, -M,
> and -C).
> 
> >   git diff -CM --I-can-write-anything here!
> >   --> does the same
> 
> Because we barfed at -CM already. It only looks funny because we didn't
> bother to print a message.
> 
> Patches welcome.

Actually, this patch is really quite trivial. Here it is.

-- >8 --
Subject: [PATCH] diff: report bogus input to -C/-M/-B

We already detect invalid input to these functions, but we
simply exit with an error code, never saying anything as
simple as "your input was wrong". Let's fix that.

Before:

  $ git diff -CM
  $ echo $?
  128

After:

  $ git diff -CM
  error: invalid argument to -C: M
  $ echo $?
  128

There should be no problems with having diff_opt_parse print
to stderr, as there is already precedent in complaining
about bogus --color and --output arguments.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, --output seems to call die(). We could do that, too, and it
would give us the slightly nicer:

  fatal: invalid argument to -C: M

Though I guess that is slightly less libified, setup_revisions just
exits anyway.

 diff.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e40c127..0c955be 100644
--- a/diff.c
+++ b/diff.c
@@ -2783,18 +2783,18 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	/* renames options */
 	else if (!prefixcmp(arg, "-B")) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
-			return -1;
+			return error("invalid argument to -B: %s", arg+2);
 	}
 	else if (!prefixcmp(arg, "-M")) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return -1;
+			return error("invalid argument to -M: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
 	else if (!prefixcmp(arg, "-C")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return -1;
+			return error("invalid argument to -C: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_COPY;
 	}
 	else if (!strcmp(arg, "--no-renames"))
-- 
1.7.1.176.gcff095.dirty
