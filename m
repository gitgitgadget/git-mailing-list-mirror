From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Function for updating refs.
Date: Wed, 05 Sep 2007 03:38:24 +0200
Message-ID: <46DE0890.5020709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 05 03:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISjrB-0008C0-BU
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 03:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbXIEBiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 21:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755669AbXIEBiu
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 21:38:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:20651 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636AbXIEBis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 21:38:48 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1595104nfh
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 18:38:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ZwOOddwB+MBZzBk2b9dKQHFm0TXHNjR/v+Ph+QEDVacD1b2Npg4EH3lr0t8jgsM9MhC/Ke8S6b2pvYKZVbWj4F4VR2VKv86xewgXCXroRRSSlXIdAtv6uOPOIvXcWhSUv1i5azxwZjSKfl+B8QjhtHR5ZEa7oTQJG+/wcpmbWYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=cWOl5oXXW3tc230ffbGAnRY8WgJkBoVuH4CyG9syBWuKeWFtNfgTecv5Azl0LUdDU/sRyS2KwN5zdgnOjT8LI44F875gZg8CY+S03ZNTljwIO87KgMtfypnJCRyfnvdeCp6JaOdMiIbxfOe6MZNeuhlvSZMnrhskaY5M3Lvkujg=
Received: by 10.78.145.5 with SMTP id s5mr4694569hud.1188956327022;
        Tue, 04 Sep 2007 18:38:47 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id e23sm205406ugd.2007.09.04.18.38.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Sep 2007 18:38:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57665>

A function intended to be called from builtins updating refs
by locking them before write, specially those that came from
scripts using "git update-ref".

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 builtin-fetch--tool.c |   21 ++++++++-------------
 builtin-update-ref.c  |    8 ++------
 refs.c                |   28 ++++++++++++++++++++++++++++
 refs.h                |    6 ++++++
 send-pack.c           |   11 +++--------
 5 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index e2f8ede..a192fd7 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -31,24 +31,19 @@ static void show_new(enum object_type type, unsigned char *sha1_new)
 		find_unique_abbrev(sha1_new, DEFAULT_ABBREV));
 }

