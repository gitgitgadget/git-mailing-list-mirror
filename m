From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] refactor ref status logic for pushing
Date: Fri, 4 Dec 2009 12:54:44 +0800
Message-ID: <20091204125444.fe943056.rctay89@gmail.com>
References: <20091204125042.c64f347d.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Clemens Buchacher" <drizzd@aon.at>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 05:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGQC5-0003xP-4u
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 05:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbZLDEyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 23:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755930AbZLDEyn
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 23:54:43 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:62677 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800AbZLDEym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 23:54:42 -0500
Received: by ywh12 with SMTP id 12so2242743ywh.21
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 20:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=l7kdpZBBhYf/dBw3n5bjIDe3nfxOWjYn9XOHSD2jfd0=;
        b=By4vD5C3ejgTcKZqAo2LGkFVTEAIlpp5zxSX7eEh7jccE5799/EqWQ7HaUxcjeQ8bi
         tdAfsC6LYFjUvPDK0kAsIPMpoeEOKNrXII6JpSoOme/MAVp4V83KvK2UZmprctd1h4jB
         SMynPJlLs55iNf4T5oYP6AvwIS2TaT9J8AiLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=VdHn9CxyQ975C8vG7qcVPfdpaFVLiZddxHrYvrRgNU2I+MD4tyE4FX1R+Ov4Ge43l3
         Tz73bHL/UXqhR6BsFU3M3hKqTPMh9r3xyeqD7MDYHi5283XCPjLpv17voqElGrgVVBxZ
         dBKQhlHQ/w+s/ZydruNB5uetk+f+5dcipwMwU=
Received: by 10.90.39.27 with SMTP id m27mr3982472agm.78.1259902488773;
        Thu, 03 Dec 2009 20:54:48 -0800 (PST)
Received: from your-cukc5e3z5n (cm81.zeta152.maxonline.com.sg [116.87.152.81])
        by mx.google.com with ESMTPS id 34sm1399224yxf.29.2009.12.03.20.54.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 20:54:48 -0800 (PST)
In-Reply-To: <20091204125042.c64f347d.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134491>

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
