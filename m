From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 36/38] hold_lock_file_for_append(): restore errno before returning
Date: Wed,  1 Oct 2014 12:28:40 +0200
Message-ID: <1412159322-2622-37-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAS-0002pF-S0
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbaJAK3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:53 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62641 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751771AbaJAK3v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:51 -0400
X-AuditID: 12074412-f792e6d000005517-a7-542bd79fdf09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A4.2A.21783.F97DB245; Wed,  1 Oct 2014 06:29:51 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6Z026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:49 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1J1/XTvEYPlbTouuK91MFg29V5gt
	nsy9y2zx9uYSRovbK+YzW/xo6WG2+DehxqKz4yujA4fH3/cfmDx2zrrL7rFgU6nHw1dd7B7P
	evcwely8pOzxeZOcx+1n21gCOKK4bZISS8qCM9Pz9O0SuDP+bF3AXHCds2L95P/sDYyn2bsY
	OTkkBEwkdj55xgZhi0lcuLceyObiEBK4zCix4dFvJpCEkMBxJom7001BbDYBXYlFPc1gcREB
	NYmJbYdYQBqYBRYzSUw4tAlskrBAqMSD3f+ZQWwWAVWJE7dmgdm8Ai4Sxy+cYIbYJiexYfd/
	RhCbEyi+/HIzC8QyZ4kdd74yTWDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NE
	LzWldBMjJBiFdjCuPyl3iFGAg1GJh1chQTtEiDWxrLgy9xCjJAeTkijvoktAIb6k/JTKjMTi
	jPii0pzU4kOMEhzMSiK82QeAcrwpiZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIy
	HBxKErwM14AaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGxEV8MjA6QFA/QXmeQ
	dt7igsRcoChE6ylGXY51nd/6mYRY8vLzUqXEeUOvAhUJgBRllObBrYClnleM4kAfC/OGg4zi
	AaYtuEmvgJYwAS1JXgO2pCQRISXVwHiQSTDHvrFpY5NV97wdrwu3Mht0N7hevPzbi2/eCkNj
	4fIa4enHRFJPtcwVbPDx0WI4/UlHPut8ZLBs0Za83EUiNYFnb665cGBnUeGX2Rr8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257718>

Callers who don't pass LOCK_DIE_ON_ERROR might want to examine errno
to see what went wrong, so restore errno before returning.

In fact this function only has one caller, add_to_alternates_file(),
and it *does* use LOCK_DIE_ON_ERROR, but, you know, think of future
generations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index c51c6ec..b2f5d36 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -243,15 +243,22 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	orig_fd = open(path, O_RDONLY);
 	if (orig_fd < 0) {
 		if (errno != ENOENT) {
+			int save_errno = errno;
+
 			if (flags & LOCK_DIE_ON_ERROR)
 				die("cannot open '%s' for copying", path);
 			rollback_lock_file(lk);
-			return error("cannot open '%s' for copying", path);
+			error("cannot open '%s' for copying", path);
+			errno = save_errno;
+			return -1;
 		}
 	} else if (copy_fd(orig_fd, fd)) {
+		int save_errno = errno;
+
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
 		rollback_lock_file(lk);
+		errno = save_errno;
 		return -1;
 	}
 	return fd;
-- 
2.1.0
