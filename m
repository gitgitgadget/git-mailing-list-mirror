From: Junio C Hamano <junkio@cox.net>
Subject: pack-objects and rev-list status updates
Date: Wed, 06 Sep 2006 02:38:16 -0700
Message-ID: <7vveo172t3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 06 11:38:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKtrP-0000kk-Iz
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 11:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWIFJiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 05:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWIFJiP
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 05:38:15 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50309 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750740AbWIFJiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 05:38:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906093812.NCYW6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 Sep 2006 05:38:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jxe51V00o1kojtg0000000
	Wed, 06 Sep 2006 05:38:05 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26511>

Tonight's "master" has an update to teach git-rev-list to read
list of rev arguments from its standard input.  We owe Andy
Whitcroft a big credit for starting this topic.

This required splitting out part of setup_revision() and make it
callable from the side.  Thanks to this split, it got a lot easier
to teach pack-objects to do a similar trick.  I did a few:

 - Earlier patch I sent to give command line parameters similar
   to rev-list to pack-objects was reworked on.  I chose to feed
   rev arguments from its standard input; so

	echo master..next | pack-objects --revs --stdout

   would do what you would expect.

 - A patch before that one to add --unpacked=<existing pack>
   option was resurrected and further reworked on.  Now you can
   say,

	rev-list --objects --unpacked=$active --all |
        pack-objects $new

   and/or

	pack-objects --unpacked=$active --all $new </dev/null

   The </dev/null at the end is ugly but the command always
   reads from its standard input.  Unlike the "something like
   this?" patch, this version can take more than one such
   "pretend things in these packs are unpacked" arguments.

 - I also told pack-objects to understand --thin, so you can do
   a thin pack this:

	echo master..next | pack-objects --thin --stdout

   The equivalent expressed in the old way is:

	rev-list --objects-edge master..next |
        pack-objects --stdout

   Note that --thin is only usable with --stdout, as before.

Andy has a patch to use "rev-list --stdin" to lift the exec
arguments limit from send-pack; I tweaked it slightly and tested
it minimally.  I think the logical next step would be to use
"pack-objects --stdin" there and lose another pipe and a process.

We also should be able to do the same for upload-pack.  Now the
groundwork is more or less done, I think this is a good exercise
for a wannabe git hacker.  Hint hint...

I do not expect to be working on git tomorrow (Wednesday my
time), so I will not be merging any of the above (except the
"rev-list --stdin" change) in "next" tonight (eh, it is already
Wednesday wee morning), but they will appear in "pu".
