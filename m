From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: faster egit history page and a pure java "gitk"
Date: Mon, 24 Mar 2008 05:27:26 -0400
Message-ID: <20080324092726.GQ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Mon Mar 24 10:28:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdiyU-0004kj-He
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 10:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbYCXJ1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 05:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366AbYCXJ1c
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 05:27:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60049 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490AbYCXJ1b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 05:27:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jdixh-0002be-5f; Mon, 24 Mar 2008 05:27:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A4FEC20FBAE; Mon, 24 Mar 2008 05:27:26 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78014>

OK, so I decided a few weeks back that the history page was not fast
enough.  I think I've spent the past 3 weeks writing true revision
machinary for jgit, and now connecting it up to a UI visualizer.

  git://repo.or.cz/egit/spearce.git plotter

The history page has been completely replaced.  I saw Roger has
some patches against the current history page.  :-|

There are huge benefits to this infrastructure:

 * Fast as snot.  We are literally just 10-20 ms slower than C Git
   on the same hardware, same repository, for the same tree.  That
   is pretty damn good, given that we are in Java.

 * Faster than gitk.  Yes, really.  My plot algorithm is not nearly
   as good as Paulus' work, but I think its better than what we
   have right now.

 * Nearly instant results without path limiter(s).  If the graph
   doesn't require parent rewrites we are able to show results
   almost immediately, and fill in the rest incrementally from
   the background job.

 * Lower memory usage.  By massive amounts.  I can't even begin to
   tell you how much different it is.  Histories that we could not
   show before can now be shown in <20M.  Our memory usage is much
   lower than that of gitk.

 * Multiple path limiters.  You can select more than one resource
   (or directory!) at once and get the combined history for
   all of them at once.  This is basically the same path limiter
   algorithm that C Git/gitk rely upon for the same sort of query.
   It is still limited to a single-repository, but I think we could
   easily extend it to allow multiple-repository unions.  :-)

 * Parent/child hyperlinks in message viewer.  Like gitk you can
   now click on the parent and child commit SHA-1s to jump up and
   down the graph.

 * Grep options available.  Not implemented in the UI yet, but
   the lower level machinary supports author/committer/log message
   grep functions.

 * Interesting/not-interesting flags available.  Not implemented
   in the UI yet, but the lower level machinary can do things like
   "^foo bar" to show all commits in bar that are not in foo.

 * More modular code.  Its broken apart much better. We don't have
   3000 lines in a single class.

 * Common AWT and SWT drawing.  Most of the UI visualization code
   is implemented in shared code that has no AWT or SWT specifics
   about it.  This makes the renderer completely portable.  I have
   both an AWT and an SWT implementation running (compare from the
   command line "jgit glog HEAD" to the history view in Eclipse).

 * Faster "RevCommit" class.  This class mostly replaces the older
   "Commit" class.  Accessing data out of a RevCommit can be much
   quicker than out of a Commit, plus a RevCommit gets the encoding
   of the author, committer and message correct more of the time.
   The downside is you can only get a RevCommit from a RevWalk,
   or one of its subclasses.

-- 
Shawn.
