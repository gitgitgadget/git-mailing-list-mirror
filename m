From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 08/38] hold_lock_file_for_append(): release lock on errors
Date: Wed,  1 Oct 2014 12:28:12 +0200
Message-ID: <1412159322-2622-9-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBW-0003Kl-RD
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbaJAK3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:06 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62614 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445AbaJAK3E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:04 -0400
X-AuditID: 12074412-f792e6d000005517-5d-542bd76fda4b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id ED.1A.21783.F67DB245; Wed,  1 Oct 2014 06:29:03 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk67026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:02 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1M2/rh1i8GmHoUXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3Bnrv19kKtjLXrH0Vxt7A+MX1i5G
	Tg4JAROJRxd6WCBsMYkL99azdTFycQgJXGaU2PzxGpRznEli0arFTCBVbAK6Eot6msFsEQE1
	iYlth1hAipgFFjNJTDi0iQ0kISzgK3F+3w5mEJtFQFXi7stbYCt4BZwlTuzeyQyxTk5iw+7/
	jCA2p4CLxPLLzWA1QkA1O+58ZZrAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5m
	iV5qSukmRkg4Cu1gXH9S7hCjAAejEg+vQoJ2iBBrYllxZe4hRkkOJiVR3kWXgEJ8SfkplRmJ
	xRnxRaU5qcWHGCU4mJVEeLMPAOV4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFk
	ZTg4lCR4Ga4BNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoiO+GBgfICkeoL3O
	IO28xQWJuUBRiNZTjMYcLU1ve5k41nV+62cSYsnLz0uVEucNvQpUKgBSmlGaB7cIloheMYoD
	/S3MGw4ykAeYxODmvQJaxQS0KnkN2KqSRISUVANjaEruxHnbH6WsPKR122nytC6zj89mB8zW
	/7uOMzJRRSUtIkpJ0rv46/LKmUmXdvfsYv9akML+8GAek8KsxLBPm/y3+3o9jf4Q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257734>

If there is an error copying the old contents to the lockfile, roll
back the lockfile before exiting so that the lockfile is not held
until process cleanup.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index d74de8d..f4ce79b 100644
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
