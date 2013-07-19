From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 1/4] Cygwin 1.7 has trustable filemode
Date: Fri, 19 Jul 2013 19:08:27 -0400
Message-ID: <1374275310-22388-1-git-send-email-mlevedahl@gmail.com>
References: <51E9C69F.7080309@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 20 01:08:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Jmz-0004aS-80
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 01:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab3GSXIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 19:08:37 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:32815 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab3GSXIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 19:08:36 -0400
Received: by mail-qe0-f49.google.com with SMTP id cz11so2707737qeb.36
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IzOFdW3v6xoPrTSJEsgZ6X3KOOM2aENnG0XSlMKRTnk=;
        b=Hs5bL/5zdAijpcAufCoeYSHwXYESspiSu5qtC0Ory29ZnC9agVYkBGinRTnH2kMwTQ
         cI+1X6UPgtk93WygGeij3rCkVoha3rzZFlCK5O8s6UlV5yDteFDbsaZRMeoAQk3z10OZ
         VtLQ9xUtHHuwnKn/ARbnrSIOe9fsHx3d+fSdNB3TJ/TEoRxfiynVfVoSW7yCYBQJv6n7
         7PVB3XV/PiI342PO0cR54YgyFeUyIGXnfzTn2esKK9E3MhqNX9Ne8pYjB9sNykiDPTE+
         w4z83uInCEq3vszbr/FxSN6I5H59e/zhhm6CZqA3uCH+PbdJ8m9Kvzo7EZr5vxi4LiLY
         /Gig==
X-Received: by 10.49.13.40 with SMTP id e8mr19401929qec.79.1374275315776;
        Fri, 19 Jul 2013 16:08:35 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id s9sm22498999qeo.3.2013.07.19.16.08.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 16:08:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
In-Reply-To: <51E9C69F.7080309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230859>

The current Cygwin 1.7 distribution on supported Windows versions provides
complete support for POSIX filemodes, so enable this by default. git as
distributed by the Cygwin project is configured this way. Cygwin 1.5
installations are less likely to have this support, so leave the old
default in place for those.

This fixes one testsuite failure:
t3300 test 17 (diff-index -M -p with mode change quotes funny filename)

Historical notes: Cygwin version 1.7 supports Windows-XP and newer, thus
dropped support for all OS variants that lack NTFS and/or the full win32
api, and since late 1.5 development, Cygwin maps POSIX modes to NTFS ACLs
by default.  Cygwin 1.5 supports OS variants that use FAT as the native
file system, and had optional methods for providing POSIX file modes on
top of FAT12/16 and NTFS, though not FAT32.  Also, support for POSIX modes
on top of FAT were dropped later in 1.5.  Thus, POSIX filemode support
is not expected by default on a Cygwin 1.5 installation, but is expected
by default on a 1.7 installation.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 7ac541e..104dc44 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -158,12 +158,12 @@ ifeq ($(uname_O),Cygwin)
 		NO_MKSTEMPS = YesPlease
 		NO_SYMLINK_HEAD = YesPlease
 		NO_IPV6 = YesPlease
+		NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 		OLD_ICONV = UnfortunatelyYes
 	endif
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
-- 
1.8.3.2.0.13
