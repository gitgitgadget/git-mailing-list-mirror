From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
	example
Date: Sun, 29 Jul 2007 08:19:48 -0400
Message-ID: <20070729121948.GA21983@coredump.intra.peff.net>
References: <20070729002427.GA1566@coredump.intra.peff.net> <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org> <20070729041159.GA5544@coredump.intra.peff.net> <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org> <7vbqdvolww.fsf@assigned-by-dhcp.cox.net> <7vwswjmu08.fsf@assigned-by-dhcp.cox.net> <20070729094955.GA14915@coredump.intra.peff.net> <Pine.LNX.4.64.0707291214060.14781@racer.site> <20070729113850.GA17796@coredump.intra.peff.net> <Pine.LNX.4.64.0707291258410.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 14:20:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF7kx-0004mi-39
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 14:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762648AbXG2MTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 08:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762650AbXG2MTv
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 08:19:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1273 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760073AbXG2MTu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 08:19:50 -0400
Received: (qmail 27908 invoked from network); 29 Jul 2007 12:19:51 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 Jul 2007 12:19:51 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2007 08:19:48 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707291258410.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54111>

On Sun, Jul 29, 2007 at 01:04:13PM +0100, Johannes Schindelin wrote:

> The idea is this: when "--quiet" was given, we do not output anything, and 
> therefore do not have to recurse into the directories, because we already 
> know that there are differences when a _tree_ is different.  I do not 
> remember all details of the "--quiet" implementation, but I think that it
> 
> - exits early (as you said)
> 
> - does not turn on "recursive" to avoid unnecessary work.

OK, looking through the code, this works _sometimes_. If I say "git-diff
--quiet" then it will not recurse. If I say "git-diff -p --quiet" then
it will (even though we never show the -p output).

Since --quiet supersedes all output formats, I think it probably should
just clear the recursive option entirely. In which case rather than
special-casing quiet to avoid recursion in git-diff, we can simply turn
on recursion before parsing options (and it will get turned off
correctly by any diff options that need to do so).

Something like:

diff --git a/builtin-diff.c b/builtin-diff.c
index 7f367b6..e6d10bd 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -229,6 +229,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+		rev.diffopt.recursive = 1;
 		if (diff_setup_done(&rev.diffopt) < 0)
 			die("diff_setup_done failed");
 	}
diff --git a/diff.c b/diff.c
index a5fc56b..aeae1a3 100644
--- a/diff.c
+++ b/diff.c
@@ -2182,6 +2182,7 @@ int diff_setup_done(struct diff_options *options)
 	if (options->quiet) {
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
 		options->exit_with_status = 1;
+		options->recursive = 0;
 	}
 
 	/*

But maybe that doesn't work because some of the options need recursion
turned on, even if --quiet is specified. I have to admit, there are a
lot of code paths here and I'm not sure how all of them interact with
the recursive option. So perhaps it is better to just special case
options->quiet as you suggested.

-Peff
