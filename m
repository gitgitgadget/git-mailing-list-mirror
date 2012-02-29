From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] grep: use static trans-case table
Date: Tue, 28 Feb 2012 16:20:30 -0800
Message-ID: <1330474831-9030-2-git-send-email-gitster@pobox.com>
References: <1330474831-9030-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 01:21:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2XI0-0008RV-HZ
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 01:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965706Ab2B2AUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 19:20:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493Ab2B2AUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 19:20:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 384ED645B
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 19:20:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qD8B
	gV8jI4YGD3XzZOO6aUB79Zo=; b=sWAU08A8Dkc7u5o2sdrhuUiEMiLCiBdO5Q0+
	3po+nuABj6unHuWCN/5d6yZDQdneHZNu3p530rc+1tjpWKJ4/gzqYU9DdwUU94wS
	vO02DTYWRCtNI7dRL4l65GffQ3abqfG0xeHHY2gGKqVrpBQkbeFG4+f0vdJtbhlA
	hCnVnEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=t8oX9C
	2qBAAk7HJKaVqMFItZ9/MhHlDmDSdKxjwM8Ysk8hqO18HIzu2hQxRzYSNLD5JBkp
	chcutKc/OYD2fUOPRxcjTbTtpeW7oief17pUpxnChI02RZeGI/B15K8BVRi7fej+
	06GkKZoEJA/oHhGqXhUUHecxDD+YLCVJ6a5FQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D450645A
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 19:20:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97D516459 for
 <git@vger.kernel.org>; Tue, 28 Feb 2012 19:20:34 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.344.g3e8c86
In-Reply-To: <1330474831-9030-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 32835332-626B-11E1-9B7B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191796>

In order to prepare the kwset machinery for a case-insensitive search, we
used to use a static table of 256 elements and filled it every time before
calling kwsalloc().  Because the kwset machinery will never modify this
table, just allocate a single instance globally and fill it at the compile
time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    3 +++
 ctype.c |   36 ++++++++++++++++++++++++++++++++++++
 grep.c  |   11 +++--------
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 79c612f..79dc305 100644
--- a/cache.h
+++ b/cache.h
@@ -1258,4 +1258,7 @@ extern struct startup_info *startup_info;
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned char *to);
 
+/* in ctype.c, for kwset users */
+extern const char tolower_trans_tbl[256];
+
 #endif /* CACHE_H */
diff --git a/ctype.c b/ctype.c
index b5d856f..7c14d85 100644
--- a/ctype.c
+++ b/ctype.c
@@ -25,3 +25,39 @@ unsigned char sane_ctype[256] = {
 	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, P, 0,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
+
+/* For case-insensitive kwset */
+const char tolower_trans_tbl[256] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+	 ' ',  '!',  '"',  '#',  '$',  '%',  '&', 0x27,
+	 '(',  ')',  '*',  '+',  ',',  '-',  '.',  '/',
+	 '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',
+	 '8',  '9',  ':',  ';',  '<',  '=',  '>',  '?',
+	 '@',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
+	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
+	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
+	 'x',  'y',  'z',  '[', 0x5c,  ']',  '^',  '_',
+	 '`',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
+	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
+	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
+	 'x',  'y',  'z',  '{',  '|',  '}',  '~', 0x7f,
+	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
+	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
+	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
+	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
+	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
+	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
+	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
+	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
+	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
+	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
+	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
+	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
+	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
+	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
+};
diff --git a/grep.c b/grep.c
index b29d09c..1030f38 100644
--- a/grep.c
+++ b/grep.c
@@ -168,15 +168,10 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		p->fixed = 0;
 
 	if (p->fixed) {
-		if (opt->regflags & REG_ICASE || p->ignore_case) {
-			static char trans[256];
-			int i;
-			for (i = 0; i < 256; i++)
-				trans[i] = tolower(i);
-			p->kws = kwsalloc(trans);
-		} else {
+		if (opt->regflags & REG_ICASE || p->ignore_case)
+			p->kws = kwsalloc(tolower_trans_tbl);
+		else
 			p->kws = kwsalloc(NULL);
-		}
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
-- 
1.7.9.2.344.g3e8c86
