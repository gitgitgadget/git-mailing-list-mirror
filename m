From: Adam Spiers <git@adamspiers.org>
Subject: RFC: web UI for commit dependency inference tool
Date: Sun, 4 Jan 2015 01:08:03 +0000
Message-ID: <20150104010803.GD4108@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 02:18:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7Zpt-0001Xr-SB
	for gcvg-git-2@plane.gmane.org; Sun, 04 Jan 2015 02:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbbADBRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2015 20:17:43 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:44396 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbADBRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 20:17:41 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jan 2015 20:17:41 EST
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id AE1A62E043
	for <git@vger.kernel.org>; Sun,  4 Jan 2015 01:08:03 +0000 (GMT)
Content-Disposition: inline
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262000>

Hi all,

Thanks to my employer's generous "Hack Week" policy[0], I have the
luxury of being able to spend most of next week hacking on a git
commit dependency inference tool which I built 14 months ago but never
got round to polishing up or publically announcing.  In this email
I'll briefly explain the tool and some ideas I have for adding a
web-based UI to it next week - any feedback is most welcome.

[0] https://hackweek.suse.com/

Background theory
=================

It is fairly clear that two git commits within a single repo can be
considered "independent" from each other in a certain sense, if they
do not change the same files, or if they do not change overlapping
parts of the same file(s).

In contrast, when a commit changes a line, it is "dependent" on not
only the commit which last changed that line, but also any commits
which were responsible for providing the surrounding lines of context,
because without those previous versions of the line and its context,
the commit's diff might not cleanly apply[1].  So all dependencies of
a commit can be programmatically inferred by running git-blame on the
lines the commit changes, plus however many lines of context make
sense for the use case of this particular dependency analysis.

Therefore the dependency calculation is impacted by a "fuzz" factor
(c.f. patch(1)) parameter, i.e. the number of lines of context which
are considered necessary for the commit's diff to cleanly apply.

As with many dependency relationships, these dependencies form edges
in a DAG (directed acyclic graph) whose nodes correspond to commits.
Note that a node can only depend on a subset of its ancestors.

[1] Depending on how it's being applied, of course.

Motivation
==========

Sometimes it is useful to understand the nature of parts of this DAG,
as its nature will impact the success or failure of operations
including merge, rebase, cherry-pick etc.

For example when porting a commit "A" between git branches via git
cherry-pick, it can be useful to programmatically determine in advance
the minimum number of other dependent commits which would also need to
be cherry-picked to provide the context for commit "A" to cleanly
apply.

Another use case might be to better understand levels of specialism /
cross-functionality within an agile team.  If I author a commit which
modifies (say) lines 34-37 and 102-109 of a file, the authors of the
dependent commits forms a list which indicates the group of people I
should potentially consider asking to review my commit, since I'm
effectively changing "their" code.  Monitoring those relationships
over time might shed some light on how agile teams should best
coordinate efforts on shared code bases.

I'm sure there are other use cases I haven't yet thought of.  At first
I thought that it might provide a useful way to programmatically
predict whether operations such as merge / rebase / cherry-pick would
succeed, but actually it's probably cheaper and more reliable simply
to perform the operation and then roll back.

BTW the dependency graph is likely to be semantically incomplete; for
example it would not auto-detect dependencies between a commit A which
changes code and another commit B which changes documentation or tests
to reflect the code changes in commit A.  (Although of course it's
usually best practice to logically group such changes together in a
single commit.)  But this should not stop it from being useful.

Current status
==============

I have written a tool called git-deps which automatically walks this
graph:

    https://github.com/aspiers/git-config/blob/master/bin/git-deps

I haven't yet documented it or formally announced it until now, but
it's a single Python script, and usage is fairly self-explanatory:

    $ git deps -h
    usage: git-deps [options] COMMIT-ISH [COMMIT-ISH...]

    Auto-detects commits which the given commit(s) depend on.

    optional arguments:
      -h, --help            show this help message and exit
      -l, --log             Show commit logs for calculated dependencies
                            [False]
      -r, --recurse         Follow dependencies recursively [False]
      -e COMMITISH, --exclude-commits COMMITISH
                            Exclude commits which are ancestors of the given
                            COMMITISH (can be repeated)
      -c NUM, --context-lines NUM
                            Number of lines of diff context to use [1]
      -d, --debug           Show debugging [False]

By default it will list all dependencies of the given commit-ish(s),
but with --recurse it will one dependency (i.e. two SHA1s representing
a graph edge) per line.

There is still plenty of scope for optimization, e.g. it only takes
partial advantage of pygit2.

Future plans
============

1. Interactive graph visualization

   Currently the output is text only, but I think it would be more
   useful to visualise the dependencies as an interactive graph where
   you could zoom in/out, pan around, hover over each node to see
   commit meta-data, click on leaf nodes to request further recursion,
   and so on.  Nodes could be coloured according to commit author, and
   sized according to the diffstats.

   Clearly this should be cross-platform and based on some modern
   rendering technology, so HTML/CSS/Javascript seems the obvious
   choice.  Dependency inference is too expensive to generate the full
   graph as a static web page, so I plan to extend the tool so it can
   act as a lightweight web server, e.g.

       $ git deps --web --port 8080

   and then you could simply point your browser at http://localhost:8080
   to interact with the graph.  It might look a little like this:

       http://marvl.infotech.monash.edu/webcola/examples/downwardedges.html

   but with interactive zoom/pan/hover/click functionality like this:

       http://marvl.infotech.monash.edu/webcola/examples/onlinebrowse.html

   Since a lot of the hard work is already done by cola.js in the above
   examples, most likely I will use that in conjunction with d3.js for
   rendering:

       http://marvl.infotech.monash.edu/webcola/

   Since the tool is already written in Python, I am considering using a
   very lightweight web framework such as Flask:

       http://flask.pocoo.org/

   (I suspect Django would be overkill for this application which is
   essentially stateless.)

   Another approach might be to integrate it into an existing git web
   frontend written in Python.  However I trawled through

       https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Web_Interfaces

   but couldn't find any Python-based frontend which looked like it was
   in active development.  Perhaps the most promising I could find was:

       http://git.kaarsemaker.net/goblet/

2. Performance improvements

   The tool should make better use of pygit2, since blame support was
   not complete when it was originally written.  It also still forks
   git-merge-base.

3. Documentation

4. Tests

   Yes - embarrassing to admit I wrote this as a quick hack without
   following TDD.  In my defence, I was doing it in coffee breaks at
   an openSUSE conference ;-p

Request for feedback
====================

Any kind of feedback is very welcome - obviously sooner rather than
later, as my Hack Week starts on Monday.  Here's the project page:

    https://hackweek.suse.com/11/projects/366

Many thanks in advance!
Adam
