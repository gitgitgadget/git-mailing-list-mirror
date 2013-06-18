From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] send-email: add test for duplicate utf8 name
Date: Tue, 18 Jun 2013 15:49:29 +0300
Message-ID: <1371559723-28059-2-git-send-email-mst@redhat.com>
References: <1371559723-28059-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?us-ascii?B?PT9VVEYtOD9xP1NaRURFUj0yMEc9QzM9QTFib3I/PQ==?= 
	<szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 14:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UovLG-0000Z8-UN
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415Ab3FRMsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 08:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25123 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327Ab3FRMsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:48:54 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5ICmgLx013650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 18 Jun 2013 08:48:42 -0400
Received: from redhat.com (vpn1-5-182.ams2.redhat.com [10.36.5.182])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r5ICmeXB004206;
	Tue, 18 Jun 2013 08:48:41 -0400
Content-Disposition: inline
In-Reply-To: <1371559723-28059-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228225>

Verify that author name is not duplicated if it matches
sender, even if it is in utf8.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 9f46f22..cef884f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -956,6 +956,19 @@ test_expect_success $PREREQ 'utf8 author is correc=
tly passed on' '
 	grep "^From: F=FC=F1n=FD N=E2m=E9 <odd_?=3Dmail@example.com>" msgtxt1
 '
=20
+test_expect_success $PREREQ 'utf8 sender is not duplicated' '
+	clean_fake_sendmail &&
+	test_commit weird_sender &&
+	test_when_finished "git reset --hard HEAD^" &&
+	git commit --amend --author "F=FC=F1n=FD N=E2m=E9 <odd_?=3Dmail@examp=
le.com>" &&
+	git format-patch --stdout -1 >funny_name.patch &&
+	git send-email --from=3D"F=FC=F1n=FD N=E2m=E9 <odd_?=3Dmail@example.c=
om>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  funny_name.patch &&
+	test `grep "^From:" msgtxt1|wc -l` -eq 1
+'
+
 test_expect_success $PREREQ 'sendemail.composeencoding works' '
 	clean_fake_sendmail &&
 	git config sendemail.composeencoding iso-8859-1 &&
--=20
MST
