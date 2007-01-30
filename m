From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 18:44:31 +0100
Organization: At home
Message-ID: <epo03h$2nc$1@sea.gmane.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: mercurial@selenic.com, mercurial@selenic.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 18:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBx14-0006R5-CT
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 18:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965641AbXA3Rnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 12:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965648AbXA3Rnb
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 12:43:31 -0500
Received: from main.gmane.org ([80.91.229.2]:56542 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965641AbXA3Rna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 12:43:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HBx0r-0007AH-QD
	for git@vger.kernel.org; Tue, 30 Jan 2007 18:43:21 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 18:43:21 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 18:43:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38174>

[Cc: git@vger.kernel.org]
[Followup-To: git@vger.kernel.org aka gmane.comp.version-control.git]

Mike Coleman wrote:

> I recently decided to jump into the DVCS pool, and I've been studying
> what seem to me to be the two leading candidates--git and
> mercurial--to try to understand the differences between them in design
> and features.  I have some questions that I hope you can enlighten me
> on.
> 
> 1.  As of today, is there any real safety concern with either tool's
> repo format?  Is either tool significantly better in this regard?
> (Keith Packard's post hints at a problem here, but doesn't really make
> the case.)

I don't know if Mercurial is safe with respect to interrupting in
the midle of update. Git is safe in that regard; the only unsafe
command is git-prune (and it is explicitely as such marked in
documentation); there were some attempts lately about making it safer.
 
> 2.  Does the git packed object format solve the performance problem
> alluded to in posts from a year or two ago?

If it was I/O performance problem, then packed objects format and
to lesser extent (important only if you have large number of tags
or branches) packed refs format, should solve it.

See http://git.or.cz/gitwiki/GitBenchmarks (most probably biased).

> 3.  Someone mentioned that git bisect can work between any two
> commits, not necessarily just one that happens to be an ancestor of
> the other.  This sounds really cool.  Can hg's bisect do this, too?

The very idea of git bisect was for it to work with nonlinear history.
Otherwise it wouldn't be really necessary.

git-bisect(1) mentions git-rev-list --bisect option, and in description
of --bisect in git-rev-list(1) we have:

        Limit output to the one  commit  object  which  is  roughly  halfway
        between the included and excluded commits. Thus, if

                $ git-rev-list --bisect foo ^bar ^baz

        outputs 'midpoint', the output of the two commands

                $ git-rev-list foo ^midpoint
                $ git-rev-list midpoint ^bar ^baz

        would be of roughly the same length. Finding the change which intro-
        duces a regression is thus reduced to a  binary  search:  repeatedly
        generate  and  test  new  'midpoint's  until  the commit chain is of
        length one.

(where "git rev-list foo ^bar" means listing all commits reachable from
commit, tag or branch 'foo' which are not reachable from 'bar').

> 4.  What is git's index good for?  I find that I like the idea of it,
> but I'm not sure I could justify it's presence to someone else, as
> opposed to having it hidden in the way that hg's dircache (?) is.  Can
> anyone think of a good scenario where it's a pretty obvious benefit?

Git index is used to stage commits, i.e. create it part by part (create
some changes, view diff of those changes, save those changes to index,
create some new changes, view diff of new changes, etc.). And it is very
useful in resolving merges and merge conflicts (you can view diff only
of the conflicted part). Also it makes add / remove operations easier
to understand. 

It also allows for some tricks like "SCM remove all files
known to SCM, which are missing in working repository", or "make SCM
think that all files are newer when importing from tar file".
 
> 5.  I think I read that there'd been just one incompatible change over
> time in the git repo format.  What was it?

If you are referring to the change that sha-1 used to be of compressed
contents, it was IIRC before first public release.
 
> 6.  Does either tool use hard links?  This matters to me because I do
> development on a connected machine and a disconnected machine, using a
> usb drive to rsync between.  (Perhaps there'll be some way to transfer
> changes using git or hg instead of rsync, but I haven't figured that
> out yet.)

Git can use hard links (git clone --local, git relink) but does not need
to. If you have hardlinks under version control, git does not checkout
them as hardlinks.

> 7.  I'm a fan of Python, and I'm really a fan of using high-level
> languages with performance-critical parts in a lower-level language,
> so in that regard, I really like hg's implementation.  If someone
> wanted to do it, is a Python clone of git conceivable?  Is there
> something about it that just requires C?

C is for performance. Git is not libified, and it would be hard to get
it fully (or at least most important parts) libified.

> 8.  It feels like hg is not really comfortable with parallel
> development over time on different heads within a single repo.
> Rather, it seems that multiple repos are supposed to be used for this.
> Does this lead to any problems?  For example, is it harder or
> different to merge two heads if they're in different repo than if
> they're in the same repo?

In git if you want to merge two heads in different repos, you in fact
first download (fetch) the objects from other repo, then merge two local
head one of which can be temporary (FETCH_HEAD) although usually we use
local branch (so called tracking branch) to always refer to downloaded
objects from other repo.

> (I'll probably post this on the hg list as well.)

I'm not sure if Mercurial mailing list is not subscribe-to-post,
unfortunately...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
