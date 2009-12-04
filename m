From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH resend 1/3] refactor ref status logic for pushing
Date: Fri, 4 Dec 2009 14:56:43 +0800
Message-ID: <20091204145643.296ec414.rctay89@gmail.com>
References: <20091204145437.1a9910db.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Clemens Buchacher" <drizzd@aon.at>, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 07:56:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGS63-0001Pq-2S
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 07:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbZLDG4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 01:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbZLDG4o
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 01:56:44 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61998 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZLDG4m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 01:56:42 -0500
Received: by yxe17 with SMTP id 17so1869842yxe.33
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 22:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=l7kdpZBBhYf/dBw3n5bjIDe3nfxOWjYn9XOHSD2jfd0=;
        b=FdAF91UjDEXNEAyZvQ42GsGCe671VcnNqn6aCzb6Arn+S7lH9dDg17cVnyxa/VzKCb
         F0PwVxBs9c1Q6jA6MF21kA/IHEfR8nqL2WdDTBmWL/5XOZ9Ax/JjyN5XKUNlVASoUBVn
         As6PkupNFR4ZL7PkpMf/CHFUHCcaOULTD3udc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=NABYkz9gcmle0t3Op64qpmQi24SbK9yGL6Bg6FE4R4ASSh4SvLxqP9p0u/3Xz9ATs8
         hibdU+C+Snqn3iASFzAncJRwhjxBooaWJCzFYTZ0syT89wZJsY1iXzItZ7uTp/vRfQ+S
         HHJvX2YwjJ+lZG6ZeBeCTY+Pm6wb+o/KnVFO0=
Received: by 10.91.10.34 with SMTP id n34mr3361611agi.36.1259909809354;
        Thu, 03 Dec 2009 22:56:49 -0800 (PST)
Received: from your-cukc5e3z5n (cm81.zeta152.maxonline.com.sg [116.87.152.81])
        by mx.google.com with ESMTPS id 4sm1434278yxd.16.2009.12.03.22.56.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 22:56:48 -0800 (PST)
In-Reply-To: <20091204145437.1a9910db.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134495>

Move the logic to a new function in remote.[ch],
 set_ref_status_for_push().

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin-send-pack.c |   39 +++------------------------------------
 remote.c            |   42 ++++++++++++++++++++++++++++++++++++++++++
 remote.h            |    1 +
 3 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8fffdbf..8c98624 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -412,44 +412,11 @@ int send_pack(struct send_pack_args *args,
 		else if (!args->send_mirror)
 			continue;

-		ref->deletion = is_null_sha1(ref->new_sha1);
-		if (ref->deletion && !allow_deleting_refs) {
-			ref->status = REF_STATUS_REJECT_NODELETE;
-			continue;
-		}
-		if (!ref->deletion &&
-		    !hashcmp(ref->old_sha1, ref->new_sha1)) {
-			ref->status = REF_STATUS_UPTODATE;
+		if (set_ref_status_for_push(ref, args->force_update))
 			continue;
-		}

-		/* This part determines what can overwrite what.
-		 * The rules are:
-		 *
-		 * (0) you can always use --force or +A:B notation to
-		 *     selectively force individual ref pairs.
-		 *
-		 * (1) if the old thing does not exist, it is OK.
-		 *
-		 * (2) if you do not have the old thing, you are not allowed
-		 *     to overwrite it; you would not know what you are losing
-		 *     otherwise.
-		 *
-		 * (3) if both new and old are commit-ish, and new is a
-		 *     descendant of old, it is OK.
-		 *
-		 * (4) regardless of all of the above, removing :B is
-		 *     always allowed.
-		 */
-
-		ref->nonfastforward =
-		    !ref->deletion &&
-		    !is_null_sha1(ref->old_sha1) &&
-		    (!has_sha1_file(ref->old_sha1)
-		      || !ref_newer(ref->new_sha1, ref->old_sha1));
-
-		if (ref->nonfastforward && !ref->force && !args->force_update) {
-			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+		if (ref->deletion && !allow_deleting_refs) {
+			ref->status = REF_STATUS_REJECT_NODELETE;
 			continue;
 		}

diff --git a/remote.c b/remote.c
index e3afecd..188869a 100644
--- a/remote.c
+++ b/remote.c
@@ -1247,6 +1247,48 @@ int match_refs(struct ref *src, struct ref **dst,
 	return 0;
 }

+int set_ref_status_for_push(struct ref *ref, int force_update)
+{
+	ref->deletion = is_null_sha1(ref->new_sha1);
+	if (!ref->deletion &&
+		!hashcmp(ref->old_sha1, ref->new_sha1)) {
+		ref->status = REF_STATUS_UPTODATE;
+		return 1;
+	}
+
+	/* This part determines what can overwrite what.
+	 * The rules are:
+	 *
+	 * (0) you can always use --force or +A:B notation to
+	 *     selectively force individual ref pairs.
+	 *
+	 * (1) if the old thing does not exist, it is OK.
+	 *
+	 * (2) if you do not have the old thing, you are not allowed
+	 *     to overwrite it; you would not know what you are losing
+	 *     otherwise.
+	 *
+	 * (3) if both new and old are commit-ish, and new is a
+	 *     descendant of old, it is OK.
+	 *
+	 * (4) regardless of all of the above, removing :B is
+	 *     always allowed.
+	 */
+
+	ref->nonfastforward =
+		!ref->deletion &&
+		!is_null_sha1(ref->old_sha1) &&
+		(!has_sha1_file(ref->old_sha1)
+		  || !ref_newer(ref->new_sha1, ref->old_sha1));
+
+	if (ref->nonfastforward && !ref->force && !force_update) {
+		ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+		return 1;
+	}
+
+	return 0;
+}
+
 struct branch *branch_get(const char *name)
 {
 	struct branch *ret;
diff --git a/remote.h b/remote.h
index 8b7ecf9..0f45553 100644
--- a/remote.h
+++ b/remote.h
@@ -98,6 +98,7 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,

 int match_refs(struct ref *src, struct ref **dst,
 	       int nr_refspec, const char **refspec, int all);
+int set_ref_status_for_push(struct ref *ref, int force_update);

 /*
  * Given a list of the remote refs and the specification of things to
--
1.6.6.rc1.286.gbc15a
