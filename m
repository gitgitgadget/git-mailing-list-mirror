From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] apply --ignore-space-change: lines with and without leading whitespaces do not match
Date: Wed, 26 Mar 2014 14:14:13 -0700
Message-ID: <xmqq61n0irx6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 22:14:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSv9R-00077t-E8
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 22:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbaCZVOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 17:14:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46196 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544AbaCZVOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 17:14:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74C72771D8;
	Wed, 26 Mar 2014 17:14:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	Vf9F1Psm2wkIhGSrHC0gN/Gpic=; b=KyXYa/aivY6ZSWvTaFJ2i/6F7GYG7S7IW
	XgEzlWDMIXYMkiIh6bTuxOvDPIeSGmWqsIHZTQ5zx+hjmRTWB+RIJ6D4vW3YLPmZ
	wHqvAC3RcLxppSx5ZuMoH0cujXx+mK4lIG1ANAqVTKLzPg+eOzn5Y8wbV+xdMxjO
	G0wwW76wNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=F+u
	omvEX+UK1fnbBy1GifAeddGZ2rvzt6YvjLKd+RgoyKJjoVVGoJUmEqOeC1QiZ4yY
	lGatxJk6+Ntf+5IMy0rOgGteNhV81KKrLEHr+lfYM2kGzG1tNWoXM2CaA7tS7X6Y
	it7bILdnF9aVeHZESzwROx5+h2e7lSMyVvohebUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FD05771D7;
	Wed, 26 Mar 2014 17:14:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6EAD771CC;
	Wed, 26 Mar 2014 17:14:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 957E90CC-B52B-11E3-A100-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245229>

The fuzzy_matchlines() function is used when attempting to resurrect
a patch that is whitespace-damaged, or when applying a patch that
was produced against an old codebase to the codebase after
indentation change.

The patch may want to change a line "a_bc" ("_" is used throught
this description for a whitespace to make it stand out) in the
original into something else, and we may not find "a_bc" in the
current source, but there may be "a__bc" (two spaces instead of one
the whitespace-damaged patch claims to expect).  By ignoring the
amount of whitespaces, it forces "git apply" to consider that "a_bc"
in the broken patch meant to refer to "a__bc" in reality.

However, the implementation special cases a run of whitespaces at
the beginning of a line and makes "abc" match "_abc", even though a
whitespace in the middle of string never matches a 0-width gap,
e.g. "a_bc" does not match "abc".  A run of whitespace at the end of
one string does not match a 0-width end of line on the other line,
either, e.g. "abc_" does not match "abc".

Fix this inconsistency by making the code skip leading whitespaces
only when both strings begin with a whitespace.  This makes the
option mean the same as the option of the same name in "diff" and
"git diff".

Note that I am not sure if anybody sane should use this option in
the first place.  The fuzzy match logic may be able to find the
original line that the patch author may have meant to touch because
it does not fully trust what the original lines say (i.e. context
lines prefixed by " " and old lines prefixed by "-" does not have to
exactly match the contents the patch is applied to).  There is no
reason for us to trust what the replacement lines (i.e. new lines
prefixed by "+") say, either, but with this option enabled, we end
up copying these new lines with suspicious whitespace distributions
literally into the patched result.  But as long as we keep it, we
should make it do its insane thing consistently.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c                    | 12 +++++++-----
 t/t4107-apply-ignore-whitespace.sh | 12 ++++--------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0189523..8b9d3de 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -300,11 +300,13 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
 	while ((*last2 == '\r') || (*last2 == '\n'))
 		last2--;
 
-	/* skip leading whitespace */
-	while (isspace(*s1) && (s1 <= last1))
-		s1++;
-	while (isspace(*s2) && (s2 <= last2))
-		s2++;
+	/* skip leading whitespaces, if both begin with whitespace */
+	if (s1 <= last1 && s2 <= last2 && isspace(*s1) && isspace(*s2)) {
+		while (isspace(*s1) && (s1 <= last1))
+			s1++;
+		while (isspace(*s2) && (s2 <= last2))
+			s2++;
+	}
 	/* early return if both lines are empty */
 	if ((s1 > last1) && (s2 > last2))
 		return 1;
diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
index b04fc8f..9e29b52 100755
--- a/t/t4107-apply-ignore-whitespace.sh
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -111,7 +111,6 @@ sed -e 's/T/	/g' > main.c.final <<\EOF
 #include <stdio.h>
 
 void print_int(int num);
-T/* a comment */
 int func(int num);
 
 int main() {
@@ -154,7 +153,8 @@ test_expect_success 'patch2 reverse applies with --ignore-space-change' '
 git config apply.ignorewhitespace change
 
 test_expect_success 'patch2 applies (apply.ignorewhitespace = change)' '
-	git apply patch2.patch
+	git apply patch2.patch &&
+	test_cmp main.c.final main.c
 '
 
 test_expect_success 'patch3 fails (missing string at EOL)' '
@@ -165,12 +165,8 @@ test_expect_success 'patch4 fails (missing EOL at EOF)' '
 	test_must_fail git apply patch4.patch
 '
 
-test_expect_success 'patch5 applies (leading whitespace)' '
-	git apply patch5.patch
-'
-
-test_expect_success 'patches do not mangle whitespace' '
-	test_cmp main.c main.c.final
+test_expect_success 'patch5 fails (leading whitespace differences matter)' '
+	test_must_fail git apply patch5.patch
 '
 
 test_expect_success 're-create file (with --ignore-whitespace)' '
-- 
1.9.1-497-g6f5ca27
