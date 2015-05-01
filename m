From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/18] reflog_expire(): integrate lock_ref_sha1_basic() errors into ours
Date: Fri,  1 May 2015 14:25:58 +0200
Message-ID: <1430483158-14349-19-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1p-0001As-3C
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbbEAM0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:39 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54459 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753794AbbEAM0e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:34 -0400
X-AuditID: 12074412-f79e46d0000036b4-ab-554370f8b53b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 76.9C.14004.8F073455; Fri,  1 May 2015 08:26:32 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zv004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:31 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqPujwDnUYNIDQ4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ5zpOMZWcIqtouljM2sD43LWLkZODgkBE4n9e9cyQthiEhfurWfrYuTiEBK4zCjx6PY7
	JgjnBJPE7P8bwDrYBHQlFvU0M4HYIgJqEhPbDrGAFDELdDBKXFi+jR0kISwQIbFx8wOwIhYB
	VYnP806DxXkFXCX+nLnOBLFOTuL88Z/MXYwcHJxA8S9TE0HCQgIuEve/f2WbwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZISAntYFx/Uu4QowAHoxIP74ZjTqFC
	rIllxZW5hxglOZiURHltE5xDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw3lMHyvGmJFZWpRbl
	w6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfD+ygdqFCxKTU+tSMvMKUFIM3Fwggzn
	khIpTs1LSS1KLC3JiAfFRnwxMDpAUjxAe5eBtPMWFyTmAkUhWk8x6nLcmfJ/EZMQS15+XqqU
	OO8JkCIBkKKM0jy4FbAE8opRHOhjYV5WYDoR4gEmH7hJr4CWMAEtOX/LAWRJSSJCSqqBUedV
	7IXbEZwZ6x+acascm+J2uPtnoFirkL+vyr1wyWaB/xcYJq8tV7CY8CTtx4/N/5slfJ4xpSTv
	WPkyXqgqpPmaivL2fq51BgFJ1/qjFCbHvOFa2Gn9cGd4zxW96Wc2/3+968t1vTvH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268124>

Now that lock_ref_sha1_basic() gives us back its error messages via a
strbuf, incorporate its error message into our error message rather
than emitting two separate error messages.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index f64f6ae..0bff903 100644
--- a/refs.c
+++ b/refs.c
@@ -4129,9 +4129,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 */
 	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type, &err);
 	if (!lock) {
-		error("%s", err.buf);
+		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
-		return error("cannot lock ref '%s'", refname);
+		return -1;
 	}
 	if (!reflog_exists(refname)) {
 		unlock_ref(lock);
-- 
2.1.4
