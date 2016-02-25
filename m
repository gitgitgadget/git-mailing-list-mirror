From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/20] safe_create_leading_directories_const(): preserve errno
Date: Thu, 25 Feb 2016 14:16:00 +0100
Message-ID: <1ff7b215e37593e935d8db81ea43c3c864161f71.1456405698.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:23:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvtU-00086n-0A
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760677AbcBYNXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:23:42 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44253 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760665AbcBYNXl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:23:41 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2016 08:23:41 EST
X-AuditID: 12074414-8b3ff70000005020-33-56cefeae5eb0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 28.15.20512.EAEFEC65; Thu, 25 Feb 2016 08:16:30 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrf024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:29 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLv+37kwg5fvWS3mbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owt7XcZC3ayVXSvfcHUwLiYtYuRk0NCwERiwbb3
	7F2MXBxCAlsZJb6+XgXlnGCS6H2/hx2kik1AV2JRTzMTiC0ioCYxse0QC0gRs8AjRomu/dsZ
	QRLCAoESO3bdABvLIqAqce/zWTCbVyBK4tG2vVDr5CRafuwGszkFLCQunpzODGILCZhLrLqx
	h30CI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCFBJrKD8chJuUOM
	AhyMSjy8Eb/PhgmxJpYVV+YeYpTkYFIS5d3z/FyYEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
	FX+BcrwpiZVVqUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErybQBoFi1LTUyvS
	MnNKENJMHJwgw7mkRIpT81JSixJLSzLiQVEQXwyMA5AUD9DeXLC9xQWJuUBRiNZTjLocC37c
	XsskxJKXn5cqJc5rBFIkAFKUUZoHtwKWUl4xigN9LMy7DqSKB5iO4Ca9AlrCBLRk5gawJSWJ
	CCmpBkaR9Y9/WmU9COyvyvlVLv50rVbnabXUkKfndKfypsmGlEgFdbaVb9l+7cikk7MUUmL8
	s3PtgxvcQ0qycpPqjFpO+wecDXPmarBsVVx3wfC/6cafmxmuXJU5r3ZuR4vVpg7x 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287385>

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
