From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Wed, 23 Sep 2015 14:44:08 -0700
Message-ID: <xmqqio70x13r.fsf@gitster.mtv.corp.google.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
	<xmqqfv25x80c.fsf@gitster.mtv.corp.google.com>
	<vpq6130ucbh.fsf@grenoble-inp.fr>
	<xmqqr3lox4kc.fsf@gitster.mtv.corp.google.com>
	<xmqqmvwcx45g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 23 23:44:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zerpp-0008Gc-AO
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 23:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbbIWVoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 17:44:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33638 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbbIWVoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 17:44:11 -0400
Received: by pacex6 with SMTP id ex6so51438551pac.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=r5wtDiXFvX2RexI/XBl2ABvgvLczyuHNa8zZsVe2HC8=;
        b=K/l5IZRA1QRNlk+LZDaECsR9ZCNs3wXI4scNzBwPmJGI6HW+dGk0TDj88F7al63cz+
         4u87Sqtu4/2VxZA0/I+ewautSyCHCKTzOtDC1mXh6ltzG5Qsm96chBArBSaScTkd5Gd8
         kd8vYaL5ZvwOtEgERi8nf2Q1tpoZEOmKYv08wbi04WNeWjK600yUM0NWJrpHNaD5c/Eh
         iryjbyW6cPIZcYzAaYu+1D5oTaHASj+Dr2DOZzqzSCLMfKG9w+iyS7RHu81w1moa3f/6
         5ibRN2vSGCBFEphZXdK7KdnMm2LWi4/9fiobM1NZIRKg1JtmMZsvcmKP6/VtxczzkjZF
         ItyA==
X-Received: by 10.68.219.194 with SMTP id pq2mr39103642pbc.20.1443044650689;
        Wed, 23 Sep 2015 14:44:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id rb8sm9773631pab.14.2015.09.23.14.44.08
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 14:44:09 -0700 (PDT)
In-Reply-To: <xmqqmvwcx45g.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Sep 2015 13:38:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278516>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps something like this (not even compile tested as both of my
> worktrees are doing something else)....

This time with a few additional tests.

-- >8 --
Subject: [PATCH] fsck: exit with non-zero when problems are found

After finding some problems (e.g. a ref refs/heads/X points at an
object that is not a commit) and issuing an error message, the
program failed to signal the fact that it found an error by a
non-zero exit status.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c  | 18 ++++++++++++++----
 t/t1450-fsck.sh | 22 +++++++++++++++++++++-
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4e8e2ee..63ab0bb 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -35,6 +35,7 @@ static int show_dangling = 1;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
+#define ERROR_REFS 010
 
 #ifdef NO_D_INO_IN_DIRENT
 #define SORT_DIRENT 0
@@ -495,8 +496,10 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 		/* We'll continue with the rest despite the error.. */
 		return 0;
 	}
-	if (obj->type != OBJ_COMMIT && is_branch(refname))
+	if (obj->type != OBJ_COMMIT && is_branch(refname)) {
 		error("%s: not a commit", refname);
+		errors_found |= ERROR_REFS;
+	}
 	default_refs++;
 	obj->used = 1;
 	mark_object_reachable(obj);
@@ -559,17 +562,23 @@ static int fsck_head_link(void)
 		fprintf(stderr, "Checking HEAD link\n");
 
 	head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid.hash, &flag);
-	if (!head_points_at)
+	if (!head_points_at) {
+		errors_found |= ERROR_REFS;
 		return error("Invalid HEAD");
+	}
 	if (!strcmp(head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error = 1;
-	else if (!starts_with(head_points_at, "refs/heads/"))
+	else if (!starts_with(head_points_at, "refs/heads/")) {
+		errors_found |= ERROR_REFS;
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
+	}
 	if (is_null_oid(&head_oid)) {
-		if (null_is_error)
+		if (null_is_error) {
+			errors_found |= ERROR_REFS;
 			return error("HEAD: detached HEAD points at nothing");
+		}
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
 			head_points_at + 11);
 	}
@@ -589,6 +598,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 		if (!obj) {
 			error("%s: invalid sha1 pointer in cache-tree",
 			      sha1_to_hex(it->sha1));
+			errors_found |= ERROR_REFS;
 			return 1;
 		}
 		obj->used = 1;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index cfb32b6..0ad04da 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -77,11 +77,31 @@ test_expect_success 'object with bad sha1' '
 test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
-	git fsck 2>out &&
+	test_must_fail git fsck 2>out &&
 	cat out &&
 	grep "not a commit" out
 '
 
+test_expect_success 'HEAD link pointing at a funny object' '
+	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
+	mv .git/HEAD .git/SAVED_HEAD &&
+	echo 0000000000000000000000000000000000000000 >.git/HEAD &&
+	# avoid corrupt/broken HEAD from interfering with repo discovery
+	test_must_fail env GIT_DIR=.git git fsck 2>out &&
+	cat out &&
+	grep "detached HEAD points" out
+'
+
+test_expect_success 'HEAD link pointing at a funny place' '
+	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
+	mv .git/HEAD .git/SAVED_HEAD &&
+	echo "ref: refs/funny/place" >.git/HEAD &&
+	# avoid corrupt/broken HEAD from interfering with repo discovery
+	test_must_fail env GIT_DIR=.git git fsck 2>out &&
+	cat out &&
+	grep "HEAD points to something strange" out
+'
+
 test_expect_success 'email without @ is okay' '
 	git cat-file commit HEAD >basis &&
 	sed "s/@/AT/" basis >okay &&
-- 
2.6.0-rc3-173-gf6e0645
