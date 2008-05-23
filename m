From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PYRITE] Status update and call for information.
Date: Fri, 23 May 2008 01:18:42 -0500
Message-ID: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 23 08:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzQcs-0005eH-TT
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 08:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbYEWGSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 02:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbYEWGSq
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 02:18:46 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:17386 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbYEWGSp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 02:18:45 -0400
Received: by ti-out-0910.google.com with SMTP id b6so431363tic.23
        for <git@vger.kernel.org>; Thu, 22 May 2008 23:18:43 -0700 (PDT)
Received: by 10.150.58.2 with SMTP id g2mr1344323yba.78.1211523522118;
        Thu, 22 May 2008 23:18:42 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Thu, 22 May 2008 23:18:42 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: fc13f5a8c37e4772
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82683>

Hey Folks,

I am still around working on Pyrite.  Which is both a porcelain and a
git/Python library.  I have been making some good progress recently
on my way to my alpha release and I thought I would share my progress
and get some feedback.

Status:

Although work and life keep me pretty busy, I have made good progress
on rounding out the use cases for Pyrite.  I can do most of my day's
SCM work in pyrite and it really just lacks a couple features before
I can, theoretically, use it all the time.  Hopefully I will be able
to tag alpha in a couple weeks.

Interface:

I have been doing a lot of thinking about what kind of interface
would make this easily accessable to new and casual users and I have
some ideas where I want to go.  Actually, I have taken most of the
ideas from other SCMs such as Mercurial and Bazaar in addition to git.

One of the things that has been commented on by almost any review of
git are the large numbers of commands that are present and the
endless stream of flags, options, configuration variables and
syntaxes that are present in git.  They certainly serve a purpose
and I probably would not be able to do this without all those things
but it can get in a normal users way some times.  Here are some of
the steps I have and will be taking.

1) Reduce the number of commands.

I am currently at 30 total commands, and while I have some more to go, I
think there are some ways that I can get rid of some of them by
combining them.  Do we really need a clone, branch and checkout?  Don't
these all mean the same thing in the end?  They mean get me a working
directory of the repository starting at X.  For clone, you start
with 'master'. For checkout, you tell it what to get you.  Branch
will help you manage things you can locally get.  So perhaps we can
do something like the following...

Clone a new repo
pyt checkout http://foo.com/bar/baz.git mybaz

It's a URL, I know that I can clone that and I know I am not inside
a repository.

Fetch
pyt co <url> # or remote:origin

It's a URL, but I am inside the repo, I should tell the user that
they are about to fetch something.

Pull
pyt co -m remote:origin:branch

Pull is just fetch/merge anyway -m tells it to merge, perhaps a flag -u
to do it all in one step.

Merge
pyt co -m localbranchhead

Checkout a branch
pyt co localbranchead # or remote:origin:branch, tag:tagname etc

Create/switch to new local branch (this should look familiar)
pyt co -c <newbranch> -b <base>

The list goes on.


2) Reduce complexity.

This one is easy, not because there are commands in git that don't
have a use, but because we can usually spell stuff in a simpler way.
Take for example master@{100}.  If I see someone on the list use that
on I might expect that that is master 100 commits ago, rather than what
HEAD was pointing at 100 operations ago.  Furthermore, if I have just
cloned, that won't work because I have no reflog.  So what if we
spelled that reflog:100:master?  Well now at least I know that I
am dealing with the reflog.  Perhaps a more refined spelling could
give the user more information.

Take ":/message"  I didn't even know that existed until I was looking
for nifty things to spell, but wouldn't "subject:my subject" work just
as well?  Thats a little friendlier.

How about not using the ".." and "..." since it can be surprising to
users what they actually do without understanding how git works.
Perhaps something like --revision-start (-r) and --revision-end(-R)
would help them out.  Add a --symmetric or something for "...".

You get the idea.

3) Addons.

Some functionality isn't for everyone.  I have just put into my
next branch an addon that gives git revision numbers.  Why, because
other SCMs that are supposed to be more user friendly have them.
Because people have been asking for them.  Because they are easier
to remember.  The concept is this.  A given commit encapsulates its
parantage, so if I have commit XYZ, I can always say that XYZ is
so-many commits away from the first commit.  The question is how
you determine that number and that you always do it the same.  If
we just define the revision number to be the place of the commit
in the list of "git rev-list --topo-order --reverse SHA1" then
we can get a consistant number semi-meaningful number, which is all
people really want.

So why isn't this for everyone?  Because its a little slow and some
people on the list HATE anything that takes more than half a
second.  I won't name names but he has an OS named after him.  So for
a git repo on decent hardware, this adds .5-1 seconds to look something
up and find out its revision.  Painful to some, but others would
rather wait than have to try and remember a SHA1 or even just the
first 8 chars of a SHA1.

4) GUI.

I have a GUI in mind, I haven't had time to work on it, but I have
started it and the idea is that it should be able to completely
replace the command line.  Why?  because some people hate command lines
and more importantly, because I want a GUI that will look like it
fits into my Gnome desktop and looks decent on my Windows machine
(which I use because I have to).

5) One stop shop.

I tried setting up Apache, lighttpd etc on Windows to do some ad-hoc
serving of a git repo.  I was painful.  I want my webserver, gui,
command line, diff tool, merge tool to all come in one package.  And
I DON'T want it to need a cygwin or msys installation to work.

That just makes life easier.  And I am all about the not expending
effort.


Well, this mail is long enough, hopefully I will get some feedback
on this, some more ideas for things that can be simplified or
enhanced or whatever.  Please feel free to drop me a line and/or
check out my public repo at http://gitorious.org/projects/pyrite.

Thanks,
Govind.
