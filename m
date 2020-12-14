Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD1BC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFB921D42
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 20:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503318AbgLNU1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:27:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54122 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503311AbgLNU1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 15:27:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16C6010D1BE;
        Mon, 14 Dec 2020 15:26:52 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=iUn7nKfQRPs0mxPLe0C+7h6IC+U=; b=eE8JFVsVtyO77+8rcPlq
        3Hs+1JfPnmEGgtxnfz0Q0eKos9YTlPniWx5/WvRR5BXB/RIjqieAlTjj6Hy0sz/P
        sA54DitCma9bvEUEISNWjv1HU5WXJTAo3kb4/ZY66JsUox7BqPXOJcRdGdqeHx1m
        Wp3vWCfETBwKpDG5wqv0vyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-transfer-encoding; q=dns;
         s=sasl; b=O0dn+hSgH9QK23wir7yVpDFHJJvstS7XYcaJ62A38rR50zeMZz6nP
        H2hzxo4mdtCFr/Mrcbbwnz4PaDD+f5l3I66wrIec7ULnta1IAz03QFjwr5ij39VC
        DB43nUiLHsJ6YPcsGQ6Xag792Y0UiIZY+WzGw9RZrfJ8KcucNclPdI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F51710D1BD;
        Mon, 14 Dec 2020 15:26:52 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 59DA410D1B9;
        Mon, 14 Dec 2020 15:26:49 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v7 0/5] making pull advice not to trigger when unneeded
Date:   Mon, 14 Dec 2020 12:26:42 -0800
Message-Id: <20201214202647.3340193-1-gitster@pobox.com>
X-Mailer: git-send-email 2.30.0-rc0-186-g20447144ec
MIME-Version: 1.0
X-Pobox-Relay-ID: B1A53D3C-3E4A-11EB-B635-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to show what was pushed out on 'seen' while I was cutting the
preview release...

This is based on Felipe's v6 (which was mislabled as v5 but sent on
a different day from the true v5), with two clean-up commits
inserted between Felipe's second step (now 2/5) and the third step
(now 5/5, with necessary adjustments).

Even with the "correct condition" clean-up, I am not quite happy
with the clarity of the logic around there.

I think !opt_ff does not exactly belong to the condition, if we
consider that the eventual endgame should be to stop non-ff
operation without merge or rebase by default with an error, and that
should happen in this block.  The error message there should say
"unable to fast-forward; must merge or rebase", which should equally
apply to those who gave "--ff-only" explicitly, even though they may
not need the advice message.

So with the help of can_ff bit introduced by 5/5, I _think_ this
part should become like

-	if (rebase_unspecified && !opt_ff && !can_ff) {
+	if (rebase_unspecified && !can_ff &&
+	    (!opt_ff || !strcmp("--ff-only", opt_ff))) {

before/when we make this codepath error out.  We won't hit the body
of this if statement when we can fast-forward.

To avoid the ugly-looking "strcmp()" in the above, we may need to
adjust "--ff" (fast-forward without creating an extra merge commit)
and "--no-ff" (create an extra merge commit when the history could
be fast-forwarded) to imply "merge", though.  It would automatically
make rebase_unspecified would become false.  With such a tweak, we
can then simplify it further to

-	if (rebase_unspecified && !can_ff &&
-	    (!opt_ff || !strcmp("--ff-only", opt_ff))) {
+	if (rebase_unspecified && !can_ff) {

But these are not part of this round.


Felipe Contreras (3):
  pull: refactor fast-forward check
  pull: give the advice for choosing rebase/merge much later
  pull: display default warning only when non-ff

Junio C Hamano (2):
  pull: get rid of unnecessary global variable
  pull: correct condition to trigger non-ff advice

 builtin/pull.c               | 70 ++++++++++++++++++++++--------------
 t/t7601-merge-pull-config.sh | 66 +++++++++++++++++++++++++++++++---
 2 files changed, 104 insertions(+), 32 deletions(-)

--=20
2.30.0-rc0-186-g20447144ec

