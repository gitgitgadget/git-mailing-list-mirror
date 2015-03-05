From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/5] fdopen_lock_file(): use fdopen_with_retry()
Date: Thu,  5 Mar 2015 17:07:46 +0100
Message-ID: <1425571669-22800-3-git-send-email-mhagger@alum.mit.edu>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:08:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTYJl-0001QX-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 17:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbbCEQIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 11:08:01 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51159 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933000AbbCEQIA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 11:08:00 -0500
X-AuditID: 12074412-f79e46d0000036b4-a5-54f87f5e364b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.48.14004.E5F78F45; Thu,  5 Mar 2015 11:07:58 -0500 (EST)
Received: from michael.fritz.box (p5DDB3EC9.dip0.t-ipconnect.de [93.219.62.201])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t25G7s7g031040
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 5 Mar 2015 11:07:57 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqBtX/yPE4MAuI4uuK91MFg29V5gt
	3t5cwmhxe8V8ZgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4MybMP8ha
	MJGtYuaDWcwNjE2sXYycHBICJhLfp7ayQ9hiEhfurWfrYuTiEBK4zCixcv5iZgjnOJPEvUvX
	WECq2AR0JRb1NDOB2CICahIT2w6BxZkF8iW+7z4BFhcWcJD4370ZbCqLgKrE8elTGUFsXgEX
	idVLGhkhtslJnD/+kxnE5hRwlZh25RZYvRBQzbx/S1knMPIuYGRYxSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRrppebWaKXmlK6iRESQEI7GNeflDvEKMDBqMTD+2Hz9xAh1sSy4srcQ4ySHExK
	orw/qn6ECPEl5adUZiQWZ8QXleakFh9ilOBgVhLhvRIJlONNSaysSi3Kh0lJc7AoifP+XKzu
	JySQnliSmp2aWpBaBJOV4eBQkuDdUwvUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqS
	EQ+KjfhiYHSApHiA9p4HaectLkjMBYpCtJ5i1OVY0L5/JpMQS15+XqqUOO/sOqAiAZCijNI8
	uBWwdPGKURzoY2HeHyCjeICpBm7SK6AlTEBLtMTAlpQkIqSkGhhDP9bkre2eqrxXcIsz3yfz
	1TLG77RZ2I77ak62nDdT1qNLLKdMqGL9n9sZbss6nyxvCnZf8V0tZnKsYbDessS4qpfdPWYe
	wg36+x9UPZ3Avne7ypETCxPyeHISrzqX/DyVa/vMSVv78f6JGltEpm7TexvlsNg9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264844>

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Jonathan's original suggestion was that this function should call
xfdopen(). But a couple of callers of fdopen_lock_file() try to
recover if it fails, so I decided to do it this way instead.

 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 9889277..cad567b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -232,7 +232,7 @@ FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
 	if (lk->fp)
 		die("BUG: fdopen_lock_file() called twice for file '%s'", lk->filename.buf);
 
-	lk->fp = fdopen(lk->fd, mode);
+	lk->fp = fdopen_with_retry(lk->fd, mode);
 	return lk->fp;
 }
 
-- 
2.1.4
