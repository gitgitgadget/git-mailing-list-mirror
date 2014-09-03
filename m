From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH] Makefile: add NO_CLOCK_GETTIME check
Date: Wed,  3 Sep 2014 12:14:47 -0700
Message-ID: <1409771687-5597-1-git-send-email-reubenhwk@gmail.com>
Cc: reubenhwk@gmail.com, karsten.blees@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 21:16:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPG2G-0000Lp-Od
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 21:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbaICTPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 15:15:41 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:44022 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbaICTPk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 15:15:40 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so18367885pab.0
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xStEd2xrmVyJFgePWrL0onRjYb9FgV+vrjFgfwiAWIs=;
        b=Jk9tB1eBhgvgEzho0F+xS2WoDIb+NIVkbT4DKxA11FhW3u6uqOy6hw25mKhZrWo66X
         EsgAciYTe/GwgTOA9YSZDkM39BzwvrApNjt2jR5x4ngLbtoFGiewusLXU95EcLOjt+TK
         Nb8i50z4AqdrXSCqpR0FD/jNTHrt1T7qfBpL38uHR9J8F968ES9a5WClvQdH/fIJXv+X
         XukulmYwivwCHXIcEs3lTFtyx0VbZ3Gw4kCAVPO7Al5l5DHq70W2BiQrxyaJgfZbpOIA
         kMCtRnQ2vo+BohhlkPQQGBGCFWaikQDyO99RzzFg5wAbsJkW6fFP0o54z1217DsXXxrm
         8ivA==
X-Received: by 10.70.91.208 with SMTP id cg16mr60556735pdb.91.1409771735917;
        Wed, 03 Sep 2014 12:15:35 -0700 (PDT)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id gw1sm7533325pbd.63.2014.09.03.12.15.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Sep 2014 12:15:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256402>

Some really old platforms, rhel3, which don't define CLOCK_MONOTONIC, still
need a way to build git.  Some high resolution timer code was added Jul 12,
2014 to aid debugging performance issues.  That code uses clock_gettime and
CLOCK_MONOTONIC.  That change breaks building git on ancient platforms which
don't support CLOCK_MONOTONIC, so a way to disable that code is needed.

To use this feature...

$ make NO_CLOCK_GETTIME=1

This change amends the commit...

 commit 148d6771bf5e00aa1d7fa2221507a3dfe4c1e37f
 Author: Karsten Blees <karsten.blees@gmail.com>
 Date:   Sat Jul 12 02:05:42 2014 +0200

  trace: add high resolution timer function to debug performance issues
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 9f984a9..0c1c8cf 100644
--- a/Makefile
+++ b/Makefile
@@ -1502,10 +1502,12 @@ ifdef GMTIME_UNRELIABLE_ERRORS
 	BASIC_CFLAGS += -DGMTIME_UNRELIABLE_ERRORS
 endif
 
+ifndef NO_CLOCK_GETTIME
 ifdef HAVE_CLOCK_GETTIME
 	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
 	EXTLIBS += -lrt
 endif
+endif
 
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
-- 
1.9.1
