From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/20] safe_create_leading_directories_const(): preserve errno
Date: Tue, 16 Feb 2016 14:22:14 +0100
Message-ID: <1ff7b215e37593e935d8db81ea43c3c864161f71.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhT-0002YS-3c
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbcBPN3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:29:51 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48652 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932280AbcBPN3t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:29:49 -0500
X-AuditID: 12074414-89fff70000005020-ce-56c322a71072
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 58.1E.20512.7A223C65; Tue, 16 Feb 2016 08:22:47 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfON028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:45 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLtc6XCYwdNlEhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8aW9ruMBTvZKrrXvmBqYFzM2sXIySEhYCJxdu1b
	9i5GLg4hga2MEocmTmOGcE4wSXx4/IENpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPAI0aJrv3b
	GUESwgJ+Er/+z2MBsVkEVCXeLukHa+AViJJYs3E5C8Q6OYmWH7vBVnMKWEicbOkFiwsJmEvc
	+bKHaQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYIUEmsoPxyEm5
	Q4wCHIxKPLwcHofChFgTy4orcw8xSnIwKYny8nAfDhPiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wvvvFVA5b0piZVVqUT5MSpqDRUmc99tidT8hgfTEktTs1NSC1CKYrAwHh5IE7ydFoKGCRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoCiILwbGAUiKB2hvGkg7b3FBYi5QFKL1FKMu
	x4Ift9cyCbHk5eelSonz7gcpEgApyijNg1sBSymvGMWBPhbm7Qap4gGmI7hJr4CWMAEtybkE
	8lxxSSJCSqqBUepGdoJFR3mgOnv9ruQJN3qfyp3n+By1/lKbwEnZpXuWfOo6dFY1dn3olVPS
	LzRS32e1bFrZwPp92pnHcoYx4gdn7zYyK27x9V61fNqq3NJzj/b25M932mFQVuWe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286368>

Theoretically, free() is allowed to change errno. So preserve the errno
from safe_create_leading_directories() across the call to free().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index aab1872..568120e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -164,10 +164,14 @@ enum scld_error safe_create_leading_directories(char *path)
 
 enum scld_error safe_create_leading_directories_const(const char *path)
 {
+	int save_errno;
 	/* path points to cache entries, so xstrdup before messing with it */
 	char *buf = xstrdup(path);
 	enum scld_error result = safe_create_leading_directories(buf);
+
+	save_errno = errno;
 	free(buf);
+	errno = save_errno;
 	return result;
 }
 
-- 
2.7.0
