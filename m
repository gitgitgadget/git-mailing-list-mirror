From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 10/11] trailer: add tests for commands in config file
Date: Sat, 16 Aug 2014 18:06:20 +0200
Message-ID: <20140816160622.18221.2101.chriscool@tuxfamily.org>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 18:54:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIhFI-0005p2-H1
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbaHPQyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:54:20 -0400
Received: from gleek.ethostream.com ([66.195.129.15]:58991 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbaHPQyT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 12:54:19 -0400
X-ASG-Debug-ID: 1408208000-016a7707b5114ebd0001-QuoKaX
Received: from relay.ethostream.com (www1.ethostream.com [66.195.129.11]) by barracuda.ethostream.com with ESMTP id BjpypjhMHPNkBLN7; Sat, 16 Aug 2014 11:53:20 -0500 (CDT)
X-Barracuda-Envelope-From: chriscool@tuxfamily.org
X-Barracuda-Apparent-Source-IP: 66.195.129.11
Received: from ethoserver.ezone.net (unknown [10.230.15.218])
	by relay.ethostream.com (Postfix) with ESMTPA id 79CE2890DD7;
	Sat, 16 Aug 2014 11:37:49 -0500 (CDT)
Received: from [127.0.1.1] (unknown [10.0.7.4])
	by ethoserver.ezone.net (Postfix) with ESMTP id 971ABC549BB;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-ASG-Orig-Subj: [PATCH v13 10/11] trailer: add tests for commands in config file
X-git-sha1: 3869c3a2ede67d88423edc7dd874366e70d7983c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140816153440.18221.29179.chriscool@tuxfamily.org>
X-Barracuda-Connect: www1.ethostream.com[66.195.129.11]
X-Barracuda-Start-Time: 1408208000
X-Barracuda-URL: http://66.195.129.15:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ethostream.com
X-Barracuda-Spam-Score: 3.38
X-Barracuda-Spam-Status: No, SCORE=3.38 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=FH_DATE_PAST_20XX
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.138343
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	3.38 FH_DATE_PAST_20XX      The date is grossly in the future.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255334>

And add a few other tests for some special cases.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7513-interpret-trailers.sh | 124 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index fa37565..562c00a 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -723,4 +723,128 @@ test_expect_success 'default "where" is now "after"' '
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
+	git config trailer.fix.ifExists "overwrite" &&
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
+	git config trailer.fix.ifExists "overwrite" &&
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
2.0.1.674.ga7f57b7
