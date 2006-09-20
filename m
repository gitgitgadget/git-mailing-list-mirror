From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 09:06:11 -0700
Message-ID: <7vac4ujzf0.fsf@assigned-by-dhcp.cox.net>
References: <20060919232851.GA12195@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:07:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4aW-0008Ow-Bv
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWITQGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbWITQGN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:06:13 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8090 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751705AbWITQGM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:06:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920160612.VCMJ6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 12:06:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qg5y1V0011kojtg0000000
	Wed, 20 Sep 2006 12:05:58 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27357>

Shawn Pearce <spearce@spearce.org> writes:

> The --mirror-all option to git-fetch can be used to obtain a copy of
> every available remote ref into the current repository.  This can be
> a rather destructive update as the local repository will have its
> HEAD ref overwritten, as well as any ref which it shares in common
> with the remote repository.

I can sort of see where something like this is very much useful,
but it sounds like a tool quite different from git-fetch.

 (1) I really do not like rolling this kind of speciale purpose
     command into git-fetch, which is frequently used by end
     users, to avoid mistakes.

     If there is reluctance against adding yet another new
     command (and there certainly is), this feels more like a
     cousin of "git-clone --bare".

 (2) Although there is no inherent reason not allowing a working
     tree associated with the repository that is kept updated
     this way, the user will be utterly confused in a working
     tree whose current branch head is updated like this, until
     the working tree and the index is matched to the updated
     HEAD.  It might be reasonable to run checkout -f HEAD when
     a working tree is associated with the repository (the
     command is screwing over even the current branch HEAD, so
     losing what happened to be in the working tree is really
     not an issue), but as a much easier safety measure we might
     want to allow this mode of updating only on a bare
     repository (that is, .git/index should not exist).

 (3) This feels primarily meant for something like Pasky is
     trying to run --- mirrored distribution point of git
     repositories perhaps displayed with gitweb.  When updating
     such a repository, you would want to do things like running
     update-server-info and automatically repacking the object
     store.  Especially the latter would be an interesting topic
     (the archive vs active repacking strategy we talked about,
     combined with set of packs with staggered spans to help
     commit walkers Pasky talked about quite a while ago).


> ... 
> such as if you are providing Git repository hosting and mirroring
> source repositories on other systems.
>
> Currently local refs are not deleted even if they do not exist in the
> remote repository.  This may be taken as either a feature or a bug.

For that purpose I would say that is definitely a bug.
