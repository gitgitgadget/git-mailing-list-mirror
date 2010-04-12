From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 2/2] index-pack: rationalize unpack_entry_data()
Date: Mon, 12 Apr 2010 12:12:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004121211100.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 18:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1MTE-0007pl-Le
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 18:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab0DLQ0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 12:26:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46109 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab0DLQ0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 12:26:25 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0R00JB7UC65KC0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Apr 2010 12:12:06 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144749>


Rework the loop to remove duplicated calls to use() and fill(), and
to make the code easier to read.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 builtin/index-pack.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 127e713..4308abb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -266,26 +266,23 @@ static void unlink_base_data(struct base_data *c)
 
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
+	if (stream.total_out != size || status != Z_STREAM_END)
+		bad_object(offset, "inflate returned %d", status);
 	git_inflate_end(&stream);
 	return buf;
 }
-- 
1.7.1.rc1.237.ge1730.dirty
