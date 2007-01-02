From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: [PATCH 4/4] Support --amend on initial commit in status output
Date: Tue,  2 Jan 2007 20:26:23 +0100
Message-ID: <11677659961794-git-send-email-j.ruehle@bmiag.de>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?q?J=FCrgen_R=FChle?= <j-r@online.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 20:27:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pHp-00082t-Ep
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbXABT06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:26:58 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbXABT06
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:26:58 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:37853 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964923AbXABT04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:26:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 65BB23AED7;
	Tue,  2 Jan 2007 20:26:55 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14487-08; Tue, 2 Jan 2007 20:26:55 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id EBB2F3AED1;
	Tue,  2 Jan 2007 20:26:54 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 553803ADC6;
	Tue,  2 Jan 2007 20:26:54 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20762-04; Tue, 2 Jan 2007 20:26:45 +0100 (CET)
Received: from localhost.localdomain (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 80DA33ADCA;
	Tue,  2 Jan 2007 20:26:37 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.g31e2
In-Reply-To: <1167765983316-git-send-email-j.ruehle@bmiag.de>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35805>

=46rom: =3D?iso-8859-1?q?J=3DFCrgen_R=3DFChle?=3D <j-r@online.de>

We check the existence of the parent commit to determine whether the st=
atus is
requested for an initial commit. Since the parent commit depends on the
presence of the --amend switch do initial commit detection after comman=
d line
arguments have been handled.

Signed-off-by: J=FCrgen R=FChle <j-r@online.de>
---
 wt-status.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 302f7ee..166d0e3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -41,8 +41,6 @@ void wt_status_prepare(struct wt_status *s)
 	unsigned char sha1[20];
 	const char *head;
=20
-	s->is_initial =3D get_sha1("HEAD", sha1) ? 1 : 0;
-
 	head =3D resolve_ref("HEAD", sha1, 0, NULL);
 	s->branch =3D head ? xstrdup(head) : NULL;
=20
@@ -287,6 +285,9 @@ static void wt_status_print_verbose(struct wt_statu=
s *s)
=20
 void wt_status_print(struct wt_status *s)
 {
+	unsigned char sha1[20];
+	s->is_initial =3D get_sha1(s->reference, sha1) ? 1 : 0;
+
 	if (s->branch)
 		color_printf_ln(color(WT_STATUS_HEADER),
 			"# On branch %s", s->branch);
--=20
1.5.0.rc0.g31e2
