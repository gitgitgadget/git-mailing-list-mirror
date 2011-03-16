From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 12:46:01 +0100
Message-ID: <1300275961-5798-1-git-send-email-cmn@elego.de>
References: <20110316112547.GA15739@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 12:46:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzpB3-0005Jm-8Y
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593Ab1CPLqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 07:46:05 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:44963 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116Ab1CPLqC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:46:02 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 7A3A7460FD;
	Wed, 16 Mar 2011 12:45:55 +0100 (CET)
Received: (nullmailer pid 5859 invoked by uid 1000);
	Wed, 16 Mar 2011 11:46:01 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <20110316112547.GA15739@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169148>

Some versions of strlen use SSE to speed up the calculation and load 4
bytes at a time, even if it means reading past the end of the
allocated memory. This read is safe and when the strlen function is
inlined, it is not replaced by valgrind, which reports a
false-possitive.

Tell valgrind to ignore this particular error, as the read is, in
fact, safe. Current upstream-released version 2.6.1 is affected. Some
distributions have this fixed in their latest versions.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

>>  I think 3.6.1 doesn't need it, as Debian's 1:3.5.0+3.6.0svn20100609=
-1
>> version is reportedly fixed.
>
>Ah, nice.  A phrase like "some versions of valgrind before 3.6.1"
>would be fine with me fwiw. :)

I just downloaded and compiled the upstream release 2.6.1 and it's
still affected (it does fix some other related
false-positives). Fedorea rawhide has the fix in, according to their
bug tracker. I haven't tested the reportedly-fixed version in Debian
yet.

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
