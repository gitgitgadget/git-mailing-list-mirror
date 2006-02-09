From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] remove delta-against-self bit
Date: Thu, 09 Feb 2006 17:50:04 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602091736500.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 23:50:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Kc6-00046m-EF
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 23:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWBIWuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 17:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWBIWuG
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 17:50:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28516 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750778AbWBIWuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 17:50:05 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IUF00H5QZFG9CD0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Feb 2006 17:50:05 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15835>

After experimenting with code to add the ability to encode a delta 
against part of the deltified file, it turns out that resulting packs 
are _bigger_ than when this ability is not used.  The raw delta output 
might be smaller, but it doesn't compress as well using gzip with a 
negative net saving on average.

Said bit would in fact be more useful to allow for encoding the copying 
of chunks larger than 64KB providing more savings with large files.  
This will correspond to packs version 3.

While the current code still produces packs version 2, it is made future 
proof so pack versions 2 and 3 are accepted.  Any pack version 2 are 
compatible with version 3 since the redefined bit was never used before.  
When enough time has passed, code to use that bit to produce version 3 
packs could be added.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/patch-delta.c b/patch-delta.c
index 98c27be..c0e1311 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -44,16 +44,15 @@ void *patch_delta(void *src_buf, unsigne
 		cmd = *data++;
 		if (cmd & 0x80) {
 			unsigned long cp_off = 0, cp_size = 0;
-			const unsigned char *buf;
 			if (cmd & 0x01) cp_off = *data++;
 			if (cmd & 0x02) cp_off |= (*data++ << 8);
 			if (cmd & 0x04) cp_off |= (*data++ << 16);
 			if (cmd & 0x08) cp_off |= (*data++ << 24);
 			if (cmd & 0x10) cp_size = *data++;
 			if (cmd & 0x20) cp_size |= (*data++ << 8);
+			if (cmd & 0x40) cp_size |= (*data++ << 16);
 			if (cp_size == 0) cp_size = 0x10000;
-			buf = (cmd & 0x40) ? dst_buf : src_buf;
-			memcpy(out, buf + cp_off, cp_size);
+			memcpy(out, src_buf + cp_off, cp_size);
 			out += cp_size;
 		} else {
 			memcpy(out, data, cmd);
diff --git a/pack.h b/pack.h
index 657deaa..9dafa2b 100644
--- a/pack.h
+++ b/pack.h
@@ -21,6 +21,7 @@ enum object_type {
  */
 #define PACK_SIGNATURE 0x5041434b	/* "PACK" */
 #define PACK_VERSION 2
+#define pack_version_ok(v) ((v) == htonl(2) || (v) == htonl(3))
 struct pack_header {
 	unsigned int hdr_signature;
 	unsigned int hdr_version;
diff --git a/index-pack.c b/index-pack.c
index 541d7bc..babe34b 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -68,9 +68,9 @@ static void parse_pack_header(void)
 	hdr = (void *)pack_base;
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
 		die("packfile '%s' signature mismatch", pack_name);
-	if (hdr->hdr_version != htonl(PACK_VERSION))
-		die("packfile '%s' version %d different from ours %d",
-		    pack_name, ntohl(hdr->hdr_version), PACK_VERSION);
+	if (!pack_version_ok(hdr->hdr_version))
+		die("packfile '%s' version %d unsupported",
+		    pack_name, ntohl(hdr->hdr_version));
 
 	nr_objects = ntohl(hdr->hdr_entries);
 
diff --git a/pack-check.c b/pack-check.c
index 511f294..67a7ecd 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -16,9 +16,9 @@ static int verify_packfile(struct packed
 	hdr = p->pack_base;
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
 		return error("Packfile %s signature mismatch", p->pack_name);
-	if (hdr->hdr_version != htonl(PACK_VERSION))
-		return error("Packfile version %d different from ours %d",
-			     ntohl(hdr->hdr_version), PACK_VERSION);
+	if (!pack_version_ok(hdr->hdr_version))
+		return error("Packfile version %d unsupported",
+			     ntohl(hdr->hdr_version));
 	nr_objects = ntohl(hdr->hdr_entries);
 	if (num_packed_objects(p) != nr_objects)
 		return error("Packfile claims to have %d objects, "
diff --git a/pack-objects.c b/pack-objects.c
diff --git a/unpack-objects.c b/unpack-objects.c
index 4b5b5cb..815a1b3 100644
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -246,13 +246,12 @@ static void unpack_all(void)
 {
 	int i;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
-	unsigned version = ntohl(hdr->hdr_version);
 	unsigned nr_objects = ntohl(hdr->hdr_entries);
 
 	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
 		die("bad pack file");
-	if (version != PACK_VERSION)
-		die("unable to handle pack file version %d", version);
+	if (!pack_version_ok(hdr->hdr_version))
+		die("unknown pack file version %d", ntohl(hdr->hdr_version));
 	fprintf(stderr, "Unpacking %d objects\n", nr_objects);
 
 	use(sizeof(struct pack_header));
