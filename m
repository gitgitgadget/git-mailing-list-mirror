From: Junio C Hamano <junkio@cox.net>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 12:00:07 -0700
Message-ID: <7vhd596ua0.fsf@assigned-by-dhcp.cox.net>
References: <4430D352.4010707@vilain.net>
	<7vsloucuxk.fsf@assigned-by-dhcp.cox.net>
	<4431B60E.3030008@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 21:00:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQqlI-000278-Dc
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 21:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWDDTAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 15:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWDDTAP
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 15:00:15 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25028 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750733AbWDDTAO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 15:00:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404190009.QDIU20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Apr 2006 15:00:09 -0400
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <4431B60E.3030008@vilain.net> (Sam Vilain's message of "Tue, 04
	Apr 2006 11:55:58 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18405>

I was re-reading the hydra stuff and realized I've seen the "a
cap that bundles independent tracks together" pattern somewhere
else in the history of git.

It is very similar to how "bind commit" would have worked.

With hydra, you keep independently mergeable tracks and bundle
their tips together:

    ---o--+
    ---o--+--*
    ---o--+

and advancement of each individual track is bundled together by
uncapping and recapping:

    ---o--o--+
    ---o--o--+--*
    ---o-----+

So a hydra cap would record:

 - the result "tree" of the (trivial) merge of the bundled tips;
 - the commit object name of the tips.

A "bind commit" proposal was made to support subprojects living
in their own subdirectories.  The picture to describe the commit
ancestry chain would be almost the same as the above picture,
except that it did not uncap and recap, but would have built its
own ancestry chain.

It had two different kinds of commit relationships: parenthood
and directory structure binding.  The component subprojects
lived in their own subdirectories (so if you are maintaining an
embedded Linux along with matching toolchain, you would have linux/
subdirectory that has the kernel hierarchy, gcc/, libc/, ...),
and commit objects had "bind commit-sha1 subdirectory-name"
lines to express how the components are bundled together.  A
commit object would have looked like this:

	tree fc9957b0052df6a8248420395bc9febd66194252
        parent 052df6a8248420395bc9febd66194252fc9957b0
        bind f6a8248420395bc9febd66194252fc9957b0052d linux/
        bind 20395bc9febd66194252fc9957b0052df6a82484 gcc/
	author A U Thor <author@example.com> 1144111304 -0700
        ...

The "parent" line is the commit ancestry as usual, and each
"bind" line names a commit object of component project and where
in the directory hierarchy the tree for that commit object would
be checked out.  The "tree" line records the result of grafting
the subprojects together.  So, for example, ls-tree -d fc9957
linux in the above example would have shown the tree object
f6a824^{tree}.

The structure forbid you from binding two separate projects at
the same directory in order to enforce clean separation of
subprojects, but if you allow multiple commits to be bound at
the root level, that could be used as a hydra cap.

I've done changes to support this at the core level; I think I
still have the code around somewhere (and the net never forgets
;-), so if you are interested you might want to take a look.

The trickest part was to tell rev-list --objects to work
sensibly so that an ancestry chain that contains this kind of
commits can be fetched and pushed.  The code unfortunately was
done before recent rev-list renovation so merging it to the
current codebase needs some understanding of how rev-list is
supposed to work, though.
