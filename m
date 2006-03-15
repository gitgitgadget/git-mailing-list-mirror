From: Junio C Hamano <junkio@cox.net>
Subject: Re: seperate commits for objects already updated in index?
Date: Tue, 14 Mar 2006 19:24:15 -0800
Message-ID: <7vy7zcie5c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
	<Pine.LNX.4.64.0603140856120.3618@g5.osdl.org>
	<Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>
	<Pine.LNX.4.64.0603140915290.3618@g5.osdl.org>
	<7vwtewk2jp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 15 04:24:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJMcX-0007Dv-Iq
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 04:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWCODYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 22:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbWCODYS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 22:24:18 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:58808 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751965AbWCODYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 22:24:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060315032422.JUKV25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Mar 2006 22:24:22 -0500
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <7vwtewk2jp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 14 Mar 2006 15:51:54 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17605>

The background behind this is around beginning of February 2006,
the thread "Two ideas" by Carl Worth.  And the current behaviour
is defined by this commit.  I'll talk about a possible
improvement but first, here is what it does:

commit 130fcca63fe8e7e087e7419907e018cbbaf434a3
Author: Junio C Hamano <junkio@cox.net>
Date:   Sun Feb 5 00:07:44 2006 -0800

     ...

     - "git commit paths..." acquires a new semantics.  This is an
       incompatible change that needs user training, which I am
       still a bit reluctant to swallow, but enough people seem to
       have complained that it is confusing to them.  It
    
       1. refuses to run if $GIT_DIR/MERGE_HEAD exists, and reminds
          trained git users that the traditional semantics now needs
          -i flag.
    
       2. refuses to run if named paths... are different in HEAD and
          the index (ditto about reminding).  Added paths are OK.
    
       3. reads HEAD commit into a temporary index file.
    
       4. updates named paths... from the working tree in this
          temporary index.
    
       5. does the same updates of the paths... from the working
          tree to the real index.
    
       6. makes a commit using the temporary index that has the
          current HEAD as the parent, and updates the HEAD with this
          new commit.

    ...

The check that prevents you from doing

	$ edit A B
	$ git update-index A B
        $ git commit -o B

is the rule #2, which I think could use further improvement.  It
is to address the "committing skewed files" issue Carl brought
up in that thread.

It might be better to further check if the working tree file is
the same as the index, and to allow a commit in such a case.

The intent of rule #2 is to prevent this from happening:

	$ edit A B
        $ git update-index A B
        $ edit B again
        $ git commit -o B

When this happens, the real index will have _old_ contents of B
that never was committed, and does not match what is in the
index.  But after the commit, we will match the real index to
what was committed, so we will _lose_ the index entry for B
before the second edit you explicitly told git to remember by
saying 'update-index'.

On the other hand, in your original sequence:

	$ edit A B
        $ git update-index A B
        $ git commit -o B

B being committed would be different between HEAD and index, but
that is what we are going to commit anyway, so after this
commit, B will be in sync with the updated HEAD.

To put it in another way, "commit -o" is a short-hand for people
who do not want to run update-index themselves (IOW, people who
just want to use git without worrying about the index file).  If
you use update-index to mark "this is what I want to commit"
yourself, you should do so consistently.  If you are not ready
to commit A but you want to commit B, do not mark both of them
and expect "commit -o" to do magic fixups.
