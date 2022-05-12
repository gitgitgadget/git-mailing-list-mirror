Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59186C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359206AbiELWgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359223AbiELWgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:36:07 -0400
X-Greylist: delayed 215 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 15:36:05 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA152555BB
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:36:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1319219C318;
        Thu, 12 May 2022 18:32:28 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=06U3yT5vhAJL
        sxdAxFrEQq7xv+oNM5pGIVrcU5fsEEY=; b=fwS0M4HD3kqy1/UvuoDutb14kyDw
        9l8wQ34F3VmYmkieufMBFFHs7ao3p6tQendagWJOsjylBG+dSF7qjRMOy94ho6GY
        UBQmHYdOcKZWV+obo12Aak+4410VAoNDs42uvim8C3El7FqsLgHUo6cmQeIggHa8
        jI3s+i9nDlmrwQI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B08719C317;
        Thu, 12 May 2022 18:32:28 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A59C119C316;
        Thu, 12 May 2022 18:32:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/4] test fixes around valgrind
Date:   Thu, 12 May 2022 15:32:14 -0700
Message-Id: <20220512223218.237544-1-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 655DEA08-D243-11EC-AA4B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updates the valgrind test framework a bit, and then fixes a few
issues valgrind has found.

Essentailly the same as the previously posted version, but those
suggested fixes squashed in.

I am sending this out as a final "complain now, or this will go to
'next' soonish" warning.  The "What's cooking" report is getting
crowded with too many topics marked as "Expecting a reroll", and I'm
trying to do easier ones myself to see how much reduction we can
make.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  tests: using custom GIT_EXEC_PATH breaks --valgrind tests
  log test: skip a failing mkstemp() test under valgrind
  commit-graph.c: don't assume that stat() succeeds
  object-file: fix a unpack_loose_header() regression in 3b6a8db3b03

 commit-graph.c        |  6 ++++--
 object-file.c         |  8 ++++++--
 t/t0060-path-utils.sh |  4 ++--
 t/t1006-cat-file.sh   | 10 ++++++++--
 t/t1450-fsck.sh       | 13 +++++++++++--
 t/t4202-log.sh        | 11 +++++++----
 t/test-lib.sh         |  1 +
 7 files changed, 39 insertions(+), 14 deletions(-)


1:  4ebaddb01d ! 1:  3b79af1dde tests: make RUNTIME_PREFIX compatible wit=
h --valgrind
    @@ Metadata
     Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    =20
      ## Commit message ##
    -    tests: make RUNTIME_PREFIX compatible with --valgrind
    +    tests: using custom GIT_EXEC_PATH breaks --valgrind tests
    =20
         Fix a regression in b7d11a0f5d2 (tests: exercise the RUNTIME_PRE=
FIX
         feature, 2021-07-24) where tests that want to set up and test a =
"git"
2:  b25609d6fc =3D 2:  35a7226706 log test: skip a failing mkstemp() test=
 under valgrind
3:  d56edb6654 ! 3:  84d1793178 commit-graph.c: don't assume that stat() =
succeeds
    @@ Commit message
    =20
         This would happen as we stat'd the non-existing
         ".git/objects/info/commit-graph" file. Let's fix mark_commit_gra=
phs()
    -    to check the statu() return value, and while we're at it fix ano=
ther
    +    to check the stat()'s return value, and while we're at it fix an=
other
         case added in the same commit to do the same.
    =20
         The caller in expire_commit_graphs() would have been less likely=
 to
4:  995cfb0439 =3D 4:  391ae0a276 object-file: fix a unpack_loose_header(=
) regression in 3b6a8db3b03



--=20
2.36.1-338-g1c7f76a54c

