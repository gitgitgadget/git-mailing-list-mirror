From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Move code resolving packed refs into its own function.
Date: Sun, 01 Oct 2006 02:58:03 -0700
Message-ID: <7vodsw2w9g.fsf@assigned-by-dhcp.cox.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
	<7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
	<200610010606.32561.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 11:58:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTy5Q-0004F8-3z
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 11:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWJAJ6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 05:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWJAJ6H
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 05:58:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15268 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751698AbWJAJ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 05:58:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061001095804.PRGF21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sun, 1 Oct 2006 05:58:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Uxy61V00Z1kojtg0000000
	Sun, 01 Oct 2006 05:58:07 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <200610010606.32561.chriscool@tuxfamily.org> (Christian Couder's
	message of "Sun, 1 Oct 2006 06:06:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28174>

Christian Couder <chriscool@tuxfamily.org> writes:

> Junio C Hamano wrote:
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> > This patch move Linus' packed refs resolving code from
>> > "resolve_ref" into a new "resolve_packed_ref" extern
>> > function so that it can be reused when needed.
>>
>> I think we are stepping on each other's toes.  How far into the
>> process of making correct branch deletion are you?
>
> I am not farther than the 2 patches I sent yesterday (before going to bed).

Thanks.  I just did not want to waste your work with overlapping
duplicated efforts.

I think what we have in "next" tonight is in a more-or-less
testable shape, although it has still a long way to reach
"master".  Things I know we need to address:

 - I've updated lock_ref_sha1_basic() to remove empty left-over
   directories and to notice conflicts between 'foo/bar' vs
   'foo' when creating a new ref, hopefully in the same spirit
   as your patch to safe_create_leading_directories(), but done
   differently (safe_... function is meant to be used anywhere
   not just $GIT_DIR/refs/, and it felt wrong for it to take
   exception for packed refs).  We should do the same for the
   reflog hierarchy but we currently don't.

 - We need to audit our shell scripts to make sure they do not
   depend on being able to look directly into $GIT_DIR/refs to
   see if the ref they are interested in exists.  I've fixed a
   few in git-fetch while handling the patch to clean up its
   output from Santi, but I would not be surprised if there are
   more.  The code in git-branch and git-tag to list what's
   there are Ok; they use "rev-parse --symbolic --all/--tags".

 - I think gitweb should be Ok; it does peek-remote on the
   repository.  Although we would probably want to update
   git_get_references and git_get_refs_list sub to use
   for-each-ref there, that can be done as a later optimization.

 - Dumb transports are not aware of packed refs on the remote
   side.  The underlying commit walkers (anything that links
   with fetch.c) needs their fetch_ref() implementation updated
   to look at the packed-refs file from the remote side and we
   should be fine after that.  I haven't looked at rsync
   transport but the change necessary there shouldn't be too
   involved.
