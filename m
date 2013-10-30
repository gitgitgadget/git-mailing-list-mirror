From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/23] fetch: only opportunistically update references based on command line
Date: Wed, 30 Oct 2013 06:32:58 +0100
Message-ID: <1383111192-23780-10-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOX5-0007NG-H4
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964Ab3J3Fl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:29 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61760 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752886Ab3J3Fl1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:27 -0400
X-AuditID: 12074412-b7fc96d0000023d5-37-52709a54a4c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.D2.09173.45A90725; Wed, 30 Oct 2013 01:34:12 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIK014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:10 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqBsyqyDI4FCfgsX0rtUsFl1Xupks
	GnqvMFvMu7uLyWLVrWXMFitn3GC0uL1iPrPF085Ki3kvXrBZ/GjpYXbg8vj7/gOTx6V1L5k8
	Dv2Zwu7x7EQ7m8ell9/ZPJ717mH0uHhJ2WNGy2sWj8+b5DwOXH7MFsAVxW2TlFhSFpyZnqdv
	l8Cd0bHBvmCrYsXlhQ9ZGhiXSnUxcnBICJhIfL4R3sXICWSKSVy4t56ti5GLQ0jgMqPE30XN
	zBDOFSaJH2daWECq2AR0JRb1NDOB2CICahIT2w6xgBQxC0xkljg+fRFYkbBAvET3zjvMIBtY
	BFQlfq/MBwnzCrhK/Fn+mQlim4LEjeaprCA2J1D8066b7CC2kICLRFP7Z/YJjLwLGBlWMcol
	5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoSErNAOxvUn5Q4xCnAwKvHwGjzIDxJi
	TSwrrsw9xCjJwaQkyps2pSBIiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv9ONA5bwpiZVVqUX5
	MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErzKM4GGChalpqdWpGXmlCCkmTg4QYZz
	SYkUp+alpBYllpZkxIPiIr4YGBkgKR6gvTwg7bzFBYm5QFGI1lOMuhwtDz5/YxRiycvPS5US
	51UAKRIAKcoozYNbAUtQrxjFgT4WhhjFA0xucJNeAS1hAlqyhyUPZElJIkJKqoGx2YYpVPfo
	Qe/oeE2epyeXTN5o+aj186wjH3KmrSgWUtb5brNHoebQy2tZurJhdhtZ79yvFa97 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236969>

The old code processed (tags == TAGS_SET) before adding the entries
used to opportunistically update references mentioned on the command
line.  The result was that all tags were also considered candidates
for opportunistic updating.

This is harmless for two reasons: (a) because it would only add
entries if there is a configured refspec that covers tags *and* both
--tags and another refspec appear on the command-line; (b) because any
extra entries would be deleted later by the call to
ref_remove_duplicates() anyway.

But, to avoid extra work and extra memory usage, and to make the
implementation better match the intention, change the algorithm
slightly: compute the opportunistic refspecs based only on the
command-line arguments, storing the results into a separate temporary
list.  Then add the tags (which have to come earlier in the list so
that they are not de-duped in favor of an opportunistic entry).  Then
concatenate the temporary list onto the main list.

This change will also make later changes easier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61e8117..0849f09 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -272,32 +272,50 @@ static struct ref *get_ref_map(struct transport *transport,
 	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
 	if (refspec_count || tags == TAGS_SET) {
-		struct ref **old_tail;
+		/* opportunistically-updated references: */
+		struct ref *orefs = NULL, **oref_tail = &orefs;
 
 		for (i = 0; i < refspec_count; i++) {
 			get_fetch_map(remote_refs, &refspecs[i], &tail, 0);
 			if (refspecs[i].dst && refspecs[i].dst[0])
 				*autotags = 1;
 		}
-		/* Merge everything on the command line, but not --tags */
+		/* Merge everything on the command line (but not --tags) */
 		for (rm = ref_map; rm; rm = rm->next)
 			rm->fetch_head_status = FETCH_HEAD_MERGE;
-		if (tags == TAGS_SET)
-			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 
 		/*
-		 * For any refs that we happen to be fetching via command-line
-		 * arguments, take the opportunity to update their configured
-		 * counterparts. However, we do not want to mention these
-		 * entries in FETCH_HEAD at all, as they would simply be
-		 * duplicates of existing entries.
+		 * For any refs that we happen to be fetching via
+		 * command-line arguments, the destination ref might
+		 * have been missing or have been different than the
+		 * remote-tracking ref that would be derived from the
+		 * configured refspec.  In these cases, we want to
+		 * take the opportunity to update their configured
+		 * remote-tracking reference.  However, we do not want
+		 * to mention these entries in FETCH_HEAD at all, as
+		 * they would simply be duplicates of existing
+		 * entries, so we set them FETCH_HEAD_IGNORE below.
+		 *
+		 * We compute these entries now, based only on the
+		 * refspecs specified on the command line.  But we add
+		 * them to the list following the refspecs resulting
+		 * from the tags option so that one of the latter,
+		 * which has FETCH_HEAD_NOT_FOR_MERGE, is not removed
+		 * by ref_remove_duplicates() in favor of one of these
+		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		old_tail = tail;
 		for (i = 0; i < transport->remote->fetch_refspec_nr; i++)
 			get_fetch_map(ref_map, &transport->remote->fetch[i],
-				      &tail, 1);
-		for (rm = *old_tail; rm; rm = rm->next)
+				      &oref_tail, 1);
+
+		if (tags == TAGS_SET)
+			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
+
+		*tail = orefs;
+		for (rm = orefs; rm; rm = rm->next) {
 			rm->fetch_head_status = FETCH_HEAD_IGNORE;
+			tail = &rm->next;
+		}
 	} else {
 		/* Use the defaults */
 		struct remote *remote = transport->remote;
@@ -334,8 +352,10 @@ static struct ref *get_ref_map(struct transport *transport,
 			tail = &ref_map->next;
 		}
 	}
+
 	if (tags == TAGS_DEFAULT && *autotags)
 		find_non_local_tags(transport, &ref_map, &tail);
+
 	ref_remove_duplicates(ref_map);
 
 	return ref_map;
-- 
1.8.4.1
