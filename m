From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] color: allow multiple attributes
Date: Sat, 27 Feb 2010 18:56:38 -0800
Message-ID: <1267325798-8280-1-git-send-email-gitster@pobox.com>
References: <7vfx4mv0h9.fsf@alter.siamese.dyndns.org>
Cc: Mark Lodato <lodatom@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 03:56:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlZKv-00057b-3Y
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 03:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968178Ab0B1C4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 21:56:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966874Ab0B1C4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 21:56:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F3A29DD76;
	Sat, 27 Feb 2010 21:56:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; s=sasl; bh=VX0XnGUygAuZra4
	FmnYlW9u2QDA=; b=Aw9rZu5GZD+WnIDepqS8BgoMleX+LXdmFbrkINb3xwnTTjp
	vjfSfpUOSYQ+2uABMpLIKztqmviaU88LLbJAI21RMjKCaCR2RQ0bA2BjSK6m2uPT
	EP34mJVGgiNEhDK/g6/lIqyLPHSOPBYDlzPAedkhbLY7bhC7fL6rP++aoPNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to; q=dns; s=sasl; b=up0iHxNA7
	pJJANzVJ81E8KTSGK19P+E9Hx0G4uVLwwuJgIs+sLnwV/OMYanLo+YRq03cCksgz
	aPA7RNnDkmtJBrDegIYL4Q9cyEtCepmsdlRtJNoAjNJwQJZScB1iurz/en3jb1B5
	7UffLt4rMpGwfgg/iFdolgI/XG+6IlhrcE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EFF5D9DD75;
	Sat, 27 Feb 2010 21:56:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D59169DD73; Sat, 27 Feb
 2010 21:56:39 -0500 (EST)
X-Mailer: git-send-email 1.7.0.270.g320aa
In-Reply-To: <7vfx4mv0h9.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: E68068DA-2414-11DF-8CAD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141241>

In configuration files (and "git config --color" command line), we
supported one and only one attribute after foreground and background
color.  Accept combinations of attributes, e.g.

    [diff.color]
            old = red reverse bold

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
  Junio C Hamano <gitster@pobox.com> writes:

  >>> but wouldn't it be more user friendly for us
  >>> to support "red blink bold ul italic"?
  >>
  >> Yes, I think this should be done whether or not the patch in question
  >> is accepted.

  This time with a bit of test updates as well for real inclusion.

  Also I realized that we can stuff them in an unsigned flag word as
  bitfields ("red bold" and "red bold bold bold" would give the same
  boldness anyway) to lift the artificial limit of number of attribute
  words.

 color.c          |   47 +++++++++++++++++++++++++++++++++++++++--------
 t/t4026-color.sh |   15 +++++++++++----
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/color.c b/color.c
index db4dccf..17eb3ec 100644
--- a/color.c
+++ b/color.c
@@ -44,12 +44,23 @@ void color_parse(const char *value, const char *var, char *dst)
 	color_parse_mem(value, strlen(value), var, dst);
 }
 
+static int count_bits(unsigned flag)
+{
+	int cnt = 0;
+	while (flag) {
+		if (flag & 01)
+			cnt++;
+		flag >>= 1;
+	}
+	return cnt;
+}
+
 void color_parse_mem(const char *value, int value_len, const char *var,
 		char *dst)
 {
 	const char *ptr = value;
 	int len = value_len;
-	int attr = -1;
+	unsigned int attr = 0;
 	int fg = -2;
 	int bg = -2;
 
@@ -58,7 +69,7 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 		return;
 	}
 
-	/* [fg [bg]] [attr] */
+	/* [fg [bg]] [attr]... */
 	while (len > 0) {
 		const char *word = ptr;
 		int val, wordlen = 0;
@@ -87,19 +98,39 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 			goto bad;
 		}
 		val = parse_attr(word, wordlen);
-		if (val < 0 || attr != -1)
+		if (0 <= val)
+			attr |= (1 << val);
+		else
 			goto bad;
-		attr = val;
 	}
 
-	if (attr >= 0 || fg >= 0 || bg >= 0) {
+	if (attr || fg >= 0 || bg >= 0) {
 		int sep = 0;
+		int i;
+		int num_attrs = count_bits(attr);
+
+		if (COLOR_MAXLEN <=
+		    /* Number of bytes to denote colors and attributes */
+		    num_attrs
+		    + (fg < 0 ? 0 : (fg < 8) ? 2 : 8) /* "3x" or "38;5;xxx" */
+		    + (bg < 0 ? 0 : (bg < 8) ? 2 : 8) /* "4x" or "48;5;xxx" */
+		    /* Number of semicolons between the above elements */
+		    + (num_attrs + (0 <= fg) + (0 <= bg) - 1)
+		    /* ESC '[', terminating 'm' and NUL */
+		    + 4)
+			goto bad;
 
 		*dst++ = '\033';
 		*dst++ = '[';
-		if (attr >= 0) {
-			*dst++ = '0' + attr;
-			sep++;
+
+		for (i = 0; attr; i++) {
+			unsigned bit = (1 << i);
+			if (!(attr & bit))
+				continue;
+			attr &= ~bit;
+			if (sep++)
+				*dst++ = ';';
+			*dst++ = '0' + i;
 		}
 		if (fg >= 0) {
 			if (sep++)
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index b61e516..c3af190 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -8,14 +8,13 @@ test_description='Test diff/status color escape codes'
 
 color()
 {
-	git config diff.color.new "$1" &&
-	test "`git config --get-color diff.color.new`" = "$2"
+	actual=$(git config --get-color no.such.slot "$1") &&
+	test "$actual" = "$2"
 }
 
 invalid_color()
 {
-	git config diff.color.new "$1" &&
-	test -z "`git config --get-color diff.color.new 2>/dev/null`"
+	test_must_fail git config --get-color no.such.slot "$1"
 }
 
 test_expect_success 'reset' '
@@ -42,6 +41,14 @@ test_expect_success 'fg bg attr' '
 	color "blue red ul" "[4;34;41m"
 '
 
+test_expect_success 'fg bg attr...' '
+	color "blue bold dim ul blink reverse" "[1;2;4;5;7;34m"
+'
+
+test_expect_success 'color specification too long' '
+	invalid_color "254 255 bold dim ul blink reverse" "[1;2;4;5;7;38;5;254;48;5;255m"
+'
+
 test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
-- 
1.7.0.270.g320aa
