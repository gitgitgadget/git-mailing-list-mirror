Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB32CC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359205AbiELWcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359199AbiELWcc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:32:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E4CA308B
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:32:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02D4D11C3A4;
        Thu, 12 May 2022 18:32:30 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NAitZOvsq15v
        kpoJYXzpoEnEwgVl7LaEbaWv0PgDOdE=; b=hE2bMAkxFXsNeD+6JPWCFENbHl8E
        4LIydaUUwiyFgpQHK98hhGG5jXYSnx74qFzO0+UB51s8ZPzZaSmT/9G0E/rA+pIr
        FG1Bvi3ZcCjHqf+U/uFefxStrhZKpj2eiVnX6MzU92wQfiwNF7pfNP8wsqitA56r
        nZF6Jt9tAFrRmow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECE0911C3A3;
        Thu, 12 May 2022 18:32:29 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5552411C39A;
        Thu, 12 May 2022 18:32:29 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] log test: skip a failing mkstemp() test under valgrind
Date:   Thu, 12 May 2022 15:32:16 -0700
Message-Id: <20220512223218.237544-3-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <20220512223218.237544-1-gitster@pobox.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
 <20220512223218.237544-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 6826C32C-D243-11EC-91FF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Skip a test added in f1e3df31699 (t: increase test coverage of
signature verification output, 2020-03-04) when running under
valgrind. Due to valgrind's interception of mkstemp() this test will
fail with:

	+ pwd
	+ TMPDIR=3D[...]/t/trash directory.t4202-log/bogus git log --show-signat=
ure -n1 plain-fail
	=3D=3D7696=3D=3D VG_(mkstemp): failed to create temp file: [...]/t/trash=
 directory.t4202-log/bogus/valgrind_proc_7696_cmdline_d545ddcf
	[... 10 more similar lines omitted ..]
	valgrind: Startup or configuration error:
	valgrind:    Can't create client cmdline file in [...]/t/trash directory=
.t4202-log/bogus/valgrind_proc_7696_cmdline_6e542d1d
	valgrind: Unable to start up properly.  Giving up.
	error: last command exited with $?=3D1

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4202-log.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index be07407f85..6e66352558 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1992,10 +1992,13 @@ test_expect_success GPG 'log --show-signature for=
 merged tag with GPG failure' '
 	git tag -s -m signed_tag_msg signed_tag_fail &&
 	git checkout plain-fail &&
 	git merge --no-ff -m msg signed_tag_fail &&
-	TMPDIR=3D"$(pwd)/bogus" git log --show-signature -n1 plain-fail >actual=
 &&
-	grep "^merged tag" actual &&
-	grep "^No signature" actual &&
-	! grep "^gpg: Signature made" actual
+	if ! test_have_prereq VALGRIND
+	then
+		TMPDIR=3D"$(pwd)/bogus" git log --show-signature -n1 plain-fail >actua=
l &&
+		grep "^merged tag" actual &&
+		grep "^No signature" actual &&
+		! grep "^gpg: Signature made" actual
+	fi
 '
=20
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x=
509' '
--=20
2.36.1-338-g1c7f76a54c

