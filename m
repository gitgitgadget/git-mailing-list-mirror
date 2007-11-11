From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix index-pack with packs >4GB containing deltas on 32-bit
 machines
Date: Sat, 10 Nov 2007 23:29:10 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711102319470.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 05:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir4Rs-0002CM-2e
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 05:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbXKKE3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 23:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbXKKE3M
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 23:29:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbXKKE3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 23:29:11 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRB00HNTR4MEI91@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Nov 2007 23:29:10 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64396>

This probably hasn't been properly tested before.  Here's a script to 
create a 8GB repo with the necessary characteristics (copy the 
test-genrandom executable from the Git build tree to /tmp first):

-----
#!/bin/bash

git init
git config core.compression 0

# create big objects with no deltas
for i in $(seq -w 1 2 63)
do
	echo $i
	/tmp/test-genrandom $i 268435456 > file_$i
	git add file_$i
	rm file_$i
	echo "file_$i -delta" >> .gitattributes
done

# create "deltifiable" objects in between big objects
for i in $(seq -w 2 2 64)
do
	echo "$i $i $i" >> grow
	cp grow file_$i
	git add file_$i
	rm file_$i
done
rm grow

# create a pack with them
git commit -q -m "commit of big objects interlaced with small deltas"
git repack -a -d
-----

Then clone this repo over the Git protocol.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/index-pack.c b/index-pack.c
index 469a330..9fd6982 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -256,7 +256,7 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 
 static void *get_data_from_pack(struct object_entry *obj)
 {
-	unsigned long from = obj[0].idx.offset + obj[0].hdr_size;
+	off_t from = obj[0].idx.offset + obj[0].hdr_size;
 	unsigned long len = obj[1].idx.offset - from;
 	unsigned long rdy = 0;
 	unsigned char *src, *data;
