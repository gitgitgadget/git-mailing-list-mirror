From: John Ellson <ellson@research.att.com>
Subject: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Fri, 30 Dec 2005 12:29:10 -0500
Message-ID: <dp3qpb$7uk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 30 18:30:35 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsO5D-0000rd-0j
	for gcvg-git@gmane.org; Fri, 30 Dec 2005 18:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVL3R3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 12:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVL3R3o
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 12:29:44 -0500
Received: from main.gmane.org ([80.91.229.2]:10916 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750871AbVL3R3n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2005 12:29:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EsO4P-0000ga-OY
	for git@vger.kernel.org; Fri, 30 Dec 2005 18:29:37 +0100
Received: from h-135-207-24-103.research.att.com ([135.207.24.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Dec 2005 18:29:37 +0100
Received: from ellson by h-135-207-24-103.research.att.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Dec 2005 18:29:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h-135-207-24-103.research.att.com
User-Agent: Mail/News 1.5 (X11/20051129)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14113>

Problem:

	ellson@ellson:git> make rpm
	GIT_VERSION = 1.0.6-g58e3
	sed -e 's/@@VERSION@@/1.0.6-g58e3/g' < git.spec.in > git.spec
	./git-tar-tree HEAD git-1.0.6-g58e3 > git-1.0.6-g58e3.tar
	tar rf git-1.0.6-g58e3.tar git-1.0.6-g58e3/git.spec
	gzip -f -9 git-1.0.6-g58e3.tar
	rpmbuild -ta git-1.0.6-g58e3.tar.gz
	error: line 3: Illegal char '-' in version: Version:    1.0.6-g58e3
	make: *** [rpm] Error 1


Suggested fix:  Use '_' instead of '-'

There is probably a cleaner implementation of the fix, but this works for me.

----------------------------------------


diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 845b9dc..e4e0ab1 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,7 +3,9 @@
  GVF=GIT-VERSION-FILE

  VN=$(git-describe --abbrev=4 HEAD 2>/dev/null) || VN=v1.0.GIT
-VN=$(expr "$VN" : v'\(.*\)')
+VN1=$(expr "$VN" : '[^-]*-\(.*\)')
+VN=$(expr "$VN" : v'\([^-]*\)')
+test "$VN1" = "" || VN="$VN"_"$VN1"
  if test -r $GVF
  then
         VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)


--------------------------------------------


Signed-off-by: John Ellson <ellson@research.att.com>
