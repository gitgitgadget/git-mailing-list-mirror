Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2403C4332F
	for <git@archiver.kernel.org>; Fri, 20 May 2022 12:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349487AbiETMuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349085AbiETMty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 08:49:54 -0400
Received: from hrbata.com (hrbata.com [109.123.216.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 633B91668A6
        for <git@vger.kernel.org>; Fri, 20 May 2022 05:49:53 -0700 (PDT)
Received: from fedora.redhat.com (ip-89-102-24-184.net.upcbroadband.cz [89.102.24.184])
        by hrbata.com (Postfix) with ESMTPSA id 9079044CE8;
        Fri, 20 May 2022 14:49:52 +0200 (CEST)
From:   Frantisek Hrbata <frantisek@hrbata.com>
To:     git@vger.kernel.org
Cc:     Frantisek Hrbata <frantisek@hrbata.com>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] fix memory leaks in transport_push()
Date:   Fri, 20 May 2022 14:49:49 +0200
Message-Id: <20220520124952.2393299-1-frantisek@hrbata.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520081723.1031830-1-frantisek@hrbata.com>
References: <20220520081723.1031830-1-frantisek@hrbata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in transport_push(), where remote_refs and local_refs
are never freed. While at it, remove the unnecessary indenting and make
the code hopefully more readable.

Changes since v2:

 * "transport: remove unnecessary indenting in transport_push()"
   s/push_refs/transport_push/ in commit message as noticed
   by Ævar Arnfjörð Bjarmason

 * "transport: unify return values and exit point from transport_push()"
   Added as suggested by Ævar Arnfjörð Bjarmason. It allows the following
   memory leak fix to be a very simple patch.

 * "transport: free local and remote refs in transport_push()"
   Just free remote_refs and local_refs. The other changes were
   included in the previous patch.

Changes since v1:

 * Slit into series of two patches. The first one just changes
   indenting in transport_push(). Second one adds the fix for
   the local_refs and remote_refs memory leaks.

 * The resulting trees are the same, there is no code change.

Frantisek Hrbata (3):
  transport: remove unnecessary indenting in transport_push()
  transport: unify return values and exit point from transport_push()
  transport: free local and remote refs in transport_push()

 transport.c | 260 +++++++++++++++++++++++++++-------------------------
 1 file changed, 133 insertions(+), 127 deletions(-)

Range-diff against v2:
1:  daf042cd2e ! 1:  d986d8e7a9 transport: remove unnecessary indenting in transport_push()
    @@ Metadata
      ## Commit message ##
         transport: remove unnecessary indenting in transport_push()
     
    -    Remove the big indented block for push_refs() check in transport vtable
    +    Remove the big indented block for transport_push() check in transport vtable
         and let's just return error immediately. Hopefully this makes the code
         more readable.
     
2:  9d25176b92 ! 2:  4a69662b28 transport: free local and remote refs in transport_push()
    @@ Metadata
     Author: Frantisek Hrbata <frantisek@hrbata.com>
     
      ## Commit message ##
    -    transport: free local and remote refs in transport_push()
    +    transport: unify return values and exit point from transport_push()
     
    -    Fix memory leaks in transport_push(), where remote_refs and local_refs
    -    are never freed.
    -
    -    116 bytes in 1 blocks are definitely lost in loss record 56 of 103
    -       at 0x484486F: malloc (vg_replace_malloc.c:381)
    -       by 0x4938D7E: strdup (strdup.c:42)
    -       by 0x628418: xstrdup (wrapper.c:39)
    -       by 0x4FD454: process_capabilities (connect.c:232)
    -       by 0x4FD454: get_remote_heads (connect.c:354)
    -       by 0x610A38: handshake (transport.c:333)
    -       by 0x612B02: transport_push (transport.c:1302)
    -       by 0x4803D6: push_with_options (push.c:357)
    -       by 0x4811D6: do_push (push.c:414)
    -       by 0x4811D6: cmd_push (push.c:650)
    -       by 0x405210: run_builtin (git.c:465)
    -       by 0x405210: handle_builtin (git.c:719)
    -       by 0x406363: run_argv (git.c:786)
    -       by 0x406363: cmd_main (git.c:917)
    -       by 0x404F17: main (common-main.c:56)
    -
    -    5,912 (388 direct, 5,524 indirect) bytes in 2 blocks are definitely lost in loss record 98 of 103
    -       at 0x4849464: calloc (vg_replace_malloc.c:1328)
    -       by 0x628705: xcalloc (wrapper.c:150)
    -       by 0x5C216D: alloc_ref_with_prefix (remote.c:975)
    -       by 0x5C232A: alloc_ref (remote.c:983)
    -       by 0x5C232A: one_local_ref (remote.c:2299)
    -       by 0x5C232A: one_local_ref (remote.c:2289)
    -       by 0x5BDB03: do_for_each_repo_ref_iterator (iterator.c:418)
    -       by 0x5B4C4F: do_for_each_ref (refs.c:1486)
    -       by 0x5B4C4F: refs_for_each_ref (refs.c:1492)
    -       by 0x5B4C4F: for_each_ref (refs.c:1497)
    -       by 0x5C6ADF: get_local_heads (remote.c:2310)
    -       by 0x612A85: transport_push (transport.c:1286)
    -       by 0x4803D6: push_with_options (push.c:357)
    -       by 0x4811D6: do_push (push.c:414)
    -       by 0x4811D6: cmd_push (push.c:650)
    -       by 0x405210: run_builtin (git.c:465)
    -       by 0x405210: handle_builtin (git.c:719)
    -       by 0x406363: run_argv (git.c:786)
    -       by 0x406363: cmd_main (git.c:917)
    +    It seems there is no reason to return 1 instead of -1 when push_refs()
    +    is not set in transport vtable. Let's unify the error return values and
    +    use the done label as a single exit point from transport_push().
     
    +    Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Frantisek Hrbata <frantisek@hrbata.com>
     
      ## transport.c ##
    @@ transport.c: int transport_push(struct repository *r,
      	int match_flags = MATCH_REFS_NONE;
      	int verbose = (transport->verbose > 0);
      	int quiet = (transport->verbose < 0);
    -@@ transport.c: int transport_push(struct repository *r,
    + 	int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
    + 	int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
    +-	int push_ret, ret, err;
    ++	int push_ret, err;
    ++	int ret = -1;
    + 	struct transport_ls_refs_options transport_options =
    + 		TRANSPORT_LS_REFS_OPTIONS_INIT;
    + 
    + 	*reject_reasons = 0;
    + 
    + 	if (transport_color_config() < 0)
    +-		return -1;
    ++		goto done;
    + 
      	if (!transport->vtable->push_refs)
    - 		return 1;
    +-		return 1;
    ++		goto done;
      
    -+	ret = -1;
      	local_refs = get_local_heads();
      
      	if (check_push_refs(local_refs, rs) < 0)
    @@ transport.c: int transport_push(struct repository *r,
      		fprintf(stderr, "Everything up-to-date\n");
      
     +done:
    -+	free_refs(local_refs);
    -+	free_refs(remote_refs);
      	return ret;
      }
      
-:  ---------- > 3:  a4984a4835 transport: free local and remote refs in transport_push()

base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
-- 
2.35.1

