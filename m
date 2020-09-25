Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16838C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 05:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4712137B
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 05:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QKpMnhoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgIYFsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 01:48:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60469 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYFsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 01:48:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 948EFEDE3F;
        Fri, 25 Sep 2020 01:48:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=3
        yEzN7HzLYEB9DZfFwFAMSqvB8g=; b=QKpMnhoOVybYC3H6Qv6TQDyTdYf4eTR7o
        BCdQOzXIrxO1p1amCF2rkUM+Wwhhn6akcWBdkMNZh0iKbGNzLgJqAW+mJP+mHUfy
        462mfmclSN72W+KKGMAqFIRz1XZ7CFn9Nsvl/QaqbdfZKaeYYD4ArZJmZk/7qKm9
        QHaXRlKoXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=yePyyhOAh/KevxOjFlST5b37ipInv8IbB0iCA5BytLaZSw4iX/Vab8bQ
        eaoHtlqLWjJCcOYAYXKwDUbfZC/zFv0rU+Mn2SbJisk3jlT84KuIoE7ls1zUKRWh
        TFJyXAtnn4ukZTvHGk4aDdIcDj0e5SsvG3gyiEVLqs1HgqF+caw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D7B3EDE3E;
        Fri, 25 Sep 2020 01:48:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7D097EDE3D;
        Fri, 25 Sep 2020 01:48:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: [RFH] sequencer: simplify logic around stopped-sha file
Date:   Thu, 24 Sep 2020 22:48:46 -0700
Message-ID: <xmqq8scymmo1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C85C6100-FEF2-11EA-AB8B-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While I was auditing the use of get_oid_committish(), I noticed that
an abbreviated object name is written to rebase-merge/stopped-sha
only to be read later and expanded to a full object name to be
passed to record_in_rewritten().  Nobody seems to expose this to the
end-user and it is unclear if there is a point in keeping it short
by abbreviating and risking to make it ambiguous as the rebase
progresses and creates new objects.

The attached patch tries to simplify the logic involved around this
file, to write and read full object names to/from the file, and the
result seems to pass testsuite---which in the ideal world would be
sufficient signal that this change is safe and sane, but it could be
that original authors thought that a change to stop abbreviating is
nonsense and not worth protecting the code against, hence RFH here.

Is there something obvious I am not seeing that makes this change a
bad idea (other than "somebody may be in the middle of a rebase and
all of a sudden, version of Git gets updated to contain this one,
which is unable to read abbreviated object name the current version
left on disk", which I am deliberately ignoring)?

Thanks.


 sequencer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fd7701c88a..7dc9088d09 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -120,7 +120,7 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
 static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
 /*
  * When we stop at a given patch via the "edit" command, this file contains
- * the abbreviated commit name of the corresponding patch.
+ * the commit object name of the corresponding patch.
  */
 static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 /*
@@ -3012,11 +3012,12 @@ static int make_patch(struct repository *r,
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct rev_info log_tree_opt;
-	const char *subject, *p;
+	const char *subject;
+	char hex[GIT_MAX_HEXSZ + 1];
 	int res = 0;
 
-	p = short_commit_name(commit);
-	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
+	oid_to_hex_r(hex, &commit->object.oid);
+	if (write_message(hex, strlen(hex), rebase_path_stopped_sha(), 1) < 0)
 		return -1;
 	res |= write_rebase_head(&commit->object.oid);
 
@@ -4396,7 +4397,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 
 		if (read_oneliner(&buf, rebase_path_stopped_sha(),
 				  READ_ONELINER_SKIP_IF_EMPTY) &&
-		    !get_oid_committish(buf.buf, &oid))
+		    !get_oid_hex(buf.buf, &oid))
 			record_in_rewritten(&oid, peek_command(&todo_list, 0));
 		strbuf_release(&buf);
 	}
