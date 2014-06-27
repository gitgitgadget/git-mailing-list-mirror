From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] resolve_gitlink_ref_recursive(): verify format of symbolic refs
Date: Fri, 27 Jun 2014 13:01:17 +0200
Message-ID: <1403866877-15733-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jens Lehmann <jens.lehmann@web.de>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 13:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0TuP-0007Pb-5G
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 13:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbaF0LB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 07:01:28 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63138 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753417AbaF0LB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 07:01:27 -0400
X-AuditID: 12074413-f79ed6d000002501-49-53ad4f06c9ba
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B0.F5.09473.60F4DA35; Fri, 27 Jun 2014 07:01:26 -0400 (EDT)
Received: from michael.fritz.box (p4FC97742.dip0.t-ipconnect.de [79.201.119.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5RB1Nva024781
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 27 Jun 2014 07:01:25 -0400
X-Mailer: git-send-email 2.0.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqMvmvzbY4NphcYuuK91MFg29V5gt
	Jk5bzGxxe8V8ZgcWj7/vPzB5XLyk7PF5k5zH7WfbWAJYorhtkhJLyoIz0/P07RK4M+a8nstY
	MJ29YuPzd+wNjK9Zuxg5OSQETCQ2fnnADmGLSVy4t56ti5GLQ0jgMqNEw9nLTBDOCSaJR9Oe
	MIFUsQnoSizqaQazRQTUJCa2HWIBsZkFciXeLj/NCGILCwRITFx3D2wqi4CqxKru7WA1vAIu
	Eqt6J7JBbJOTaLjxiW0CI/cCRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWb
	GCEBIbyDcddJuUOMAhyMSjy8Bh5rgoVYE8uKK3MPMUpyMCmJ8jq6rg0W4kvKT6nMSCzOiC8q
	zUktPsQowcGsJMI72QMox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS
	4PXyA2oULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB4V6fDEw2EFSPEB73/mC7C0u
	SMwFikK0nmJUlBLnDQZJCIAkMkrz4MbC4vwVozjQl8K8F0CqeIApAq77FdBgJqDB5gWrQAaX
	JCKkpBoY6ytfP/+3+YHq8urIQt3c6fpCxumLYrUOuSxLiy+Xkpms8+jq5h0XtUwn1p1pMhPI
	dDOzV3NRZ+F9cPNDkPt95TXXnCz0excc+8obkSS0rujm7GulDRmC8pf8nGIdrucJRn+c37Ai
	M/VUazujzxWnAGZTKdOycM/ooK+rbm+XWzGL8VnNIjUlluKMREMt5qLiRADJhuXp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252544>

When reading a symbolic ref via resolve_gitlink_ref_recursive(), check
that the reference name that is pointed at is formatted correctly,
using the same check as resolve_ref_unsafe() uses for non-gitlink
references.  This prevents bogosity like

    ref: ../../other/file

from causing problems.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Given that symbolic references cannot be transferred via the Git
protocol, I do not expect this bug to be exploitable.

 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index dc45774..7da8e7d 100644
--- a/refs.c
+++ b/refs.c
@@ -1273,6 +1273,9 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	while (isspace(*p))
 		p++;
 
+	if (check_refname_format(p, REFNAME_ALLOW_ONELEVEL))
+		return -1;
+
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-- 
2.0.0
