From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 10:31:14 +0100
Message-ID: <1300267874-15365-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 10:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzn4a-00006R-DH
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab1CPJbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 05:31:17 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:44601 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296Ab1CPJbP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 05:31:15 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 3A280460FD;
	Wed, 16 Mar 2011 10:31:09 +0100 (CET)
Received: (nullmailer pid 15398 invoked by uid 1000);
	Wed, 16 Mar 2011 09:31:14 -0000
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169126>

The C library uses SSE instructions to make strlen (among others)
faster, loading 4 bytes at a time and reading past the end of the
allocated memory. This read is safe and when the strlen function is
inlined, it is (obviously) not replaced by valgrind, which reports a
false-possitive.

Tell valgrind to ignore this particular error, as the read is, in
fact, safe.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 t/valgrind/default.supp |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 9e013fa..327478c 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -43,3 +43,9 @@
 	fun:write_buffer
 	fun:write_loose_object
 }
+
+{
+	ignore-sse-strlen-invalid-read-size
+	Memcheck:Addr4
+	fun:copy_ref
+}
\ No newline at end of file
--=20
1.7.4.1
