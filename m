From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/14] t5520: style fixes
Date: Sat, 25 Apr 2015 22:25:55 -0700
Message-ID: <1430025967-24479-3-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5I-0002kU-Fd
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbbDZF0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751004AbbDZF0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 918F0466E5;
	Sun, 26 Apr 2015 01:26:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=L2Ku
	5GSZg3B5yuFZWk6wyJbGlHc=; b=ZGiE0Ng4kx1bJYaDYn7ldlbPS5fGbH0JyZiD
	G+IswBYMnLHn4ax8OBGxhEkvBTZTaguFejJp5Bu7SzEodaahr96iuz7agPYtIbeB
	rGyn6lm0dZIw4Rxs5mI5veJNCUgboFBMyqxGDRjvT13vaM+cEYgetUwV89fRaAMD
	lz1+PZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=quSXf2
	n8d68fwIzxVTrAnsB5JOO1pGUsiL+KC4Rsqc4Kpwd8kDIdwtEw1CAkFq/cmcnxxw
	89O6Sgh4+jO8scb5aYFGwGwT7P1l47So1zvmXAEJIHnb7OcAOCwSRSJ8fyTzvYYx
	prUiT9cU+q5y5l3FF8MS9RyX2pTXq0Sz46Ahs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A82E466E3;
	Sun, 26 Apr 2015 01:26:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B98B466E2;
	Sun, 26 Apr 2015 01:26:10 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BFC023E2-EBD4-11E4-B17D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267813>

Fix style funnies in early part of this test script that checks "git
pull" into an unborn branch.  The primary change is that 'chdir' to
a newly created empty test repository is now protected by being done
in a subshell to make it more robust without having to chdir back to
the original place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5520-pull.sh | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 227d293..5195a21 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -9,36 +9,27 @@ modify () {
 	mv "$2.x" "$2"
 }
 
-D=`pwd`
-
 test_expect_success setup '
-
 	echo file >file &&
 	git add file &&
 	git commit -a -m original
-
 '
 
 test_expect_success 'pulling into void' '
-	mkdir cloned &&
-	cd cloned &&
-	git init &&
-	git pull ..
-'
-
-cd "$D"
-
-test_expect_success 'checking the results' '
+	git init cloned &&
+	(
+		cd cloned &&
+		git pull ..
+	) &&
 	test -f file &&
 	test -f cloned/file &&
 	test_cmp file cloned/file
 '
 
 test_expect_success 'pulling into void using master:master' '
-	mkdir cloned-uho &&
+	git init cloned-uho &&
 	(
 		cd cloned-uho &&
-		git init &&
 		git pull .. master:master
 	) &&
 	test -f file &&
@@ -71,7 +62,6 @@ test_expect_success 'pulling into void does not overwrite staged files' '
 	)
 '
 
-
 test_expect_success 'pulling into void does not remove new staged files' '
 	git init cloned-staged-new &&
 	(
-- 
2.4.0-rc3-238-g36f5934
