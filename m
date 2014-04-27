From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 2/2] test/send-email: to-cover, cc-cover tests
Date: Sun, 27 Apr 2014 21:25:54 +0300
Message-ID: <1398623142-28501-2-git-send-email-mst@redhat.com>
References: <1398623142-28501-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 20:25:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTlN-00084N-DH
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 20:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbaD0SZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 14:25:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbaD0SZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 14:25:08 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3RIP6dc003330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Apr 2014 14:25:06 -0400
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3RIP4Xd026734;
	Sun, 27 Apr 2014 14:25:04 -0400
Content-Disposition: inline
In-Reply-To: <1398623142-28501-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247217>

Add tests for the new feature.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1ecdacb..97cc094 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1334,6 +1334,51 @@ test_expect_success $PREREQ '--force sends cover letter template anyway' '
 	test -n "$(ls msgtxt*)"
 '
 
+test_cover_addresses () {
+	header="$1"
+	shift
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git format-patch --cover-letter -2 -o outdir &&
+	cover=`echo outdir/0000-*.patch` &&
+	mv $cover cover-to-edit.patch &&
+	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.patch > $cover &&
+	git send-email \
+	  --force \
+	  --from="Example <nobody@example.com>" \
+	  --no-to --no-cc \
+	  "$@" \
+	  --smtp-server="$(pwd)/fake.sendmail" \
+	  outdir/0000-*.patch \
+	  outdir/0001-*.patch \
+	  outdir/0002-*.patch \
+	  2>errors >out &&
+	grep "^$header: extra@address.com" msgtxt1 > to1 &&
+	grep "^$header: extra@address.com" msgtxt2 > to2 &&
+	grep "^$header: extra@address.com" msgtxt3 > to3 &&
+	test_line_count = 1 to1 &&
+	test_line_count = 1 to2 &&
+	test_line_count = 1 to3
+}
+
+test_expect_success $PREREQ 'to-cover adds To to all mail' '
+	test_cover_addresses "To" --to-cover
+'
+
+test_expect_success $PREREQ 'cc-cover adds Cc to all mail' '
+	test_cover_addresses "Cc" --cc-cover
+'
+
+test_expect_success $PREREQ 'tocover adds To to all mail' '
+	test_config sendemail.tocover true &&
+	test_cover_addresses "To"
+'
+
+test_expect_success $PREREQ 'cccover adds Cc to all mail' '
+	test_config sendemail.cccover true &&
+	test_cover_addresses "Cc"
+'
+
 test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
 	clean_fake_sendmail &&
 	echo "alias sbd  somebody@example.org" >.mailrc &&
-- 
MST
