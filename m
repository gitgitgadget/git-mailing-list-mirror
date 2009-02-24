From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 01/23] builtin-clone: move locate_head() to remote.c so it can be re-used
Date: Tue, 24 Feb 2009 04:50:49 -0500
Message-ID: <4c6211345999ae7b99da14b87283c3836169ab63.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzs-0002Ej-32
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890AbZBXJv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbZBXJvZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:25 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:58685 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbZBXJvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:20 -0500
Received: by gxk22 with SMTP id 22so6475210gxk.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PCDV7Wh/Zqcziqpl5sYTrjulYiaWKyrklmAjRkEcdqY=;
        b=Xh58ClgNe2Z6rXl3A1lzj0Spfz8ioWtm20NQEumaBAzeYE16eDNE3bKAosq4pEs5Z4
         a2GWleCAr8HKji0384N8g5zFt6575g1FL3cJp2m/BKT8g3LEfjNy1J4tmAwMlUkT9eTp
         XqYP9rlyddFWTCOwdEkD5szPXoILQvMUZM2r4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sW0WG9EWN/VhyCkfLKRtPmHE4EKCunGPACnk3K1ZNm+GP7015jEdRVAuvIxvUtXjzA
         GVjqSHEi8lOoC14XwSF93A0erw0tzjZI+h6v08mxv/9y/xDR9qC5xoIjWJwHMXbDYFHX
         QcixMBjN5ukpD/FmO+9EsGZvl+9MeWL3vwzKU=
Received: by 10.100.93.17 with SMTP id q17mr5449857anb.93.1235469077707;
        Tue, 24 Feb 2009 01:51:17 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b32sm2009353ana.55.2009.02.24.01.51.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:17 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111254>

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
1.6.2.rc1.291.g83eb
