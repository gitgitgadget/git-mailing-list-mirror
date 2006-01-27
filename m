From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to create and keep up to date a naked/bare repository?
Date: Thu, 26 Jan 2006 19:36:49 -0800
Message-ID: <7vd5ie735a.fsf@assigned-by-dhcp.cox.net>
References: <7v1wyvn9pc.fsf@assigned-by-dhcp.cox.net>
	<7v64o7fac1.fsf@assigned-by-dhcp.cox.net>
	<m34q3q9759.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 04:37:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2KPx-0001r3-5i
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 04:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWA0Dgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 22:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWA0Dgw
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 22:36:52 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63976 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932417AbWA0Dgv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 22:36:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060127033655.QVJH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 Jan 2006 22:36:55 -0500
To: Mathieu Chouquet-Stringer <ml2news@free.fr>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15173>

Mathieu Chouquet-Stringer <ml2news@free.fr> writes:

> junkio@cox.net (Junio C Hamano) writes:
>> It sounds like you are not telling fetch to update the refs you
>> track from outside.  Perhaps, this may help (untested):
>> 
>> 	$ GIT_DIR=/pub/scm/git/git.git git fetch \
>>         	--update-head-ok $remote master:master
>
> I guess I'm a little bit confused here as I'm not quite sure what I'm
> trying to accomplish...
>
> Here's what I ran:
> % GIT_DIR=. git fetch \
> --update-head-ok git://www.kernel.org/pub/scm/git/git master:master
>
> Isn't git supposed to fetch master:origin as my remotes/origin file
> contains (I actually tried both and refs/heads/origin and refs/heads/master
> have the same value):
>
> URL: git://www.kernel.org/pub/scm/git/git.git
> Pull: master:origin
> Pull: todo:todo
> Pull: html:html
> Pull: maint:maint
> Pull: man:man
> Pull: pu:pu
>
> So it knows about the repository and the ref spec so all I need would be
> the --update-head-ok flag then, no?

True.

The latest git-clone.sh stopped creating both refs/heads/origin
and remotes/origin.  The former was to prevent common mistake
when using it as a shared repository, but removal of the latter
might have been a mistake.  I dunno.


Let's step back a bit and think about the modes of usage for a
bare cloned repository.

 - A central distribution point for a (sub)project.

   This is the original mode of operation bare repositories were
   to be used.  Think of bare repositories on kernel.org public
   machines.  Subsystem maintainers never work in them; the
   maintainers push into them from their private development
   trees.  Most importantly, fetching into them is not usually
   done.  Fetching from upstream or sibling is done first into
   maintainers' private development trees, and then either
   vanilla upstream tip and/or merge result with it are pushed
   into this bare repository.

 - A shared repository, CVS style.

   This is a natural extension of the above, but instead of
   having one person (the owner of the central distribution
   point for the subproject, aka subsystem maintainer), members
   of a group push into it.  Other aspects of the repository are
   not different from the above.  For example, if the project
   has an upstream, the changes from the upstream is fetched by
   people into their own development tree, merged appropriately
   and pushed back to the shared repository.

 - A mirror of somebody else's work.

   I suspect this is what you are doing.  Instead of individual
   developers pulling directly from upstream, you would want to
   fetch and update the bare cloned repository and have your
   developers fetch from it.

The first two forms are equivalent.  The first one is a special
case of having only one user of the shared repository.  The
mirror usage can be combined with the shared repository style.

Let's outline how.

What I would suggest is to arrange things like this:

   +-------------------------------------------+
   | Your upstream repository                  |
   | git://git.kernel.org/pub/scm/git/git.git/ |
   +-------------------------------------------+ 
      |                                      ^
      | (1)                                  | (5)
      |                                      |
      v                                      |
   +-----------------+                     +----------------+
   | Your central    |        (4)          | My development |
   | bare repository |-------------------->| tree           |
   +-----------------+                     +----------------+
      |      ^
      | (2)  | (3)
      |      |
      v      |
   +------------------+
   | Your developers' |+
   | trees            ||+
   +------------------+||
     +-----------------+|
      +-----------------+

