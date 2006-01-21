From: Junio C Hamano <junkio@cox.net>
Subject: Re: What is in git.git
Date: Sat, 21 Jan 2006 11:37:11 -0800
Message-ID: <7vek31mkyg.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net>
	<200601211636.02340.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:37:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0OY2-0004kv-3f
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWAUThO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWAUThO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:37:14 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19156 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932275AbWAUThN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 14:37:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121193431.RYVH17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 14:34:31 -0500
To: Alexander Litvinov <lan@ac-sw.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15008>

I suspect there is an misunderstanding or two, because I did not
repeat what the other parts (Porcelain-ish) would do and
everything fits together.  For that, you need to refer to a
couple of earlier messages from me on the "RFC: Subprojects"
thread [*1*], and perhas use some imagination, because the
outline I did back then was done without having much of what are
in "pu" today and I may have got some details wrong.  The
message you are responding to was to give a demonstation of the
current status of how the core part works.

Alexander Litvinov <lan@ac-sw.com> writes:

>> 1. Can I bind some branch instead of tag (commit) ?

The "bind" line describes relationship among specific points in
development histories of subprojects and superprojects so it
needs to use commit object names.

If you mean by "binding a branch", to record how each subproject
relates to the toplevel project (i.e. "the subproject bound to
X/ subdirectory of the toplevel project comes from branch Y"),
that information needs to be somewhere, but recording it in the
commit object goes against the whole git philosophy.

Branch naming is a local matter.  "master" in my repository
represents a different development history of the project from
what your "master" does.  The subproject I happen to use the
"subpro" branch to keep track of might be called "sub" in yours.
Recording the name "subpro" on a "bind" line in a commit object
makes that commit object useless when you fetch such a commit
from my repository.

>> 2. Is it possible to commit changes of subpro's file in
>> master branch into subpro branch to make this changes visible
>> to master-2 ?

You are way ahead of what I am putting in "pu".  That is all
responsibility of the scripting part that use the core part;
refer to the outline in earlier messages on the subprojects
thread.

I think the above relates to this part of what you said:

> subpro and main are separate projects and master is the join
> of them. If I want to modify subpro I have to checkout subpro
> branch, edit files. When I have to got to master and bind new
> version of subpro to it.

I do not see any problem with this.  The core level tools in
"pu" supports that mode of operation.  They also support another
mode of operation, checking out the whole thing and making a
commit for subprojects.

> Worse, if I will edit subpro's files bined to master branch
> changes will go to master branch instead of subpro's history.

Simply untrue.

Even though I will use present tense (e.g. "the checkout command
notices") in the following, you should remember that the current
set of barebone Porcelainish scripts have not been taught about
any of this.

You need to keep a file that describes how your repository is
tracking the development histories of each subproject in
$GIT_DIR/bind, that would look like:

	master main=/ subpro=sub/

meaning:

	In this repository, the project whose history is kept
	track of by "master" branch binds the projects whose
	history is kept track of by "subpro" branch at sub/ and
	another project that holds the rest whose history is
	kept track by "main" branch.

You can have more than one branches for subprojects and the
combined project.  Just have more lines in $GIT_DIR/bind,
like so, to achieve that [*2*]:

     master main=/ subpro=sub/
     master20 main2=/ subpro=sub/
     master02 main2=/ subpro2=sub/
	...

To work on the example project, there are two alternative
workflows that can be supported:

1. You can be on "master" branch (i.e. checking out everything
   at the right place), and make necessary changes, be they at
   toplevel or sub/ directory.  

   The checkout command notices you are on "master" branch, and
   you are checking out a bound commit which has "bind" lines
   for / and sub/ directories.  When committing, a single "git
   commit" may make potentially three commits.  (1) If you want
   to commit changes you made to sub/ part, that is committed to
   "subpro" branch; (2) If you want to commit changes to the
   rest, that is committed to "main" branch; (3) and a commit to
   the "master" branch is made to record the state of the whole
   thing.

2. You can work on an individual subproject without bothering
   the combined project.  You can have another repository to do
   developments of the project this repository uses "subpro"
   branch to keep track of.  When that work in the other
   repository on a subproject is ready to be integrated into the
   whole, you would fetch/merge the subproject part into this
   repository from there, advancing "subpro" branch head in this
   repository.

   When this happens, you can notice that the commit on the
   "bind" line for sub/ part does not match the branch head that
   keeps track of that part of the tree (i.e. "subpro")
   anymore, and can update sub/ part by merging.

> One more comment: it seems to me it is not possible to make
> two branches on separate subprojects with the same name.

This is precisely why I said "the branch naming is a local
issue", and the commit object does not record branch name.  In
the above workflow #2, there is no reason for the other
repository that develops the sub/ subproject part to name its
primary branch "subpro".  Most likely it is named "master"
there, and the combined project would fetch its advancement by
issuing:

	$ git fetch ../subprorepo master:subpro

If you have more than one branches in the other repository and
would want to use that instead, you would fetch from that branch
not from master there.

You can also keep more than one branch for a subproject inside
the combined repository and have more than one $GIT_DIR/bind
lines that describe different superprojects that bind different
branches of the same subproject at the same location in the
corresponding superproject branch..


[Footnote]

*1* Here are a couple of key messages in the thread, that
attempt to describe how the things would fit together:

    http://article.gmane.org/gmane.comp.version-control.git/14781
    http://article.gmane.org/gmane.comp.version-control.git/14809

*2* Theoretically you could have NxMxOx... master project
branches for subprojects with N, M, O,... branches, but in
practice, the combined project is an integration field, and most
of the combinations are not something you are interested in.

Not all of the N branches in a subproject need to be directly
integrated into the whole --- most of them are used only while
coming up with the version of the subproject that is suitable
for the integration.
