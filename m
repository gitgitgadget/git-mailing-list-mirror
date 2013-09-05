From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 14/38] pack v4: object headers
Date: Thu, 05 Sep 2013 02:19:37 -0400
Message-ID: <1378362001-1738-15-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSw9-000832-7Y
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358Ab3IEGUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab3IEGUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:17 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3W2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 11B472DA0547	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233906>

In pack v4 the object size and type is encoded differently from pack v3.
The object size uses the same efficient variable length number encoding
already used elsewhere.

The object type has 4 bits allocated to it compared to 3 bits in pack v3.
This should be quite sufficient for the foreseeable future, especially
since pack v4 has only one type of delta object instead of two.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index 61b70c8..6098062 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -635,6 +635,33 @@ static unsigned long packv4_write_tables(struct sha1file *f, unsigned nr_objects
 	return written;
 }
 
+static int write_object_header(struct sha1file *f, enum object_type type, unsigned long size)
+{
+	unsigned char buf[16];
+	uint64_t val;
+	int len;
+
+	/*
+	 * We really have only one kind of delta object.
+	 */
+	if (type == OBJ_OFS_DELTA)
+		type = OBJ_REF_DELTA;
+
+	/*
+	 * We allocate 4 bits in the LSB for the object type which should
+	 * be good for quite a while, given that we effectively encodes
+	 * only 5 object types: commit, tree, blob, delta, tag.
+	 */
+	val = size;
+	if (MSB(val, 4))
+		die("fixme: the code doesn't currently cope with big sizes");
+	val <<= 4;
+	val |= type;
+	len = encode_varint(val, buf);
+	sha1write(f, buf, len);
+	return len;
+}
+
 static struct packed_git *open_pack(const char *path)
 {
 	char arg[PATH_MAX];
-- 
1.8.4.38.g317e65b
