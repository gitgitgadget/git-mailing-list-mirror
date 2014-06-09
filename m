From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] t3302: do not chdir around in the primary test process
Date: Mon,  9 Jun 2014 16:22:52 -0700
Message-ID: <1402356175-7249-5-git-send-email-gitster@pobox.com>
References: <1402356175-7249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8ui-0004Rp-6z
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933957AbaFIXXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:23:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52931 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbaFIXXX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:23:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA29A1D40A;
	Mon,  9 Jun 2014 19:23:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rGyw
	ZQy3134rkFqT5Mk4S13379o=; b=Lx3FlksTR2Q7+qznknhbYc1WsQozx28Rbtzx
	r+tqexiislOwp+zT3DQiH34VkS5pep45IezWMdsQlaA+NWrybCNSeT6eFozsaEFY
	qLDdlP2/cJ/hGcwNVBnJ0FpirH1C09d1Js7+WNw/r0820prulmmiUB++iIM8ubFU
	IkmR6tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YixyUf
	Il2xtRlTOq4cixwqrI2jHZISyfqEFh9HCnHMvRYXT17MhmYz62LaHtHl1gb+fSR3
	SYhCmujn2QCbHv033RCXgLfBAXZ8W9tR3UdLuWRvLaIChZOx1uB3PNWnnKjnAt+r
	P6ROeXBGWg9u6cXmkPd0nNfXY1JuhmEu0k/jY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D20231D405;
	Mon,  9 Jun 2014 19:23:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AAB961D401;
	Mon,  9 Jun 2014 19:23:18 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-483-g1a584c4
In-Reply-To: <1402356175-7249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0A3B220E-F02D-11E3-92BE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251136>

These days^Wyears we strive to do stuff in subdirectories inside
subshells to avoid mistakes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3302-notes-index-expensive.sh | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index aa9dbd7..7712cf3 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -106,18 +106,27 @@ do_tests () {
 	pr=$1
 	count=$2
 
-	test_expect_success $pr 'setup / mkdir' '
-		mkdir $count &&
-		cd $count
+	test_expect_success $pr "setup $count" '
+		mkdir "$count" &&
+		(
+			cd "$count" &&
+			create_repo "$count"
+		)
 	'
 
-	test_expect_success $pr "setup $count" "create_repo $count"
-
-	test_expect_success $pr 'notes work' "test_notes $count"
-
-	test_expect_success USR_BIN_TIME,$pr 'notes timing with /usr/bin/time' "time_notes 100"
+	test_expect_success $pr 'notes work' '
+		(
+			cd "$count" &&
+			test_notes "$count"
+		)
+	'
 
-	test_expect_success $pr 'teardown / cd ..' 'cd ..'
+	test_expect_success USR_BIN_TIME,$pr 'notes timing with /usr/bin/time' '
+		(
+			cd "$count" &&
+			time_notes 100
+		)
+	'
 }
 
 do_tests NOT_EXPENSIVE 10
-- 
2.0.0-435-g307a092
