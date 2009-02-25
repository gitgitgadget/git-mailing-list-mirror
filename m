From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 06/21] move locate_head() to remote.c
Date: Wed, 25 Feb 2009 03:32:13 -0500
Message-ID: <69eb7688ec4be7eaa8c6be6e8194d4ad682ed70b.1235546708.git.jaysoffian@gmail.com>
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
	id 1LcFF3-0000Xo-Gy
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759539AbZBYIcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759292AbZBYIct
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:32:49 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:53623 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759203AbZBYIcq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:46 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1285047yxm.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=60aYzdbB5zf6FuUN5gQN+aGzBCV75IpvXhGJiai+EQY=;
        b=tTjx3hhm1YKDRvztZS+egmUMTSctt+HUEuFWaL/AvAKEak0VsdaFVV6Rypa5h/XTLR
         FvVcr/sYkao62xXIFx9+S40KYNITv8OIGikCRgK8vu/sHyjFxtR5E67YRhKvsvwm/iGu
         bDDNGT2Pc3Elh0VO4xuxonVVOCZKWsSCdZ6Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UfZLSH+Enp89tnFV4YbW+88pvwhXQrrKooltI6SPEnfwE5L+aQ6J4JSTR67ovNv7GR
         wnQs0Wu3mNPUnxktTWEfYFFRlhT10uALYfZaO60nVGLZ4MR06fXQ9elKWPcJZoPxHIfF
         5y2NBbz7E1oGCPw83o+jQd1THdaAcLQZj42lM=
Received: by 10.100.125.12 with SMTP id x12mr829750anc.153.1235550764909;
        Wed, 25 Feb 2009 00:32:44 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b29sm13011670ana.31.2009.02.25.00.32.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:44 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111406>

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
index c338910..d179d1c 100644
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
@@ -545,7 +509,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
 
-		head_points_at = locate_head(refs, mapped_refs, &remote_head);
+		head_points_at = guess_remote_head(refs, mapped_refs,
+						   &remote_head);
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
diff --git a/remote.c b/remote.c
index c8b7ea4..49a183e 100644
--- a/remote.c
+++ b/remote.c
@@ -1451,3 +1451,40 @@ struct ref *get_local_heads(void)
 	for_each_ref(one_local_ref, &local_tail);
 	return local_refs;
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
index c0666a0..9605da9 100644
--- a/remote.h
+++ b/remote.h
@@ -139,4 +139,13 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
 struct ref *get_local_heads(void);
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
1.6.2.rc1.291.g83eb
