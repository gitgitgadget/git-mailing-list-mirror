From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Sat, 12 Jan 2013 10:47:20 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130112154719.GA3270@thyrsus.com>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <7v62339du4.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 16:48:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu3JM-0008Np-G8
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 16:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab3ALPre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 10:47:34 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:46719
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3ALPrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 10:47:33 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 36B294065F; Sat, 12 Jan 2013 10:47:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v62339du4.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213289>

Junio C Hamano <gitster@pobox.com>:
> And here is what I got:

Hm. In my version of these tests, I only have one regression from the
old combo (in the pathological tags test, t9602).  You're seeing more
breakage than that, obviously.

> A funny thing was that without cvsps-3.7 on $PATH (which means I am
> getting distro packaged cvsps 2.1), I got identical errors.

That suggests that something in your test setup has gone bad and is
introducing spurious errors. Which would be consistent with the above.

>                                                     Looking
> at the log message, it seems that you meant to remove t960[123], so
> perhaps the patch simply forgot to remove 9601 and 9602?

Yes.
 
> As neither test runs "git cvsimport" with -o/-m/-M options, ideally
> we should be able to pass them with and without having cvsps-3.x.
> Not passing them without cvsps-3.x would mean that the fallback mode
> of rewritten cvsimport is not working as expected. Not passing them
> with cvsps-3.x may mean the tests were expecting a wrong conversion
> result, or they uncover bugs in the replacement cvsimport.

That's possible, but seems unlikely.  Because the new cvsimport is
such a thin wrapper around the conversion engine, bugs in it should
lead to obvious crashes or failure to run the engine rather than the 
sort of conversion error the t960* tests are designed to check.  Really
all it does is assemble options to pass to the conversion engines.

My test strategy is aimed at the engine, not the wrapper. I took the
repos from t960*  and wrote a small Python framework to check the same 
assertions as the git-tree tests do, but using the engine.  For example,
here's how my t9602 looks:

import os, cvspstest

cc = cvspstest.ConvertComparison("t9602", "module")
cc.cmp_branch_tree("test of branch", "master", True)
cc.cmp_branch_tree("test of branch", "vendorbranch", True)
cc.cmp_branch_tree("test of branch", "B_FROM_INITIALS", False)
cc.cmp_branch_tree("test of branch", "B_FROM_INITIALS_BUT_ONE", False)
cc.cmp_branch_tree("test of branch", "B_MIXED", False)
cc.cmp_branch_tree("test of branch", "B_SPLIT", True)
cc.cmp_branch_tree("test of tag", "vendortag", False)
# This is the only test new cvsps fails that old git-cvsimport passed.
cc.cmp_branch_tree("test of tag", "T_ALL_INITIAL_FILES", True)
cc.cmp_branch_tree("test of tag", "T_ALL_INITIAL_FILES_BUT_ONE", False)
cc.cmp_branch_tree("test of tag", "T_MIXED", False)
cc.cleanup()
 
> t9600 fails with "-a is no longer supported", even without having
> cvsps-3.x on the $PATH (i.e. attempting to use the fallback).  I
> wonder if this is an option the updated cvsimport would want to
> simply ignore?

Probably.  But I don't think you should keep these tests in the git tree.
That wasn't a great idea even when you were supporting just one engine;
with two (and soon three) it's going to be just silly.  Let sanity-checking
the engines be *my* problem, since I have to do it anyway.

(I'm working towards the generalized test suite as fast as I can.  First
results probably in four days or so.)

> It is a way to tell the old cvsps/cvsimport to disable its
> heuristics to ignore commits made within the last 10 minutes (this
> is done in the hope of waiting for the per-file nature of CVS
> commits to stabilize, IIUC); the user tells the command that he
> knows that the CVS repository is now quiescent and it is safe to
> import the whole thing.

Yes, that's just what -a is supposed to do.  But is should be
irrelevant for testing - in the test framework CVS is running locally, 
so there's no network lag.

> So... does this mean that we now set the minimum required version of
> Python to 2.7?  I dunno.

That would be bad, IMO.  I'll put backporting to 2.6 high on my to-do list.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
