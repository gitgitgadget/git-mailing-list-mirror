From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable git rev-list to parse --quiet
Date: Thu, 17 Jul 2008 22:42:21 -0700
Message-ID: <7v8wvzeojm.fsf@gitster.siamese.dyndns.org>
References: <20080718040459.13073.76896.stgit@marcab.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 07:43:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJikb-0001F2-Ff
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 07:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbYGRFma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 01:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYGRFma
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 01:42:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYGRFma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 01:42:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C0763065B;
	Fri, 18 Jul 2008 01:42:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 82E7C3065A; Fri, 18 Jul 2008 01:42:23 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4E9CA10E-548C-11DD-B6FD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88985>

Nick Andrew <nick@nick-andrew.net> writes:

> Enable git rev-list to parse --quiet
>
> git rev-list never sees the --quiet option because --quiet is
> also an option for diff-files.
>
> Example:
>
> $ ./git rev-list --quiet ^HEAD~2 HEAD
> 1e102bf7c83281944ffd9202a7d35c514e4a5644
> 3bf0dd1f4e75ee1591169b687ce04dff00ae2e3e
> $ echo $?
> 0
>
> The fix scans the argument list to detect --quiet before passing it
> to setup_revisions(). It also arranges to count the number of commits
> or objects (whether sent to STDOUT or not) so --quiet can return an
> appropriate exit code (1 if there were commits/objects, 0 otherwise).
>
> After fix:

Thanks for noticing, but this replaces one breakage with another.

Your new behaviour is a new "tell me if it is an empty set" option, and it
means quite different thing from what --quiet does.

The --quiet option is designed primarily for sanity checking after a
failed fetch by commit walkers.  Here is how it works (well, at least how
it is supposed to work).

Imagine you have this history:

	---o---o---X

and the other side has this history:

	---o---o---X---A---B---C

And you run fetch over a dumb protocol; the commit walker fetches C,
discovers you do not have its parent B and tries to fetch it, and you
somehow kill that process.  Your repository will have:

	---o---o---X           C

Now, we do not mark C with our refs, so we do not say "Ok we have
everything leading up to C" when you re-run the same commit walker.
Instead, we'll let the walker walk again starting from C.  So we will
never in corrupt state.

But you might want to see if your repository has this kind of failure.
For that, you can run rev-list starting from C and X --- it will fail
after it finds out that C's parent is B and tries to read it.  And you
will learn the failure with the exit code from the command.  --quiet was
about squelching the output of "I've seen C", "I've seen X", as the only
thing you care about in that mode of usage is if the history is well
connected which is reported by the exit code.

-- >8 --
Subject: [PATCH] rev-list: honor --quiet option

Nick Andrew noticed that rev-list lets the --quiet option to be parsed by
underlying diff_options parser but did not pick up the result.  This
resulted in --quiet option to become effectively a no-op.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-rev-list.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 8e1720c..507201e 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -589,7 +589,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 	argc = setup_revisions(argc, argv, &revs, NULL);
-
+	quiet = DIFF_OPT_TST(&revs.diffopt, QUIET);
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -621,10 +621,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			read_revisions_from_stdin(&revs);
 			continue;
 		}
-		if (!strcmp(arg, "--quiet")) {
-			quiet = 1;
-			continue;
-		}
 		usage(rev_list_usage);
 
 	}
-- 
1.5.6.3.573.gd2d2
