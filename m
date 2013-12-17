From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/3] prune_object_dir(): verify that path fits in the temporary buffer
Date: Tue, 17 Dec 2013 14:43:57 +0100
Message-ID: <1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 14:44:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsuwr-0003YA-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 14:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626Ab3LQNoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 08:44:30 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42342 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753270Ab3LQNo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 08:44:28 -0500
X-AuditID: 1207440f-b7f306d000006d99-1d-52b0553bc2ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.CB.28057.B3550B25; Tue, 17 Dec 2013 08:44:27 -0500 (EST)
Received: from michael.fritz.box (p57A24733.dip0.t-ipconnect.de [87.162.71.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBHDiIKu024888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Dec 2013 08:44:26 -0500
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqGsduiHIoG+ZmUXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGecnj+VpaCTvWLzqjNsDYzn
	WLsYOTkkBEwkJpzezgRhi0lcuLeerYuRi0NI4DKjxOW7V5kgnONMEn0vWsA62AR0JRb1NIN1
	iAioSUxsO8QCYjMLOEhs/tzICGILC4RJ7H/0D6yGRUBV4tizN8wgNq+Ai8SLi0/YILYpSOy7
	dBKshlPAVeLHnY9gthBQTeOneawTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvN
	LNFLTSndxAgJFv4djF3rZQ4xCnAwKvHwbpixPkiINbGsuDL3EKMkB5OSKO9Zlw1BQnxJ+SmV
	GYnFGfFFpTmpxYcYJTiYlUR4HwQC5XhTEiurUovyYVLSHCxK4rzqS9T9hATSE0tSs1NTC1KL
	YLIyHBxKErwqIUCNgkWp6akVaZk5JQhpJg5OEMEFsoEHaMPNYJANxQWJucWZ6RBFpxgVpcR5
	nUEmCIAkMkrz4AbA4voVozjQP8K8CiBVPMCUANf9CmgwE9Dg52vWgQwuSURISTUwzkudoly6
	6dvMmFOCbl3bVx30utcRHdxw2+qEgNc7g4yL07VKrdhfM7pL/rk+ecPGS11v9foudShP7zyZ
	ZsXRKbRratvFmwZW78v3M991VW//vpVxy+Q97648e5S5XrB944bYlyveW/sl2QSdtpBctM4h
	Ovvz2xUp5d1bPicLbXtQ7TF5UtnZJUosxRmJhlrMRcWJANfT/yvGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239382>

Dimension the buffer based on PATH_MAX rather than a magic number, and
verify that the path fits in it before continuing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I don't think that this problem is remotely exploitable, because the
size of the string doesn't depend on inputs that can be influenced by
a client (at least not within Git).

 builtin/prune.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 6366917..ae34d04 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -96,7 +96,9 @@ static void prune_object_dir(const char *path)
 {
 	int i;
 	for (i = 0; i < 256; i++) {
-		static char dir[4096];
+		static char dir[PATH_MAX + 1];
+		if (strlen(path) + 3 > PATH_MAX)
+			die("impossible object directory");
 		sprintf(dir, "%s/%02x", path, i);
 		prune_dir(i, dir);
 	}
-- 
1.8.5.1
