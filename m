From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix push with refspecs containing wildcards
Date: Fri, 8 Jun 2007 01:43:05 +0200
Message-ID: <20070607234305.GB10633@steel.home>
References: <20070607225302.GA10633@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 01:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRdH-0000l6-Br
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763659AbXFGXnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763668AbXFGXnI
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:43:08 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:26715 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763659AbXFGXnH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:43:07 -0400
Received: from tigra.home (Fc805.f.strato-dslnet.de [195.4.200.5])
	by post.webmailer.de (mrclete mo30) (RZmta 7.2)
	with ESMTP id 901ef7j57M7ZGS ; Fri, 8 Jun 2007 01:43:06 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 04DB0277BD;
	Fri,  8 Jun 2007 01:43:05 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D6D89BEA7; Fri,  8 Jun 2007 01:43:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070607225302.GA10633@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWosH
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49413>

Otherwise

    git push 'remote-name' 'refs/heads/*:refs/remotes/other/*'

will consider references in "refs/heads" of the remote repository
"remote-name", instead of the ones in "refs/remotes/other", which
the given refspec clearly means.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Fri, Jun 08, 2007 00:53:02 +0200:
> Try something like this:
> 
>     git-send-pack --remote=origin --thin /some/other/repo \
>     'refs/heads/*:refs/remotes/child/*'
> 
> The result looks broken: the sent reference are created not in
> refs/remotes/child/ but just in refs/heads/ of /some/other/repo.
> 

And as usual, I'm not sure if it is the right fix. Johannes has a
point: why the hell does send-pack parse the wildcards at all?!

 remote.c |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/remote.c b/remote.c
index d904616..33c8e50 100644
--- a/remote.c
+++ b/remote.c
@@ -501,16 +501,16 @@ static struct ref *find_ref_by_name(struct ref *list, const char *name)
 	return NULL;
 }
 
-static int check_pattern_match(struct refspec *rs, int rs_nr, struct ref *src)
+static const struct refspec *check_pattern_match(const struct refspec *rs,
+						 int rs_nr,
+						 const struct ref *src)
 {
 	int i;
-	if (!rs_nr)
-		return 1;
 	for (i = 0; i < rs_nr; i++) {
 		if (rs[i].pattern && !prefixcmp(src->name, rs[i].src))
-			return 1;
+			return rs + i;
 	}
-	return 0;
+	return NULL;
 }
 
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
@@ -525,29 +525,44 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	/* pick the remainder */
 	for ( ; src; src = src->next) {
 		struct ref *dst_peer;
+		const struct refspec *pat = NULL;
+		char *dst_name;
 		if (src->peer_ref)
 			continue;
-		if (!check_pattern_match(rs, nr_refspec, src))
-			continue;
+		if (nr_refspec) {
+			pat = check_pattern_match(rs, nr_refspec, src);
+			if (!pat)
+				continue;
+		}
 
-		dst_peer = find_ref_by_name(dst, src->name);
+		if (pat) {
+			dst_name = xmalloc(strlen(pat->dst) +
+					   strlen(src->name) -
+					   strlen(pat->src) + 2);
+			strcpy(dst_name, pat->dst);
+			strcat(dst_name, src->name + strlen(pat->src));
+		} else
+			dst_name = strdup(src->name);
+		dst_peer = find_ref_by_name(dst, dst_name);
 		if (dst_peer && dst_peer->peer_ref)
 			/* We're already sending something to this ref. */
-			continue;
+			goto free_name;
 		if (!dst_peer && !nr_refspec && !all)
 			/* Remote doesn't have it, and we have no
 			 * explicit pattern, and we don't have
 			 * --all. */
-			continue;
+			goto free_name;
 		if (!dst_peer) {
 			/* Create a new one and link it */
-			int len = strlen(src->name) + 1;
+			int len = strlen(dst_name) + 1;
 			dst_peer = xcalloc(1, sizeof(*dst_peer) + len);
-			memcpy(dst_peer->name, src->name, len);
+			memcpy(dst_peer->name, dst_name, len);
 			hashcpy(dst_peer->new_sha1, src->new_sha1);
 			link_dst_tail(dst_peer, dst_tail);
 		}
 		dst_peer->peer_ref = src;
+	free_name:
+		free(dst_name);
 	}
 	return 0;
 }
-- 
1.5.2.1.147.g7c82d
