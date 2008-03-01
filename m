From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 4/7] Allow builtin-fetch's find_non_local_tags to append onto a list
Date: Sat, 1 Mar 2008 00:25:08 -0500
Message-ID: <20080301052508.GD27300@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 06:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVKEQ-0004xA-41
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 06:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYCAFZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYCAFZM
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:25:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48603 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYCAFZL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:25:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVKDd-0000tH-F7; Sat, 01 Mar 2008 00:25:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8681120FBAE; Sat,  1 Mar 2008 00:25:08 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75616>

By allowing the function to append onto the end of an existing list
we can do more interesting things, like join the list of tags we
want to fetch into the first fetch, rather than the second.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 5bce20f..1d3ce77 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -453,7 +453,9 @@ static int add_existing(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static struct ref *find_non_local_tags(struct transport *transport)
+static void find_non_local_tags(struct transport *transport,
+			struct ref **head,
+			struct ref ***tail)
 {
 	static struct path_list existing_refs = { NULL, 0, 0, 0 };
 	struct path_list new_refs = { NULL, 0, 0, 1 };
@@ -462,8 +464,6 @@ static struct ref *find_non_local_tags(struct transport *transport)
 	const unsigned char *ref_sha1;
 	const struct ref *tag_ref;
 	struct ref *rm = NULL;
-	struct ref *ref_map = NULL;
-	struct ref **tail = &ref_map;
 	const struct ref *ref;
 
 	for_each_ref(add_existing, &existing_refs);
@@ -498,13 +498,11 @@ static struct ref *find_non_local_tags(struct transport *transport)
 			strcpy(rm->peer_ref->name, ref_name);
 			hashcpy(rm->old_sha1, ref_sha1);
 
-			*tail = rm;
-			tail = &rm->next;
+			**tail = rm;
+			*tail = &rm->next;
 		}
 		free(ref_name);
 	}
