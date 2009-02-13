From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/4] builtin-clone: move locate_head() to remote.c so it can be re-used
Date: Fri, 13 Feb 2009 03:54:32 -0500
Message-ID: <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, peff@peff.net,
	gitster@pobox.com, barkalow@iabervon.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 09:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXtqC-0003ao-QM
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 09:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbZBMIym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 03:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbZBMIym
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 03:54:42 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:50221 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbZBMIyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 03:54:41 -0500
Received: by yw-out-2324.google.com with SMTP id 5so588604ywh.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 00:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ma7GdJ6wNW+q9YIG/W4kDhqpDuNNFSu0WW01XksJQKM=;
        b=mKuodAMqyIln7Ge+Z73oLpDqbAgjRu89o0wnYybW+8zLGDwZikoMJmgKW4YL08FeT7
         1vk4UEkKsbPxtl/rcSyp+9GrE8IN9gDwHIz5cY29E/WXLdgp8T5OJAAFJ/Ntd9SOKSwM
         hbj/2TVKJNc+r/vSVfaG0eL0oHlVlpyKX5D/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=w+d9StM4GjcBEf/9/45MJ6nQhblYRwEW3KJvx0mr9BPp3NNLNUKvv8W4EkarJAUSMc
         KQVXLsu3FeAyAH4xV+JYwvl+bUaWE8NeOcX685JdShZjSGu3WVCbjrwS9EzKiXqFP5Ct
         E/8sT19XK/5eq0oNV/1pJOL2jfzwp3DbPtL4Y=
Received: by 10.101.71.6 with SMTP id y6mr876623ank.103.1234515279741;
        Fri, 13 Feb 2009 00:54:39 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b32sm1487600ana.15.2009.02.13.00.54.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 00:54:39 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.209.g7c178
In-Reply-To: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109728>

Move locate_head() to remote.c and rename it to guess_remote_head() to
more accurately reflect what it does. This is in preparation for being
able to call it from builtin-remote.c

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-clone.c |   41 +++--------------------------------------
 remote.c        |   37 +++++++++++++++++++++++++++++++++++++
 remote.h        |    9 +++++++++
 3 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index f73029e..280b866 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -20,6 +20,7 @@
 #include "dir.h"
 #include "pack-refs.h"
 #include "sigchain.h"
+#include "remote.h"
 
 /*
  * Overall FIXMEs:
@@ -293,43 +294,6 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
 
-static const struct ref *locate_head(const struct ref *refs,
-				     const struct ref *mapped_refs,
-				     const struct ref **remote_head_p)
-{
-	const struct ref *remote_head = NULL;
-	const struct ref *remote_master = NULL;
-	const struct ref *r;
-	for (r = refs; r; r = r->next)
-		if (!strcmp(r->name, "HEAD"))
-			remote_head = r;
-
-	for (r = mapped_refs; r; r = r->next)
-		if (!strcmp(r->name, "refs/heads/master"))
-			remote_master = r;
-
-	if (remote_head_p)
-		*remote_head_p = remote_head;
-
-	/* If there's no HEAD value at all, never mind. */
-	if (!remote_head)
-		return NULL;
-
-	/* If refs/heads/master could be right, it is. */
-	if (remote_master && !hashcmp(remote_master->old_sha1,
-				      remote_head->old_sha1))
-		return remote_master;
-
-	/* Look for another ref that points there */
-	for (r = mapped_refs; r; r = r->next)
-		if (r != remote_head &&
-		    !hashcmp(r->old_sha1, remote_head->old_sha1))
-			return r;
-
-	/* Nothing is the same */
-	return NULL;
-}
-
 static struct ref *write_remote_refs(const struct ref *refs,
 		struct refspec *refspec, const char *reflog)
 {
@@ -532,7 +496,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
 
-		head_points_at = locate_head(refs, mapped_refs, &remote_head);
+		head_points_at = guess_remote_head(refs, mapped_refs,
+						   &remote_head);
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
diff --git a/remote.c b/remote.c
index d7079c6..447f091 100644
--- a/remote.c
+++ b/remote.c
@@ -1376,3 +1376,40 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			    base, num_ours, num_theirs);
 	return 1;
 }
+
+const struct ref *guess_remote_head(const struct ref *refs,
+				    const struct ref *mapped_refs,
+				    const struct ref **remote_head_p)
+{
+	const struct ref *remote_head = NULL;
+	const struct ref *remote_master = NULL;
+	const struct ref *r;
+	for (r = refs; r; r = r->next)
+		if (!strcmp(r->name, "HEAD"))
+			remote_head = r;
+
+	for (r = mapped_refs; r; r = r->next)
+		if (!strcmp(r->name, "refs/heads/master"))
+			remote_master = r;
+
+	if (remote_head_p)
+		*remote_head_p = remote_head;
+
+	/* If there's no HEAD value at all, never mind. */
+	if (!remote_head)
+		return NULL;
+
+	/* If refs/heads/master could be right, it is. */
+	if (remote_master && !hashcmp(remote_master->old_sha1,
+				      remote_head->old_sha1))
+		return remote_master;
+
+	/* Look for another ref that points there */
+	for (r = mapped_refs; r; r = r->next)
+		if (r != remote_head &&
+		    !hashcmp(r->old_sha1, remote_head->old_sha1))
+			return r;
+
+	/* Nothing is the same */
+	return NULL;
+}
diff --git a/remote.h b/remote.h
index a46a5be..cabb14a 100644
--- a/remote.h
+++ b/remote.h
@@ -137,4 +137,13 @@ enum match_refs_flags {
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
+/*
+ * Look in refs for HEAD. Then look for a matching SHA1 in mapped_refs,
+ * first checking if refs/heads/master matches. Return NULL if nothing matches
+ * or if there is no HEAD in refs. remote_head_p is assigned HEAD if not NULL.
+ */
+const struct ref *guess_remote_head(const struct ref *refs,
+				    const struct ref *mapped_refs,
+				    const struct ref **remote_head_p);
+
 #endif
-- 
1.6.2.rc0.209.g7c178
