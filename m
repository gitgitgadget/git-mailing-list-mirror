From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/25] rollback_lock_file(): set fd to -1
Date: Mon,  7 Apr 2014 01:33:46 +0200
Message-ID: <1396827247-28465-5-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbN-000602-2n
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbaDFXfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53200 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754586AbaDFXet (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:34:49 -0400
X-AuditID: 1207440e-f79c76d000003e2c-64-5341e499a69a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.29.15916.994E1435; Sun,  6 Apr 2014 19:34:49 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWp011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:48 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqDvziWOwwazXahZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PhtOcsBcdZK74u3s/UwLiDpYuRk0NCwESir7mJ
	HcIWk7hwbz0biC0kcJlRYu4lxi5GLiD7OJPElw8rGUESbAK6Eot6mplAbBEBNYmJbYdYQIqY
	BW4wSrzbdxhsqrCAjcSDDcdZQWwWAVWJ9i3PmEFsXgEXiUdX7zFBbJOTOHlsMlgNp4CrxLrJ
	c1kgNrsAzbnHNoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU0k2MkNDj
	28HYvl7mEKMAB6MSD++KQ47BQqyJZcWVuYcYJTmYlER5Le8BhfiS8lMqMxKLM+KLSnNSiw8x
	SnAwK4nwHrgBlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAefQzU
	KFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KjfhiYHSApHiA9l4EaectLkjMBYpC
	tJ5iVJQS5535CCghAJLIKM2DGwtLKK8YxYG+FOZdBtLOA0xGcN2vgAYzAQ1uCLMDGVySiJCS
	amAMPWcZdMFnurgLV/LRcwz8ObN+x9juZnuo1JpRExj9cm/6OauWV1E10YFKIg06hxTezH/m
	/mChyfPHCdFMikf9OhoEmz6f3rrNtpUzuNM8vvTraf+ZCU4L7P19ttiufSzerCTw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245804>

When rolling back the lockfile, call close_lock_file() so that the
lock_file's fd field gets set back to -1.  This keeps the lock_file
object in a valid state, which is important because these objects are
allowed to be reused.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 7701267..1122542 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -275,7 +275,7 @@ void rollback_lock_file(struct lock_file *lk)
 {
 	if (lk->filename[0]) {
 		if (lk->fd >= 0)
-			close(lk->fd);
+			close_lock_file(lk);
 		unlink_or_warn(lk->filename);
 		lk->filename[0] = 0;
 	}
-- 
1.9.1
