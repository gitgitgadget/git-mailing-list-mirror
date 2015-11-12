From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] http: fix some printf format warnings
Date: Thu, 12 Nov 2015 00:07:42 +0000
Message-ID: <5643D84E.2070904@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 01:07:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwfQg-00005D-MS
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 01:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbKLAHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 19:07:50 -0500
Received: from avasout04.plus.net ([212.159.14.19]:60533 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbKLAHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 19:07:49 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout04 with smtp
	id gQ7k1r0042GQ2gJ01Q7lRR; Thu, 12 Nov 2015 00:07:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=W-DkS_-wva5Ft8jEB14A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281209>


Commit f8117f55 ("http: use off_t to store partial file size",
02-11-2015) changed the type of some variables from long to off_t.
Unfortunately, the off_t type is not portable and can be represented
by several different actual types (even multiple types on the same
platform). This makes it difficult to print an off_t variable in
a platform independent way. As a result, this commit causes gcc to
issue some printf format warnings on a couple of different platforms.

In order to suppress the warnings, change the format specifier to use
the PRIuMAX macro and cast the off_t argument to uintmax_t. (See also
the http_opt_request_remainder() function, which uses the same
solution).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 http.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 42f29ce..2532976 100644
--- a/http.c
+++ b/http.c
@@ -1617,8 +1617,8 @@ struct http_pack_request *new_http_pack_request(
 	if (prev_posn>0) {
 		if (http_is_verbose)
 			fprintf(stderr,
-				"Resuming fetch of pack %s at byte %ld\n",
-				sha1_to_hex(target->sha1), prev_posn);
+				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
+				sha1_to_hex(target->sha1), (uintmax_t)prev_posn);
 		http_opt_request_remainder(preq->slot->curl, prev_posn);
 	}
 
@@ -1772,8 +1772,8 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	if (prev_posn>0) {
 		if (http_is_verbose)
 			fprintf(stderr,
-				"Resuming fetch of object %s at byte %ld\n",
-				hex, prev_posn);
+				"Resuming fetch of object %s at byte %"PRIuMAX"\n",
+				hex, (uintmax_t)prev_posn);
 		http_opt_request_remainder(freq->slot->curl, prev_posn);
 	}
 
-- 
2.6.0
