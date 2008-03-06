From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/5] Add 'df_name_compare()' helper function
Date: Thu, 06 Mar 2008 14:03:56 +0100
Message-ID: <8563w03sxv.fsf@lola.goethe.zz>
References: <cover.1204777699.git.torvalds@linux-foundation.org>
	<b1cd18fa986c63bea6d0a20ac580b993e5fffaa2.1204777699.git.torvalds@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 16:32:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXI4j-0003yD-Uj
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 16:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbYCFPb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 10:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbYCFPb2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 10:31:28 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:36551 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbYCFPb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 10:31:27 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.67)
	(envelope-from <dak@gnu.org>)
	id 1JXI43-0004G2-3L; Thu, 06 Mar 2008 10:31:23 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 18BD01C162C1; Thu,  6 Mar 2008 14:03:55 +0100 (CET)
In-Reply-To: <b1cd18fa986c63bea6d0a20ac580b993e5fffaa2.1204777699.git.torvalds@linux-foundation.org>
	(Linus Torvalds's message of "Wed, 5 Mar 2008 18:25:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76394>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This new helper is identical to base_name_compare(), except it compares
> conflicting directory/file entries as equal in order to help handling DF
> conflicts (thus the name).
>
> Note that while a directory name compares as equal to a regular file
> with the new helper, they then individually compare _differently_ to a
> filename that has a dot after the basename (because '\0' < '.' < '/').

Uh, that screams just bloody murder at me with regard to working on
sorted material.  You'll never even get into the situation where the
conflicting "equal" entries will be compared if you presorted them with
something in between.  Consider the case of a merge of

A:
blubb
blubb.hi

B:
blubb.hi
blubb/

Any traversal that is done reasonably efficiently will never compare
blubb to blubb/ and I don't see how to get around this.

Basically, I think you need a special traversal routine.  This routine
will push all non-directory entries during a parallel traverse into a
might-conflict-queue, appending a slash in the course.  The front of
this queue then gets compared with the next processed entry.  If it is
larger, it is kept at the front, if it is equal, the conflict gets
treated/resolved, if it is smaller, it gets popped (since it can't
conflict anymore).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
