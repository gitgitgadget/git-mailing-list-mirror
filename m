From: Wincent Colaiuta <win@wincent.com>
Subject: Installation failure caused by CDPATH environment variable
Date: Wed, 11 Jul 2007 18:59:23 +0200
Message-ID: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 19:12:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8fjc-0002p5-KD
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 19:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbXGKRMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 13:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbXGKRMN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 13:12:13 -0400
Received: from wincent.com ([72.3.236.74]:41247 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbXGKRMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 13:12:12 -0400
X-Greylist: delayed 741 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2007 13:12:12 EDT
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l6BGxd3h019158
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 11:59:48 -0500
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52177>

This week I've installed Git on two different machines and one of  
them mysteriously failed making the "install" target in the  
"templates/Makefile". Specifically, the problem was occuring here:

         (cd blt && $(TAR) cf - .) | \
         (cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)

And the error message was:

tar: This does not look like a tar archive
tar: Skipping to next header
tar: Error exit delayed from previous errors

Upon investigation, I discovered that the cause was that on the  
failing machine, the CDPATH environment variable was set and included  
"." (the current directory). This meant that upon executing:

         (cd blt && $(TAR) cf - .)

The data from tar was getting prepended with garbage because "cd blt"  
was echoing the path to the directory.

The workaround is to "unset CDPATH" or change the value of CDPATH so  
that it doesn't include the "." (although the latter is not very  
feasible because without "." at the front of CDPATH changing into a  
directory relative to the current directory can be quite painful).

What do you think about altering the templates/Makefile to make it  
more robust against this kind of environment?

Here's a possible patch:

 From 057630bdcfeee63b90468d1a69153171b15780c0 Mon Sep 17 00:00:00 2001
From: Wincent Colaiuta <win@wincent.com>
Date: Wed, 11 Jul 2007 18:43:59 +0200

[PATCH] Proof Makefile against possible problems with CDPATH environment

If the CDPATH environment variable is set and contains a period
Bash may echo the current directory name while performing a cd,
and when this extra output is piped to tar as part of template
installation it can cause tar to abort with an error. This patch
avoids this problem by invoking cd as a separate step prior to
invoking tar.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
  templates/Makefile |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/templates/Makefile b/templates/Makefile
index aaa39d3..3457ccb 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -46,5 +46,6 @@ clean:

  install: all
         $(INSTALL) -d -m755 '$(DESTDIR_SQ)$(template_dir_SQ)'
-       (cd blt && $(TAR) cf - .) | \
+       cd blt && $(TAR) cf - . | \
         (cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)
+       cd -
-- 
1.5.2.3
