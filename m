From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 08/21] remote: let guess_remote_head() optionally return all matches
Date: Fri, 27 Feb 2009 14:10:05 -0500
Message-ID: <9d146489b82f3f8108903dcb9acbe569a4b690a1.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235759631.git.jaysoffian@gmail.com>
 <45e13cde37f6da8e6c379b5deea81b00148b4355.1235759631.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 20:11:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld87h-0000L0-2A
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbZB0TKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756510AbZB0TKT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:10:19 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:43671 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbZB0TKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:10:16 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2090607qwi.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 11:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :references:mime-version:content-type:content-transfer-encoding;
        bh=cOy8AseVZGw4E8KPHfcNhBqW5a9CNwVKJYBH99/72UM=;
        b=ph4UWf/qczV3/P8B9NGFgqNcxvkDdZpgK7mcP2oBQQL/VmgL8l18iwa8vbvPGD6XwF
         yFU699ufonT5vPGPMt2keE+a6gYKkRYwcWn5NbGgJiqYyoPF0L1dLSLK5+GDh3AKSeDn
         khlrnJFBbataXH06ygbRCk4Xr3VqbHJScyxWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eQukizgneBe3jM3LLtNXgZxtWo0jEvPW+YnDRqGBTswEOsLeF13X5ye8sRR3U9uFGS
         4RhYs4tmSyl8kBpjN/v2ORu7L4o7YbAtIqn2+Rt0NoM1Yvawb5jGJsZVPdeuadtBoBdQ
         hhwJh98AnnF6jNnDyO60fHl3a3PtOajB/zkU4=
Received: by 10.224.53.210 with SMTP id n18mr4660479qag.129.1235761814669;
        Fri, 27 Feb 2009 11:10:14 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 2sm2212453qwi.48.2009.02.27.11.10.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Feb 2009 11:10:13 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
In-Reply-To: <45e13cde37f6da8e6c379b5deea81b00148b4355.1235759631.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111697>

Determining HEAD is ambiguous since it is done by comparing SHA1s.

In the case of multiple matches we return refs/heads/master if it
matches, else we return the first match we encounter. builtin-remote
needs all matches returned to it, so add a flag for it to request such.

To be simple and consistent, the return value is now a copy (including
peer_ref) of the matching refs.

Originally contributed by Jeff King along with the prior commit as a
single patch.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This patch replaces 08/21 in the original series
series - http://article.gmane.org/gmane.comp.version-control.git/111394

 builtin-clone.c |    2 +-
 remote.c        |   29 +++++++++++++++++++----------
 remote.h        |   14 ++++++++------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index f9ce4fb..3146ca8 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -510,7 +510,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
 
 		remote_head = find_ref_by_name(refs, "HEAD");
-		head_points_at = guess_remote_head(remote_head, mapped_refs);
+		head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
diff --git a/remote.c b/remote.c
index 22203ea..304e967 100644
--- a/remote.c
+++ b/remote.c
@@ -1460,24 +1460,33 @@ struct ref *get_local_heads(void)
 	return local_refs;
 }
 
-const struct ref *guess_remote_head(const struct ref *head,
-				    const struct ref *refs)
+struct ref *guess_remote_head(const struct ref *head,
+			      const struct ref *refs,
+			      int all)
 {
 	const struct ref *r;
+	struct ref *list = NULL;
+	struct ref **tail = &list;
 
 	if (!head)
 		return NULL;
 
 	/* If refs/heads/master could be right, it is. */
-	r = find_ref_by_name(refs, "refs/heads/master");
-	if (r && !hashcmp(r->old_sha1, head->old_sha1))
-		return r;
+	if (!all) {
+		r = find_ref_by_name(refs, "refs/heads/master");
+		if (r && !hashcmp(r->old_sha1, head->old_sha1))
+			return copy_ref(r);
+	}
 
 	/* Look for another ref that points there */
-	for (r = refs; r; r = r->next)
-		if (r != head && !hashcmp(r->old_sha1, head->old_sha1))
-			return r;
+	for (r = refs; r; r = r->next) {
+		if (r != head && !hashcmp(r->old_sha1, head->old_sha1)) {
+			*tail = copy_ref(r);
+			tail = &((*tail)->next);
+			if (!all)
+				break;
+		}
+	}
 
-	/* Nothing is the same */
-	return NULL;
+	return list;
 }
diff --git a/remote.h b/remote.h
index db49ce0..de3d21b 100644
--- a/remote.h
+++ b/remote.h
@@ -139,12 +139,14 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
 struct ref *get_local_heads(void);
-
 /*
- * Look for a ref in refs whose SHA1 matches head, first checking if
- * refs/heads/master matches. Return NULL if nothing matches or if head
- * is NULL.
+ * Find refs from a list which are likely to be pointed to by the given HEAD
+ * ref. If 'all' is false, returns the most likely ref; otherwise, returns a
+ * list of all candidate refs. If no match is found (or 'head' is NULL),
+ * returns NULL. All returns are newly allocated and should be freed.
  */
-const struct ref *guess_remote_head(const struct ref *head,
-				    const struct ref *refs);
+struct ref *guess_remote_head(const struct ref *head,
+			      const struct ref *refs,
+			      int all);
+
 #endif
-- 
1.6.2.rc1.309.g5f417
