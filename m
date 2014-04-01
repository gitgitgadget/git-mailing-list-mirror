From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 10/11] trailer: add tests for commands in config file
Date: Tue, 01 Apr 2014 21:20:21 +0200
Message-ID: <20140401192023.353.53841.chriscool@tuxfamily.org>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:25:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4JY-0001NC-Tv
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbaDATZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:25:35 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:38436 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbaDATZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:25:12 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 7BBFC67;
	Tue,  1 Apr 2014 21:25:11 +0200 (CEST)
X-git-sha1: ef95b23dd0c99e0870e121df04d20f8e4a84c21e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140401191831.353.99271.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245628>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 71 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 417a4f3..0a1f3b6 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -333,4 +333,75 @@ test_expect_success 'using "ifMissing = doNothing"' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with simple command' '
+	git config trailer.sign.key "Signed-off-by: " &&
+	git config trailer.sign.where "after" &&
+	git config trailer.sign.ifExists "addIfDifferentNeighbor" &&
+	git config trailer.sign.command "echo \"A U Thor <author@example.com>\"" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers "review:" "fix=22" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with command using commiter information' '
+	git config trailer.sign.ifExists "addIfDifferent" &&
+	git config trailer.sign.command "echo \"\$GIT_COMMITTER_NAME <\$GIT_COMMITTER_EMAIL>\"" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	git interpret-trailers "review:" "fix=22" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with command using author information' '
+	git config trailer.sign.key "Signed-off-by: " &&
+	git config trailer.sign.where "after" &&
+	git config trailer.sign.ifExists "addIfDifferentNeighbor" &&
+	git config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers "review:" "fix=22" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup a commit' '
+	echo "Content of the first commit." > a.txt &&
+	git add a.txt &&
+	git commit -m "Add file a.txt"
+'
+
+test_expect_success 'with command using $ARG' '
+	git config trailer.fix.ifExists "overwrite" &&
+	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
+	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
+		Fixes: $FIXED
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers "review:" "fix=HEAD" <complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.9.0.164.g3aa33cd.dirty
