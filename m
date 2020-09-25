Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B4DC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC4C21775
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lxdnKHYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgIYGHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 02:07:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61588 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYGHr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 02:07:47 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 02:07:45 EDT
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB272966D0;
        Fri, 25 Sep 2020 02:00:11 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=qXa08rM1Y0unt7/r3RyPB06H3
        e0=; b=lxdnKHYfTRag1pjQCvmt06Q9fnEho8r2wOVp/hQChMakGOc8qQ8ChkTdO
        q9gfNS6gFbFPwM5s54TitDZY7HqyeOVUjAhdF1NbV3mc3hdxxka5vmgduhC7wQxA
        5xc9vumo6K5X72tv95ImUWwh3TiD6l/hsn9rVeNVyLDpQxZRvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=aoeUiQg23BdUNMJED6r
        L8AAYmdcxDAvwdy6NZngA+HOWtZS1TtOxx6sU2GDWxLVmFnDTP99v43UwTxHFcF9
        szMUUyn45z4VlmLgvjXz4u97unc5pjUItO3t8Y4D3nNHf5FyEQxq4+4ZXnRyTRz/
        /1+n4dLJhuDNDyHWTueenXOI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D20A8966CA;
        Fri, 25 Sep 2020 02:00:10 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1001D966C3;
        Fri, 25 Sep 2020 02:00:08 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] sequencer: stop abbreviating stopped-sha file
Date:   Thu, 24 Sep 2020 22:59:54 -0700
Message-Id: <20200925055954.1111389-5-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-718-gd8d5e3da39
In-Reply-To: <20200925055954.1111389-1-gitster@pobox.com>
References: <20200925055954.1111389-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 5D68E3BC-FEF4-11EA-BC65-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The object name written to this file is not exposed to end-users and
the only reader of this file immediately expands it back to a full
object name.  Stop abbreviating while writing, and expect a full
object name while reading, which simplifies the code a bit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fd7701c88a..7dc9088d09 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -120,7 +120,7 @@ static GIT_PATH_FUNC(rebase_path_author_script, "reba=
se-merge/author-script")
 static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
 /*
  * When we stop at a given patch via the "edit" command, this file conta=
ins
- * the abbreviated commit name of the corresponding patch.
+ * the commit object name of the corresponding patch.
  */
 static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha"=
)
 /*
@@ -3012,11 +3012,12 @@ static int make_patch(struct repository *r,
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	struct rev_info log_tree_opt;
-	const char *subject, *p;
+	const char *subject;
+	char hex[GIT_MAX_HEXSZ + 1];
 	int res =3D 0;
=20
-	p =3D short_commit_name(commit);
-	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
+	oid_to_hex_r(hex, &commit->object.oid);
+	if (write_message(hex, strlen(hex), rebase_path_stopped_sha(), 1) < 0)
 		return -1;
 	res |=3D write_rebase_head(&commit->object.oid);
=20
@@ -4396,7 +4397,7 @@ int sequencer_continue(struct repository *r, struct=
 replay_opts *opts)
=20
 		if (read_oneliner(&buf, rebase_path_stopped_sha(),
 				  READ_ONELINER_SKIP_IF_EMPTY) &&
-		    !get_oid_committish(buf.buf, &oid))
+		    !get_oid_hex(buf.buf, &oid))
 			record_in_rewritten(&oid, peek_command(&todo_list, 0));
 		strbuf_release(&buf);
 	}
--=20
2.28.0-718-gd8d5e3da39

