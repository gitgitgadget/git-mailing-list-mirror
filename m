Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6252AC64EDA
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355740AbjHQWaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355731AbjHQW3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 18:29:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9285130DA
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 15:29:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44D3C1A8249;
        Thu, 17 Aug 2023 18:29:51 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=VH9rjk4ANdN3r00VnJQlDJhHQ
        mFSezuh2hYLMh7dz9w=; b=NLnfQ5Z0VQifU7XQwE6L8fIdVmXZQTFQ7i2ybu/7a
        fJF94xvT33K/W/ngMj2nFVqvIoZOX8CNuOqHszprQPq2NBM1wldDr3hMTE3ANQ5I
        IHraZWbz6S7CU39rSpuNP7qNsz1tU9pNj0bkpgCA9FqKw9GwBD+JbiRW6cn3jKnW
        fI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CDC21A8248;
        Thu, 17 Aug 2023 18:29:51 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B9461A8247;
        Thu, 17 Aug 2023 18:29:50 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/5] fix interactions with "-w" and "--exit-code"
Date:   Thu, 17 Aug 2023 15:29:44 -0700
Message-ID: <20230817222949.3835424-1-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2
In-Reply-To: <xmqqttsxbfyw.fsf@gitster.g>
References: <xmqqttsxbfyw.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: 94656E68-3D4D-11EE-AA3F-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here is the reworked series.  The previous attempt mostly
correspond to [4/5] of this series, but the approach has been quite
updated, so here is marked as "v2" but I omitted the interdiff as it
would be more or less useless.

The first patch is not part of the main theme, but because I'll be
adding the first use of "--dirstat" to t4015 that has been leak
sanitizer clean, and the "--dirstat" codepath has known leaks, I am
plugging the leaks as a preliminary step to avoid having to mark
t4015 as leak sanitizer unclean again.

The second patch flips around order of processing without changing
the meaning.  After this change, blocks that compute output that
also take contents into account are grouped together, before the
fallback code for output formats that do not look at the contents to
compute their result.  It is purely done as a clean-up.

The earlier series claimed that "--exit-code -w" is reliable as long
as "--patch" output is used, but it turns out that there are corner
case holes in the "--patch" codepath.  The third patch fixes them.

The fourth patch teachs "--stat" codepath to help "--exit-code -w";
as it looks at contents to produce its output, we note the fact that
we found (or did not find) differences, and use that for the exit
code computation.

The fifth patch deals with other output modes that do not look at
contents for their output to reuse the fallback code.

Junio C Hamano (5):
  diff: --dirstat leakfix
  diff: move the fallback "--exit-code" code down
  diff: mode-only change should be noticed by "--patch -w --exit-code"
  diff: teach "--stat -w --exit-code" to notice differences
  diff: teach "--name-status" and friends to honor "--exit-code -w"

 diff.c                     | 71 +++++++++++++++++++++++++++-----------
 t/t4015-diff-whitespace.sh | 36 ++++++++++++++++++-
 t/t4047-diff-dirstat.sh    |  2 ++
 3 files changed, 87 insertions(+), 22 deletions(-)

--=20
2.42.0-rc2

