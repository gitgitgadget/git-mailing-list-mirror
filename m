From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] stream_to_pack: xread does not guarantee to read all requested
 bytes
Date: Tue, 20 Aug 2013 11:15:26 +0200
Message-ID: <521333AE.1090506@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 11:15:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBi2O-00005S-M0
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 11:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab3HTJPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 05:15:37 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:6207 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750974Ab3HTJPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 05:15:36 -0400
Received: from [10.71.219.138] (178.115.251.138.wireless.dyn.drei.com [178.115.251.138])
	by bsmtp.bon.at (Postfix) with ESMTP id ED97C1300C0;
	Tue, 20 Aug 2013 11:15:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232591>

The deflate loop in bulk-checkin::stream_to_pack expects to get all bytes
from a file that it requests to read in a single function call. But it
used xread(), which does not give that guarantee. Replace it by
read_in_full().

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 The size is limited to sizeof(ibuf) == 16384 bytes, so that there
 should not be a problem with the unpatched code on any OS in practice.
 Nevertheless, this change seems reasonable from a code hygiene POV.

 bulk-checkin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6b0b6d4..118c625 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -114,7 +114,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 
 		if (size && !s.avail_in) {
 			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
-			if (xread(fd, ibuf, rsize) != rsize)
+			if (read_in_full(fd, ibuf, rsize) != rsize)
 				die("failed to read %d bytes from '%s'",
 				    (int)rsize, path);
 			offset += rsize;
-- 
1.8.4.rc3.1241.gcbfd92d.dirty
