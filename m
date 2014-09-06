From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 07/32] hold_lock_file_for_append(): release lock on errors
Date: Sat,  6 Sep 2014 09:50:21 +0200
Message-ID: <1409989846-22401-8-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnI-0000CU-66
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbaIFHwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:16 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55657 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852AbaIFHwI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:08 -0400
X-AuditID: 1207440e-f79da6d0000002fc-73-540abd2743f6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.BD.00764.72DBA045; Sat,  6 Sep 2014 03:52:07 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH6006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:06 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqKu+lyvEYMtJE4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujFvL5rEUdLFXXFjYy97AeIy1i5GTQ0LAROLHgv/sELaYxIV769m6
	GLk4hAQuM0pMOryPFcI5xiTx9FE/M0gVm4CuxKKeZiaQhIhAG6PEroubwUYxC6RIdDzvZgSx
	hQV8JaZtvwM0loODRUBVYtKPDJAwr4CLxOtrK6C2yUls2P0frJxTwFVielMnmC0EVNN+sp9p
	AiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxghgca3g7F9vcwhRgEO
	RiUe3kIHrhAh1sSy4srcQ4ySHExKorx5y4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHg7JgPl
	eFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvC57gBoFi1LTUyvSMnNK
	ENJMHJwgw7mkRIpT81JSixJLSzLiQbERXwyMDpAUD9BeVpB23uKCxFygKETrKUZjjpamt71M
	HOs6v/UzCbHk5eelSonzMoGUCoCUZpTmwS2CpZhXjOJAfwvzioFU8QDTE9y8V0CrmIBWmadz
	gqwqSURISTUwTpHaEdDGcGDBm0QF9wvtKq6bTc80/XzSlj133wHjFw/tV6dFPptwh/3ac64/
	H3/M2zb9oVOvnlvAq9ne6/kTuMw//f93oNorRn5KeXJoUzvb5b6LZjOXsZWFOmm9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256554>

If there is an error copying the old contents to the lockfile, roll
back the lockfile before exiting so that the lockfile is not held
until process cleanup.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index d4f165d..983c3ec 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -219,13 +219,13 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 		if (errno != ENOENT) {
 			if (flags & LOCK_DIE_ON_ERROR)
 				die("cannot open '%s' for copying", path);
-			close(fd);
+			rollback_lock_file(lk);
 			return error("cannot open '%s' for copying", path);
 		}
 	} else if (copy_fd(orig_fd, fd)) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
-		close(fd);
+		rollback_lock_file(lk);
 		return -1;
 	}
 	return fd;
-- 
2.1.0
