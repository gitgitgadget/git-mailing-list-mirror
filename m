From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git-rev-parse master` not referred to by any ref?
Date: Sun, 26 Aug 2007 14:26:28 -0700
Message-ID: <7vir72ng1n.fsf@gitster.siamese.dyndns.org>
References: <20070826134521.GA20243@fieldses.org>
	<20070826135251.GB20243@fieldses.org>
	<20070826140645.GC20243@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 23:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPPcw-0005Ak-NZ
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 23:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbXHZV0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 17:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbXHZV0a
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 17:26:30 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38288 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbXHZV03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 17:26:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070826212629.QHKH11280.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 26 Aug 2007 17:26:29 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id glSU1X00S1gtr5g0000000; Sun, 26 Aug 2007 17:26:28 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56737>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>> Oops, found it:
>> 
>> 	git$ cat .git/master
>> 	407c0c87e15b3cf60347f4fc0bcdb4d239de4163

It _might_ make it safer to refuse creating anything outside
refs/ if the name does not contain or ends with "HEAD" (or
perhaps names that have chars outside "[_A-Z]"), but that would
restrict future tools that might want to have HEAD-like files,
so I am a bit hesitant.

OTOH, a random file under .git/ does not count as a ref for the
purposes of fsck/prune, so it may make sense to teach 
check_ref_format() about the same set of "special" names that
can appear directly under .git without being in refs/ hierarchy
(currently I think only "HEAD" and possibly "ORIG_HEAD" are in
that set).

BTW, git-merge.sh and git-reset.sh should use "git update-ref ORIG_HEAD"
instead of doing it by hand using "echo >$GIT_DIR/ORIG_HEAD".

Also, I *think* objects that are only reachable via ORIG_HEAD
are not considered as reachable by fsck/prune --- we probably
would want to fix this.
