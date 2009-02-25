From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 08/21] remote: let guess_remote_head() optionally return all matches
Date: Wed, 25 Feb 2009 03:32:15 -0500
Message-ID: <ad3c408c208c8a829b1e4a0c0818e808b19e1dfc.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFF4-0000Xo-V4
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759646AbZBYIc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759372AbZBYIc5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:32:57 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:43044 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759317AbZBYIcw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:52 -0500
Received: by an-out-0708.google.com with SMTP id c2so1348077anc.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HuLcMaF3RVZ0q5ZejfTcrfMq3ONQ21C8i8p4oyNp9Hc=;
        b=rtOJOAjT+uuWvl/9EwVz8hY7Kg2fRLT1UsGrrTsJjkmc+fi/xZaaT5WIfSUvqXFd81
         pUSHe4le4VEBeFF4aK06iXK+Z51rxZtKKad5YbqXeklJ2Jf6Lv5dqf3XyYP8TIs57eky
         QGpub4N4TMj9kOFSY062h7D7gzkI0fSaNg2yA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kt81Uc/JrTsjLibSmpltTP2aSKx5TIBlJJaTDyvXQeihX0NfF3QVQl+xmXROyn0Upk
         lCMJ4t1Nrqnd6uvWxtJNGQJm+AbnweQql34vQnJuWFXYCfABIPYnjHp4c9FtElWG7wMb
         zF7VZ8bJoO5zcpj82UAiEY6i7WUKY/8DgksiY=
Received: by 10.100.213.18 with SMTP id l18mr861972ang.0.1235550769803;
        Wed, 25 Feb 2009 00:32:49 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c1sm8134073ana.0.2009.02.25.00.32.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:49 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111403>

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
 builtin-clone.c |    2 +-
 remote.c        |   36 ++++++++++++++++++++++++++----------
 remote.h        |   14 ++++++++------
 3 files changed, 35 insertions(+), 17 deletions(-)

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
index aed760e..3940a3c 100644
--- a/remote.c
+++ b/remote.c
@@ -1452,24 +1452,40 @@ struct ref *get_local_heads(void)
 	return local_refs;
 }
 
-const struct ref *guess_remote_head(const struct ref *head,
-				    const struct ref *refs)
+struct ref *copy_ref_with_peer(const struct ref *src)
+{
+	struct ref *dst = copy_ref(src);
+	dst->peer_ref = copy_ref(src->peer_ref);
+	return dst;
+}
+
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
+			return copy_ref_with_peer(r);
+	}
 
 	/* Look for another ref that points there */
-	for (r = refs; r; r = r->next)
-		if (r != head && !hashcmp(r->old_sha1, head->old_sha1))
-			return r;
+	for (r = refs; r; r = r->next) {
+		if (r != head && !hashcmp(r->old_sha1, head->old_sha1)) {
+			*tail = copy_ref_with_peer(r);
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
1.6.2.rc1.291.g83eb
