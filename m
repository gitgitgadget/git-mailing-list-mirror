From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] check-attr -z: a single -z should apply to both input and output
Date: Thu, 11 Jul 2013 23:18:47 -0700
Message-ID: <1373609927-3244-5-git-send-email-gitster@pobox.com>
References: <1373609927-3244-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWhA-0006vk-92
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab3GLGTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:19:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286Ab3GLGS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:18:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D5342B509
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1iST
	xbP7p36xQCTq2y7uJaOU5Yo=; b=drhk8mgImgzZUz+e/C4DK0fAGMde12wP/DH2
	/kKNz9TY2IXmdI/KvsB32pq+3PKjV4f2FG7+tZe4inT8ovGY9ndaLsWFvFZ6v0id
	PUQ+oqrBOF8NM44yo7vZIxoeJ5aOxUbRMKqovVK70XNqasDXjssX7BllIO7ZlH0E
	r1MpNTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bK1Zw2
	suNTJuNENjwYdYy4qqq6Ekuko8Kis4W0v7ZgnhFPM+ty8wx5y4gkI3E6BvWxLFT3
	WuTim3ftYn04n4iKnNVICmHD3OFll52avgIkabTKa6S1kxEkaqu83SdoEV14BUDF
	Go/M8InBk2DBBpuAs89JxyYeu/o4N7/BWkxmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 944D22B508
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E34192B503
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:55 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
In-Reply-To: <1373609927-3244-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EE6BB390-EABA-11E2-8979-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230170>

Unless a command has separate --nul-terminated-{input,output}
options, the --nul-terminated-records (-z) option should apply
to both input and output for consistency.  The caller knows that its
input paths may need to be protected for LF, and the program shows
these problematic paths to its output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-attr.txt |  9 +++++++--
 builtin/check-attr.c             | 14 +++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 5abdbaa..760aca9 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -31,8 +31,9 @@ OPTIONS
 	Read file names from stdin instead of from the command-line.
 
 -z::
-	Only meaningful with `--stdin`; paths are separated with a
-	NUL character instead of a linefeed character.
+	The output format is modified to be machine-parseable.
+	If `--stdin` is also given, input paths are separated
+	with a NUL character instead of a linefeed character.
 
 \--::
 	Interpret all preceding arguments as attributes and all following
@@ -48,6 +49,10 @@ OUTPUT
 The output is of the form:
 <path> COLON SP <attribute> COLON SP <info> LF
 
+unless `-z` is in effect, in which case NUL is used as delimiter:
+<path> NUL <attribute> NUL <info> NUL
+
+
 <path> is the path of a file being queried, <attribute> is an attribute
 being queried and <info> can be either:
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 7cc9b5d..cd46690 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -20,7 +20,7 @@ static const struct option check_attr_options[] = {
 	OPT_BOOLEAN(0,  "cached", &cached_attrs, N_("use .gitattributes only from the index")),
 	OPT_BOOLEAN(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
 	OPT_BOOLEAN('z', NULL, &nul_term_line,
-		    N_("input paths are terminated by a NUL character")),
+		    N_("terminate input and output records by a NUL character")),
 	OPT_END()
 };
 
@@ -38,8 +38,16 @@ static void output_attr(int cnt, struct git_attr_check *check,
 		else if (ATTR_UNSET(value))
 			value = "unspecified";
 
-		quote_c_style(file, NULL, stdout, 0);
-		printf(": %s: %s\n", git_attr_name(check[j].attr), value);
+		if (nul_term_line) {
+			printf("%s%c" /* path */
+			       "%s%c" /* attrname */
+			       "%s%c" /* attrvalue */,
+			       file, 0, git_attr_name(check[j].attr), 0, value, 0);
+		} else {
+			quote_c_style(file, NULL, stdout, 0);
+			printf(": %s: %s\n", git_attr_name(check[j].attr), value);
+		}
+
 	}
 }
 
-- 
1.8.3.2-911-g2c4daa5
