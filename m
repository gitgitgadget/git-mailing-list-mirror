From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 3/3] index-helper: take extra care with readlink
Date: Mon, 11 Apr 2016 00:03:39 +0100
Message-ID: <570ADBCB.4040503@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 01:03:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apOOU-0000cd-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 01:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbcDJXDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 19:03:46 -0400
Received: from avasout08.plus.net ([212.159.14.20]:50347 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcDJXDp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 19:03:45 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id gn3h1s0052D2Veb01n3ivq; Mon, 11 Apr 2016 00:03:42 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=97WklIaUedYe_k3lwIkA:9 a=tpShoWDjIXCYigYw:21
 a=RmRdCUnGEeJjmu10:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291193>


It took me a few minutes to convince myself that, if index-helper is
the only writer for the symlink, that the call to readlink would
result in a properly NULL terminated string. This relies on the
initialization of the address variable setting each byte of the
'struct sockaddr_un' to zero and the contents of the symlink being
no more than 'sizeof(address.sun_path) - 1' bytes long.

In order to make the call easier to reason about, introduce a wrapper
function, read_link(), which copes with overlong symlinks and ensures
correct NULL termination.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 read-cache.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index c7053d8..39330a1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1722,12 +1722,23 @@ static void post_read_index_from(struct index_state *istate)
 	tweak_untracked_cache(istate);
 }
 
+static int read_link(const char *path, char *buf, size_t bufsize)
+{
+	int len;
+
+	len = readlink(path, buf, bufsize);
+	if (len < 0 || len >= bufsize)
+		return -1;
+	buf[len] = '\0';
+	return 0;
+}
+
 int connect_to_index_helper(void)
 {
 	struct sockaddr_un address = {0};
 	int fd;
 
-	if (readlink(git_path("index-helper.path"), address.sun_path,
+	if (read_link(git_path("index-helper.path"), address.sun_path,
 		     sizeof(address.sun_path)) < 0)
 		return -1;
 
-- 
2.8.0
