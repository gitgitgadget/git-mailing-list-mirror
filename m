From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC 2011] Git Sequencer
Date: Sun, 3 Apr 2011 22:50:56 +0530
Message-ID: <20110403172054.GA10220@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 19:22:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6R0L-0000pN-OF
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 19:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009Ab1DCRWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 13:22:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47437 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab1DCRWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 13:22:03 -0400
Received: by iwn34 with SMTP id 34so5072586iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=hZQ5m10lnx/P2clK/da4enCadXXSqj+Gr1sBqhm3P8A=;
        b=R7d9l/dQ9kW1vF4GhqKljv/LyNGXrMDjw3x65loKorBpvVKFEETE01cORoC5tUE/ql
         5G5Y+a71H3XAWtXzRqKdEf4EnzkBD1VmuRj8tnDFNzzsLlXdQSip28KbgGu1iNSo6bUs
         qNhJnVto5+hTHO0xhGyl7874aosv/ZkoZB6Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=MDik38BlfMxBXE3kcr9baGsZlrZwBMth5I1WcRxVLp0l1MigGkWc58qrk9jd1+odjJ
         eAahKospz5AAjWhmdypbHw/CBn7CXXjFGFz6QNUWQpEwE1F24SEwrRPeCPS4ySe/UCK7
         TnPYRjhCht9y4DBEALpOAGVpUq3oUqxBJzVVw=
Received: by 10.42.150.132 with SMTP id a4mr1234609icw.199.1301851322633;
        Sun, 03 Apr 2011 10:22:02 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i26sm3103764iby.24.2011.04.03.10.21.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 10:22:01 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170758>

Hi,

I'd like to re-apply this year as a student because I really want to
see (among other things), a sequencer in git.git.  Also, since I
worked on areas related to fast-import and remote helpers last year, I
thought I should work on something completely orthogonal this year.

I now have a draft of my proposal ready, and I'd really appreciate
feedback.  Also, could someone mentor me?

======================================================================
Project Proposal: Git Sequencer
Student: Ramkumar Ramachandra
Mentor: ?

== The Objective ==

To write git-sequencer, a new builtin command, and implement existing
commands on top of that.  This should give the commands more
functionality, improve their error handling, and make them faster.
The project can only be considered successful if all (or most) of the
code written gets merged into upstream.

The Git Sequencer was a 2008 GSoC project as well; unfortunately most
of the code did not get merged into git.git.  The learning from all
that work should serve as a huge headstart this year.

=== The Plan ===

1. Extend 'cherry-pick' with '--continue', '--abort', and '--skip'
features, so that it works like (a subset of) the current
'git-rebase--interactive.sh'.  This will require patching
'builtin/revert.c' in place, and merging it immediately.  I plan to
roughly follow the road laid out by Christian's 2010 series [1].

1.1. Factor out all calls to 'die' with 'return error' so so that we
can pause the entire process when a commit doesn't apply
automatically.

1.2. Create and populate TODO and DONE files, similar to the one that
'git-rebase--interactive.sh' creates.  For now, it should simply give
us information about why a 'cherry-pick' failed.  Use these files with
'git-rebase--interactive.sh' to resume.

1.3. Port selective tests from the current 't3404' to make sure that
TODO and DONE are populated correctly; "stop on conflicting pick" is a
good candidate.

1.4. Decouple the 'revert' functionality from the 'cherry-pick'
functionality in 'revert.c'.  Implement '--abort' for 'cherry-pick'
and port "abort" test from 't3404'.

1.5. Implement parsing the TODO and DONE files into suitable data
structures.  Derive inspiration from the code written in 2008 to do
this.

1.6. Implement '--continue' and '--skip', and write suitable tests.
Merge into upstream.

2. Factor out the 'cherry-pick' code from 'revert.c' into a new
'builtin/sequencer.c', and expose a simple cherry-picking API in
'sequencer.h'.

3. Implement a fresh 'cherry-pick.c' as a simple API call to the
sequencer, and make sure that all the existing tests pass.  After
this, cherry-pick will not be a builtin command anymore*.  Merge into
upstream.

4. Extend the sequncer to parse commands like 'execute', 'reword',
'squash', and 'fixup' that are specific to interactive rebasing.
Carefully implement the functionality for each of these keywords in a
step-wise manner, making sure that it inter-operates with 'rebase -i'
seamlessly.

5. Port the entire testsuite from 'rebase -i', and rewrite
'git-rebase.sh', 'git-rebase--interactive.sh' to call the sequncer.
The script should essentially build to a list of TODO instructions and
pass it to the 'git-sequencer' binary.  Merge into upstream.

6. [Optional] Lib'ify the sequncer: modify the sequencer API to
include rebase-related functionality.  Write 'rebase.c' as a bunch of
API calls to the sequencer.  Make sure that the existing tests pass.
Merge into upstream.

7. [Optional] Re-implement 'git-am.sh' as a thin wrapper over the
sequncer: 'am.c'.  Bulk of this should be mbox parsing code.  Make sure
that all existing tests pass.  Merge into upstream.

* Is this a good change? Are there any forseeable issues?
** [Optional] should be read as "If time permits"

== Timeline ===

Deriving from last year's experience, I've decided not to present a
tight timeline.  Instead, I simply have an outline: Get the extended
cherry-pick functionality merged before mid-term evaluations, and the
rest before the final evaluations.

== Who am I? ==

I'm Ramkumar Ramachandra, and I first started contributing to git.git
in January 2010.  Apart from doing fast-import and remote helper
related work last year, I also authored and merged svnrdump into
Subversion trunk in the same period.

== Notes ==

[1]: http://thread.gmane.org/gmane.comp.version-control.git/162183
======================================================================

Thanks for reading.

-- Ram
