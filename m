From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 0/4] RepositoryTestCase cleanups
Date: Thu, 27 Nov 2008 13:49:16 -0800
Message-ID: <20081127214916.GD23984@spearce.org>
References: <1227820410-9621-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fonseca@diku.dk
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 22:50:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5okt-0007qy-2W
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbYK0VtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbYK0VtS
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:49:18 -0500
Received: from george.spearce.org ([209.20.77.23]:35695 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbYK0VtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:49:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9F4E238200; Thu, 27 Nov 2008 21:49:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1227820410-9621-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101841>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Ok, so here is an attempt to improve the ability of the JGit's unit
> tests to delete temporary repositories. This has probably been seen
> by many, but Jonas Fonseca raised the issue.

Hmpph.  This takes 19 seconds to run the suite, where it used to be
only 2 seconds on the same system.  The slower run isn't something
I'm too happy about, actually I'd like to make the run even faster
than 2 seconds.
 
> The background is that on Windows you cannot delete files that are
> open and mmapped files are open until they get unmapped, which in
> Java is beyond explicit programmer control. You can only free the
> resources and pray that the GC does the work. Fortunately it usually
> does. It turned out our testcases weren't even trying to clean up
> properly. 

If the issue is mmap'd files, why don't we instead disable mmap
on Windows during JUnit tests, and use the non-mmap variant of
pack access?  At least do that for the bulk of the tests, and
then have a single test case which tests the mmap code path but
has careful System.gc calls in place to try and ensure we can
actually clean up the temporary files.

Another option is to refactor the Repository class a little so we
can replace local filesystem IO with something else, like say an
in-core repository.  E.g. a pack file and/or pack index stored in
a byte[], and refs stored in a HashMap.  We'd still need a couple
of tests to verify local disk IO, but many of the tests can be
validated against such a pure in-memory Repository concept.

I'd actually like to get that Repository refactoring done soon,
someone else was asking about it for the RefDatabase (to store the
refs in a SQL database so JGit ties into JTA) but I may also want
it for Gerrit 2 - I'm looking at doing something that would put
200,000 refs per year into a repository.  That's so large that
most operations can't afford to scan the entire ref database,
and it really cannot be loose.  ;-)


Refactoring repository is a fair chunk of work, disabling the mmap
feature under Windows in JUnit may be easier.  Hmm, according to
WindowCache's <clinit> its default by false.  Why is it enabling
on Windows?  The only code that calls WindowCache.reconfigure()
is in the Eclipse plugin, so pure JGit unit tests shouldn't be
turning on mmap code *at all*.

Which also points out a gap in our tests.  Nothing new, we have
lots of gaps.  *sigh*

-- 
Shawn.
