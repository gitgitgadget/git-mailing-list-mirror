Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D3E1F461
	for <e@80x24.org>; Sun, 21 Jul 2019 18:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfGUSSJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jul 2019 14:18:09 -0400
Received: from m12-13.163.com ([220.181.12.13]:33095 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfGUSSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jul 2019 14:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GRFg5
        y4ztIqec6MRbCJAXVmKdtN+Qx9ShkfeUgEba/g=; b=azXsPVHjI5+3pZLPp8aal
        0cVJqUOSj/rvkcB9ce+jOOjuShx+rGa8zl8XJrmcc5Gjak2hJOP+lgshjbgIZAqY
        eAaDGWu/Wg4giLQG4+x/0nurj5+DIMwS6Un/nA95RbuR4utxedQ5x8gRsMz1K388
        WTuFHiiFOgen5H0UCN4HnQ=
Received: from localhost.localdomain (unknown [122.233.177.66])
        by smtp9 (Coremail) with SMTP id DcCowAAnZ79OrDRdTDH8CA--.21881S4;
        Mon, 22 Jul 2019 02:17:56 +0800 (CST)
From:   16657101987@163.com
Cc:     git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com,
        Sun Chao <sunchao9@huawei.com>
Subject: [PATCH v1 1/1] pack-refs: pack expired loose refs to packed_refs
Date:   Mon, 22 Jul 2019 02:17:39 +0800
Message-Id: <20190721181739.81110-2-16657101987@163.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
In-Reply-To: <20190721181739.81110-1-16657101987@163.com>
References: <20190721181739.81110-1-16657101987@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAnZ79OrDRdTDH8CA--.21881S4
X-Coremail-Antispam: 1Uf129KBjvJXoWfGr1Dtw15Cr1kXF4kZw1DKFg_yoWDWryrpF
        Z5Cw15Ka18t3WSvr1qqr1kXFWrJan5try7X34fAwna9w4xXw10vr4F93WavFyrJF1kA3yr
        ZF48t3y8XFs8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bYXocUUUUU=
X-Originating-IP: [122.233.177.66]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiMgL4glWBkFhdNgAAs9
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

When a packed ref is deleted, the whole packed-refs file is
rewrite and omit the ref that no longer exists. However if
another gc command is running and call `pack-refs --all`
simultaneously, there is a change that a ref just updated
will lost the newly commits.

Through these steps, losting commits of newly updated refs
could be demonstrated:

  # step 1: compile git without `USE_NSEC` option
  Some kernerl releases does enable it by default while some
  does not. And if we compile git without `USE_NSEC`, it
  will be easier demonstrated by the following steps.

  # step 2: setup a bare repository and clone it as child
  git init --bare parent &&
  (cd parent && git config core.logallrefupdates true) &&
  git clone parent child

  # step 3: in one terminal, repack the bare refs repeatedly
  cd parent &&
  while true; do
    git pack-refs --all
  done

  # step 4: in another terminal, simultaneously update the
  # master with update-ref, and create and delete an
  # unrelated ref also with update-ref
  cd child &&
  while true; do
    git commit --allow-empty -m foo &&
    us=`git rev-parse master` &&
    pushd ../parent &&
      git fetch ../child/.git master &&
      git update-ref refs/heads/newbranch $us &&
      git update-ref refs/heads/master $us &&
      git update-ref -d refs/heads/newbranch &&
      them=`git rev-parse master` &&
      if test "$them" != "$us"; then
        echo >&2 "lost commit: $us"
        exit 1
      fi
    popd
  done

Though we have the packed-refs lock file and loose refs lock
files to avoid updating conflicts, a ref will lost its newly
commits if the situation which is described as racy-git by
`Documentation/technical/racy-git.txt` happens, it comes like
this:

  1. Call `pack-refs --all` to pack all the loose refs to
     packed-refs, and let say the modify time of the
     packed-refs is DATE_M.

  2. Call `update-ref` to update a new commit to master while
     it is already packed.  the old value (let us call it
     OID_A) remains in the packed-refs file and write the new
     value (let us call it OID_B) to $GIT_DIR/refs/heads/master.

  3. Call `update-ref -d` within the same DATE_M from the 1th
     step to delete a different ref newbranch which is packed
     in the packed-refs file. It check newbranch's oid from
     packed-refs file without locking it.

     Meanwhile it keeps a snapshot of the packed-refs file in
     memory and record the file's timestamp with the snapshot.
     The oid of master in the packed-refs's snapshot is OID_A.

  4. Redo the 1th step, after `pack-refs --all` finished, the
     oid of master in packe-refs file is OID_B, and the loose
     refs $GIT_DIR/refs/heads/master is removed. Let's say
     the `pack-refs --all` is very quickly done and the new
     packed-refs file's modify time is stille DATE_M.

  5. 3th step now going on, after checking the newbranch, it
     begin to rewrite the packed-refs file, after get the lock
     file of packed-ref file, it checks the timestamp of it's
     snapshot in memory with the packed-refs file's time,
     they are both the same DATE_M, so the snapshot is not
     refreshed.

     Because the loose ref of master is removed by 4th step,
     `update-ref -d` will updates the new packed-ref to disk
     which contains master with the oid OID-A. So now the
     newly commit OID-B of master is lost.

There are two valid methods to avoid losting commit of ref:
  - force `update-ref -d` to update the snapshot before
    rewrite packed-refs.
  - do not pack a recently updated ref, where *recently*
    could be set by *pack.looserefsexpire* option.

I prefer **do not pack a recently updated ref**, here is the
reasons:

  1. It could avoid losting the newly commit of a ref which I
     described upon.

  2. Sometime, the git server will do `pack-refs --all` and
     `update-ref` the same time, and the two commands have
     chances to trying lock the same ref such as master, if
     this happends one command will fail with such error:

     **cannot lock ref 'refs/heads/master'**

     This could happen if a ref is updated frequently, and
     avoid pack the ref which is update recently could avoid
     this error most of the time.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 builtin/pack-refs.c       | 13 ++++++++++++-
 refs.c                    |  4 ++--
 refs.h                    |  2 +-
 refs/files-backend.c      | 18 +++++++++++++++++-
 refs/packed-backend.c     |  2 +-
 refs/refs-internal.h      |  2 +-
 t/helper/test-ref-store.c |  2 +-
 7 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index cfbd5c36c7..7baced5788 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -9,16 +9,27 @@ static char const * const pack_refs_usage[] = {
 	NULL
 };
 
+static const char *pack_loose_refs_expire = "now";
+
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
 	struct option opts[] = {
 		OPT_BIT(0, "all",   &flags, N_("pack everything"), PACK_REFS_ALL),
 		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
+		{ OPTION_STRING, 0, "expire", &pack_loose_refs_expire, N_("date"),
+			N_("pack unactive loose refs"),
+			PARSE_OPT_OPTARG, NULL, (intptr_t)pack_loose_refs_expire },
 		OPT_END(),
 	};
+	static timestamp_t expire;
+
+	git_config_get_expiry("pack.looserefsexpire", &pack_loose_refs_expire);
 	git_config(git_default_config, NULL);
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	return refs_pack_refs(get_main_ref_store(the_repository), flags);
+
+	if (parse_expiry_date(pack_loose_refs_expire, &expire))
+		die(_("failed to parse '%s' value '%s'"), "pack.looserefsexpire", pack_loose_refs_expire);
+	return refs_pack_refs(get_main_ref_store(the_repository), flags, expire);
 }
