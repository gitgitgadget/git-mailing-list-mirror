From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 07/21] remote: simplify guess_remote_head()
Date: Wed, 25 Feb 2009 03:32:14 -0500
Message-ID: <7a4c3693fd5f1e53a63182a2da9ed9e46fb99441.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFF4-0000Xo-7z
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759606AbZBYIc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759396AbZBYIc4
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:32:56 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:52135 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758947AbZBYIct (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:49 -0500
Received: by an-out-0708.google.com with SMTP id c2so1348060anc.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Z/G8LO/SY2xk54fevfny0bucYjAILpIvzxQG6gSqMMM=;
        b=s4aSujK7adj9wJL3aX8Ik56kMUp0p41ZEibz3J6axUtCHPiRMW47rSbjXkB1c2J7IU
         qA0o4PjLGJ0M6W/6iHz9aD0CPdjUzxwQ2O4I/xIjY9BGhQfilhhH1Qt0jeYGcBK9Ws+v
         6s1WAEoQRZ46p225MgG1jx6kRC5O3VVZiMktc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=K6Vam/NWiv7A7SPz1Q90US/KmVMRC5oU7LlkKd/Lea3E+z19HlDhQ4sFbqn+YArsYH
         76R2ElnWvvxngsr19OD7TKvG4n2xMGtI2h+VqRUNE1H8d8t4RkD/EqnaSyvLgGBKScFg
         cosR7RilBG07UZ8YdbrAbQq2gEwb9cC0vuFx0=
Received: by 10.100.105.9 with SMTP id d9mr810766anc.142.1235550767389;
        Wed, 25 Feb 2009 00:32:47 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d21sm12052756and.46.2009.02.25.00.32.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:46 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111405>

This function had complications which made it hard to extend.

- It used to do two things: find the HEAD ref, and then find a
  matching ref, optionally returning the former via assignment to a
  passed-in pointer. Since finding HEAD is a one-liner, just have a
  caller do it themselves and pass it as an argument.

- It used to manually search through the ref list for
  refs/heads/master; this can be a one-line call to
  find_ref_by_name.

Originally contributed by Jeff King along with the next commit as a
single patch.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I split Jeff's patch into two as it makes the diff a littler easier on
the eyes and the history is clearer this way.

 builtin-clone.c |    4 ++--
 remote.c        |   31 ++++++++-----------------------
 remote.h        |   13 ++++++-------
 3 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index d179d1c..f9ce4fb 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -509,8 +509,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
 
-		head_points_at = guess_remote_head(refs, mapped_refs,
-						   &remote_head);
+		remote_head = find_ref_by_name(refs, "HEAD");
+		head_points_at = guess_remote_head(remote_head, mapped_refs);
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
diff --git a/remote.c b/remote.c
index 49a183e..aed760e 100644
--- a/remote.c
+++ b/remote.c
@@ -1452,37 +1452,22 @@ struct ref *get_local_heads(void)
 	return local_refs;
 }
 
-const struct ref *guess_remote_head(const struct ref *refs,
-				    const struct ref *mapped_refs,
-				    const struct ref **remote_head_p)
+const struct ref *guess_remote_head(const struct ref *head,
+				    const struct ref *refs)
 {
-	const struct ref *remote_head = NULL;
-	const struct ref *remote_master = NULL;
 	const struct ref *r;
-	for (r = refs; r; r = r->next)
-		if (!strcmp(r->name, "HEAD"))
-			remote_head = r;
 
-	for (r = mapped_refs; r; r = r->next)
-		if (!strcmp(r->name, "refs/heads/master"))
-			remote_master = r;
-
-	if (remote_head_p)
-		*remote_head_p = remote_head;
-
-	/* If there's no HEAD value at all, never mind. */
-	if (!remote_head)
+	if (!head)
 		return NULL;
 
 	/* If refs/heads/master could be right, it is. */
-	if (remote_master && !hashcmp(remote_master->old_sha1,
-				      remote_head->old_sha1))
-		return remote_master;
+	r = find_ref_by_name(refs, "refs/heads/master");
+	if (r && !hashcmp(r->old_sha1, head->old_sha1))
+		return r;
 
 	/* Look for another ref that points there */
-	for (r = mapped_refs; r; r = r->next)
-		if (r != remote_head &&
-		    !hashcmp(r->old_sha1, remote_head->old_sha1))
+	for (r = refs; r; r = r->next)
+		if (r != head && !hashcmp(r->old_sha1, head->old_sha1))
 			return r;
 
 	/* Nothing is the same */
diff --git a/remote.h b/remote.h
index 9605da9..db49ce0 100644
--- a/remote.h
+++ b/remote.h
@@ -139,13 +139,12 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
 struct ref *get_local_heads(void);
+
 /*
- * Look in refs for HEAD. Then look for a matching SHA1 in mapped_refs,
- * first checking if refs/heads/master matches. Return NULL if nothing matches
- * or if there is no HEAD in refs. remote_head_p is assigned HEAD if not NULL.
+ * Look for a ref in refs whose SHA1 matches head, first checking if
+ * refs/heads/master matches. Return NULL if nothing matches or if head
+ * is NULL.
  */
-const struct ref *guess_remote_head(const struct ref *refs,
-				    const struct ref *mapped_refs,
-				    const struct ref **remote_head_p);
-
+const struct ref *guess_remote_head(const struct ref *head,
+				    const struct ref *refs);
 #endif
-- 
1.6.2.rc1.291.g83eb
