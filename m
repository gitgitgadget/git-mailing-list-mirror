From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 13/23] pack v4: object headers
Date: Tue, 27 Aug 2013 00:25:57 -0400
Message-ID: <1377577567-27655-14-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsJ-0007jK-Tl
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab3H0E1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:27:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab3H0E0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:33 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600F6D9O5GV90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 960642DA056B	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233066>

In pack v4 the object size and type is encoded differently from pack v3.
The object size uses the same efficient variable length number encoding
already used elsewhere.

The object type has 4 bits allocated to it compared to 3 bits in pack v3.
This should be quite sufficient for the foreseeable future, especially
since pack v4 has only one type of delta object instead of two.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index 5211f9c..6e0bb1d 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -647,6 +647,32 @@ static unsigned long packv4_write_tables(struct sha1file *f, unsigned nr_objects
 	return written;
 }
 
+static unsigned int write_object_header(struct sha1file *f, enum object_type type, unsigned long size)
+{
+	unsigned char buf[30], *end;
+	uint64_t val;
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
+	end = add_number(buf, val);
+	sha1write(f, buf, end - buf);
+	return end - buf;
+}
+
 static struct packed_git *open_pack(const char *path)
 {
 	char arg[PATH_MAX];
-- 
1.8.4.22.g54757b7
