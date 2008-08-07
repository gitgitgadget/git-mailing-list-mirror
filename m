From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: GIT-VERSION-GEN gives "-dirty" when file metadata changed
Date: Thu, 07 Aug 2008 21:35:17 +0200
Message-ID: <sjj6zt28jy9qy7y8@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Gerrit Pape <pape@smarden.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 22:20:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRBxx-00006m-Ke
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 22:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbYHGUTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 16:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbYHGUTF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 16:19:05 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:52599 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753071AbYHGUTE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Aug 2008 16:19:04 -0400
Received: (qmail 27349 invoked from network); 7 Aug 2008 20:19:01 -0000
Received: from unknown (HELO ethlife-a) (127.0.0.1)
  by localhost with SMTP; 7 Aug 2008 20:19:01 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91601>

Hello,

Today I've created custom Debian packages from Git for the first time (yes I know there are Debian packages already, I'm doing it so that I can patch Git and still have the convenience of a package system), using the 1.6.0.rc2 checkout, and using my normal procedure to build debian source packages (running "dpkg-buildpackage -uc -us -b -rfakeroot" as non-root user). The resulting binary reported for --version the string "1.6.0.rc2-dirty"; I wondered why, since I didn't have uncommitted changes neither in the working dir nor in the index. I found that the GIT-VERSION-GEN script would check for a clean working directory by checking that "git diff-index --name-only HEAD --" does not report any files, and since this is now running under the control of the fakeroot process, all files had owner 
 and group 0, whereas in reality (when I made the checkout) they had a non-root uid/gid. This made diff-index report all files, and hence give the "-dirty" version.

I'll followup this mail with two variants of a patch which runs "git update-index --refresh" before that check, which solves the issue. Patch A just does it always, patch B does it only if the metadata check failed; I've created the latter with the idea in mind that update-index might be too costly in some situation (here it's fast but I don't know about people without much RAM).

Perhaps not many people are building Git with the help of fakeroot, but I don't see why the patch would hurt either, and it seems to me like it's implementing the correct behaviour (metadata changes could also happen should anyone or some build process move or copy the files to another place before building, or similar). I don't know whether the Debian Git package maintainer had another solution, but maybe his packages are simply being built as root without the help of "fakeroot" (cc to him for information).

Christian.
