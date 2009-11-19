From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Hey - A Conceptual Simplication....
Date: Thu, 19 Nov 2009 08:42:34 +0100
Message-ID: <20091119074226.GA23304@atjola.homenet>
References: <005a01ca684e$71a1d710$54e58530$@com>
 <20091118142512.1313744e@perceptron>
 <008401ca6880$33d7e550$9b87aff0$@com>
 <m37htnd3kb.fsf@localhost.localdomain>
 <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com>
 <009401ca68bc$7e4b12b0$7ae13810$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 'Jason Sewall' <jasonsewall@gmail.com>,
	'Jakub Narebski' <jnareb@gmail.com>,
	'Jan =?iso-8859-1?Q?Kr=FCger'?= <jk@jk.gs>, git@vger.kernel.org
To: George Dennie <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 08:42:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB1fE-0000Sc-NV
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 08:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbZKSHmg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 02:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbZKSHmg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 02:42:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:60217 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752864AbZKSHmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 02:42:35 -0500
Received: (qmail invoked by alias); 19 Nov 2009 07:42:38 -0000
Received: from i59F54809.versanet.de (EHLO atjola.homenet) [89.245.72.9]
  by mail.gmx.net (mp058) with SMTP; 19 Nov 2009 08:42:38 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18TMdBmJYYT6SELNZXssqk82ZhWap83zYtghePJ3q
	5BjEpM9JBi4q58
Content-Disposition: inline
In-Reply-To: <009401ca68bc$7e4b12b0$7ae13810$@com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133215>

On 2009.11.18 21:03:31 -0500, George Dennie wrote:
> Jason Sewell wrote....
> > I find this leads to big, shapeless commits and, as I mentioned
> > before, it seriously limits the utility of 'git bisect'.  I also
> > fail to see how 'selectively saving parts of the document' is
> > versioning and publishing - what is the publishing part?  The act o=
f
> > committing is one thing (and 'saving...
>=20
> The notion of a shapeless commit is curious. Intuitively, I consider =
a
> commit as capturing the state of my work at a transactional boundary
> (i.e. a successful unit test...or even lunch break). However, your
> characterization of "shape" suggest that you are constructing
> something other than the immediate functionality of the software.
> Consequently, your software document is not really the solution files
> alone but also this commit history that you meticulously craft.=20

Your "lunch break" as a transaction boundary is a great example of
something that probably most people on this list would consider to
create commits that need rewriting before publishing them. Let's take a=
n
extreme example:

You work on adding a feature to some webmail site that adds colors to
the mail being displayed, using different colors for the headers, quote=
d
sections and the text from the sender. The colors should be configurabl=
e
by the user.

*work*
git commit -m "Go for a coffee"
*work*
git commit -m "Lunch break"
*work*
git commit -m "Meeting"
*work*
git commit -m "Time to go home"

*come back to work*
*work*
git commit -m "Finished the mail coloring support"

This gives you:

* Finished the mail coloring support
|
* Time to go home
|
* Meeting
|
* Lunch break
|
* Go for a coffee

Such a history is basically completely useless. It's (ab)using the VCS
as a plain code dump. In a week, you'll be able to see that you had a
meeting that day, but it doesn't tell you anything about what you did t=
o
the project. And even with less "insane" commit messages, the
"transactional boundaries" are totally arbitrary. They're aligned to
things you did that have absolutely nothing to do with the stuff you're
tracking in your VCS.

A far more useful history might look like this:

* Colorize quoted text in a mail, depending on its quoting depth
|
* Parse mails into a tree structure to represent sections of quoted tex=
t
|
* Colorize mail headers
|
* Add support for the user to change the colors used for mails
|
* Add configuration variable for the colors used for mails


At each step, something functionally changed about the software. The
commit messages tell you something about how the software evolved. And
if you get bogus values for the colors in the configuration, you can be
90% sure, by only looking at the commit messages, that you have a bug i=
n
the "Add support for the user to change the colors ..." commit, and not
in one of the others. So you can run "git show $that_commit" to see the
diff of the changes you made in that commit and quickly check them for
your bug.

And while that's not sooo useful for commits that added new
functionality, it's extremely useful for commits that just made small
changes to existing functionality. Finding a bug in a large piece of
code (say 2000 lines) isn't trivial. But if you know that a commit that
changed 5 lines in that code is responsible for the breakage, all you
have to do is to identify the faulty change, which is a lot easier.

And with a large history, where it's not obvious in which commit
something got broken, "git bisect" can help to quickly find the bad
commit. Now consider "git bisect" finding your "Lunch break" commit.
Looking at the commit message tells nothing. The diff is pretty much
arbitrary, might be huge. Not much help. Finding the "Add support for
the user to change the colors ..." commit already tells you something
just because of the commit message. And the diff is about just one
specific change. It's all nicely separated, and that's a huge value.

Using git and producing nice commits is about _documenting_ the history
of your code. And having small, self-contained and well separated
commits is key to that.


And the index can be a great help with that. Given the above example,
you might already have some code to use the configured colors, just for
testing, so things aren't so boring. Maybe even some hack-up of the
code you'll be using later. If that part of the code would be committed
right away, you'd mess up your commit, because it wouldn't be about a
single change anymore, but would also have your testing code in there.
Bad.

But you don't want to throw the testing code away either, because it's
useful right now, and you might need it later, because it might evolve
into the final code used for the actual coloring. So, what now? You hav=
e
code that you want to commit, and some code you don't want to commit,
and which needs to go away temporarily, so you can test without it. No
problem, here comes the index.

Say you have:
config.c     # Has changes for the colors
show_mail.c  # Has changes to use the colors
whatever.c   # Has some changes for both

You do:
git add config.c       # Add to the index
git add -p whatever.c  # Only add some hunks to the index

So now the index has what you want to commit, and the working tree stil=
l
has everything.

git stash save --keep-index

Now your working tree and index only have the things you want to commit=
=2E
You run your unit tests, everythings fine. You commit and get a nice
clean commit, for which you write a useful commit message.

git stash pop

You've got your changes back that you didn't want to commit just yet,
and you can continue working.


Another use-case I have found for myself is to use the index to separat=
e
reviewed and not-yet-reviewed changes. Before I commit, I always review
the diff of the things I'm going to commit. So I start out with "git
diff" and start reading. When I finished reviewing a file, I can do "gi=
t
add $that_file", so the diff for that file will no longer be shown by
"git diff". That nicely cuts down the size of the "git diff" output to
things I'm still interested in. Quite useful when you are forced to do =
a
large commit, because you did some refactoring. If I find a bug during
the review, I can fix that and re-run "git diff", which will only show
changes to me that I didn't declare as "good" already by adding them to
the index.


Sure, it takes some pratice and discipline to generate a nice, useful
history. But that's not much different from writing code. Others will
hate you for writing unreadable spaghetti code, and so will they hate
you for producing a useless history that tells them that you had lunch,
instead of telling them what you did to the code ;-)

Bj=F6rn
