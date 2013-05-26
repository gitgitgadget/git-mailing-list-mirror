From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/6] t/send-email: test suppress-cc=self on cccmd
Date: Sun, 26 May 2013 17:41:01 +0300
Message-ID: <1369579187-27573-4-git-send-email-mst@redhat.com>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 16:40:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugc7m-0000e9-SX
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 16:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab3EZOkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 10:40:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53334 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819Ab3EZOkj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 10:40:39 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4QEedVK010789
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:39 -0400
Received: from redhat.com (vpn-202-184.tlv.redhat.com [10.35.202.184])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4QEebWO018284
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:38 -0400
Content-Disposition: inline
In-Reply-To: <1369579187-27573-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225547>

Check that suppress-cc=self works when applied
to output of cccmd.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t9001-send-email.sh | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 36ecf73..8aa55f8 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -179,37 +179,53 @@ test_suppress_self () {
 			echo sed -n -e s/^cccmd--//p \"\$1\"
 		} > cccmd-sed &&
 		chmod +x cccmd-sed &&
-		git commit --amend --author="$1 <$2>" -F - << EOF && \
-		clean_fake_sendmail && \
-		echo suppress-self-$3.patch > /dev/tty && \
-		git format-patch --stdout -1 >suppress-self-$3.patch && \
-		git send-email --from="$1 <$2>" \
+		git commit --amend --author="$1 <$2>" -F - && 
+		clean_fake_sendmail && 
+		git format-patch --stdout -1 >suppress-self-$3.patch && 
+		git send-email --from="$1 <$2>"  \
 		--to=nobody@example.com \
 		--cc-cmd=./cccmd-sed \
 		--suppress-cc=self \
 		--smtp-server="$(pwd)/fake.sendmail" \
-		suppress-self-$3.patch && \
-		mv msgtxt1 msgtxt1-$3 && \
-		sed -e '/^$/q' msgtxt1-$3 > msghdr1-$3 && \
-		rm -f expected-no-cc-$3 && \
-		touch expected-no-cc-$3 && \
-		grep '^Cc:' msghdr1-$3 > actual-no-cc-$3 && \
-		test_cmp expected-no-cc-$3 actual-no-cc-$3
-test suppress-cc.self $3 with name $1 email $2
+		suppress-self-$3.patch && 
+		mv msgtxt1 msgtxt1-$3 && 
+		sed -e '/^$/q' msgtxt1-$3 > msghdr1-$3 && 
+		rm -f expected-no-cc-$3 && 
+		touch expected-no-cc-$3 && 
+		(grep '^Cc:' msghdr1-$3 > actual-no-cc-$3;
+		 test_cmp expected-no-cc-$3 actual-no-cc-$3)
+}
+
+test_suppress_self_unquoted () {
+test_suppress_self "$1" "$2" "unquoted-$3" << EOF
+		test suppress-cc.self unquoted-$3 with name $1 email $2
+unquoted-$3
+
+cccmd--$1 <$2>
+
+Cc: $1 <$2>
+Signed-off-by: $1 <$2>
+EOF
+}
+
+test_suppress_self_quoted () {
+test_suppress_self "$1" "$2" "quoted-$3" << EOF
+test suppress-cc.self quoted-$3 with name $1 email $2
 
-$3
+quoted-$3
 
 cccmd--"$1" <$2>
 
-Cc: "$1" <$2>
 Cc: $1 <$2>
-Signed-off-by: "$1" <$2>
+Cc: "$1" <$2>
 Signed-off-by: $1 <$2>
+Signed-off-by: "$1" <$2>
 EOF
 }
 
+
 test_expect_success $PREREQ 'self name is suppressed' "
-	test_suppress_self 'A U Thor' 'author@redhat.com' 'self_name_suppressed'
+	test_suppress_self_unquoted 'A U Thor' 'author@redhat.com' 'self_name_suppressed'
 "
 
 test_expect_success $PREREQ 'Show all headers' '
-- 
MST
