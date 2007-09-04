From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Functions for updating refs.
Date: Tue, 04 Sep 2007 15:39:44 +0200
Message-ID: <46DD6020.4050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 15:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISYdM-0000Cp-Kv
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 15:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbXIDNj4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 09:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbXIDNj4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 09:39:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:14954 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXIDNjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 09:39:55 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1440613nfh
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 06:39:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=GGg+M9jJ/MGtd4twLeJXLAGyzP2Ej3sXQ8KrJs51E1YRmFWzbRlqG7DpLVqrxR0BNf4J2e6Xay/Vau3or6bX6RzQxvsaiwsQYGvoarAi2GK5k74rUuhyJ/TF8HiUg+p7WuSCzftCbaZmt63+9UrrN+8pV43L5VWwbIStWfTfJiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=FbB7HtVTXtycQoTv7rk0XkuA346V6+7hcqIlAc5s9vKv8lzVqu2oVJEQttvl5fPJ1mwJQqo5Lw7cdVC3jAwrOI4ktBcbkqyA3eT5aI9Q5Hwa7XCSjtQCoue4uCsdK3TL0Y9/yUhc7/yHRhPUViwhlm5AYQoYJYf5GmsxMZU/tcw=
Received: by 10.78.37.7 with SMTP id k7mr4132830huk.1188913193128;
        Tue, 04 Sep 2007 06:39:53 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id j2sm3096164ugf.2007.09.04.06.39.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Sep 2007 06:39:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57566>

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

   They are designed to be reused also from other builtins,
   like the recently changed builtin-tag.c and the upcoming
   builtin-reset.c, and perhaps also from builtin-fetch--tool.c.

 builtin-update-ref.c |    8 ++------
 refs.c               |   32 ++++++++++++++++++++++++++++++++
 refs.h               |    8 ++++++++
 send-pack.c          |   12 ++++--------
 4 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 8339cf1..bd7fe4d 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -62,10 +62,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (oldval && *oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);

-	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL, ref_flags);
-	if (!lock)
-		die("%s: cannot lock the ref", refname);
-	if (write_ref_sha1(lock, sha1, msg) < 0)
-		die("%s: cannot update the ref", refname);
-	return 0;
+	return update_ref_or_die(msg, refname, sha1,
+				oldval ? oldsha1 : NULL, ref_flags);
 }
diff --git a/refs.c b/refs.c
index 09a2c87..4fd5065 100644
--- a/refs.c
+++ b/refs.c
@@ -1455,3 +1455,35 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_reflog("", fn, cb_data);
 }
+
+int update_ref_or_die(const char *action, const char *refname,
+				const unsigned char *sha1,
+				const unsigned char *oldval, int flags)
+{
+	static struct ref_lock *lock;
+	lock = lock_any_ref_for_update(refname, oldval, flags);
+	if (!lock)
+		die("Cannot lock the ref '%s'.", refname);
+	if (write_ref_sha1(lock, sha1, action) < 0)
+		die("Cannot update the ref '%s'.", refname);
+	return 0;
+}
+
+int update_ref_or_error(const char *action, const char *refname,
+				const unsigned char *sha1,
+				const unsigned char *oldval, int quiet)
+{
+	static struct ref_lock *lock;
+	lock = lock_any_ref_for_update(refname, oldval, 0);
+	if (!lock) {
+		if (!quiet)
+			error("Cannot lock the ref '%s'.", refname);
+		return 1;
+	}
+	if (write_ref_sha1(lock, sha1, action) < 0) {
+		if (!quiet)
+			error("Cannot update the ref '%s'.", refname);
+		return 1;
+	}
+	return 0;
+}
diff --git a/refs.h b/refs.h
index f234eb7..3d0100e 100644
--- a/refs.h
+++ b/refs.h
@@ -64,4 +64,12 @@ extern int rename_ref(const char *oldref, const char *newref, const char *logmsg
 /** resolve ref in nested "gitlink" repository */
 extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *result);

+/** lock a ref and then write its file */
+int update_ref_or_die(const char *action, const char *refname,
+				const unsigned char *sha1,
+				const unsigned char *oldval, int flags);
+int update_ref_or_error(const char *action, const char *refname,
+				const unsigned char *sha1,
+				const unsigned char *oldval, int quiet);
+
 #endif /* REFS_H */
diff --git a/send-pack.c b/send-pack.c
index 9fc8a81..1907684 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -313,14 +313,10 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
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
+					update_ref_or_error("update by push",
+							rs.dst, ref->new_sha1,
+							NULL, 0);
 				free(rs.dst);
 			}
 		}
-- 
1.5.0
