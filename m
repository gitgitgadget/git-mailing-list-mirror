From: Junio C Hamano <junkio@cox.net>
Subject: Resetting paths
Date: Thu, 09 Feb 2006 20:40:15 -0800
Message-ID: <7vlkwjzv0w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 10 05:40:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Q51-0002xH-V0
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 05:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWBJEkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 23:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWBJEkS
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 23:40:18 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25065 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750929AbWBJEkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 23:40:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210043725.OLAB17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 23:37:25 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15864>

While working on "assume unchanged" git series, I found one
thing missing from the current set of tools.

While I worked on parts of the system that deals with the cached
lstat() information, I needed a way to debug that, so I hacked
ls-files -t option to show entries marked as "always matches the
index" with lowercase tag letters.  This was primarily debugging
aid hack.

Then I committed the whole thing with "git commit -a" by
mistake.  In order to rewind the HEAD to pre-commit state, I can
say "git reset --soft HEAD^", but after doing that, now I want
to unupdate the index so that ls-files.c matches the pre-commit
HEAD.

"git reset --mixed" is a heavy-handed tool for that.  It reads
the entier index from the HEAD commit without touching the
working tree, so I would need to add the modified paths back
with "git update-index".

The low-level voodoo to do so for this particular case is this
single liner:

	git ls-tree HEAD ls-files.c | git update-index --index-info

Have people found themselves in similar need like this?  This
could take different forms.

 * you did "git update-index" on a wrong path.  This is my
   example and the above voodoo is a recipe for recovery.

 * you did "git add" on a wrong path and you want to remove it.
   This is easier than the above:

	git update-index --force-remove path

 * you did the above recovery from "git add" on a wrong path,
   and you want to add it again.  The same voodoo would work in
   this case as well.

	git ls-tree HEAD path | git update-index --index-info

We could add "git reset path..." to reduce typing for the above,
but I am wondering if it is worth it.

BTW, this shows how "index centric" git is.  With other SCM that
has only the last commit and the working tree files, you do not
have to worry any of these things, so it might appear that index
is just a nuisance.  But if you do not have any "registry of
paths to be committed", you cannot do a partial commit like what
I did above ("commit changes to all files other than
ls-files.c") without listing all the paths to be committed, or
fall back on CVS style "one path at a time", breaking an atomic
commit, so there is a drawback for not having an index as well.
