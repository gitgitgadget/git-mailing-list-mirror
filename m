From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/3] rev_is_head(): use skip_prefix()
Date: Wed,  5 Feb 2014 07:25:17 +0100
Message-ID: <1391581517-8586-4-git-send-email-mhagger@alum.mit.edu>
References: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
Cc: "Kent R. Spillner" <kspillner@acm.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 07:26:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAvwN-0004mm-Ha
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 07:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbaBEG0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 01:26:25 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60506 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751687AbaBEG0B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 01:26:01 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-12-52f1d9784158
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id DF.20.19161.879D1F25; Wed,  5 Feb 2014 01:26:00 -0500 (EST)
Received: from michael.fritz.box (p57A24DEA.dip0.t-ipconnect.de [87.162.77.234])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s156POxx019775
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Feb 2014 01:25:59 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqFtx82OQwfPFEhZdV7qZLBp6rzBb
	PNjxk8ni9or5zBbdU94yOrB6XL7i7fH3/Qcmj52z7rJ7XLyk7PF5k1wAaxS3TVJiSVlwZnqe
	vl0Cd8bvQ/vZCx5xVPR/PMfSwNjP3sXIwSEhYCKxZ0JEFyMnkCkmceHeerYuRi4OIYHLjBJ3
	njYyQzjHmSQOL5rDBlLFJqArsainmQnEFhFQk5jYdogFpIhZ4DSjxMeJv1hBEsICphJt908w
	g9gsAqoSHyZPZAexeQWcJb5N+8MIsU5BomXZLrA4p4CLxN/fN8FsIaCa2fMPsU9g5F3AyLCK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIySk+HYwtq+XOcQowMGoxMPbIfox
	SIg1say4MvcQoyQHk5Iob/0NoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3sRuoBxvSmJlVWpR
	PkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJ3EshQwaLU9NSKtMycEoQ0EwcniOAC
	2cADtGHzdZANxQWJucWZ6RBFpxgVpcR554JMEABJZJTmwQ2ARf8rRnGgf4R5DUGqeICJA677
	FdBgJqDB61zfgwwuSURISTUwlvI6T9/8OctDqnYZT5q/x7dna40+Ci2fc+Vlx1qlS0tmCuVd
	fqcyvzxTJznYzu5kwUquGfZ/ny3f25PO+VfijpKRynY/y4aYmFOrGA4WvUg4uVekPWbaOvEF
	c08VeOnfNPnJFyaXLMI3q9Nn+ftL9jqr5680nTY94Nw1fs8vEu5T36f3qX8OUmIp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241595>

Change the logic a little bit so that we can use skip_prefix() instead
of doing pointer arithmetic with hardcoded numbers.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/show-branch.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f2c3b19..aee7fe5 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -475,14 +475,15 @@ static void snarf_refs(int head, int remotes)
 static int rev_is_head(const char *head, int headlen, const char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
+	const char *short_name;
+
 	if ((!head[0]) ||
 	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
 	head = skip_prefix_if_present(head, "refs/heads/");
-	if (starts_with(name, "refs/heads/"))
-		name += 11;
-	else if (starts_with(name, "heads/"))
-		name += 6;
+	if ((short_name = skip_prefix(name, "refs/heads/")) ||
+	    (short_name = skip_prefix(name, "heads/")))
+		return !strcmp(head, short_name);
 	return !strcmp(head, name);
 }
 
-- 
1.8.5.3
