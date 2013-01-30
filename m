From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/8] parse_fetch_refspec(): clarify the codeflow a bit
Date: Wed, 30 Jan 2013 10:45:38 -0800
Message-ID: <1359571542-19852-5-git-send-email-gitster@pobox.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cg4-0004fU-Um
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab3A3Sp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:45:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756650Ab3A3Spw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:45:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B48EC404;
	Wed, 30 Jan 2013 13:45:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=BdQ+
	UkN9vscQwJUyeNaBrJHjxV4=; b=OGocy36ccepR73N6MHzSj34sRbzi3339bSsS
	CFRh5V1zDyNgvucU+97K+CD0b2Dieei5AwIN6H2/jZp96TZ5agg4xpN2D1rSPM90
	DSFj9t8P5yRHMyjDI0s5fekYkbSlxGbTobD/3+E4SB9IJchiuK64vAIsIGGFjNOW
	rpAe3n4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	oN1XbnPcfPs7bTILbvKqR+933pL9MhST7392wSBaE3RbUtFzCCLa8GrW1nZrgiav
	v6gMTc/kGSKOUh7HcNjbkQZwzu26PA7ka8IC7NgnMmP+U63PmnNmEEZ3x0enfJwP
	kFtLo1mqBJGOMAe3/LtNDFNBukqiIJ67YU3o+u4jzLs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 610D1C403;
	Wed, 30 Jan 2013 13:45:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D498FC402; Wed, 30 Jan 2013
 13:45:51 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.589.ga9b91ac
In-Reply-To: <1359571542-19852-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 457804DC-6B0D-11E2-9A32-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215051>

Most parts of the cascaded if/else if/... checked an allowable
condition but some checked forbidden conditions.  This makes adding
new allowable conditions unnecessarily inconvenient.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/remote.c b/remote.c
index 4b1153f..1b7828d 100644
--- a/remote.c
+++ b/remote.c
@@ -538,7 +538,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 
 		/*
 		 * Before going on, special case ":" (or "+:") as a refspec
-		 * for matching refs.
+		 * for pushing matching refs.
 		 */
 		if (!fetch && rhs == lhs && rhs[1] == '\0') {
 			rs[i].matching = 1;
@@ -565,26 +565,21 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
 
 		if (fetch) {
-			/*
-			 * LHS
-			 * - empty is allowed; it means HEAD.
-			 * - otherwise it must be a valid looking ref.
-			 */
+			/* LHS */
 			if (!*rs[i].src)
-				; /* empty is ok */
-			else if (check_refname_format(rs[i].src, flags))
+				; /* empty is ok; it means "HEAD" */
+			else if (!check_refname_format(rs[i].src, flags))
+				; /* valid looking ref is ok */
+			else
 				goto invalid;
-			/*
-			 * RHS
-			 * - missing is ok, and is same as empty.
-			 * - empty is ok; it means not to store.
-			 * - otherwise it must be a valid looking ref.
-			 */
+			/* RHS */
 			if (!rs[i].dst)
-				; /* ok */
+				; /* missing is ok; it is the same as empty */
 			else if (!*rs[i].dst)
-				; /* ok */
-			else if (check_refname_format(rs[i].dst, flags))
+				; /* empty is ok; it means "do not store" */
+			else if (!check_refname_format(rs[i].dst, flags))
+				; /* valid looking ref is ok */
+			else
 				goto invalid;
 		} else {
 			/*
-- 
1.8.1.2.589.ga9b91ac
