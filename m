From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/18] report_refname_conflict(): inline function
Date: Mon, 11 May 2015 17:25:08 +0200
Message-ID: <1431357920-25090-7-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:27:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpbs-0003Bm-7G
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbbEKP1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:27:07 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61531 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638AbbEKPZj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:39 -0400
X-AuditID: 12074414-f797f6d000004084-28-5550c9f306f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 72.94.16516.3F9C0555; Mon, 11 May 2015 11:25:39 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnI002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:38 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqPv5ZECowa9lAhZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7owHb+6xF8zgrvi28wdLA+M7ji5GTg4JAROJheceMULYYhIX7q1n62Lk
	4hASuMwocfjBTyjnOJPEoyln2UGq2AR0JRb1NDOB2CICahIT2w6xgBQxC+xilLi3dCoLSEJY
	wEWic9EZNhCbRUBVYtnpG8wgNi9QfP6bz+wQ6+Qkzh//CRbnFHCVWHr1MlivEFBN0+N7LBMY
	eRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0rXQy80s0UtNKd3ECAkzkR2MR07KHWIU4GBU
	4uE1uOAfKsSaWFZcmXuIUZKDSUmU99fegFAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzKa4By
	vCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoSvI0ngBoFi1LTUyvSMnNK
	ENJMHJwgw7mkRIpT81JSixJLSzLiQdERXwyMD5AUD9De3SDtvMUFiblAUYjWU4yKUuK8C0ES
	AiCJjNI8uLGw5PGKURzoS2HejyBVPMDEA9f9CmgwE9BgxziwwSWJCCmpBsaCjxG8uvXLt2+4
	JLOw+nrxhoNr2SPf508K22Z9t+P2zyMmbxsbNqZs9kzPfaEik6hhvzM0ZHreoZlOVsdrFtTM
	u9F1PROYKh0jC1OKcqM39HzeO2P2nU+POiVto47GRDppn6xM9T+k84xlsavciYrk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268792>

It wasn't pulling its weight. And we are about to need code similar to
this where no ref_entry is available and with more diverse error
messages. Rather than try to generalize the function, just inline it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 6bdd34f..7422594 100644
--- a/refs.c
+++ b/refs.c
@@ -857,12 +857,6 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 	return 1;
 }
 
-static void report_refname_conflict(struct ref_entry *entry,
-				    const char *refname)
-{
-	error("'%s' exists; cannot create '%s'", entry->name, refname);
-}
-
 /*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.  If
@@ -918,7 +912,7 @@ static int is_refname_available(const char *refname,
 				 */
 				return 1;
 			}
-			report_refname_conflict(entry, refname);
+			error("'%s' exists; cannot create '%s'", entry->name, refname);
 			return 0;
 		}
 
@@ -969,7 +963,7 @@ static int is_refname_available(const char *refname,
 		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
 			return 1;
 
-		report_refname_conflict(data.found, refname);
+		error("'%s' exists; cannot create '%s'", data.found->name, refname);
 		return 0;
 	}
 
-- 
2.1.4
