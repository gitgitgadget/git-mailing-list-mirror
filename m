From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 1/6] t/send-email.sh: add test for suppress-cc=self
Date: Thu, 30 May 2013 10:11:13 +0300
Message-ID: <1369897638-27299-2-git-send-email-mst@redhat.com>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 09:10:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhx0j-000399-EB
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 09:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967733Ab3E3HKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 03:10:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967670Ab3E3HKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 03:10:45 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4U7Aiaa001629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 30 May 2013 03:10:44 -0400
Received: from redhat.com (vpn-203-5.tlv.redhat.com [10.35.203.5])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4U7AgAX004076;
	Thu, 30 May 2013 03:10:43 -0400
Content-Disposition: inline
In-Reply-To: <1369897638-27299-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225937>

This adds a basic test for --suppress-cc=self
option of git send-email.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ebd5c5d..e1a7f3e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -171,6 +171,49 @@ Result: OK
 EOF
 "
 
+test_suppress_self () {
+	test_commit $3 &&
+	test_when_finished "git reset --hard HEAD^" &&
+
+	write_script cccmd-sed <<-EOF &&
+		sed -n -e s/^cccmd--//p "\$1"
+	EOF
+
+	git commit --amend --author="$1 <$2>" -F - &&  
+	clean_fake_sendmail &&  
+	git format-patch --stdout -1 >"suppress-self-$3.patch" &&  
+
+	git send-email --from="$1 <$2>" \
+		--to=nobody@example.com \
+		--cc-cmd=./cccmd-sed \
+		--suppress-cc=self \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		suppress-self-$3.patch &&
+
+	mv msgtxt1 msgtxt1-$3 &&
+	sed -e '/^$/q' msgtxt1-$3 >"msghdr1-$3" &&
+	>"expected-no-cc-$3" &&
+
+	(grep '^Cc:' msghdr1-$3 >"actual-no-cc-$3";
+	 test_cmp expected-no-cc-$3 actual-no-cc-$3)
+}
+
+test_suppress_self_unquoted () {
+	test_suppress_self "$1" "$2" "unquoted-$3" <<-EOF
+		test suppress-cc.self unquoted-$3 with name $1 email $2
+
+		unquoted-$3
+
+		Cc: $1 <$2>
+		Signed-off-by: $1 <$2>
+	EOF
+}
+
+test_expect_success $PREREQ 'self name is suppressed' "
+	test_suppress_self_unquoted 'A U Thor' 'author@redhat.com' \
+		'self_name_suppressed'
+"
+
 test_expect_success $PREREQ 'Show all headers' '
 	git send-email \
 		--dry-run \
-- 
MST
