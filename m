Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1EAC4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620E120866
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XkhzCmac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIYWTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:19:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51971 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgIYWTu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 18:19:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E24EEF4CF5;
        Fri, 25 Sep 2020 18:19:48 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=6i1J8If8ptRI+DKzCyz68Z5zOS4=; b=XkhzCmacfb/OwF83Mv4/
        pjBsXeIS6PaUqNPKrMWtzfoL9S1Qe9WN/O23lLXff/T4g/sw0u8c7A4K89sQIigs
        +9pYp+H9LTceilIAxUOju96cV2YuXmdDTZyJLUOrT/l+9yFL9dNoKU/SuSQ6Y+7Z
        t/GjhHZeZuNwwmvQveRqurg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         q=dns; s=sasl; b=rBiKg99q/vV4/ppgEJqcb4yYqE3a68ttbHb8gqz61trbDL
        loOViDfpLWrHloMSKi5rLlCyZ9O4FbfVTpfZmlsuVxc/i+ln6udNyjg/8VJlkdjK
        jNXZ4ZN4rLgpKNhrPNCkBM8H2JRJJttwMpYs4CjA9/rJ4BDCpVMBSDmDmnwLI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA592F4CF4;
        Fri, 25 Sep 2020 18:19:48 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C004F4CF3;
        Fri, 25 Sep 2020 18:19:46 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 01/26] transport: not report a non-head push as a branch
Date:   Fri, 25 Sep 2020 15:19:19 -0700
Message-Id: <20200925221944.4020954-1-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-733-g3cecc26178
MIME-Version: 1.0
X-Pobox-Relay-ID: 37DAA39A-FF7D-11EA-A57D-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When pushing a new reference (not a head or tag), report it as a new
reference instead of a new branch.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5516-fetch-push.sh | 2 +-
 transport.c           | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9c6218f568..77938db77f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1039,7 +1039,7 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag =
message'"
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new br=
anch]"  &&
+	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new re=
ference]"  &&
 	echo >>.git/foo "Done" &&
 	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes=
/origin/master &&
 	(
diff --git a/transport.c b/transport.c
index 15f5ba4e8f..26fefd13c1 100644
--- a/transport.c
+++ b/transport.c
@@ -500,9 +500,12 @@ static void print_ok_ref_status(struct ref *ref, int=
 porcelain, int summary_widt
 				 porcelain, summary_width);
 	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain, summary_width);
+				 (starts_with(ref->name, "refs/tags/")
+				  ? "[new tag]"
+				  : (starts_with(ref->name, "refs/heads/")
+				     ? "[new branch]"
+				     : "[new reference]")),
+				 ref, ref->peer_ref, NULL, porcelain, summary_width);
 	else {
 		struct strbuf quickref =3D STRBUF_INIT;
 		char type;
--=20
2.28.0-733-g3cecc26178

