From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: Git:  CVS to Git import
Date: Sun, 13 Nov 2011 19:44:03 -0700
Message-ID: <20111114024403.GA2905@comcast.net>
References: <1321053453892-6987037.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jvsrvcs <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 03:50:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPmcT-0005iM-4o
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 03:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab1KNCt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 21:49:57 -0500
Received: from qmta15.emeryville.ca.mail.comcast.net ([76.96.27.228]:57719
	"EHLO qmta15.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752859Ab1KNCt4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 21:49:56 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Nov 2011 21:49:56 EST
Received: from omta09.emeryville.ca.mail.comcast.net ([76.96.30.20])
	by qmta15.emeryville.ca.mail.comcast.net with comcast
	id wqSk1h00F0S2fkCAFqk5B0; Mon, 14 Nov 2011 02:44:05 +0000
Received: from mmogilvi.homeip.net ([24.8.44.9])
	by omta09.emeryville.ca.mail.comcast.net with comcast
	id wqkN1h00V0BsQcg8VqkNWQ; Mon, 14 Nov 2011 02:44:23 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id D196AC62001; Sun, 13 Nov 2011 19:44:03 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <1321053453892-6987037.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185359>

On Fri, Nov 11, 2011 at 03:17:33PM -0800, Jvsrvcs wrote:
> Git:  CVS to Git import
> 
> We are moving from CVS to Git and want to know if anyone has had any
> experience there doing this and could share do's  / dont's, best practices
> when doing the initial import.

Some ideas:

I wouldn't trust "git cvsimport".  In my testing, it was actaully fairly
common for the resulting git tags and branches to be inconsistent with the
original CVS tags and branches: checking out a tag from CVS and the same
tag from GIT, the trees were often different.  See the manpage
for a list of some of the known issues. 

Use cvs2git instead.

Write up your own script to do the conversion.  Iteratively inspect
the results, find ways to fix up anything you don't like,
and re-run the script.  Any "fixups" you want should be
scripted, so that you can try different things, examine
the result.  Then when the actual "real" conversion
happens, you have a minimal amount of downtime as you your
already-tested script runs.

The exact fixups your script should do depend on your
circumstances, but in my case, some of things my script did included:

  - First, copy the CVS repository, and work with the copy:
  - Delete some ",v" files we didn't interested in importing into git for
    various reasons.
  - Tweak some CVS commit timestamps in some files (such as a version
    file), to reduce import odditities.  (The most common oddities
    resulted from an old CVS workflow that would often sequence:
    (a) checkout, (b) modify version number file, (c) build, (d) commit
    the new version number file, and (e) tag the sandbox.  It was
    was moderately common for other changes (in other files) to
    be committed between (a) and (d), which will either cause
    strange import artifacts or actually break import tools, due to
    the out-of-order timestamps.  Tweaking back the timestamp in the
    CVS file typically allows the import tool to avoid the
    oddity.  Completely cleaning this up would have been a
    lot of work, so I focused just on just improving recent
    history.)  (sed -i ...)
  - Do the bulk of the import work using cvs2git.
  - Graft on appropriate merge history (multiple parents) for
    CVS merges.  To save time, I only worried about recent merges.
     - If you have a nice consistent tag naming
       convention, there are ways to do this as part of cvs2git.
       Unfortunately, we didn't.
     - Do not refer to a previous run's commit SHA-1's; they'll
       likely change as things change.  Use CVS tags instead.
     - git rev-parse is useful for looking up current references
       to construct graft lines.
  - Use git filter-branch to both make the above grafts permanent,
    and to fix commiter/author username/email.
  - Move imported tags and branches to refs/oldcvstags/*
    and refs/oldcvsbranches/*, to bury a lot of the noise
    (automatic build tags, tags applied as part of doing a
    merge, etc) to where a normal "git clone" will not grab
    them, but they can still be fetched manually if necessary.
  - Copy/rename a few recent release tags and branches to
    normal refs/tags/* and refs/heads/*, when they are actually
    useful. (git pack-refs and sed)
  - Something like: sleep 5 ; git gc --aggressive --prune='1 second ago'

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
