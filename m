From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/33] refname_is_safe(): insist that the refname already be normalized
Date: Fri,  6 May 2016 18:13:49 +0200
Message-ID: <e40f3557f7e767bd2be2a824bc3bc2379aa69931.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:16:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiQG-0000eH-3n
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbcEFQP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:59 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48392 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758607AbcEFQOk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:40 -0400
X-AuditID: 12074414-63fff700000008e6-c6-572cc2eb808c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B1.12.02278.BE2CC275; Fri,  6 May 2016 12:14:35 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUo031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:34 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqPv6kE64weQeOYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8aNR4uZC1o5Kqa2XmRsYJzB1sXIySEhYCJx8c12
	li5GLg4hga2MEsfeN0E5x5kkJm/ezAxSxSagK7Gop5kJxBYRiJBoeNXC2MXIwcEs8JlRYiU3
	SFhYIEri79kHYOUsAqoSByZ8B1vACxRfuriDHWKZnMTl6Q/A4pwCFhKHeo+DjRQSMJfoWHuD
	fQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYIQEmsoPxyEm5Q4wC
	HIxKPLwZJ7XDhVgTy4orcw8xSnIwKYnyfi/QCRfiS8pPqcxILM6ILyrNSS0+xCjBwawkwntl
	H1CONyWxsiq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCtxkYSUKCRanpqRVp
	mTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoAiILwbGAEiKB2gvH0g7b3FBYi5QFKL1FKMux5H9
	99YyCbHk5eelSonzzj0IVCQAUpRRmge3ApZOXjGKA30szHsZpIoHmIrgJr0CWsIEtOT9XE2Q
	JSWJCCmpBsb0b7Jrb+4/av1rgdv8HNkc5de1v0LXFKYXOX3Z+CImj9H3NWfFg4UFj3Im+ijF
	psxOn/AjTUX315njboZ3FuXv5OCqyw5v9v04eWZxueOpO42WzD5KL/bL9/qcc+P+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293825>

The reference name is going to be compared to other reference names, so
it should be in its normalized form.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index ca0280f..b18d995 100644
--- a/refs.c
+++ b/refs.c
@@ -125,14 +125,19 @@ int refname_is_safe(const char *refname)
 	if (skip_prefix(refname, "refs/", &rest)) {
 		char *buf;
 		int result;
+		size_t restlen = strlen(rest);
+
+		/* rest must not be empty, or start or end with "/" */
+		if (!restlen || *rest == '/' || rest[restlen - 1] == '/')
+			return 0;
 
 		/*
 		 * Does the refname try to escape refs/?
 		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
 		 * is not.
 		 */
-		buf = xmallocz(strlen(rest));
-		result = !normalize_path_copy(buf, rest);
+		buf = xmallocz(restlen);
+		result = !normalize_path_copy(buf, rest) && !strcmp(buf, rest);
 		free(buf);
 		return result;
 	}
-- 
2.8.1
