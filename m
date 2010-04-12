From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 2/2] index-pack: rationalize unpack_entry_data()
Date: Sun, 11 Apr 2010 22:57:27 -0400
Message-ID: <1271041047-32563-2-git-send-email-nico@fluxnic.net>
References: <1271041047-32563-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 04:57:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O19qH-0005vy-36
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 04:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab0DLC5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 22:57:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40763 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab0DLC5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 22:57:30 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0Q00220TJR4XD0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 11 Apr 2010 22:57:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.237.ge1730.dirty
In-reply-to: <1271041047-32563-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144703>

Rework the loop to remove duplicated calls to use() and fill(), and
to make the code easier to read.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 builtin/index-pack.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c746d3b..69b9167 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -266,27 +266,24 @@ static void unlink_base_data(struct base_data *c)
 
 static void *unpack_entry_data(unsigned long offset, unsigned long size)
 {
+	int status;
 	z_stream stream;
 	void *buf = xmalloc(size);
 
 	memset(&stream, 0, sizeof(stream));
+	git_inflate_init(&stream);
 	stream.next_out = buf;
 	stream.avail_out = size;
-	stream.next_in = fill(1);
-	stream.avail_in = input_len;
-	git_inflate_init(&stream);
 
-	for (;;) {
-		int ret = git_inflate(&stream, 0);
-		use(input_len - stream.avail_in);
-		if (stream.total_out == size && ret == Z_STREAM_END)
-			break;
-		if (ret != Z_OK)
-			bad_object(offset, "inflate returned %d", ret);
+	do {
 		stream.next_in = fill(1);
 		stream.avail_in = input_len;
-	}
+		status = git_inflate(&stream, 0);
+		use(input_len - stream.avail_in);
+	} while (status == Z_OK);
 	git_inflate_end(&stream);
+	if (stream.total_out != size || status != Z_STREAM_END)
+		bad_object(offset, "inflate returned %d", status);
 	return buf;
 }
 
-- 
1.7.1.rc1.237.ge1730.dirty
