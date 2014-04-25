From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v11 10/11] trailer: add tests for commands in config file
Date: Fri, 25 Apr 2014 21:07:01 +0200
Message-ID: <20140425190703.28550.40167.chriscool@tuxfamily.org>
References: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 21:12:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlXX-0001aP-V0
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbaDYTL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:11:58 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:43461 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932103AbaDYTHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:07:51 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 1000272;
	Fri, 25 Apr 2014 21:07:49 +0200 (CEST)
X-git-sha1: 92b9eb22dacae257bec8e3f963d6a7e021019655 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247102>

And add a few other tests for some special cases.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7513-interpret-trailers.sh | 124 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 4506e18..9aae721 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -415,4 +415,128 @@ test_expect_success 'using "ifMissing = doNothing"' '
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
+	git interpret-trailers --trailer "review:" --trailer "fix=22" \
+		<complex_message >actual &&
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
+	git interpret-trailers --trailer "review:" --trailer "fix=22" \
+		<complex_message >actual &&
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
+	git interpret-trailers --trailer "review:" --trailer "fix=22" \
+		<complex_message >actual &&
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
+	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with failing command using $ARG' '
+	git config trailer.fix.ifExists "overwrite" &&
+	git config trailer.fix.command "false \$ARG" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with empty tokens' '
+	cat >expected <<-EOF &&
+
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers --trailer ":" --trailer ":test" >actual <<-EOF &&
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'with command but no key' '
+	git config --unset trailer.sign.key &&
+	cat >expected <<-EOF &&
+
+		sign: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers >actual <<-EOF &&
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'with no command and no key' '
+	git config --unset trailer.review.key &&
+	cat >expected <<-EOF &&
+
+		review: Junio
+		sign: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers --trailer "review:Junio" >actual <<-EOF &&
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
1.9.1.636.g20d5f34
