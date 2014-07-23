From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 15/15] refs.c: allow deleting refs with a broken sha1
Date: Wed, 23 Jul 2014 10:03:55 -0700
Message-ID: <1406135035-26441-16-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zyG-0004nO-9r
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbaGWREf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:35 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:42805 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbaGWREA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:04:00 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so258836yha.4
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ce4tHBOgxTBHST+1OO9su79d/bl4YNOoL+OXU5D4eb8=;
        b=dAyZWk4bxDzJYH0282XNjvUKsnLH49aIEY7YonD3LC8xzP7Iyi1/fTY37Z/O7sCF23
         GkSRP9XDn/TN7Ei+fmNPPVgaKpQT+oRAEE4KxpuRWWovia1EPYiRM3X4RkfSv5KnCfBs
         MczhRzy3Re1JH0/XxP7zS5L9aUYxs/ndPaBd4WsWxBEVZ3cjfKY9sCfTJpx9klnI5YWh
         aO6IDgnVIWHa1YPUNZirviRcIUUZywQsNKjJ0YElSVFvYGZjY2+4X8hY2cMaMYS2c0km
         RWJHiuZHpSj9WwyOEfMUcmufEjFZhuoExwi7UC1Fd9Jrgoi1ApQxAAazAnzoQr/8QiM3
         rnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ce4tHBOgxTBHST+1OO9su79d/bl4YNOoL+OXU5D4eb8=;
        b=ODH8CHBXjQKX29Muy0SePFWnAk/wgCidcn3X35P/1rRBhGu9JS7NCB9kM2cnrLWcmj
         ZNVVsyVaFEqlSYzIAwbXX9p1v8YYUdrkyfiDKbKkI8uQma3A6s3DZOlwPb+Kgiov83He
         rickIXB4vOukaVqtByhi5YNjF82ns5Q/JPX1jCL7zb/k+EWgtj974rCi/SuS+gq+4nEv
         3POq9sd61xW/qjP1/1th6wRBJSY42ows/sLAzf4mrfcaxK59muwfknF96gZKBQn4/0Q9
         ciFDUfkQFJOLQrJ+XxDwVZfe4Uzm7h/sc2i4kjt3l1R+SpQOHcMLSGgC5tF/v83m6CTG
         JzXQ==
X-Gm-Message-State: ALoCoQmqfY0ssFjo6eBkPyfamBWkl5Ce+rXktINcUvcQ4hPSy4EkwVlbYKRIlOESG9OPhmt0wQD7
X-Received: by 10.236.164.106 with SMTP id b70mr1030072yhl.1.1406135039277;
        Wed, 23 Jul 2014 10:03:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si486998yhg.1.2014.07.23.10.03.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0699D31C34D;
	Wed, 23 Jul 2014 10:03:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B53CEE0600; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254090>

Add (back?) support to make it possible to delete refs that are broken.

Add a new flag REF_ALLOWBROKEN that can be passed to the functions to
lock a ref. If this flag is set we allow locking the ref even if the
ref points to a broken sha1. For example a sha1 that is created by :

   echo "Broken ref" > .git/refs/heads/foo-broken-1

Use this flag when calling from branch.c dusing a ref delete so that we
only allow locking those broken refs IFF when called during a branch
delete.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/branch.c |  6 ++++--
 refs.c           | 10 +++++++---
 refs.h           |  3 ++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5c95656..6d70037 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -236,6 +236,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		name = mkpathdup(fmt, bname.buf);
 		target = resolve_ref_unsafe(name, sha1,
 					    RESOLVE_REF_ALLOW_BAD_NAME, &flags);
+		if (!target && (flags & REF_ISBROKEN))
+			target = name;
 		if (!target ||
 		    (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
 			error(remote_branch
@@ -245,14 +247,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (!(flags & REF_ISSYMREF) &&
+		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
 					force)) {
 			ret = 1;
 			continue;
 		}
 
-		if (delete_ref(name, sha1, REF_NODEREF)) {
+		if (delete_ref(name, sha1, REF_NODEREF|REF_ALLOWBROKEN)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/refs.c b/refs.c
index 0ead11f..2662ef6 100644
--- a/refs.c
+++ b/refs.c
@@ -2122,12 +2122,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int resolve_flags;
 	int missing = 0;
 	int attempts_remaining = 3;
-	int bad_refname;
+	int bad_ref;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	bad_refname = check_refname_format(refname, REFNAME_ALLOW_ONELEVEL);
+	bad_ref = check_refname_format(refname, REFNAME_ALLOW_ONELEVEL);
 
 	resolve_flags = RESOLVE_REF_ALLOW_BAD_NAME;
 	if (mustexist)
@@ -2150,6 +2150,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		refname = resolve_ref_unsafe(orig_refname, lock->old_sha1,
 					     resolve_flags, &type);
 	}
+	if (!refname && (flags & REF_ALLOWBROKEN) && (type & REF_ISBROKEN)) {
+		bad_ref = 1;
+		refname = orig_refname;
+	}
 	if (type_p)
 	    *type_p = type;
 	if (!refname) {
@@ -2212,7 +2216,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		else
 			unable_to_lock_index_die(ref_file, errno);
 	}
-	if (bad_refname)
+	if (bad_ref)
 		return lock;
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
diff --git a/refs.h b/refs.h
index 712fc32..0172f48 100644
--- a/refs.h
+++ b/refs.h
@@ -174,10 +174,11 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  * Flags controlling transaction_update_sha1(), transaction_create_sha1(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
- *
+ * REF_ALLOWBROKEN: allow locking refs that are broken.
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REF_NODEREF	0x01
+#define REF_ALLOWBROKEN 0x02
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
-- 
2.0.1.508.g763ab16
