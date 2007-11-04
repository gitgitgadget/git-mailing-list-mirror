From: Paul Mackerras <paulus@samba.org>
Subject: Why is --pretty=format: so slow?
Date: Sun, 4 Nov 2007 14:42:54 +1100
Message-ID: <18221.16318.785162.44769@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 04:43:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoWOX-0001Z7-Em
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 04:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891AbXKDDnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 23:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756930AbXKDDnP
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 23:43:15 -0400
Received: from ozlabs.org ([203.10.76.45]:37988 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750AbXKDDnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 23:43:15 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2DE44DDE1D; Sun,  4 Nov 2007 14:43:13 +1100 (EST)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63339>

For some reason, using --pretty=format:... with git log is much slower
than other formats.  For example, on the kernel tree (on my quad G5):

$ time git log --pretty=oneline >/dev/null

real    0m2.165s
user    0m2.092s
sys     0m0.070s

$ time git log --pretty=raw >/dev/null

real    0m2.426s
user    0m2.358s
sys     0m0.068s

$ time git log --pretty="format:%H" >/dev/null

real    0m7.843s
user    0m6.282s
sys     0m1.557s

$ time git log --pretty="format:%H {%P} %ct" >/dev/null

real    0m7.950s
user    0m6.374s
sys     0m1.573s

Strace seems to indicate that git log is doing at least one sequence
of open, fstat64, fcntl64, getdents64 and close for each line of
output in the --pretty=format: cases, but not in the other cases.
This seems rather unnecessary - could it be fixed?  I'd like to use
the last format listed above with gitk, but not if it is going to make
things 3 times slower.

Paul.
