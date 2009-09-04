From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] diff --whitespace=warn/error: obey blank-at-eof
Date: Fri,  4 Sep 2009 03:55:16 -0700
Message-ID: <1252061718-11579-8-git-send-email-gitster@pobox.com>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:56:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWTH-00041M-JA
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbZIDKzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756745AbZIDKzl
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737AbZIDKzf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1733725EF6
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HBqk
	Kn17IN+lcjdCwK1Aw2arn74=; b=fbUs+99OXazNNkKMYWdsFFJPz6yagUWbh8JN
	prBjUde3UEBzU7vUUN/p2k3AeUQKnYsPDA7jWjfRnSpf/J9I02pmqIGDd/KHpfps
	6IN4sj7xKcpBNiOe2s1Fg5p/UGAA9vdW3sWQgBzDoeKyG73Zxxs5nsyXQKa5F70h
	QZhWzD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Rev57C
	NQs3oqmsMxCuoQFxPYVeYPK+sKlk9y3Z4hZaFLONvyZ3cxRcmMZdkFJ8FKOyswbB
	Ey6+wzZUqEBGLIy8ZSCN/pCgfgIC4+43ub+jhXn7+Ml9p8axrZ6PSC8hecbb2ifz
	nLSadc1VaXDkfDwVMla8xiZ6DEbp7kZnQSbgs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 121B825EF5
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C40925EF4 for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:37 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7AD63334-9941-11DE-82A7-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127717>

The "diff --check" code used to conflate trailing-space whitespace error
class with this, but now we have a proper separate error class, we should
check it under blank-at-eof, not trailing-space.

The whitespace error is not about _having_ blank lines at end, but about
adding _new_ blank lines.  To keep the message consistent with what is
given by "git apply", call whitespace_error_string() to generate it,
instead of using a hardcoded custom message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     |   10 +++++++---
 t/t4015-diff-whitespace.sh |    4 ++--
 t/t4019-diff-wserror.sh    |    2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 1eddd59..a693d18 100644
--- a/diff.c
+++ b/diff.c
@@ -1650,10 +1650,14 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		ecb.priv = &data;
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 
-		if ((data.ws_rule & WS_TRAILING_SPACE) &&
+		if ((data.ws_rule & WS_BLANK_AT_EOF) &&
 		    data.trailing_blanks_start) {
-			fprintf(o->file, "%s:%d: ends with blank lines.\n",
-				data.filename, data.trailing_blanks_start);
+			static char *err;
+
+			if (!err)
+				err = whitespace_error_string(WS_BLANK_AT_EOF);
+			fprintf(o->file, "%s:%d: %s\n",
+				data.filename, data.trailing_blanks_start, err);
 			data.status = 1; /* report errors */
 		}
 	}
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b1cbd36..a5d4461 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -335,10 +335,10 @@ test_expect_success 'line numbers in --check output are correct' '
 
 '
 
-test_expect_success 'checkdiff detects trailing blank lines' '
+test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 	echo "foo();" >x &&
 	echo "" >>x &&
-	git diff --check | grep "ends with blank"
+	git diff --check | grep "new blank line"
 '
 
 test_expect_success 'checkdiff allows new blank lines' '
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 84a1fe3..1517fff 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -165,7 +165,7 @@ test_expect_success 'trailing empty lines (1)' '
 
 	rm -f .gitattributes &&
 	test_must_fail git diff --check >output &&
-	grep "ends with blank lines." output &&
+	grep "new blank line at" output &&
 	grep "trailing whitespace" output
 
 '
-- 
1.6.4.2.313.g0425f
