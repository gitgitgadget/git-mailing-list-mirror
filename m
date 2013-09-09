From: Nicolas Pitre <nico@fluxnic.net>
Subject: pack v4 trees with a canonical base
Date: Mon, 09 Sep 2013 15:25:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309091517380.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Nguyn_Th=E1i_Ngc_Duy?= <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 21:25:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ75h-0005Vk-36
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 21:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab3IITZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 15:25:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13129 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab3IITZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 15:25:36 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSV00EJHHYN9D80@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Sep 2013 15:25:36 -0400 (EDT)
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234362>

While reviewing the pack v4 thin support Ive realized that some base 
tree objects appended to a thin pack won't be in pack v4 format.  Hence 
the patch below to deal with that possibility.

An eventual optimization to index-pack when completing a pack would be 
to attempt the encoding of appended tree objects into the packv4 format 
using the existing dictionary table in the pack, and fall back to the 
canonical format if that table doesn't have all the necessary elements.

    packv4-parse.c: allow tree entry copying from a canonical tree object
    
    It is possible for a base tree object to be in the canonical
    representation.  This may happen if the encoder detected an irregularity
    preventing a loss free encoding to the pack v4 format, or if a thin pack
    was completed with such tree objects.
    
    Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/packv4-parse.c b/packv4-parse.c
index c62c4ae..36942bb 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -10,6 +10,7 @@
 
 #include "cache.h"
 #include "packv4-parse.h"
+#include "tree-walk.h"
 #include "varint.h"
 
 const unsigned char *get_sha1ref(struct packed_git *p,
@@ -321,6 +322,45 @@ void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 	return dst;
 }
 
+static int copy_canonical_tree_entries(struct packed_git *p, off_t offset,
+				       unsigned int start, unsigned int count,
+				       unsigned char **dstp, unsigned long *sizep)
+{
+	void *data;
+	const void *from, *end;
+	enum object_type type;
+	unsigned long size;
+	struct tree_desc desc;
+
+	data = unpack_entry(p, offset, &type, &size);
+	if (!data)
+		return -1;
+	if (type != OBJ_TREE) {
+		free(data);
+		return -1;
+	}
+
+	init_tree_desc(&desc, data, size);
+
+	while (start--)
+		update_tree_entry(&desc);
+
+	from = desc.buffer;
+	while (count--)
+		update_tree_entry(&desc);
+	end = desc.buffer;
+
+	if (end - from > *sizep) {
+		free(data);
+		return -1;
+	}
+	memcpy(*dstp, from, end - from);
+	*dstp += end - from;
+	*sizep -= end - from;
+	free(data);
+	return 0;
+}
+
 static int tree_entry_prefix(unsigned char *buf, unsigned long size,
 			     const unsigned char *path, unsigned mode)
 {
@@ -364,7 +404,12 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 		while (*scp & 128)
 			if (++scp - src >= avail - 20)
 				return -1;
-		/* let's still make sure this is actually a tree */
+		/* is this a canonical tree object? */
+		if ((*scp & 0xf) == OBJ_TREE)
+			return copy_canonical_tree_entries(p, offset,
+							   start, count,
+							   dstp, sizep);
+		/* let's still make sure this is actually a pv4 tree */
 		if ((*scp++ & 0xf) != OBJ_PV4_TREE)
 			return -1;
 	}
