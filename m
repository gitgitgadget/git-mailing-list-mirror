From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH 2/2] parse_date(): '@' prefix forces git-timestamp
Date: Thu,  2 Feb 2012 13:41:43 -0800
Message-ID: <1328218903-5681-3-git-send-email-gitster@pobox.com>
References: <1328218903-5681-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 22:42:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt4Q0-0007OE-Ts
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 22:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462Ab2BBVlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 16:41:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757098Ab2BBVlv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 16:41:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA916479;
	Thu,  2 Feb 2012 16:41:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gHPX
	zU8utL/85Ans81lmW/cPvK8=; b=X01zm5F0cmABWpOZq6jtCsnmYL37cGKhmE5k
	ASwp+BzenYPqUlejUCQ+2qQCm85kb0SsJRF70hIXXX0ijBSipF3f/O+01zdX24WY
	hH9bM7FiKxtwToUwRr3bhgQ+qoF1rTkURVLa02r/MZISire0IvCb8HPNtL6YnEhU
	u0XOypc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QuEJp8
	GBzelm+rLb8v9iaUKO8xPT0lG26ditXslYZGUL4NSK7gUe1uXt5Uwrxk1ICjvBuU
	sK9vjqxxpXRtxJTTBonjSi7Ng15bMpLifcvfBUqhjmyAB/qJW2XQamuRGHJ9FAkK
	zqpaddVn+TgHW9KyuRsJCCqTgSOfQeJJdESik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96E056478;
	Thu,  2 Feb 2012 16:41:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D78E6476; Thu,  2 Feb 2012
 16:41:49 -0500 (EST)
X-Mailer: git-send-email 1.7.9.172.ge26ae
In-Reply-To: <1328218903-5681-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B653C76C-4DE6-11E1-B473-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189713>

The only place that the issue this series addresses was observed
where we read "cat-file commit" output and put it in GIT_AUTHOR_DATE
in order to replay a commit with an ancient timestamp.

With the previous patch alone, "git commit --date='20100917 +0900'"
can be misinterpreted to mean an ancient timestamp, not September in
year 2010.  Guard this codepath by requring an extra '@' in front of
the raw git timestamp on the parsing side. This of course needs to
be compensated by updating get_author_ident_from_commit and the code
for "git commit --amend" to prepend '@' to the string read from the
existing commit in the GIT_AUTHOR_DATE environment variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c  |    6 ++++++
 date.c            |    3 ++-
 git-sh-setup.sh   |    2 +-
 t/t3400-rebase.sh |   23 +++++++++++++++++++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index cbc9613..bcb0db2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -534,6 +534,7 @@ static void determine_author_info(struct strbuf *author_ident)
 
 	if (author_message) {
 		const char *a, *lb, *rb, *eol;
+		size_t len;
 
 		a = strstr(author_message_buffer, "\nauthor ");
 		if (!a)
@@ -554,6 +555,11 @@ static void determine_author_info(struct strbuf *author_ident)
 					 (a + strlen("\nauthor "))));
 		email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
 		date = xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
+		len = eol - (rb + strlen("> "));
+		date = xmalloc(len + 2);
+		*date = '@';
+		memcpy(date + 1, rb + strlen("> "), len);
+		date[len + 1] = '\0';
 	}
 
 	if (force_author) {
diff --git a/date.c b/date.c
index c212946..ca60767 100644
--- a/date.c
+++ b/date.c
@@ -637,7 +637,8 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 	*offset = -1;
 	tm_gmt = 0;
 
-	if (!match_object_header_date(date, timestamp, offset))
+	if (*date == '@' &&
+	    !match_object_header_date(date + 1, timestamp, offset))
 		return 0; /* success */
 	for (;;) {
 		int match = 0;
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 8e427da..015fe6e 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -200,7 +200,7 @@ get_author_ident_from_commit () {
 		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
 
 		g
-		s/^author [^<]* <[^>]*> \(.*\)$/\1/
+		s/^author [^<]* <[^>]*> \(.*\)$/@\1/
 		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
 
 		q
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6eaecec..e26e14d 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -218,4 +218,27 @@ test_expect_success 'rebase -m can copy notes' '
 	test "a note" = "$(git notes show HEAD)"
 '
 
+test_expect_success 'rebase commit with an ancient timestamp' '
+	git reset --hard &&
+
+	>old.one && git add old.one && test_tick &&
+	git commit --date="@12345 +0400" -m "Old one" &&
+	>old.two && git add old.two && test_tick &&
+	git commit --date="@23456 +0500" -m "Old two" &&
+	>old.three && git add old.three && test_tick &&
+	git commit --date="@34567 +0600" -m "Old three" &&
+
+	git cat-file commit HEAD^^ >actual &&
+	grep "author .* 12345 +0400$" actual &&
+	git cat-file commit HEAD^ >actual &&
+	grep "author .* 23456 +0500$" actual &&
+	git cat-file commit HEAD >actual &&
+	grep "author .* 34567 +0600$" actual &&
+
+	git rebase --onto HEAD^^ HEAD^ &&
+
+	git cat-file commit HEAD >actual &&
+	grep "author .* 34567 +0600$" actual
+'
+
 test_done
-- 
1.7.9.172.ge26ae
