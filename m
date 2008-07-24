From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] index-pack: correctly initialize appended objects
Date: Thu, 24 Jul 2008 18:32:00 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241821440.8986@racer>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1630730122-1216920721=:8986"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nicolas Pitre <nico@cam.org>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jul 24 19:33:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM4gW-0005ZX-1i
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbYGXRb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbYGXRb6
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:31:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:47410 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751155AbYGXRb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:31:57 -0400
Received: (qmail invoked by alias); 24 Jul 2008 17:31:56 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp017) with SMTP; 24 Jul 2008 19:31:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+E1jc/20aEaptHoMDMYFAFbweMRuNS1Vhu33DDgN
	MmAZicBe4CcBaU
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89920>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1630730122-1216920721=:8986
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT


From: Björn Steinbrink <B.Steinbrink@gmx.de>

When index-pack completes a thin pack it appends objects to the pack.  
Since the commit 92392b4(index-pack: Honor core.deltaBaseCacheLimit when 
resolving deltas) such an object can be pruned in case of memory
pressure.

To be able to re-read the object later, a few more fields have to be set.

Noticed by Pierre Habouzit.

Hopefully-signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
Hopefully-reviewed-and-signed-off-by: Nicolas Pitre <nico@cam.org>, 

--

	This was probably missed in the flurry of patches, scratched 
	patches, and new patches.

	Nico could you have a quick look?  (I would ask Shawn, but I know 
	that he is pretty busy with real world issues.)

diff --git a/index-pack.c b/index-pack.c
index ac20a46..33ba8ef 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -699,6 +699,9 @@ static struct object_entry *append_obj_to_pack(
 	write_or_die(output_fd, header, n);
 	obj[0].idx.crc32 = crc32(0, Z_NULL, 0);
 	obj[0].idx.crc32 = crc32(obj[0].idx.crc32, header, n);
+	obj[0].hdr_size = n;
+	obj[0].type = type;
+	obj[0].size = size;
 	obj[1].idx.offset = obj[0].idx.offset + n;
 	obj[1].idx.offset += write_compressed(output_fd, buf, size, &obj[0].idx.crc32);
 	hashcpy(obj->idx.sha1, sha1);
--8323329-1630730122-1216920721=:8986--
