From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 06/32] lockfile: unlock file if lockfile permissions cannot be adjusted
Date: Sat,  6 Sep 2014 09:50:20 +0200
Message-ID: <1409989846-22401-7-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAu4-00052k-74
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbaIFH7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:20 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59873 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849AbaIFH7T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:19 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2014 03:59:19 EDT
X-AuditID: 1207440f-f79156d000006a5c-2c-540abd265c95
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 69.1B.27228.62DBA045; Sat,  6 Sep 2014 03:52:06 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH5006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:05 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqKu2lyvEoH2/lEXXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi86Or4wObB5/339g8nj4qovd41nvHkaPi5eUPT5vkvO4/WwbSwBb
	FLdNUmJJWXBmep6+XQJ3xv2FUxkL2tkrZnw8xN7AeIq1i5GTQ0LARGLNpLNQtpjEhXvr2boY
	uTiEBC4zSlxpXg+WEBI4xiRx6nsCiM0moCuxqKeZCaRIRKCNUWLXxc1gRcwCKRIdz7sZQWxh
	gSiJm79PsYHYLAKqEmdebAWL8wq4SNy6cI4dYpucxIbd/8HinAKuEtObOhkhlrlItJ/sZ5rA
	yLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkig8e9g7Fovc4hRgINR
	iYe3wIErRIg1say4MvcQoyQHk5Iob95yoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3o7JQDne
	lMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvjd1AjYJFqempFWmZOSUI
	aSYOTpDhXFIixal5KalFiaUlGfGg2IgvBkYHSIoHaO9ZkHbe4oLEXKAoROspRmOOlqa3vUwc
	6zq/9TMJseTl56VKifMy7QEqFQApzSjNg1sESzGvGMWB/hbmvQ8ykAeYnuDmvQJaxQS0yjyd
	E2RVSSJCSqqBMX9dSvC1q7/jZMxmrH4T2pxQtazZvYq/8cCh1uq0VcufWD1g0FpdsWE7d2Ld
	l/yqs0+rxJYyaM9boHhLpEz+Z8nB5R5i4ZenmLfppX0NsFtmVvbu+cFDEy03NIka 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256567>

If the call to adjust_shared_perm() fails, lock_file returns -1, which
to the caller looks like any other failure to lock the file.  So in
this case, roll back the lockfile before returning so that the lock
file is deleted immediately and the lockfile object is left in a
predictable state (namely, unlocked).  Previously, the lockfile was
retained until process cleanup in this situation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lockfile.c b/lockfile.c
index b1c4ba0..d4f165d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -153,6 +153,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			int save_errno = errno;
 			error("cannot fix permission bits on %s",
 			      lk->filename);
+			rollback_lock_file(lk);
 			errno = save_errno;
 			return -1;
 		}
-- 
2.1.0
