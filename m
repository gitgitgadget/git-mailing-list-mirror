From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/2] sha1_file: silence sha1_loose_object_info
Date: Thu, 30 May 2013 22:00:22 +0200
Message-ID: <2d926e4dbd218b2305f50652c00a5c1d87e81208.1369943791.git.trast@inf.ethz.ch>
References: <87bo7sbeoc.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <kernel-hacker@bennee.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	"John Keeping" <john@keeping.me.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 30 22:00:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui91Z-0001Cz-P6
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 22:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933539Ab3E3UAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 16:00:35 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:28630 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933511Ab3E3UA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 16:00:26 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 22:00:23 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 22:00:24 +0200
X-Mailer: git-send-email 1.8.3.506.g4fdeee5
In-Reply-To: <87bo7sbeoc.fsf@linux-k42r.v.cablecom.net>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226035>

sha1_object_info() returns -1 (OBJ_BAD) if it cannot find the object
for some reason, which suggests that it wants the _caller_ to report
this error.  However, part of its work happens in
sha1_loose_object_info, which _does_ report errors itself.  This is
doubly strange because:

* packed_object_info(), which is the other half of the duo, does _not_
  report this.

* In the event that an object is packed and pruned while
  sha1_object_info_extended() goes looking for it, we would
  erroneously show the error -- even though the code of the latter
  function purports to handle this case gracefully.

* A caller might invoke sha1_object_info() to find the type of an
  object even if that object is not known to exist.

Silence this error.  The others remain untouched as a corrupt object
is a much more grave error than it merely being absent.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 67e815b..c0f6a0e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2348,7 +2348,7 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 
 	map = map_sha1_file(sha1, &mapsize);
 	if (!map)
-		return error("unable to find %s", sha1_to_hex(sha1));
+		return -1;
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
-- 
1.8.3.506.g4fdeee5