diff --git a/refs.c b/refs.c
index cd297ee4bd..e72f4b05dd 100644
--- a/refs.c
+++ b/refs.c
@@ -1947,9 +1947,9 @@ void base_ref_store_init(struct ref_store *refs,
 }
 
 /* backend functions */
-int refs_pack_refs(struct ref_store *refs, unsigned int flags)
+int refs_pack_refs(struct ref_store *refs, unsigned int flags, timestamp_t expire)
 {
-	return refs->be->pack_refs(refs, flags);
+	return refs->be->pack_refs(refs, flags, expire);
 }
 
 int refs_peel_ref(struct ref_store *refs, const char *refname,
diff --git a/refs.h b/refs.h
index 730d05ad91..0270aa9efc 100644
--- a/refs.h
+++ b/refs.h
@@ -378,7 +378,7 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
  * Write a packed-refs file for the current repository.
  * flags: Combination of the above PACK_REFS_* flags.
  */
-int refs_pack_refs(struct ref_store *refs, unsigned int flags);
+int refs_pack_refs(struct ref_store *refs, unsigned int flags, timestamp_t expire);
 
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 63e55e6773..7e6676cece 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1144,7 +1144,7 @@ static int should_pack_ref(const char *refname,
 	return 1;
 }
 
-static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
+static int files_pack_refs(struct ref_store *ref_store, unsigned int flags, timestamp_t expire)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
@@ -1152,13 +1152,19 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct ref_iterator *iter;
 	int ok;
 	struct ref_to_prune *refs_to_prune = NULL;
+	struct stat st;
+	struct strbuf path = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
+	size_t path_baselen;
 
 	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
 	if (!transaction)
 		return -1;
 
+	files_ref_path(refs, &path, "");
+	path_baselen = path.len;
+
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
@@ -1172,6 +1178,16 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 				     flags))
 			continue;
 
+		/*
+		 * If the loose reference is active (not expired), do not pack it.
+		 */
+		strbuf_setlen(&path, path_baselen);
+		strbuf_addstr(&path, iter->refname);
+		if (stat(path.buf, &st) == 0) {
+			if (st.st_mtime > expire)
+				continue;
+		}
+
 		/*
 		 * Add a reference creation for this reference to the
 		 * packed-refs transaction:
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c01c7f5901..2c6e6ee990 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1550,7 +1550,7 @@ static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 	return ret;
 }
 
-static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
+static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags, timestamp_t expire)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f2d8c0123a..81f00e4c04 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -530,7 +530,7 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
 
-typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
+typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags, timestamp_t expire);
 typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 799fc00aa1..b2be2e311d 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -69,7 +69,7 @@ static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 {
 	unsigned int flags = arg_flags(*argv++, "flags");
 
-	return refs_pack_refs(refs, flags);
+	return refs_pack_refs(refs, flags, TIME_MAX);
 }
 
 static int cmd_peel_ref(struct ref_store *refs, const char **argv)
-- 
2.22.0.214.g8dca754b1e


