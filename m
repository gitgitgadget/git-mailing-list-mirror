From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/4] Teach git-fetch to grab a tag at the same time as a commit
Date: Thu, 28 Feb 2008 03:43:05 -0500
Message-ID: <20080228084305.GD16870@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 09:43:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUeMt-0008Pd-Ou
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 09:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbYB1InO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 03:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754602AbYB1InO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 03:43:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32831 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbYB1InL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 03:43:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JUeM5-00013O-49; Thu, 28 Feb 2008 03:43:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E3E3B20FBAE; Thu, 28 Feb 2008 03:43:05 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75368>

If the situation is the following on the remote and L is the common
base between both sides:

          T - tag1    S - tag2
         /           /
    L - A - O - O - B
     \               \
      origin/master   master

and we have decided to fetch "master" to acquire the range L..B we
can also nab tag S at the same time during the first connection,
as we can clearly see from the refs advertised by upload-pack that
S^{} = B and master = B.

Unfortunately we still cannot nab T at the same time as we are not
able to see that T^{} will also be in the range implied by L..B.
Such computations must be performed on the remote side (not yet
supported) or on the client side as post-processing (the current
behavior).

This optimization is an extension of the previous one in that it
helps on projects which tend to publish both a new commit and a
new tag, then lay idle for a while before publishing anything else.
Most followers are able to download both the new commit and the new
tag in one connection, rather than two.  git.git tends to follow
such patterns with its roughly once-daily updates from Junio.

A protocol extension and additional server side logic would be
necessary to also ensure T is grabbed on the first connection.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index a80f95b..eddf788 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -458,6 +458,17 @@ static int add_existing(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
+static int will_fetch(struct ref **head, const unsigned char *sha1)
+{
+	struct ref *rm = *head;
+	while (rm) {
+		if (!hashcmp(rm->old_sha1, sha1))
+			return 1;
+		rm = rm->next;
+	}
+	return 0;
+}
+
 static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
@@ -494,7 +505,8 @@ static void find_non_local_tags(struct transport *transport,
 
 		if (!path_list_has_path(&existing_refs, ref_name) &&
 		    !path_list_has_path(&new_refs, ref_name) &&
-		    has_sha1_file(ref->old_sha1)) {
+		    (has_sha1_file(ref->old_sha1) ||
+		     will_fetch(head, ref->old_sha1))) {
 			path_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref(strlen(ref_name) + 1);
-- 
1.5.4.3.393.g5540
