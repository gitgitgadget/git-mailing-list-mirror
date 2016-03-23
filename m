From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/21] resolve_ref_1(): reorder code
Date: Wed, 23 Mar 2016 11:04:27 +0100
Message-ID: <5c86c4c5969701a5b8a098591cc4a9e522beb97c.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:16:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmi-0001Ah-MY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbcCWKMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:55 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49322 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754703AbcCWKMm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:42 -0400
X-AuditID: 12074411-fd3ff700000071cf-eb-56f26a4e5877
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 9D.17.29135.E4A62F65; Wed, 23 Mar 2016 06:05:02 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1F018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:01 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqBuQ9SnMYKWiRdeVbiaLht4rzBa3
	V8xntuie8pbR4kdLD7PFzKvWDmwef99/YPLYOesuu8ez3j2MHhcvKXvsX7qNzePzJrkAtihu
	m6TEkrLgzPQ8fbsE7ozD83YzFfSzVWx6+5uxgfExSxcjJ4eEgInE2a4PzF2MXBxCAlsZJc4d
	fscEkhASOMkksXl3BIjNJqArsainGSwuIqAmMbHtEAtIA7PAAkaJjYsXM4MkhIEmTZneDzaV
	RUBVYtqs74wgNq9AlETLsv/sENuUJDY8uAA2iFPAQuLkyaWMEMvMJbY/WMs0gZFnASPDKka5
	xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQYBLcwTjjpNwhRgEORiUe3sJzH8OE
	WBPLiitzDzFKcjApifKeD/oUJsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmENyQDKMebklhZlVqU
	D5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuC9lg7UKFiUmp5akZaZU4KQZuLgBBnO
	JSVSnJqXklqUWFqSEQ+KgfhiYBSApHiA9kaC7S0uSMwFikK0nmLU5Vjw4/ZaJiGWvPy8VClx
	Xg2QIgGQoozSPLgVsNTxilEc6GNh3nqQKh5g2oGb9ApoCRPQkoU+YEtKEhFSUg2MPR07fPP1
	1dU//1yyn+1I82lNW6cLAi5XjbKPOig5zOmZuNZh9v2DEi5LmtKeZZ3kWJQg9GC9x+b2i1FO
	x3NYXhnx5tzfnGCcfOTf5QtLl31ZHbqaNXrdBYNu5r/7Cm7bOjVJbTWpMmfMKkjK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289633>

There is no need to adjust *flags if we're just about to fail.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 69ec903..60f1493 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1542,13 +1542,13 @@ static const char *resolve_ref_1(const char *refname,
 			return refname;
 		}
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-			*flags |= REF_ISBROKEN;
-
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname)) {
 				errno = EINVAL;
 				return NULL;
 			}
+
+			*flags |= REF_ISBROKEN;
 			bad_name = 1;
 		}
 	}
-- 
2.8.0.rc3
