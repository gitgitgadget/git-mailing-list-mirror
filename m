From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 37/39] hold_lock_file_for_append(): restore errno before returning
Date: Fri, 26 Sep 2014 12:08:37 +0200
Message-ID: <1411726119-31598-38-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSTL-0004Bi-RN
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202AbaIZKJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:53 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61750 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755809AbaIZKJu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:50 -0400
X-AuditID: 12074414-f79446d000001f1d-ec-54253b6e3d15
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.0F.07965.E6B35245; Fri, 26 Sep 2014 06:09:50 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMM013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:49 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1M2zVg0xOHdU2qLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ow/WxcwF1znrFg/+T97A+Np9i5G
	Tg4JAROJQ2/uMULYYhIX7q1n62Lk4hASuMwo0X9nHiuEs4lJ4tL57UwgVWwCuhKLeprBbBEB
	NYmJbYdYQIqYBRYzSUw4tIkNJCEsECpx41Q72FgWAVWJaacng8V5BVwlFhzshVonJ7Fh938w
	mxMo3rj9GpgtJOAi0bJ+MssERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RS
	U0o3MULCUWQH45GTcocYBTgYlXh4b6xTCRFiTSwrrsw9xCjJwaQkyvvFQjVEiC8pP6UyI7E4
	I76oNCe1+BCjBAezkgjvHSOgHG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwM
	B4eSBO9mK6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFB0xBcD4wMkxQO0tx2k
	nbe4IDEXKArReopRl2Nd57d+JiGWvPy8VClx3iOWQEUCIEUZpXlwK2DJ5xWjONDHwrzHQUbx
	ABMX3KRXQEuYgJYoHVEGWVKSiJCSamAs/C4wLW1y1udL/hslzZI4tF4KNXeuK9/JZ3MuRnFf
	WVSJuZ8606cUjsL5F0O2uzba5EYk601ZbOP5dSa7dv7Kz0p7steVTfx20d1yu7Wm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257517>

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
