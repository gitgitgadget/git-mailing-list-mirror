From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 8/8] refs.c: allow deleting refs with a broken sha1
Date: Fri,  5 Dec 2014 18:46:35 -0800
Message-ID: <1417833995-25687-9-git-send-email-sbeller@google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 06 03:47:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx5Od-0004pu-Vv
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbaLFCqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:46:53 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:49767 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaLFCqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:46:49 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so1794750ieb.7
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=008X65NA1Y55YKfw4HYeAPALOJ0AP/iu5ubXlATQHYs=;
        b=hs99MOvDGh0p+amXlDF5EdurOJvO0cqUtDo+BNFZF8OLBvNwmKDpLCkxYIv9tl3aEs
         0vdi/HlcTLMv7lt14/K+GPX8o13LwJOcTKlblf7LlcBg3L733QgQoQQqtR6mYNCtB29X
         7C5qC2maaH6msfRJF3eGpJS9R7sQLTOtwZkKEbtgjV9hgRTJCJ4azo1YH1TBzXpAJTdN
         1NS57DnTupQVIVmDO7+GL/6u56yI6QlQHcpZJUYv10cz3SnKmVWXW6p2Cf9aB/lO6TQz
         by1iyKq3Xjz0sGpJodNknTyhaI/UL5E55F79bcyJnk+XVo//C6AF/HWK4R9w1gIrG2D4
         U/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=008X65NA1Y55YKfw4HYeAPALOJ0AP/iu5ubXlATQHYs=;
        b=KcWAUrLaB5TWrkJnoJIkMk6+x6k3QcyRXkyekd9zNm9p6/89XSLYCYH/zCOe2auwfQ
         4W6/s3HlmdeM3V1MwLXyhZDU+tnZWvO5cCqu7XZqw95AP+Vjr/74BET8ysdxXU2Vv045
         vgOvUG5wrPjJPF/FWsPeY9hFjFtLArG6VBFg05r464RjCGH5izOFJjtAM1e5qdkkU+qs
         YhZWo4YnXZeNemoSuEwccFWlXZXpx5hXmrpaf7wM7PVUCJG9hKqCdvCitStgOORtyp/a
         jJhpIB0dWK+IAruJ+m3uEf+uBiieReX/8w3/HWzFmuhvDlsyHW6CTdeamx6Yag3xdMaM
         0YRA==
X-Gm-Message-State: ALoCoQljJthvbxhWS/gdIdhASIZ/TD8BbR6atAmG60GGPzW/t5eeS+h+kjtZfRPYKYtF3Br+u09y
X-Received: by 10.50.30.202 with SMTP id u10mr5432289igh.35.1417834008444;
        Fri, 05 Dec 2014 18:46:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id n17sm193547igi.2.2014.12.05.18.46.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 18:46:47 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417833995-25687-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260928>

From: Ronnie Sahlberg <sahlberg@google.com>

Add back support to make it possible to delete refs that have a broken
sha1.

Add new internal flags REF_ALLOW_BROKEN and RESOLVE_REF_ALLOW_BAD_SHA1
to pass intent from branch.c that we are willing to allow
resolve_ref_unsafe and lock_ref_sha1_basic to allow broken refs.
Since these refs can not actually be resolved to a sha1, they instead resolve
to null_sha1 when these flags are used.

For example, the ref:

   echo "Broken ref" > .git/refs/heads/foo-broken-1

can now be deleted using git branch -d foo-broken-1

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Changes to previously sent version:
     * do not introduce yet another flag, but stick with REF_DELETING
       which was meant for this purpose.

 builtin/branch.c  | 5 +++--
 cache.h           | 7 +++++++
 refs.c            | 5 +++++
 t/t3200-branch.sh | 8 ++++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3b79c50..5fe1cac 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -238,7 +238,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		target = resolve_ref_unsafe(name,
 					    RESOLVE_REF_READING
 					    | RESOLVE_REF_NO_RECURSE
-					    | RESOLVE_REF_ALLOW_BAD_NAME,
+					    | RESOLVE_REF_ALLOW_BAD_NAME
+					    | RESOLVE_REF_ALLOW_BAD_SHA1,
 					    sha1, &flags);
 		if (!target) {
 			error(remote_branch
@@ -255,7 +256,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (delete_ref(name, sha1, REF_NODEREF)) {
+		if (delete_ref(name, sha1, REF_NODEREF|REF_DELETING)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/cache.h b/cache.h
index 99ed096..61e61af 100644
--- a/cache.h
+++ b/cache.h
@@ -1000,10 +1000,17 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * resolved. The function returns NULL for such ref names.
  * Caps and underscores refers to the special refs, such as HEAD,
  * FETCH_HEAD and friends, that all live outside of the refs/ directory.
+ *
+ * RESOLVE_REF_ALLOW_BAD_SHA1 when this flag is set and the ref contains
+ * an invalid sha1, resolve_ref_unsafe will clear the sha1 argument,
+ * set the REF_ISBROKEN flag and return the refname.
+ * This allows using resolve_ref_unsafe to check for existence of such
+ * broken refs.
  */
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
+#define RESOLVE_REF_ALLOW_BAD_SHA1 0x08
 extern const char *resolve_ref_unsafe(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 extern char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 
diff --git a/refs.c b/refs.c
index 2effd66..94b766f 100644
--- a/refs.c
+++ b/refs.c
@@ -1587,6 +1587,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
 				if (flags)
 					*flags |= REF_ISBROKEN;
+				if (resolve_flags & RESOLVE_REF_ALLOW_BAD_SHA1) {
+					hashclr(sha1);
+					return refname;
+				}
 				errno = EINVAL;
 				return NULL;
 			}
@@ -2265,6 +2269,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		resolve_flags |= RESOLVE_REF_READING;
 	if (flags & REF_DELETING) {
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
+		resolve_flags |= RESOLVE_REF_ALLOW_BAD_SHA1;
 		if (flags & REF_NODEREF)
 			resolve_flags |= RESOLVE_REF_NO_RECURSE;
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 432921b..1ea0d2c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -163,6 +163,14 @@ test_expect_success 'git branch --list -d t should fail' '
 	test_path_is_missing .git/refs/heads/t
 '
 
+test_expect_success 'git branch -d can delete ref with broken sha1' '
+	echo "pointing nowhere" >.git/refs/heads/brokensha1 &&
+	test_when_finished "rm -f .git/refs/heads/brokensha1" &&
+	git branch -d brokensha1 &&
+	git branch >output &&
+	! grep brokensha1 output
+'
+
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expected <<\EOF &&
-- 
2.2.0
