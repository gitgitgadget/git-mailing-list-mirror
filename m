From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH v2] build: avoid possible confusion between GNU/XPG4 make on Solaris
Date: Fri,  2 Mar 2012 11:18:24 +0100
Message-ID: <abe2c43575849e612b17a1e6a6f8eb33db9623b8.1330683426.git.stefano.lattarini@gmail.com>
References: <4F5095D6.6050401@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 11:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3PZQ-0007xX-A1
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 11:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab2CBKSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 05:18:35 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39505 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab2CBKSe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 05:18:34 -0500
Received: by eaaq12 with SMTP id q12so539044eaa.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 02:18:33 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.14.99.204 as permitted sender) client-ip=10.14.99.204;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.14.99.204 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.14.99.204])
        by 10.14.99.204 with SMTP id x52mr5667067eef.7.1330683513252 (num_hops = 1);
        Fri, 02 Mar 2012 02:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WLfQ90x8QgCa7u+MdBxrbV6aZ9IO/PLU8RKSg5VCtAM=;
        b=TxIkQE2ybOprEFBsApnDKjxkfeoXkzqYdrwrMhC+7/UKhOuU+wXWpmihxIknSx0OWG
         OJc9kXrP5/Tvc7N4M+Qq3KIyGU3tWX6JJciyS5s7Ub2bx4C/uIJWSN+z0APTYi1ftEnX
         PXsvkT2mhPOdAKXq8nstHKjHHM5RbMwx316r2no241NZE/OJNt55LCk+LvChi0iUo6Dt
         z+AytnHmNXddPrxLyjo1xN7gZ3ef+MqTaVYAQbOWk0j98eEEDtvEd4sQVBXBTwK4YnH2
         bDfRolFCVUhGfNNavf3eB6gkAGfoJTXfd84csgzXkq0fP2eXAVaq5U0VOUnLLF+1P4p3
         IWrQ==
Received: by 10.14.99.204 with SMTP id x52mr4362088eef.7.1330683513173;
        Fri, 02 Mar 2012 02:18:33 -0800 (PST)
Received: from localhost.localdomain (host25-99-dynamic.20-79-r.retail.telecomitalia.it. [79.20.99.25])
        by mx.google.com with ESMTPS id r5sm18676693eef.6.2012.03.02.02.18.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 02:18:32 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <4F5095D6.6050401@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192020>

On a Solaris 10 system with Solaris XPG4 make installed as /usr/xpg4/bin/make,
GNU make installed as /usr/local/bin/make, and with /usr/local/bin appearing
in $PATH *before* /usr/xpg4/bin, I was seeing errors like this upon invoking
"make all":

        SUBDIR perl
    make: Warning: Ignoring DistributedMake -o option
    Usage : make [ -f makefile ][ -K statefile ]...
    make: Fatal error: Unknown option `-C'

This happens because the Git's Makefiles, when running on Solaris, sanitize
$PATH by prepending /usr/xpg6/bin and /usr/xpg4/bin to it, but in the setup
described above such a behaviour has the unintended consequence of forcing
the use of Solaris make in recursive make invocations, even if the $(MAKE)
macro is being correctly used in them; this happens because, in that setup,
the original GNU make process was invoked simply as "make".

To avoid such an issue, we instruct our Makefile to redefine $(MAKE) to
point to the absolute path of the originally-invoked make program.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 Makefile |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index e4f8e0e..e71d688 100644
--- a/Makefile
+++ b/Makefile
@@ -303,6 +303,21 @@ ifdef MSVC
 	uname_O := Windows
 endif
 
+# This Makefile will possibly sanitize PATH by prepending system-specific
+# directories to it (e.g., /usr/xpg4/bin on Solaris).  This can become
+# problematic for recursive make invocations, if one of those directories
+# contains a "make" program and the user has called GNU make by simply
+# invoking "make" (this can happen e.g. when GNU make has been installed
+# as /usr/local/bin/make).  To avoid such issues, we redefine $(MAKE) to
+# point to the absolute path of the originally-invoked make program.
+original_MAKE := $(MAKE)
+MAKE := $(shell command -v $(firstword $(original_MAKE)) 2>/dev/null)
+ifeq ($(MAKE),)
+	MAKE := $(original_MAKE)
+else
+	MAKE += $(wordlist 2,$(words $(original_MAKE)),$(original_MAKE))
+endif
+
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
-- 
1.7.9