-static int update_ref(const char *action,
+static int update_ref_env(const char *action,
 		      const char *refname,
 		      unsigned char *sha1,
 		      unsigned char *oldval)
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;

 	if (!rla)
 		rla = "(reflog update)";
-	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
-	lock = lock_any_ref_for_update(refname, oldval, 0);
-	if (!lock)
-		return 1;
-	if (write_ref_sha1(lock, sha1, msg) < 0)
-		return 1;
-	return 0;
+	if (snprintf(msg, sizeof(msg), "%s: %s", rla, action) >= sizeof(msg))
+		error("reflog message too long: %.*s...", 50, msg);
+	return update_ref(msg, refname, sha1, oldval, 0, QUIET_ON_ERR);
 }

 static int update_local_ref(const char *name,
@@ -88,7 +83,7 @@ static int update_local_ref(const char *name,
 		fprintf(stderr, "* %s: storing %s\n",
 			name, note);
 		show_new(type, sha1_new);
-		return update_ref(msg, name, sha1_new, NULL);
+		return update_ref_env(msg, name, sha1_new, NULL);
 	}

 	if (!hashcmp(sha1_old, sha1_new)) {
@@ -102,7 +97,7 @@ static int update_local_ref(const char *name,
 	if (!strncmp(name, "refs/tags/", 10)) {
 		fprintf(stderr, "* %s: updating with %s\n", name, note);
 		show_new(type, sha1_new);
-		return update_ref("updating tag", name, sha1_new, NULL);
+		return update_ref_env("updating tag", name, sha1_new, NULL);
 	}

 	current = lookup_commit_reference(sha1_old);
@@ -117,7 +112,7 @@ static int update_local_ref(const char *name,
 		fprintf(stderr, "* %s: fast forward to %s\n",
 			name, note);
 		fprintf(stderr, "  old..new: %s..%s\n", oldh, newh);
-		return update_ref("fast forward", name, sha1_new, sha1_old);
+		return update_ref_env("fast forward", name, sha1_new, sha1_old);
 	}
 	if (!force) {
 		fprintf(stderr,
@@ -131,7 +126,7 @@ static int update_local_ref(const char *name,
 		"* %s: forcing update to non-fast forward %s\n",
 		name, note);
 	fprintf(stderr, "  old...new: %s...%s\n", oldh, newh);
-	return update_ref("forced-update", name, sha1_new, sha1_old);
+	return update_ref_env("forced-update", name, sha1_new, sha1_old);
 }

 static int append_fetch_head(FILE *fp,
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 8339cf1..2ed98e8 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -8,7 +8,6 @@ static const char git_update_ref_usage[] =
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname=NULL, *value=NULL, *oldval=NULL, *msg=NULL;
-	struct ref_lock *lock;
 	unsigned char sha1[20], oldsha1[20];
 	int i, delete, ref_flags;

@@ -62,10 +61,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (oldval && *oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);

-	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL, ref_flags);
-	if (!lock)
-		die("%s: cannot lock the ref", refname);
-	if (write_ref_sha1(lock, sha1, msg) < 0)
-		die("%s: cannot update the ref", refname);
+	update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
+						ref_flags, DIE_ON_ERR);
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 09a2c87..1343f0d 100644
--- a/refs.c
+++ b/refs.c
@@ -1455,3 +1455,31 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_reflog("", fn, cb_data);
 }
+
+int update_ref(const char *action, const char *refname,
+		const unsigned char *sha1, const unsigned char *oldval,
+		int flags, enum action_on_err onerr)
+{
+	static struct ref_lock *lock;
+	lock = lock_any_ref_for_update(refname, oldval, flags);
+	if (!lock) {
+		const char *str = "Cannot lock the ref '%s'.";
+		switch (onerr) {
+		case MSG_ON_ERR: error(str, refname); break;
+		case DIE_ON_ERR: die(str, refname); break;
+		case QUIET_ON_ERR: break;
+		}
+		return 1;
+	}
+	if (write_ref_sha1(lock, sha1, action) < 0) {
+		const char *str = "Cannot update the ref '%s'.";
+		switch (onerr) {
+		case MSG_ON_ERR: error(str, refname); break;
+		case DIE_ON_ERR: die(str, refname); break;
+		case QUIET_ON_ERR: break;
+		}
+		return 1;
+	}
+	return 0;
+}
+
diff --git a/refs.h b/refs.h
index f234eb7..6eb98a4 100644
--- a/refs.h
+++ b/refs.h
@@ -64,4 +64,10 @@ extern int rename_ref(const char *oldref, const char *newref, const char *logmsg
 /** resolve ref in nested "gitlink" repository */
 extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *result);

+/** lock a ref and then write its file */
+enum action_on_err { MSG_ON_ERR, DIE_ON_ERR, QUIET_ON_ERR };
+int update_ref(const char *action, const char *refname,
+		const unsigned char *sha1, const unsigned char *oldval,
+		int flags, enum action_on_err onerr);
+
 #endif /* REFS_H */
diff --git a/send-pack.c b/send-pack.c
index 9fc8a81..c59eea4 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -313,14 +313,9 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 					if (delete_ref(rs.dst, NULL)) {
 						error("Failed to delete");
 					}
-				} else {
-					lock = lock_any_ref_for_update(rs.dst, NULL, 0);
-					if (!lock)
-						error("Failed to lock");
-					else
-						write_ref_sha1(lock, ref->new_sha1,
-							       "update by push");
-				}
+				} else
+					update_ref("update by push", rs.dst,
+						ref->new_sha1, NULL, 0, 0);
 				free(rs.dst);
 			}
 		}
-- 
1.5.0
