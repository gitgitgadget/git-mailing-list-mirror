From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/19] branch -d: avoid repeated symref resolution
Date: Wed, 10 Sep 2014 20:10:03 -0700
Message-ID: <20140911031003.GR18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:12:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRuoY-0004Gv-En
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbaIKDKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:10:09 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:60820 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbaIKDKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:10:06 -0400
Received: by mail-pa0-f47.google.com with SMTP id ey11so10614954pad.34
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fi+ZF3ta+8nRv+iRoUnpeb07ETggoGMlCG+XpJu7o98=;
        b=bi6jrWXDxJXGQ3AbFFX8kgMTC7z+cQVMDnX4YRLG2upVbxtR4K6OQz8XGTZFtSzwWs
         48SMnHr6XlenEyOdLSxVjFeWPPW4Q1e6YmvLPdN4goRYackmE2a6cwGtzWUmv9RPspLB
         k45QoQ/7d0Pg0MS8kSai3BsXWTTfCUy7P+PBk6iQBZ86bI96FQgtFz5HP/iy1ATdhYZY
         ilPbJTR/xC8u8nLQSlJHluJrlbLkaPeQ2YPmSuUnxQhT4li+Nf8WGVIYORSCEYd18Q11
         7KWPORicdGuhAVeWYBwH8IB9z8Ib+tkSUqrSOXB+ZXsMVi4gNhJhzCdHStf3FbhapyW0
         CqpA==
X-Received: by 10.70.88.66 with SMTP id be2mr17768162pdb.30.1410405005949;
        Wed, 10 Sep 2014 20:10:05 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ka1sm15098741pbd.70.2014.09.10.20.10.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:10:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256831>

If a repository gets in a broken state with too much symref nesting,
it cannot be repaired with "git branch -d":

 $ git symbolic-ref refs/heads/nonsense refs/heads/nonsense
 $ git branch -d nonsense
 error: branch 'nonsense' not found.

Worse, "git update-ref --no-deref -d" doesn't work for such repairs
either:

 $ git update-ref -d refs/heads/nonsense
 error: unable to resolve reference refs/heads/nonsense: Too many levels of symbolic links

Fix both by teaching resolve_ref_unsafe a new RESOLVE_REF_NODEREF flag
and passing it when appropriate.

Callers can still read the value of a symref (for example to print a
message about it) with that flag set --- resolve_ref_unsafe will
resolve one level of symrefs and stop there.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/branch.c      |  3 ++-
 cache.h               |  1 +
 refs.c                | 10 ++++++++++
 t/t1400-update-ref.sh | 16 ++++++++++++++++
 t/t3200-branch.sh     |  9 +++++++++
 5 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f144808..7925660 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -234,7 +234,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(name);
 
 		name = mkpathdup(fmt, bname.buf);
-		target = resolve_ref_unsafe(name, sha1, &flags, 0);
+		target = resolve_ref_unsafe(name, sha1,
+					    &flags, RESOLVE_REF_NODEREF);
 		if (!target ||
 		    (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
 			error(remote_branch
diff --git a/cache.h b/cache.h
index 2d3c5ed..03ade12 100644
--- a/cache.h
+++ b/cache.h
@@ -982,6 +982,7 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * errno is set to something meaningful on error.
  */
 #define RESOLVE_REF_READING 0x01
+#define RESOLVE_REF_NODEREF 0x02
 extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int *flags, int resolve_flags);
 extern char *resolve_refdup(const char *ref, unsigned char *sha1, int *flags, int resolve_flags);
 
diff --git a/refs.c b/refs.c
index a5f9734..f11df33 100644
--- a/refs.c
+++ b/refs.c
@@ -1408,6 +1408,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *fl
 				refname = refname_buffer;
 				if (flags)
 					*flags |= REF_ISSYMREF;
+				if (resolve_flags & RESOLVE_REF_NODEREF) {
+					hashclr(sha1);
+					return refname;
+				}
 				continue;
 			}
 		}
@@ -1471,6 +1475,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *fl
 			return NULL;
 		}
 		refname = strcpy(refname_buffer, buf);
+		if (resolve_flags & RESOLVE_REF_NODEREF) {
+			hashclr(sha1);
+			return refname;
+		}
 	}
 }
 
@@ -2110,6 +2118,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
+	if (flags & REF_NODEREF)
+		resolve_flags |= RESOLVE_REF_NODEREF;
 
 	refname = resolve_ref_unsafe(refname, lock->old_sha1, &type,
 				     resolve_flags);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 0218e96..ff4607b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -110,6 +110,22 @@ test_expect_success "delete symref without dereference when the referred ref is
 cp -f .git/HEAD.orig .git/HEAD
 git update-ref -d $m
 
+test_expect_success 'update-ref -d is not confused by self-reference' '
+	git symbolic-ref refs/heads/self refs/heads/self &&
+	test_when_finished "rm -f .git/refs/heads/self" &&
+	test_path_is_file .git/refs/heads/self &&
+	test_must_fail git update-ref -d refs/heads/self &&
+	test_path_is_file .git/refs/heads/self
+'
+
+test_expect_success 'update-ref --no-deref -d can delete self-reference' '
+	git symbolic-ref refs/heads/self refs/heads/self &&
+	test_when_finished "rm -f .git/refs/heads/self" &&
+	test_path_is_file .git/refs/heads/self &&
+	git update-ref --no-deref -d refs/heads/self &&
+	test_path_is_missing .git/refs/heads/self
+'
+
 test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ac31b71..432921b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -285,6 +285,15 @@ test_expect_success 'deleting a dangling symref' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'deleting a self-referential symref' '
+	git symbolic-ref refs/heads/self-reference refs/heads/self-reference &&
+	test_path_is_file .git/refs/heads/self-reference &&
+	echo "Deleted branch self-reference (was refs/heads/self-reference)." >expect &&
+	git branch -d self-reference >actual &&
+	test_path_is_missing .git/refs/heads/self-reference &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
-- 
2.1.0.rc2.206.gedb03e5
