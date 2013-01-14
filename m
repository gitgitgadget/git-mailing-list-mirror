From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] cvsimport: make tests reusable for cvsimport-3
Date: Sun, 13 Jan 2013 23:25:50 -0800
Message-ID: <1358148351-31552-6-git-send-email-gitster@pobox.com>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358148351-31552-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 08:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TueRC-0002XD-Cx
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab3ANH0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:26:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61373 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755608Ab3ANH0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:26:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CB13B8C9
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:26:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4QSM
	hHZit7eaAyi/DGTl0qu700A=; b=ux6/7gx1XAIWBOC0y03075EZroofGbBr48yx
	T2pEhqm97Gd34rYceNy8yY9EzdmMrxFJUxO935gzAi4Kur1K6VtU4goUagM4Eq1D
	eEj/P0n97Fl9QYTBl5nUtZDpAummCRsUKnQVE5U6fXozHfcf6OAjx09UrUgghmD4
	I7v9+nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HZejp4
	1dA/E2nr66yH4MxwSLw7mQo3XIhDXBcYRo77r6836e0QHnhDXvilobzuTVE+gkIo
	oOX0ogtV1FgGp19zjDmmdfLbfmFenf2CM91HKi585ddTZ6nJ9DLP5fzuWYXqUB8r
	BTWlHQWO+c8jelIDXLWyFwBg4tEEG9TQ/z8ao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BEAFB8C8
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:26:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 449ABB8C6 for
 <git@vger.kernel.org>; Mon, 14 Jan 2013 02:26:04 -0500 (EST)
X-Mailer: git-send-email 1.8.1.421.g6236851
In-Reply-To: <1358148351-31552-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A7CBB588-5E1B-11E2-ADFD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213461>

This way, a dual-use test can be dot-sourced into a new test script
after defining GIT_CVSPS_VERSION=3 to test that the new cvsimport
with cvsps (3.x) works on simple test histories that old cvsimport
can grok correctly.

Also allow CVSPS2_PATH and CVSPS3_PATH to be defined as "NoThanks"
to cause the tests in t96?? series to be skipped.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-cvs.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index bdab63c..3a55b8a 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -1,5 +1,8 @@
 #!/bin/sh
 
+: ${TEST_CVSPS_VERSION=2}
+export TEST_CVSPS_VERSION
+
 . ./test-lib.sh
 
 unset CVS_SERVER
@@ -13,22 +16,56 @@ fi
 CVS="cvs -f"
 export CVS
 
-CVSPS="$CVSPS2_PATH"
-
-cvsps_version=`$CVSPS -h 2>&1 | sed -ne 's/cvsps version //p'`
-case "$cvsps_version" in
-2.1 | 2.2*)
+skip_all=
+case "$TEST_CVSPS_VERSION" in
+2)
+	if test "$CVSPS2_PATH" = NoThanks
+	then
+		skip_all='skipping cvsimport tests, cvsps(2) not used'
+	else
+		case $($CVSPS2_PATH -h 2>&1 | sed -ne 's/cvsps version //p') in
+		2.1 | 2.2*)
+			;;
+		'')
+			skip_all='skipping cvsimport tests, cvsps(2) not found'
+			;;
+		*)
+			skip_all='skipping cvsimport tests, unsupported cvsps(2)'
+			;;
+		esac
+	fi
 	;;
-'')
-	skip_all='skipping cvsimport tests, cvsps not found'
-	test_done
+3)
+	if test "$CVSPS3_PATH" = NoThanks
+	then
+		skip_all='skipping cvsimport tests, cvsps(3) not used'
+	else
+		case $($CVSPS3_PATH -h 2>&1 | sed -ne 's/cvsps version //p') in
+		3.*)
+			;;
+		'')
+			skip_all='skipping cvsimport tests, cvsps(3) not found'
+			;;
+		*)
+			skip_all='skipping cvsimport tests, unsupported cvsps(3)'
+			;;
+		esac
+	fi
 	;;
 *)
-	skip_all='skipping cvsimport tests, unsupported cvsps version'
-	test_done
+	echo >&2 "Bug in test: set TEST_CVSPS_VESION to either 2 or 3"
+	exit 1
 	;;
 esac
 
+GIT_CVSPS_VERSION=$TEST_CVSPS_VERSION
+export GIT_CVSPS_VERSION
+
+if test -n "$skip_all"
+then
+	test_done
+fi
+
 setup_cvs_test_repository () {
 	CVSROOT="$(pwd)/.cvsroot" &&
 	cp -r "$TEST_DIRECTORY/$1/cvsroot" "$CVSROOT" &&
-- 
1.8.1.421.g6236851
