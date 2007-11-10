From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make builtin-tag.c use parse_options.
Date: Sat, 10 Nov 2007 01:41:16 -0800
Message-ID: <7vabpmo2tf.fsf@gitster.siamese.dyndns.org>
References: <473463E0.7000406@gmail.com>
	<7vabpmpr9y.fsf@gitster.siamese.dyndns.org>
	<7vhcjuo3h9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Carlos Rica <jasampler@gmail.com>
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 10:41:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqmqS-00038t-Fi
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 10:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXKJJlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 04:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbXKJJlZ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 04:41:25 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35414 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbXKJJlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 04:41:24 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1B05C2F2;
	Sat, 10 Nov 2007 04:41:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6759F91ED4;
	Sat, 10 Nov 2007 04:41:41 -0500 (EST)
In-Reply-To: <7vhcjuo3h9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 10 Nov 2007 01:26:58 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64321>

This is an updated patch to the test script...

 t/t7501-commit.sh |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index b151b51..4dc35bd 100644
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -163,4 +163,73 @@ test_expect_success 'partial commit that involves removal (3)' '
 
 '
 
+author="The Real Author <someguy@his.email.org>"
+test_expect_success 'amend commit to fix author' '
+
+	oldtick=$GIT_AUTHOR_DATE &&
+	test_tick &&
+	git reset --hard &&
+	git cat-file -p HEAD |
+	sed -e "s/author.*/author $author $oldtick/" \
+		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
+		expected &&
+	git commit --amend --author="$author" &&
+	git cat-file -p HEAD > current &&
+	diff expected current
+
+'
+
+test_expect_success 'sign off (1)' '
+
+	echo 1 >positive &&
+	git add positive &&
+	git commit -s -m "thank you" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	(
+		echo thank you
+		echo
+		git var GIT_COMMITTER_IDENT |
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+	) >expected &&
+	diff -u expected actual
+
+'
+
+test_expect_success 'sign off (2)' '
+
+	echo 2 >positive &&
+	git add positive &&
+	existing="Signed-off-by: Watch This <watchthis@example.com>" &&
+	git commit -s -m "thank you
+
+$existing" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	(
+		echo thank you
+		echo
+		echo $existing
+		git var GIT_COMMITTER_IDENT |
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+	) >expected &&
+	diff -u expected actual
+
+'
+
+test_expect_success 'multiple -m' '
+
+	>negative &&
+	git add negative &&
+	git commit -m "one" -m "two" -m "three" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	(
+		echo one
+		echo
+		echo two
+		echo
+		echo three
+	) >expected &&
+	diff -u expected actual
+
+'
+
 test_done
