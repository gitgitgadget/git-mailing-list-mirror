From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/19] prune_remote(): use delete_refs()
Date: Mon, 22 Jun 2015 16:02:58 +0200
Message-ID: <4d2d496d5ac550923110960fcd26a57c4a7b860c.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:03:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72K6-0005Z7-Au
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933620AbbFVODi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:03:38 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50088 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933443AbbFVOD2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:28 -0400
X-AuditID: 1207440c-f79e16d000002a6e-ef-558815ac9efc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.D4.10862.CA518855; Mon, 22 Jun 2015 10:03:24 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cc5030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:23 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqLtGtCPU4P9zIYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ1z9MZ+14AF/xbI3D9gaGJ/wdDFycEgImEjsmO7YxcgJZIpJXLi3nq2LkYtDSOAyo8Sv
	iTcYIZyTTBKPP/9gBaliE9CVWNTTzARiiwioSUxsO8QCUsQs0MEocWH5NnaQhLCAtcTJf4fB
	ilgEVCW2LD7CDGLzCkRJvG6Zyg6xTk7i/PGfYHFOAQuJ+fv+g8WFBMwlJs58xDKBkXcBI8Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJCQ4tnB+G2dzCFGAQ5GJR5eB9v2
	UCHWxLLiytxDjJIcTEqivAdeA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8LacBcrxpiRWVqUW
	5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4/UQ6QoUEi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQbERXwyMDpAUD9DepSDtvMUFiblAUYjWU4yKUuK8/iAJAZBERmke
	3FhYonjFKA70pTDvT2GgKh5gkoHrfgU0mAlo8JfcNpDBJYkIKakGxuLX9/aIHy2f0Rv2Y4tC
	fda/koK5to4KR9a5/A/RTXBbb3ROdwavQRhnyr7nR+4yyth8+d3GlGq4VuifwZ+Kjk3TMvUm
	s2zIrLN1uWayPkB3s1v709gbvA8iqkP7WoVUu3uj2VeEv/sv+PyEq+jmCw8SFjjH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272345>

This slightly changes how errors are reported. The old and new code
both report errors that come from repack_without_refs() the same way.
But if an error occurs within delete_ref(), the old version only
emitted an error within delete_ref() without further comment. The new
version (in delete_refs()) still emits that error, but then follows it
up with

    error(_("could not remove reference %s"), refname)

The "could not remove reference" error originally came from a similar
message in remove_branches() (from builtin/remote.c).

This is an improvement, because the error from delete_ref() (which
usually comes from ref_transaction_commit()) can be pretty low-level,
like

    Cannot lock ref '%s': unable to resolve reference %s: %s

where the last "%s" is the original strerror.

In any case, I don't think we need to sweat the details too much,
because these errors should only ever be seen in the case of a broken
repository or a race between two processes; i.e., only in pretty rare
and anomalous situations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c8dc724..cc3c741 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1314,19 +1314,12 @@ static int prune_remote(const char *remote, int dry_run)
 		string_list_append(&refs_to_prune, item->util);
 	string_list_sort(&refs_to_prune);
 
-	if (!dry_run) {
-		struct strbuf err = STRBUF_INIT;
-		if (repack_without_refs(&refs_to_prune, &err))
-			result |= error("%s", err.buf);
-		strbuf_release(&err);
-	}
+	if (!dry_run)
+		result |= delete_refs(&refs_to_prune);
 
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname = item->util;
 
-		if (!dry_run)
-			result |= delete_ref(refname, NULL, 0);
-
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
 			       abbrev_ref(refname, "refs/remotes/"));
-- 
2.1.4
