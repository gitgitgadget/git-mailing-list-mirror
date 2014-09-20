From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v15 10/11] trailer: add tests for commands in config file
Date: Sat, 20 Sep 2014 15:45:13 +0200
Message-ID: <20140920134515.18999.78477.chriscool@tuxfamily.org>
References: <20140920134048.18999.79434.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 15:49:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVL2C-0006ro-0i
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 15:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143AbaITNs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 09:48:56 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:34945 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695AbaITNsm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 09:48:42 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 5BF7B73;
	Sat, 20 Sep 2014 15:48:40 +0200 (CEST)
X-git-sha1: e84a91f1fc0e3bac7046a9b431a490ed886d1c6a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140920134048.18999.79434.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257316>

And add a few other tests for some special cases.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7513-interpret-trailers.sh | 125 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index fa37565..c5b86ff 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -723,4 +723,129 @@ test_expect_success 'default "where" is now "after"' '
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
+		Reviewed-by:
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
+		Reviewed-by:
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
+		Reviewed-by:
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
+	git config trailer.fix.ifExists "replace" &&
+	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
+	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
+		Fixes: $FIXED
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with failing command using $ARG' '
+	git config trailer.fix.ifExists "replace" &&
+	git config trailer.fix.command "false \$ARG" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with empty tokens' '
+	git config --unset trailer.fix.command &&
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
2.0.3.960.g41c6e4c
