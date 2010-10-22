From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] diff: don't presume empty file when corresponding object is
 missing
Date: Fri, 22 Oct 2010 00:02:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010212353550.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_ysQpRj6I4Dh0KGWrezBtpg)"
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 06:02:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P98pz-0004uY-Vf
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 06:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab0JVECf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 00:02:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41469 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab0JVECe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 00:02:34 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAO006PCB7WN0C1@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Oct 2010 00:02:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159635>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_ysQpRj6I4Dh0KGWrezBtpg)
Content-type: TEXT/PLAIN; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

The low-level diff code will happily produce totally bogus diff output 
with a broken repository via format-patch and friends by treating missing
objects as empty files.  Let's prevent that from happening any longer.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

diff --git a/diff.c b/diff.c
index 4732b32..b2839f9 100644
--- a/diff.c
+++ b/diff.c
@@ -2386,10 +2386,14 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 	}
 	else {
 		enum object_type type;
-		if (size_only)
+		if (size_only) {
 			type = sha1_object_info(s->sha1, &s->size);
-		else {
+			if (type < 0)
+				die("unable to read %s", sha1_to_hex(s->sha1));
+		} else {
 			s->data = read_sha1_file(s->sha1, &type, &s->size);
+			if (!s->data)
+				die("unable to read %s", sha1_to_hex(s->sha1));
 			s->should_free = 1;
 		}
 	}

--Boundary_(ID_ysQpRj6I4Dh0KGWrezBtpg)--
