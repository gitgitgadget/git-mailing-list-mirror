From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Wed, 11 Jul 2007 14:26:16 -0700
Message-ID: <7vps2y3a4n.fsf@assigned-by-dhcp.cox.net>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu> <f72hu8$65g$1@sea.gmane.org>
	<20070711185644.GA3069@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jiN-0007v9-8M
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757705AbXGKV0o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755676AbXGKV0o
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:26:44 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61272 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbXGKV0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:26:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711212618.HHCH1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:26:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMSG1X00U1kojtg0000000; Wed, 11 Jul 2007 17:26:17 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52210>

Jan Hudec <bulb@ucw.cz> writes:

> If index matches any of that, but the working tree version does not match any
> parent, the index entry should be removed (which currently isn't -- that's
> the proposed change), but the file left in wokring tree. That would make
> git-add + git-rm get you right back where you started, with nothing in index
> and unversioned file in working tree.

Don't think of 'rm' as inverse of 'add'.  That would only
confuse you.

A natural inverse of 'add' is 'un-add', and that operation is
called 'rm --cached', because we use that to name the option to
invoke an "index-only" variant of a command when the command can
operate on index and working tree file (e.g. "diff --cached",
"apply --cached").

A life of a file that does _not_ make into a commit goes like
this:

	[1]$ edit a-new-file

This is 'create', not 'add'.  git is not involved in this step.

	[2]$ git add a-new-file

This is 'add'; place an existing file in the index.  When you do
not want it in the index, you 'un-add' it.

	[3]$ git rm --cached a-new-file

This removes the entry from the index, without touching the
working tree file.  If you do not want that file at all (as
opposed to, "I am making a series of partial commits, and the
addition of this path does not belong to the first commit of the
series, so I am unstaging"), this is followed by

	[4]$ rm -f a-new-file

Again, git is not involved in this step.

The thing is, people sometimes want to have steps 3 and 4
combined, and it meshes well with the users' expectation when
they see the word "rm".  Think of "git rm" without "--cached" as
a shorthand to do 3 and 4 in one go to meet that expectation.

Obviously, we cannot usefully combine steps 1 and 2.  We could
have "git add --create a-new-file" launch an editor to create a
new file, but that would not be very useful in practice.

The fact that steps 3 and 4 can be naturally combined, but steps
1 and 2 cannot be, makes "add" and "rm" not inverse of each
other.
