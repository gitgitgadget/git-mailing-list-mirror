From: Junio C Hamano <junkio@cox.net>
Subject: [HOWTO] Using post-update hook
Date: Fri, 26 Aug 2005 18:19:10 -0700
Message-ID: <7vy86o6usx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 27 03:19:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8pMJ-0003hT-Mr
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 03:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVH0BTN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 21:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVH0BTN
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 21:19:13 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11976 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965198AbVH0BTM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 21:19:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827011911.IQKK17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 21:19:11 -0400
To: git@vger.kernel.org
Abstract: In this how-to article, JC talks about how he
 uses the post-update hook to automate git documentation page
 shown at http://www.kernel.org/pub/software/scm/git/docs/.
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7835>

The pages under http://www.kernel.org/pub/software/scm/git/docs/
are built from Documentation/ directory of the git.git project
and needed to be kept up-to-date.  The www.kernel.org/ servers
are mirrored and I was told that the origin of the mirror is on
the machine master.kernel.org, on which I was given an account
when I took over git maintainership from Linus.

The directories relevant to this how-to are these two:

    /pub/scm/git/git.git/	The public git repository.
    /pub/software/scm/git/docs/	The HTML documentation page.

So I made a repository to generate the documentation under my
home directory over there.

    $ cd
    $ mkdir doc-git && cd doc-git
    $ git clone /pub/scm/git/git.git/ docgen

What needs to happen is to update the $HOME/doc-git/docgen/
working tree, build HTML docs there and install the result in
/pub/software/scm/git/docs/ directory.  So I wrote a little
script:

    $ cat >dododoc.sh <<\EOF
    #!/bin/sh
    cd $HOME/doc-git/docgen || exit

    unset GIT_DIR

    git pull /pub/scm/git/git.git/ master &&
    cd Documentation &&
    make install-webdoc
    EOF

Initially I used to run this by hand whenever I push into the
public git repository.  Then I did a cron job that ran twice a
day.  The current round uses the post-update hook mechanism,
like this:

    $ cat >/pub/scm/git/git.git/hooks/post-update <<\EOF
    #!/bin/sh
    #
    # An example hook script to prepare a packed repository for use over
    # dumb transports.
    #
    # To enable this hook, make this file executable by "chmod +x post-update".

    case " $* " in
    *' refs/heads/master '*)
            echo $HOME/doc-git/dododoc.sh | at now
            ;;
    esac
    exec git-update-server-info
    EOF
    $ chmod +x /pub/scm/git/git.git/hooks/post-update

There are three things worth mentioning:

 - The update-hook is run after the repository accepts a "git
   push", under my user privilege.  It is given the full names
   of refs that have been updated as arguments.  My post-update
   runs the dododoc.sh script only when the master head is
   updated.

 - When update-hook is run, GIT_DIR is set to '.' by the calling
   receive-pack.  This is inherited by the dododoc.sh run via
   the "at" command, and needs to be unset; otherwise, "git
   pull" it does into $HOME/doc-git/docgen/ repository would not
   work correctly.

 - This is still crude and does not protect against simultaneous
   make invocations stomping on each other.  I would need to add
   some locking mechanism for this.
