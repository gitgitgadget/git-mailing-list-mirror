From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Libify diff-files.
Date: Sat, 22 Apr 2006 03:52:00 -0700
Message-ID: <7vfyk5khm7.fsf@assigned-by-dhcp.cox.net>
References: <7vbqutlxwq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Sat Apr 22 22:44:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXOxU-0004Zv-HY
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWDVUnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWDVUnl
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:43:41 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17106 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750914AbWDVUnk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:43:40 -0400
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MAr76H029750
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 10:53:09 GMT
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422105201.JOXK24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 06:52:01 -0400
To: git@vger.kernel.org
In-Reply-To: <7vbqutlxwq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 22 Apr 2006 03:14:45 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19057>

I noticed that there are two flags related to missing working
tree files in diff-files and diff-index.  The former takes -q
to mean "do not report lossage of working tree files", and the
latter uses -m to mean "when not using --cached, pretend that
missing working tree files are actually present and match the
index".

Being able to pretend missing working tree files are unchanged
was originally done to help merging in a separate temporary
area, and it is useful, but I wish we used the same flag.  I
started wondering if we can unify them to '-q', since '-m'
means "do not ignore merges" in diff-tree context (including
log and whatchanged).

NOTE. -q is different from specifying --diff-filter=ACMRTU;
while the former does not even feed the filepair to diffcore,
the latter tells the diffcore to filter deletion out in the
output phase.  The distinction makes huge difference when the
rename/copy detection, especially without --find-copies-harder,
is involved.

Now, as far as I can tell, nobody uses "diff-files -q".  Cogito
uses "diff-index -m" quite a bit, but I suspect large part of it
is remnant from the days it did a merge in a separate directory,
and/or a cut-and-paste error from neighbouring "diff-tree -m -r".

A cursory look suggests some could even be bugs.  For example,
cg-patch has

	diff-tree -m -r "$commitparent" "$commitid"

(where -m does not have any effect) which is immediately
followed by a

	diff-index -m -r HEAD

where -m may or may not be intended.
