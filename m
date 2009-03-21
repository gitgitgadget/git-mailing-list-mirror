From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] check_ref_format(): tighten refname rules
Date: Sat, 21 Mar 2009 15:13:33 -0700
Message-ID: <1237673619-12608-2-git-send-email-gitster@pobox.com>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 23:15:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9TG-0007RU-As
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbZCUWNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZCUWNr
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:13:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbZCUWNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:13:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FEE9A317B
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ED97BA317A for
 <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:42 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.299.gda643a
In-Reply-To: <1237673619-12608-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8A597866-1665-11DE-930D-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114077>

Yes, I know that tightening rules retroactively is bad, but this changes
the rules for refnames to forbid:

 (1) a refname that ends with a dot.

     We already reject a path component that begins with a dot, primarily
     to avoid ambiguous range interpretation.  If we allowed ".B" as a
     valid ref, it is unclear if "A...B" means "in dot-B but not in A" or
     "either in A or B but not in both".

     But for this to be complete, we need also to forbid "A." to avoid "in
     B but not in A-dot".  This was not a problem in the original range
     notation, but we should have added this restriction when three-dot
     notation was introduced.

     Unlike "no dot at the beginning of any path component" rule, this
     rule does not have to be "no dot at the end of any path component",
     because you cannot abbreviate the tail end away, similar to you can
     say "dot-B" to mean "refs/heads/dot-B".

 (2) a refname that contains "@{" in it.

     Some people and foreign SCM converter may have named their branches
     as frotz@243 and we still want to keep supporting it, but "git branch
     @{1}" is a disaster.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8d3c502..abd5623 100644
--- a/refs.c
+++ b/refs.c
@@ -693,7 +693,7 @@ static inline int bad_ref_char(int ch)
 
 int check_ref_format(const char *ref)
 {
-	int ch, level, bad_type;
+	int ch, level, bad_type, last;
 	int ret = CHECK_REF_FORMAT_OK;
 	const char *cp = ref;
 
@@ -717,19 +717,23 @@ int check_ref_format(const char *ref)
 				return CHECK_REF_FORMAT_ERROR;
 		}
 
+		last = ch;
 		/* scan the rest of the path component */
 		while ((ch = *cp++) != 0) {
 			bad_type = bad_ref_char(ch);
-			if (bad_type) {
+			if (bad_type)
 				return CHECK_REF_FORMAT_ERROR;
-			}
 			if (ch == '/')
 				break;
-			if (ch == '.' && *cp == '.')
+			if (last == '.' && ch == '.')
+				return CHECK_REF_FORMAT_ERROR;
+			if (last == '@' && ch == '{')
 				return CHECK_REF_FORMAT_ERROR;
 		}
 		level++;
 		if (!ch) {
+			if (ref <= cp - 2 && cp[-2] == '.')
+				return CHECK_REF_FORMAT_ERROR;
 			if (level < 2)
 				return CHECK_REF_FORMAT_ONELEVEL;
 			return ret;
-- 
1.6.2.1.299.gda643a