(1) is initially done with "clone --bare".  You have already
    done this.  To let your developers fetch the upstream
    without directly going to kernel.org/, you would need a
    mirror, which means you would want to keep all branches from
    the upstream that your developers might be interested in.

    So I would suggest to have something like this in this
    repository:

        $ cat remotes/origin
        URL: git://git.kernel.org/pub/scm/git/git.git/
        Pull: master:mirror
        Pull: maint:maint
        Pull: +pu:pu
        Pull: todo:todo
        Pull: html:html
        Pull: man:man
	$ mv refs/heads/origin refs/heads/mirror

    You may not particularly interested in the last three, in
    which case you can safely omit them.  Also note that I
    renamed "origin" to "mirror" here.

    I imagine that your developers would be making updates to
    git, and wish to share the changes with outside world (the
    repository is not strict a mirror in that sense), so you
    would need your own branch or two.  Your "master" branch is
    used for that.

    Periodically, you could mirror me with:

	$ GIT_DIR=. git fetch

    Which would update the branch heads listed on the RHS of
    Pull: lines above.  Note that the branch HEAD points at is
    refs/heads/master and is not listed on the RHS of Pull:
    lines, so --update-ok is not needed.  My "master" will be
    mirrored as "mirror" in this repository.

(2) is created by "git clone" from your "central bare repository", and
    maintained by subsequent "git pull".  I am not offhand certain
    what remotes/origin file they would get by default, but I would
    recommend having something like this in their trees:

	$ cat .git/remotes/origin
        URL: git://your.host/your/git.git
	Push: master:master
        Pull: master:public
        Pull: mirror:mirror
	Pull: +pu:pu

    Again, you may not particularly interested in all my branches, so
    I've omitted most from the above.  Your developers should never
    touch branches that are used to keep track of outside branches in
    their repositories (they are "public", "mirror" and "pu" in the
    above example).  Have them work on their "master" branch.

	$ git pull

    would fetch from the "master" of your central bare repository and
    keep track of it as the "public" branch [*1*][*2], and merge the
    result of other developers in your group into the "master" branch.
    If you would want to see how well your work works with the latest
    upstream:

	$ git branch -f test mirror
    	$ git checkout test
        $ git pull . master

    would create a "test" branch based on my tip of "master", and
    merge your development histories into it.  Substitute "mirror"
    with "pu" if you want to see how well your development works with
    the tip of "pu" branch.

(3) Your developers will make commits to their own "master" branch,
    and when things are ready, push the branch back:

	$ git push origin

    which would attempt to update "master" in your central bare
    repository with developer's "master".  This will fail if the
    developer is not up to date --- in which case another git
    pull and a merge would be needed to incorporate other developer's
    changes.

(4) If you got fixes and enhancements for public consumption,
    drop me a "please pull from here" note.  I'll pull your
    changes into my development tree [*3*].

(5) And I would push them out to the public repository.  The
    next fetch from me by your central bare repository and then
    your developer's pull from it would complete the full
    circle.


Does this make sense now?


[Footnotes]

*1* The "public" branch represents what other developers in your
    group have done.

*2* At the same time, it would fetch "mirror", which is my
    "master", and keep track of it as the "mirror" branch head,
    and "pu", which is also my "pu", and stores it as "pu".

    So if you are interested in what I've done in the past
    couple of days, you could:

	$ git whatchanged --since=3.days pu ;# everything
	$ git whatchanged --since=3.days mirror ;# my "master"

*3* This is one reason I did not recommend frequent merging from
    "mirror" to "master" in workflow (2).  If you do not expect me to
    pull from you, merging "mirror" into "master" to update the
    development base might be easier to handle for your developers.
