Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C9EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 22:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjGGWKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGGWK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 18:10:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A771FEB
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 15:10:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E4BC29EC4;
        Fri,  7 Jul 2023 18:05:02 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=eMlqrcUpDsnm3fjsnf/BcgHPJzrEss0VoQodgxWIqx4=; b=HT1G
        jNdfAxizn8AFOeOQBm2l2SLH/k9b4Yx+cQp5SjAj3T6zMFd7Ls86h4QL+vbiQfjG
        hpx/YweAgGqGV0sJYX04i510r9Sj8OGIDKduAVy/gCE8lynQu6VjJuYO4B2Rz868
        sUCrCs8p6dwekMQdhaQQ5Iv1jIBhwwK3KNqkrp4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 875E529EC3;
        Fri,  7 Jul 2023 18:05:02 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 13A0529EBF;
        Fri,  7 Jul 2023 18:04:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Matthew Hughes <mhughes@uw.co.uk>
Subject: [PATCH 0/2] Fix attr magic combined with pathspec prefix
Date:   Fri,  7 Jul 2023 15:04:55 -0700
Message-ID: <20230707220457.3655121-1-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-318-g061c58647e
MIME-Version: 1.0
X-Pobox-Relay-ID: 506C2F68-1D12-11EE-A0DF-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew Hughes noticed and reported that a pathspec that uses the
attribute magic with pathspec pattern does not work correctly.

After digging around, I found that

    $ git ls-files ":(attr:label)"

notices that the "label" attribute is set to path "sub/file" by
listing it, and combined with a pathspec pattern, i.e.

    $ git ls-files ":(attr:label)sub"

it still correctly reports "sub/file" has the "label" attribute, be
it defined in ".gitignore" or "sub/.gitignore".  The case that it
does not work is the command invocation is

    $ git ls-files ":(attr:label)sub/"

and the attribute "label" is defined in "sub/.gitattributes" for
"sub/file".

It turns out that the problematic invocation triggers the common
prefix optimization, which is totally broken for this case.

The first patch enhances the test coverage, and the second patch
fixes the broken common prefix optimization.

Junio C Hamano (2):
  t6135: attr magic with path pattern
  dir: do not feed path suffix to pathspec match

 dir.c                          | 31 ++++++-----------------
 t/t6135-pathspec-with-attrs.sh | 46 ++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 25 deletions(-)

--=20
2.41.0-318-g061c58647e

