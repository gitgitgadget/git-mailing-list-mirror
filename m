From: David Turner <dturner@twopensource.com>
Subject: [PATCH] http.c: use CURLOPT_RANGE for range requests
Date: Fri, 30 Oct 2015 18:41:28 -0400
Message-ID: <1446244888-32610-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 23:42:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsIN6-00014Y-AP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 23:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759637AbbJ3Wll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 18:41:41 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35467 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758258AbbJ3Wlk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 18:41:40 -0400
Received: by qgbb65 with SMTP id b65so73528108qgb.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=DP1UwuKQ+r1upt6aq/22lfFCYJVwetxvnSK6xyk374o=;
        b=Jxq3PS29uHezd7r4k1ofNE12cRI82TWddhTXbolMlP677xczQ5LB+0Zxt2ZpftgYhW
         v3NVRZxvKdkx/X2xWzyJ+IBvFLoYn49OWhlTkQ03bZDDOJS6vzXRVASmf26nP6eM8Bxd
         tLhp5nks40FEI71JgUMKgfxlBYBR+8b6Ao+eZihmJkYAXoVTl+5HAQADCycatMA4mNpt
         +8CZMexBbNXmrD+QHghmvTDmCHyqQuJnsd0J58c1mq8r7SjQxZYDKjpxBijXnv+coZEh
         k1ZsZnNKGl5/MdRsfp2IXs5wFaxGL1YZ+4leamoGuwD3BhgcjkDgAb0Jjz1WH5QW3S8S
         65KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DP1UwuKQ+r1upt6aq/22lfFCYJVwetxvnSK6xyk374o=;
        b=igXi9DCh15df1OyZLJkrCMkuHFXQWLJO7pQbnD4pmFfYwq4+rU3Xw0//zgzgbbLNzx
         /dSYhgrmETjPmUIiDiwctpW5DRvdTVhL1IGZBSapY8lEjvKWBoOG/tqC36FmcemR+QqK
         jNNbB46Zwha1f396l4cacRzFcjILckWh5W4NH615zYfsxE9VRTsisOkkm6a6b7ZXqKay
         QEOSed8Z3mb3q1cDo7lNM+g3Zx7igrhsvlMLsfLFG7ZA8KCbf9kQiC3YalaHMl3ph1cv
         ZJysOaRkWaW1PpvHlCpIr/Q4da5WOUUm9JImA+Tw4p4m9vwRK96iRMiEyu90D1hr67CV
         kORA==
X-Gm-Message-State: ALoCoQl1X3vwPmVcVbJ77UU36po0/p50ltII8gobWmvMIMhEHgKyIhrvDtJ8gjwVI5l0emT3Dw8m
X-Received: by 10.140.102.102 with SMTP id v93mr13576728qge.60.1446244899945;
        Fri, 30 Oct 2015 15:41:39 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id o20sm3370133qki.42.2015.10.30.15.41.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 15:41:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.691.g714732c-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280555>

A HTTP server is permitted to return a non-range response to a HTTP
range request (and Apache httpd in fact does this in some cases).
While libcurl knows how to correctly handle this (by skipping bytes
before and after the requested range), it only turns on this handling
if it is aware that a range request is being made.  By manually
setting the range header instead of using CURLOPT_RANGE, we were
hiding the fact that this was a range request from libcurl.  This
could cause corruption.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 http.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 0f924a8..303b388 100644
--- a/http.c
+++ b/http.c
@@ -1202,8 +1202,9 @@ static int http_request(const char *url,
 			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
 					 fwrite);
 			if (posn > 0) {
-				strbuf_addf(&buf, "Range: bytes=%ld-", posn);
-				headers = curl_slist_append(headers, buf.buf);
+				strbuf_addf(&buf, "%ld-", posn);
+				curl_easy_setopt(slot->curl, CURLOPT_RANGE,
+						 &buf.buf);
 				strbuf_reset(&buf);
 			}
 		} else
-- 
2.4.2.691.g714732c-twtrsrc
