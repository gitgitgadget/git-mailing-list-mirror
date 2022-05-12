Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8009DC433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359229AbiELWgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359234AbiELWgM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:36:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC425A799
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:36:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 651831A0213;
        Thu, 12 May 2022 18:32:34 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Asupa+Rsxs/O
        iSkAGafJfKz8DkzawI631fYqbqRRYoQ=; b=TyynJOHDDH1W2XIh7PYveuVMO/+l
        a6UztdZbvk++EI9GwWeCbuaTzimvjA6t9tJggMBKFtfGELPcbKeN0i0nf6y82Nly
        eZzHXTw4Vz+eUf8q5mDnsw+W6c6eNhEZ97ZYHOpj7s9ZSwrAeYRGM3DxxHZbFyt0
        7hoRHcynX74P9VM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DA031A0212;
        Thu, 12 May 2022 18:32:34 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 09E511A0211;
        Thu, 12 May 2022 18:32:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] commit-graph.c: don't assume that stat() succeeds
Date:   Thu, 12 May 2022 15:32:17 -0700
Message-Id: <20220512223218.237544-4-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <20220512223218.237544-1-gitster@pobox.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
 <20220512223218.237544-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 6928A808-D243-11EC-8312-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Fix code added in 8d84097f965 (commit-graph: expire commit-graph
files, 2019-06-18) to check the return value of the stat() system
call. Not doing so caused us to use uninitialized memory in the "Bloom
generation is limited by --max-new-filters" test in
t4216-log-bloom.sh:

	+ rm -f trace.event
	+ pwd
	+ GIT_TRACE2_EVENT=3D[...]/t/trash directory.t4216-log-bloom/limits/trac=
e.event git commit-graph write --reachable --split=3Dreplace --changed-pa=
ths --max-new-filters=3D2
	=3D=3D24835=3D=3D Syscall param utimensat(times[0].tv_sec) points to uni=
nitialised byte(s)
	=3D=3D24835=3D=3D    at 0x499E65A: __utimensat64_helper (utimensat.c:34)
	=3D=3D24835=3D=3D    by 0x4999142: utime (utime.c:36)
	=3D=3D24835=3D=3D    by 0x552BE0: mark_commit_graphs (commit-graph.c:221=
3)
	=3D=3D24835=3D=3D    by 0x550822: write_commit_graph (commit-graph.c:242=
4)
	=3D=3D24835=3D=3D    by 0x54E3A0: write_commit_graph_reachable (commit-g=
raph.c:1681)
	=3D=3D24835=3D=3D    by 0x4374BB: graph_write (commit-graph.c:269)
	=3D=3D24835=3D=3D    by 0x436F7D: cmd_commit_graph (commit-graph.c:326)
	=3D=3D24835=3D=3D    by 0x407B9A: run_builtin (git.c:465)
	=3D=3D24835=3D=3D    by 0x406651: handle_builtin (git.c:719)
	=3D=3D24835=3D=3D    by 0x407575: run_argv (git.c:786)
	=3D=3D24835=3D=3D    by 0x406410: cmd_main (git.c:917)
	=3D=3D24835=3D=3D    by 0x511F09: main (common-main.c:56)
	=3D=3D24835=3D=3D  Address 0x1ffeffde70 is on thread 1's stack
	=3D=3D24835=3D=3D  in frame #1, created by utime (utime.c:25)
	=3D=3D24835=3D=3D  Uninitialised value was created by a stack allocation
	=3D=3D24835=3D=3D    at 0x552B50: mark_commit_graphs (commit-graph.c:220=
1)
	=3D=3D24835=3D=3D
	[...]
	error: last command exited with $?=3D126
	not ok 137 - Bloom generation is limited by --max-new-filters

This would happen as we stat'd the non-existing
".git/objects/info/commit-graph" file. Let's fix mark_commit_graphs()
to check the stat()'s return value, and while we're at it fix another
case added in the same commit to do the same.

The caller in expire_commit_graphs() would have been less likely to
run into this, as it's operating on files it just got from readdir(),
but it could still happen due to a race with e.g. a concurrent "rm
-rf" of the commit-graph files.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 441b36016b..2b52818731 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2206,7 +2206,8 @@ static void mark_commit_graphs(struct write_commit_=
graph_context *ctx)
 		struct stat st;
 		struct utimbuf updated_time;
=20
-		stat(ctx->commit_graph_filenames_before[i], &st);
+		if (stat(ctx->commit_graph_filenames_before[i], &st) < 0)
+			continue;
=20
 		updated_time.actime =3D st.st_atime;
 		updated_time.modtime =3D now;
@@ -2247,7 +2248,8 @@ static void expire_commit_graphs(struct write_commi=
t_graph_context *ctx)
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
=20
-		stat(path.buf, &st);
+		if (stat(path.buf, &st) < 0)
+			continue;
=20
 		if (st.st_mtime > expire_time)
 			continue;
--=20
2.36.1-338-g1c7f76a54c

