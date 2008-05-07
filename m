From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] compat/fopen.c: avoid clobbering the system defined fopen
 macro
Date: Wed, 07 May 2008 12:34:18 -0500
Message-ID: <4821E81A.4030600@nrlssc.navy.mil>
References: <7vfxsudrt0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 19:37:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtnZC-00070A-TT
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 19:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762106AbYEGRf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 13:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761910AbYEGRf0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 13:35:26 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33465 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765230AbYEGRfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 13:35:19 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m47HYJtK022464;
	Wed, 7 May 2008 12:34:19 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 May 2008 12:34:19 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7vfxsudrt0.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 07 May 2008 17:34:19.0164 (UTC) FILETIME=[945365C0:01C8B068]
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81465>

Some systems define fopen as a macro based on compiler settings.
The previous technique for reverting to the system fopen function
by merely undefining fopen is inadequate in this case. Instead,
avoid defining fopen entirely when compiling this source file.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 compat/fopen.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/compat/fopen.c b/compat/fopen.c
index ccb9e89..b5ca142 100644
--- a/compat/fopen.c
+++ b/compat/fopen.c
@@ -1,5 +1,16 @@
+/*
+ *  The order of the following two lines is important.
+ *
+ *  FREAD_READS_DIRECTORIES is undefined before including git-compat-util.h
+ *  to avoid the redefinition of fopen within git-compat-util.h. This is
+ *  necessary since fopen is a macro on some platforms which may be set
+ *  based on compiler options. For example, on AIX fopen is set to fopen64
+ *  when _LARGE_FILES is defined. The previous technique of merely undefining
+ *  fopen after including git-compat-util.h is inadequate in this case.
+ */
+#undef FREAD_READS_DIRECTORIES
 #include "../git-compat-util.h"
-#undef fopen
+
 FILE *git_fopen(const char *path, const char *mode)
 {
 	FILE *fp;
-- 
1.5.5
