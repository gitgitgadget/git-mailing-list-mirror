Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95361C2BB1D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA86206E2
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nVtYVL8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbgCPV3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:29:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56143 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPV3B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 17:29:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E92F613CA;
        Mon, 16 Mar 2020 17:28:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=g0yUYIDW/a4tHvUtVjubaJONeSw=; b=nVtYVL8tAiXuaxcHZYe9
        CDONi7IdE/r6hSUKai8hxMO3KsVdzx38RBPq6XWnVHSTwuKSVwV25N/+iY10Atdq
        HnoYWhhjrfL+tFVroDigla9L9X2qctLsky9J1W2UFpAnCKgSZ5PiWrr+oyBhaE6h
        wz5wy64r/ySSjDn7j4A48tA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-transfer-encoding; q=dns;
         s=sasl; b=qWxWE9oRd9zAdNkqIfCkrVDFqN/t8OkVDgdFH/DckP5VOwd3SyDXc
        fITmdyypQiOkmesAECGD1Aw6YA56DvjuH6KU03scGJEEpcuDDDV+Wnm+PeP1puLp
        G+/UDk27SxyBF0AlaDh4SBPIxXKZJ9odyCgdpVqHjnxWa2Qv7UJYvI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16ACE613C8;
        Mon, 16 Mar 2020 17:28:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B808613C5;
        Mon, 16 Mar 2020 17:28:58 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] I keep typing "git log --no-mailmap" X-<
Date:   Mon, 16 Mar 2020 14:28:54 -0700
Message-Id: <20200316212857.259093-1-gitster@pobox.com>
X-Mailer: git-send-email 2.26.0-rc1-11-g30e9940356
MIME-Version: 1.0
X-Pobox-Relay-ID: 25A697F8-67CD-11EA-B661-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ultimate objective of this miniseries is to allow me to say
"git log --no-mailmap" by adding an alias "--mailmap" to the=20
existing "--use-mailmap" option.

But I had to do a little cleaning up of the OPT_ALIAS() interface,
which is the topic of the first two patches.  Without them, an
option that is an alias to another option is shown in "git cmd -h"
output like this illustration:

    $ git clone -h
    usage: git clone [<options>] [--] <repo> [<dir>]
	...
	--recursive[=3D<pathspec>]
			      initialize submodules in the clone
	--recurse-submodules[=3D<pathspec>]
			      initialize submodules in the clone
	-j, --jobs <n>        number of submodules cloned in parallel
	...

The "recursive" option is defined as an alias to "recurse-submodules",
but with exactly the same short text, the user may realize that they
are identical, or they may suspect they are largely similar with
subtle differences that the short help text cannot adequately convey.

With the first two patches, the output becomes like this:

    $ git clone -h
    usage: git clone [<options>] [--] <repo> [<dir>]
	...
	--recurse-submodules[=3D<pathspec>]
			      initialize submodules in the clone
	--recursive[=3D<pathspec>]
			      alias of --recurse-submodules
	-j, --jobs <n>        number of submodules cloned in parallel
	...

which would make it clear that the latter is a way to spell the same
thing as the other.

Junio C Hamano (3):
  parse-options: teach "git cmd -h" to show alias as alias
  clone: reorder --recursive/--recurse-submodules
  log: give --[no-]use-mailmap a more sensible synonym --[no-]mailmap

 Documentation/git-log.txt | 1 +
 builtin/clone.c           | 2 +-
 builtin/log.c             | 1 +
 parse-options.c           | 9 +++------
 t/t0040-parse-options.sh  | 2 +-
 5 files changed, 7 insertions(+), 8 deletions(-)

--=20
2.26.0-rc1-11-g30e9940356


