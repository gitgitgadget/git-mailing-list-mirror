From: Jeff King <peff@peff.net>
Subject: Re: Problem with "dashless options"
Date: Wed, 9 Sep 2009 10:34:55 -0400
Message-ID: <20090909143455.GA10092@sigill.intra.peff.net>
References: <D69FA890-4249-4DC9-B8AE-C9F105F1AD3B@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Henrik Tidefelt <tidefelt@isy.liu.se>
X-From: git-owner@vger.kernel.org Wed Sep 09 16:35:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlOGE-0001e8-12
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 16:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbZIIOez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 10:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbZIIOey
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 10:34:54 -0400
Received: from peff.net ([208.65.91.99]:37447 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbZIIOey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 10:34:54 -0400
Received: (qmail 28613 invoked by uid 107); 9 Sep 2009 14:35:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 09 Sep 2009 10:35:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 10:34:55 -0400
Content-Disposition: inline
In-Reply-To: <D69FA890-4249-4DC9-B8AE-C9F105F1AD3B@isy.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128067>

On Wed, Sep 09, 2009 at 03:21:30PM +0200, Henrik Tidefelt wrote:

> Yesterday I installed a fresh git (1.6.4.2) on my system using
> MacPorts.  Some of the git sub-commands work fine (for instance,
> checkout, status, remote), while push gives an error as follows:
> 
> $ git push isy next
> fatal: BUG: dashless options don't support arguments

Hmm. Very strange. The only code path that triggers this is an option
declared with PARSE_OPT_NODASH but not PARSE_OPT_NOARG. But there are
only two options in all of git that use PARSE_OPT_NODASH, and:

  1. They are in git grep, not git push.

  2. They correctly have PARSE_OPT_NOARG set.

Which leads me to believe that something is writing random cruft on top
of the options struct. Either a stack overflow, or some issue related to
your compiler (either a bug in the compiler, or something non-portable
we are doing).

Can you try applying the patch below which will at least give us a bit
more information about the offending option?

Also, does 1.6.4.1 work OK? Or any other earlier version? If so, can you
try bisecting?

diff --git a/parse-options.c b/parse-options.c
index f7ce523..e93eb67 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -275,7 +275,15 @@ static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
 			continue;
 		if ((options->flags & PARSE_OPT_OPTARG) ||
 		    !(options->flags & PARSE_OPT_NOARG))
-			die("BUG: dashless options don't support arguments");
+			die("BUG: dashless options don't support arguments\n"
+			    "buggy option is:\n"
+			    " type: %d\n"
+			    " short_name: %c\n"
+			    " long_name: %s\n"
+			    " flags: %d\n",
+			    options->type, options->short_name,
+			    options->long_name, options->flags
+			);
 		if (!(options->flags & PARSE_OPT_NONEG))
 			die("BUG: dashless options don't support negation");
 		if (options->long_name)
