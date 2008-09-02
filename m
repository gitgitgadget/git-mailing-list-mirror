From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Support diff.autorefreshindex=true in `git-diff --quiet'
Date: Mon, 01 Sep 2008 23:20:26 -0700
Message-ID: <7vy72bnk5x.fsf_-_@gitster.siamese.dyndns.org>
References: <quack.20080901T0129.lth8wuci80o@roar.cs.berkeley.edu>
 <7vskskw41j.fsf@gitster.siamese.dyndns.org>
 <quack.20080901T0350.lthzlmsgmx6@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Tue Sep 02 08:21:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaPGl-0000Q9-5g
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 08:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbYIBGUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 02:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbYIBGUe
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 02:20:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYIBGUd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 02:20:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F0F76591CE;
	Tue,  2 Sep 2008 02:20:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F207B591CB; Tue,  2 Sep 2008 02:20:28 -0400 (EDT)
In-Reply-To: <quack.20080901T0350.lthzlmsgmx6@roar.cs.berkeley.edu> (Karl
 Chen's message of "Mon, 01 Sep 2008 03:50:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3ED8F8CC-78B7-11DD-8230-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94651>

Karl Chen <quarl@cs.berkeley.edu> writes:

>>>>>> On 2008-09-01 03:31 PDT, Junio C Hamano writes:
>
>     Junio> My knee-jerk reaction is that I do not particularly
>     Junio> like this, but I haven't thought things through.  What
>     Junio> does --exit-code do with or without the configuration
>     Junio> variable?
>
> git diff --exit-code silently refreshes the index and returns 0,
> as documented and as I expect.  So I further expect "git diff
> --exit-code --quiet" to be have the same semantics as "git diff
> --exit-code >/dev/null".
>
> What don't you like about this?  Isn't this the point of
> diff.autorefreshindex ?

The point of autorefreshindex was actually to reduce newbie confusion, and
the change to make it the default turned out to be a good thing for the
Porcelain layer.

I however do not think we are hurting anybody with the change to make it
ignore stat dirtiness; see the proposed commit log message in the attached
patch for details of the reasoning behind this statement.

I have to still wonder about your implementation, though.

Why do you have "apply-filter" and only that one in effect?

Since you are skipping break/rename, "diff --quiet -M --diff-filter=D"
will not do what the user intended to do (which is to pair up the renamed
paths and see if there is anything truly deleted, among many paths that
disappeared merely because they are renamed away).

Looking at your patch and thinking about the issue very much tempt me to
suggest the attached patch which is at the other extreme of the spectrum.

-- >8 --
diff --quiet: make it synonym to --exit-code >/dev/null

The point of --quiet was to return the status as early as possible without
doing any extra processing.  Well behaved scripts, when they expect to run
many diff operations inside, are supposed to run "update-index --refresh"
upfront; we do not want them to pay the price of iterating over the index
and comparing the contents to fix the stat dirtiness, and we avoided most
of the processing in diffcore_std() when --quiet is in effect.

But scripts that adhere to the good practice won't have to pay any more
price than the necessary lstat(2) that will report stat cleanliness.

More importantly, users who do ask for "--quiet -M --filter=D" (in order
to notice only the deletion, not paths that disappeared only because they
have been renamed away) deserve to get the result they asked for, even it
means they have to pay the extra price; the alternative is to get a cheap
early return that gives a result they did not ask for, which is much
worse.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I also suspect that the check for FIND_COPIES_HARDER to decide if we
   call skip-stat-unmatch is an incorrect optimization, but that is a
   separate topic.  In short, these two gives different results:

    $ >foo
    $ git add foo
    $ touch foo
    $ git diff -C -C
    $ git diff -C

 diff.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git c/diff.c w/diff.c
index 7b4300a..5014a72 100644
--- c/diff.c
+++ w/diff.c
@@ -2392,13 +2392,6 @@ int diff_setup_done(struct diff_options *options)
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
 
-	/*
-	 * If we postprocess in diffcore, we cannot simply return
-	 * upon the first hit.  We need to run diff as usual.
-	 */
-	if (options->pickaxe || options->filter)
-		DIFF_OPT_CLR(options, QUIET);
-
 	return 0;
 }
 
@@ -3388,9 +3381,6 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 
 void diffcore_std(struct diff_options *options)
 {
-	if (DIFF_OPT_TST(options, QUIET))
-		return;
-
 	if (options->skip_stat_unmatch && !DIFF_OPT_TST(options, FIND_COPIES_HARDER))
 		diffcore_skip_stat_unmatch(options);
 	if (options->break_opt != -1)
