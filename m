From: Alex Riesen <raa.lkml@gmail.com>
Subject: t7300 "removal failure" broken on Windows
Date: Tue, 26 Feb 2008 21:22:27 +0100
Message-ID: <20080226202227.GA1245@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 21:23:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU6KS-0003xV-SE
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 21:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbYBZUWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 15:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbYBZUWb
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 15:22:31 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:50178 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYBZUWa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 15:22:30 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSlDOQ=
Received: from tigra.home (Fa882.f.strato-dslnet.de [195.4.168.130])
	by post.webmailer.de (fruni mo52) (RZmta 16.8)
	with ESMTP id B0731ak1QI22ej for <git@vger.kernel.org>;
	Tue, 26 Feb 2008 21:22:27 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9B329277BD
	for <git@vger.kernel.org>; Tue, 26 Feb 2008 21:22:27 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3853056D24; Tue, 26 Feb 2008 21:22:27 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75167>

Just a heads-up.

The test is fails because it uses "chmod 0" to enforce an error while
deleting files by "git clean -f -d". This does not work on windows,
because the directories even without write permission on them can be
freely modified (the contained names can be removed). Maybe even the
removal of list permission does not mean a thing either to cygwin or
windows (that last one being more likely the case: it is more wrong).

So git-clean succeeds and the test fails.

It probably can be worked around by opening the file and keeping it open.

The patch below may fix it (haven't tested yet).

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 3840364..85341af 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -320,6 +320,7 @@ test_expect_success 'removal failure' '
 
 	mkdir foo &&
 	touch foo/bar &&
+	exec <foo/bar &&
 	chmod 0 foo &&
 	! git clean -f -d
 
