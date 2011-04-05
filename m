From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC 2011 v2] Git Sequencer
Date: Wed, 6 Apr 2011 01:30:10 +0530
Message-ID: <20110405200008.GC25644@kytes>
References: <20110403172054.GA10220@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 22:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7CRC-0008C4-87
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 22:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab1DEUBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 16:01:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38775 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab1DEUBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 16:01:12 -0400
Received: by iyb14 with SMTP id 14so716031iyb.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pceePamQn3/elrh8+ORjhKwyDn7cdjMIkB4uObMV/ic=;
        b=Gp5Xct+ozogFbpErI+Y5UFFMSTERtX0f4aCJpnyP+nLdcPx5SC81Z7/X2dXFvKTUZ+
         QEZS+7UtXziI00mMygzPHenF4PcEBHy31zw8qThY95ehomqyvtIl4sHU0GL47JZaicy3
         3XXVj9WcFm5c8nc+raXDaAgMuJDYlvJcy+WsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LcTnyxhZvrRpjEi++m+aZ+Mg952ZNHlQiOHOZYBtjnLiy8uQfLOR/vKynAmV+hv48U
         8ujymofrnMwAkkF6a3eFjBAlTeQGk7b2cGuEAMacA3pvNvViDVi+rDv3elA7UJXckwSz
         nXtvK9+1jAHM2kltPWHABXxx118qChYl3o3IY=
Received: by 10.42.240.134 with SMTP id la6mr125545icb.347.1302033672012;
        Tue, 05 Apr 2011 13:01:12 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id y10sm4670072iba.63.2011.04.05.13.01.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 13:01:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110403172054.GA10220@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170908>

Hi,

Thanks for all the feedback on the first iteration!

This iteration of the proposal has already been submitted via the
Melange interface. More comments/ feedback are always welcome.

======================================================================
Project Proposal: Git Sequencer
Student: Ramkumar Ramachandra
Mentor: Christian Couder

== The Objective ==

Extend 'git cherry-pick' with '--continue', '--abort', and '--skip'
features.  This will ultimately be used to write git-sequencer, a new
builtin command.  The sequencer will provide a uniform interface over
which existing commands like 'rebase', 'rebase -i' and 'am' can be
re-implented.  This should give the commands more functionality,
improve their error handling, and make them faster.  The project can
only be considered successful if most of the code written gets merged
into upstream.

The Git Sequencer was a 2008 GSoC project as well; unfortunately most
of the code did not get merged into git.git.  The learning from all
that work should serve as a huge headstart this year [1].

=== The Plan ===

1. Extend 'cherry-pick' with '--continue', '--abort', and '--skip'
features, so that it works like (a subset of) the current
'git-rebase--interactive.sh'.  This will require patching
'builtin/revert.c' in place, and merging it immediately.  I plan to
roughly follow the road laid out by Christian's 2010 series [2].

1.1. Factor out all calls to 'die' with 'return error' so so that we
can pause the entire process when a commit doesn't apply
automatically.

1.2. Create and populate TODO and DONE files, similar to the one that
'git-rebase--interactive.sh' creates.  For now, it should simply give
us information about why a 'cherry-pick' failed.

1.3. Port selective tests from the current 't3404' to make sure that
TODO and DONE are populated correctly; "stop on conflicting pick" is a
good candidate.

1.4. Decouple the 'revert' functionality from the 'cherry-pick'
functionality in 'revert.c'.  Implement '--abort' for 'cherry-pick'
and port "abort" test from 't3404'.

1.5. Implement parsing the TODO and DONE files into suitable data
structures.  Derive inspiration from the code written in 2008 to do
this [3].

1.6. Implement '--continue' and '--skip', and write suitable tests.

2. Build a sequencer so that just has cherry-picking functionality.
This mostly involves moving code written in (1) around, and crafting a
general API for handling conflicts.

2.1. Factor out the 'cherry-pick' code from 'revert.c' into a new
'builtin/sequencer.c'.

2.2. Write an API for handling conflicts, so that the sequencer is
ultimate entry/ exit point for all user intervention in a multi-step
process [4].

2.3. Implement a fresh 'cherry-pick.c' on top of the sequencer.  Make
sure that all the existing tests pass.

2.4 [Optional] Patch 'builtin/merge.c' to use the conflict handler in
the sequencer.

3. Extend the sequencer to accomodate the functionality provided by
'rebase -i'.

3.1. Parse commands like 'execute', 'reword', 'squash', and 'fixup'
that are specific to interactive rebasing.  Carefully implement the
functionality for each of these keywords in a step-wise manner.

3.2. [Optional] Port the '--preserve-merges' option of 'rebase' to the
sequencer.  Port relevant tests from 't3409'.

4. [Optional] Lib'ify the sequncer. Modify the API to
include rebase-related functionality.  Write 'rebase.c' as a bunch of
API calls to the sequencer.  Make sure that the existing tests pass.

5. [Optional] Re-implement 'git-am.sh' as a thin wrapper over the
sequncer: 'am.c'.  Bulk of this should be mbox parsing code.  Make sure
that all existing tests pass.

[Optional] should be read as "If time permits"

== Timeline ===

- Before mid june: (1) should be implemented, and a series should be
  sent out to the list for review.

- Before midterm evaluation: (1) should be merged, and an
  implementation of (2) should be sent to the list.

- Before the end of July: (2) should be merged, and an implementation
  of (3) should be sent to the list.

- Before final evaluation: (3) should be merged.

== Who am I? ==

I'm Ramkumar Ramachandra, and I first started contributing to git.git
in January 2010.  Apart from doing fast-import and remote helper
related work last year, I also authored and merged svnrdump into
Subversion trunk in the same period.

== Notes ==

[1]: http://repo.or.cz/w/git/sbeyer.git
[2]: http://thread.gmane.org/gmane.comp.version-control.git/162183
[3]: http://article.gmane.org/gmane.comp.version-control.git/162198
[4]: http://thread.gmane.org/gmane.comp.version-control.git/170834
======================================================================

Thanks for reading.

-- Ram
