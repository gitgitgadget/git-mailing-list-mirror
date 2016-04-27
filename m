From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/29] refname_is_safe(): insist that the refname already be normalized
Date: Wed, 27 Apr 2016 18:57:22 +0200
Message-ID: <a8e1e1a9e6a48fbb20fab2144279b93a48db584a.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnB-0003f6-6w
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbcD0Q6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:13 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:63723 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752916AbcD0Q6L (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:11 -0400
X-AuditID: 12074412-52fff700000009f7-c3-5720efa32441
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A1.66.02551.3AFE0275; Wed, 27 Apr 2016 12:58:11 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6I022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:09 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLv4vUK4wYkP/BbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxL23+wFTznrJh6YjJTA+MV9i5GTg4JAROJ9Wu3
	MXcxcnEICWxllJgxtYEdwjnOJLFsyzlGkCo2AV2JRT3NTCC2iICDxPKVv8CKmAWamCS+L29i
	AUkIC4RLvF83AcxmEVCVWPPjKjOIzSsQJbH6ykJWiHVyEpenP2ADsTkFLCS+tL4FWyAkYC6x
	5MFq9gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihASZ0A7G9Sfl
	DjEKcDAq8fAWSiiEC7EmlhVX5h5ilORgUhLlXXIWKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	d/oboBxvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeHkgTv0XdAjYJFqemp
	FWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKIgvBsYBSIoHaG8pSDtvcUFiLlAUovUUo6KU
	OO8CkIQASCKjNA9uLCx1vGIUB/pSmPcCSBUPMO3Adb8CGswENPjyIVmQwSWJCCmpBkZViZsK
	j5R5zYNvxfNknsmpC5uv+/+W8vZync/rDOSdmCpjIrmd50r+3CTHU1D+My3ow4XdqZubD+/Y
	Kt224627x7ZbqiLu5q137t3w1jjVb6NyUS1oyZcrOlN39ftK27sXChbx3bb75nvu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292749>

The reference name is going to be compared to other reference names, so
it should be in its normalized form.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Does anybody have a use case for allowing un-normalized reference
names like "refs/foo/../bar///baz"? I'm pretty certain they would not
be handled correctly anyway, especially if they are not stored as
loose references.

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
