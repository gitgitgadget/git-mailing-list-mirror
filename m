From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] dir.c::match_basename(): pay attention to the length of
 string parameters
Date: Tue, 26 Mar 2013 11:39:29 -0700
Message-ID: <1364323171-20299-3-git-send-email-gitster@pobox.com>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com, peff@peff.net, avila.jn@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 19:40:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKYn5-0002XY-TY
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 19:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760130Ab3CZSjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 14:39:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760128Ab3CZSjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 14:39:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25768A86A;
	Tue, 26 Mar 2013 14:39:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dw6y
	9zQkK7a/4HOGVFZe07blL7Y=; b=Mh4JIkrvFO4IAufsry1+SsXAKuLD3ldm/+LQ
	kOZCuNXtvlT77kl6ZJ50mvAaFKZVNZeWjx+XuWrh8BGbKiZF2lCJSsMW8RCeLCCM
	ZXxSHGep8BEPmWEcQA7iLMsQq/jFAu5Wiiig6WSGPU8+RIh8trpKChQlU17P45nJ
	E3rrn1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ncMK6d49S40xPApRFz+Ytda30L+bnz1Zc7orH0aur3eQOnJx1jLB0g2fNn05DgSH
	ADxalYF/T/o61AwJckeoyxKjzcHhYqy5ZtXP51BBrTleX7YQqEY0bv3/s4FG3QBy
	EtVzGxYHzJu/GaOMjP/XWiNbDqMRWvcNwK8XPx4pa/k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16866A869;
	Tue, 26 Mar 2013 14:39:37 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74490A867; Tue, 26 Mar 2013
 14:39:36 -0400 (EDT)
X-Mailer: git-send-email 1.8.2-350-g3df87a1
In-Reply-To: <1364323171-20299-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 826FB1A2-9644-11E2-A3B7-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219180>

The function takes two counted strings (<basename, basenamelen> and
<pattern, patternlen>) as parameters, together with prefix (the
length of the prefix in pattern that is to be matched literally
without globbing against the basename) and EXC_* flags that tells it
how to match the pattern against the basename.

However, it did not pay attention to the length of these counted
strings.  Update them to do the following:

 * When the entire pattern is to be matched literally, the pattern
   matches the basename only when the lengths of them are the same,
   and they match up to that length.

 * When the pattern is "*" followed by a string to be matched
   literally, make sure that the basenamelen is equal or longer than
   the "literal" part of the pattern, and the tail of the basename
   string matches that literal part.

 * Otherwise, make sure we use only the counted part of the strings
   when calling fnmatch_icase().  Because these counted strings are
   full strings most of the time, avoid unnecessary allocation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 5a83aa7..aa16303 100644
--- a/dir.c
+++ b/dir.c
@@ -537,15 +537,38 @@ int match_basename(const char *basename, int basenamelen,
 		   int flags)
 {
 	if (prefix == patternlen) {
-		if (!strcmp_icase(pattern, basename))
+		if (patternlen == basenamelen &&
+		    !strncmp_icase(pattern, basename, basenamelen))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
+		/* "*literal" matching against "fooliteral" */
 		if (patternlen - 1 <= basenamelen &&
-		    !strcmp_icase(pattern + 1,
-				  basename + basenamelen - patternlen + 1))
+		    !strncmp_icase(pattern + 1,
+				   basename + basenamelen - (patternlen - 1),
+				   patternlen - 1))
 			return 1;
 	} else {
-		if (fnmatch_icase(pattern, basename, 0) == 0)
+		int match_status;
+		struct strbuf pat = STRBUF_INIT;
+		struct strbuf base = STRBUF_INIT;
+		const char *use_pat = pattern;
+		const char *use_base = basename;
+
+		if (pattern[patternlen]) {
+			strbuf_add(&pat, pattern, patternlen);
+			use_pat = pat.buf;
+		}
+		if (basename[basenamelen]) {
+			strbuf_add(&base, basename, basenamelen);
+			use_base = base.buf;
+		}
+		match_status = fnmatch_icase(use_pat, use_base, 0);
+		if (use_pat)
+			strbuf_release(&pat);
+		if (use_base)
+			strbuf_release(&base);
+
+		if (match_status == 0)
 			return 1;
 	}
 	return 0;
-- 
1.8.2-350-g3df87a1
