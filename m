From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/17] rename_tmp_log(): on SCLD_VANISHED, retry
Date: Mon,  6 Jan 2014 14:45:35 +0100
Message-ID: <1389015935-21936-18-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:47:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AW2-0006PI-Ns
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbaAFNql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:41 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50609 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459AbaAFNqi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:38 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-52-52cab3bd7e06
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 91.B9.18966.DB3BAC25; Mon,  6 Jan 2014 08:46:37 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfPI021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:36 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLt386kgg873EhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa7py1gc2D1+Pv+A5PHzll32T0uXlL2eDzxBKvH501yAaxR3DZJiSVlwZnp
	efp2CdwZc/8+ZC14w1axadtLlgbGI6xdjJwcEgImEtfebmSEsMUkLtxbzwZiCwlcZpR49EC7
	i5ELyD7GJHHk3AGwBjYBXYlFPc1MILaIgJrExLZDLCBFzAKLGSW6pn0DmyQs4CyxZ8VXsEks
	AqoS3/teg9m8Aq4Sbzc8A6rhANqmILH6uhBImBMoPG3aYajFLhJrDj1imcDIu4CRYRWjXGJO
	aa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSEjx7mD8v07mEKMAB6MSD6/Hs5NBQqyJ
	ZcWVuYcYJTmYlER5OVefChLiS8pPqcxILM6ILyrNSS0+xCjBwawkwsu1ACjHm5JYWZValA+T
	kuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgNdkE1ChYlJqeWpGWmVOCkGbi4AQRXCAb
	eIA2KIAU8hYXJOYWZ6ZDFJ1iVJQS5xUExq+QAEgiozQPbgAs+l8xigP9I8xrA9LOA0wccN2v
	gAYzAQ0OjQMbXJKIkJJqYHRKzWz9Ui+3WW/2kcnld+4rCr9czz2ZzSZH+NF3VYu0GtYfb5xi
	Wp7EfpHfNVHGrvjk+d+bfk25G7zH73jc8rz1bT9+sDzb5Dbp66qHadP+Bc3v+32w4uk7AYF9
	L7a0TVNdXFPDe9Ny0eovLusqJWYLBnotFpBKTfuwZ3ngPrHwY3G+6bmZ29KVWIoz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240004>

If safe_create_leading_directories() fails because a file along the
path unexpectedly vanished, try again from the beginning.  Try at most
3 times.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 490525a..810f802 100644
--- a/refs.c
+++ b/refs.c
@@ -2533,7 +2533,14 @@ static int rename_tmp_log(const char *newrefname)
 	int attempts = 4;
 
  retry:
-	if (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
+	switch (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
+	case SCLD_OK:
+		break; /* success */
+	case SCLD_VANISHED:
+		if (--attempts > 0)
+			goto retry;
+		/* fall through */
+	default:
 		error("unable to create directory for %s", newrefname);
 		return -1;
 	}
-- 
1.8.5.2
