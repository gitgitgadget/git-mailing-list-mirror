X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] commit: Steer new users toward "git commit -a" rather than update-index
Date: Tue, 14 Nov 2006 15:30:25 -0800
Message-ID: <7vfyclwqr2.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 23:30:41 +0000 (UTC)
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455A1137.8030301@shadowen.org> (Andy Whitcroft's message of
	"Tue, 14 Nov 2006 18:55:51 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31392>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk7jc-0003Lo-9b for gcvg-git@gmane.org; Wed, 15 Nov
 2006 00:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966465AbWKNXa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 18:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966476AbWKNXa2
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 18:30:28 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16304 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S966465AbWKNXa1
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 18:30:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114233026.UIKM296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 18:30:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mnWY1V00f1kojtg0000000; Tue, 14 Nov 2006
 18:30:33 -0500
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

> Are we sure this isn't porcelain-ish?  We need to use it in merge
> conflict correction and the like?  You can't use git-commit there as a
> replacement.  I'd expect it to be 'git update-index' rather than
> 'git-update-index' of course.

I think status should be taken as Porcelain-ish so it should
notice more about the environment to see why the user has
changed but not updated files and recommend the possible action
depending on the context.

For that, you would need to enumerate what kind of 'context'
there could be with the current set of tools.  Here is a
strawman.

 1. None of the below.
 2. A merge was attempted and resulted in a conflict.
 3. An am or rebase without --merge was attempted and
    resulted in a conflict or patch rejection.
 4. A "rebase --merge was attempted and resulted in a conflict.

In the normal case, the next user action would be:

 1-1. The user wants that change in the next commit, and should
      run "git update-index $that_path" to prepare the index for
      partial commit, or "git commit -a" to commit all the
      changes made to the working tree so far.  Carl's patch
      helps the user in this case.

 1-2. The user realizes that the some of the changes in the
      working tree were not desirable, and "git checkout --
      $that_path" to revert them before continuing.  Before
      deciding to revert, the user may want to check what the
      difference is by running "git diff -- $that_path" so
      suggesting these two might also be helpful.

 1-3. The user wants to keep that change a strictly local change
      in the working tree (this is often very useful and making
      "commit -a" the default will not be acceptable unless
      there is a very compelling reason to do so).  This means
      the suggestion we would make should clearly be
      _suggestion_.

The earlier wording was bad in that it suggested to use a
Plumbing command update-index, but was attempting to convey that
it was merely a conditional suggestion by saying "use it TO MARK
FOR COMMIT", implying that if the user does not want to mark
them for commit, it is Ok not to use update-index.

When a merge is in progress, we would have .git/MERGE_HEAD and
that would be the way to tell case 2.  In that case, the next
user action would be:

 2-1. The user resolves conflicts and marks them as resolved,
      with update-index (or "git mark-resolved"), to prepare the
      index for the merge commit.  But this is not done for
      "Changed but not updated" files but "unmerged" files.  We
      should strongly suggest not to do _anything_ to "Changed
      but not updated" files here.

 2-2. The user decides this conflict is too much to handle right
      now, and abandones the change by "git reset --hard".  This
      would lose the local changes ("Changed but not updated"),
      so we should suggest to save the change before doing so.

	If you are going to abandone this merge with "reset
	--hard", your changes to these files will be lost.  You
	can save them with "git diff HEAD -- $this_path
	$that_path..."

      which is probably too long for that part of the output but
      that is what we would want to say if we want to be
      helpful.

When either rebase without --merge or am is in progress, there
would be .dotest/ directory (whose name could be changed but I
think this was a mistake and we would be better off using fixed
names for this kind of application) for git-status to notice.
The next user action would be:

 3-1. The user resolves the conflict or manually apply the
      patch, update-index the paths involved and proceeds with
      "rebase --continue" or "am --resolved".  "Changed but not
      updated" paths should not be touched in this case,
      similarly to 2-1.

 3-2. The user gives up.  Same as 2-2.

Designing for the "rebase --merge" case and coming up with other
cases are left as exercise to the list for further discussion.

