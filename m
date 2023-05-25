Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A133C77B7A
	for <git@archiver.kernel.org>; Thu, 25 May 2023 03:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjEYDKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 23:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYDKi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 23:10:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA63A9
        for <git@vger.kernel.org>; Wed, 24 May 2023 20:10:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B95118AC49;
        Wed, 24 May 2023 23:10:36 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=IW7DL5LzJhgHwwSvKH3vOU+z52Ofmw+qY3nOLJzVNww=; b=YLt3
        PDBuydddaa4kIL3s4Tuf9u6KRGd/qAEKLR8PO0kqeG5OdZ3VHhSr4siIQwMUC/55
        WYhh7lFpqQqY7GSu1e9QKRDuJoRdSDtuXsW+nqX9NCqyguLgjiDLVJXPlAWd9pKS
        eNXdhNZLxgbrciYKvboC8xrQZQw0Mffek18V3PM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95B1C18AC48;
        Wed, 24 May 2023 23:10:36 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB4A518AC47;
        Wed, 24 May 2023 23:10:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH] t/lib-gpg: fix ssh-keygen -Y check-novalidate with openssh-9.0
Date:   Wed, 24 May 2023 23:10:24 -0400
Message-ID: <20230525031026.3554406-1-tmz@pobox.com>
X-Mailer: git-send-email 2.41.0.rc2
MIME-Version: 1.0
X-Pobox-Relay-ID: B7F0F6A4-FAA9-11ED-90AB-C65BE52EC81B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OpenSSH-9.0 requires a namespace option with `-Y check-novalidate`.
This was added in openssh-portable commit a0b5816f8 (upstream:
ssh-keygen -Y check-novalidate requires namespace or SEGV, 2022-03-18).

The -n option was documented as a required option since check-novalidate
was added in openssh-portable 8aa2aa3cd (upstream: Allow testing
signature syntax and validity without verifying, 2019-09-16).

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
Hi,

I only recently noticed the GPGSSH_VERIFYTIME prereq had
been failing in the Fedora builds.  This began when openssh
was updated to 9.0 in the distribution, which means I've
been slack on checking missing prereqs since last August. :/

Initially, I thought it was another issue, where the final
ssh-keygen call in the prereq lacked a message on stdin,
which caused it to hang.

That only occurs when running the contents of the prereq
manually, so it may not be worth touching.  But if that
seems worthwhile -- if only to avoid anyone else getting
spending time debugging the wrong problem -- I can send the
patch I had prepared which does:

  diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
  index 114785586a..2815df8503 100644
  --- a/t/lib-gpg.sh
  +++ b/t/lib-gpg.sh
  @@ -165,7 +165,7 @@ test_lazy_prereq GPGSSH_VERIFYTIME '
   	# and verify ssh-keygen verifies the key lifetime
   	echo "testpayload" |
   	ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_EXPIRED}" >gpgssh_verify=
time_prereq.sig &&
  -	! (ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "p=
rincipal with expired key" -s gpgssh_verifytime_prereq.sig)
  +	! (echo "testpayload" | ssh-keygen -Y verify -n "git" -f "${GPGSSH_AL=
LOWED_SIGNERS}" -I "principal with expired key" -s gpgssh_verifytime_prer=
eq.sig)
   '
  =20
   sanitize_pgp() {

 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 114785586a..28652ed91f 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -136,7 +136,7 @@ test_lazy_prereq GPGSSH '
=20
 test_lazy_prereq GPGSSH_VERIFYTIME '
 	# Check if ssh-keygen has a verify-time option by passing an invalid da=
te to it
-	ssh-keygen -Overify-time=3DINVALID -Y check-novalidate -s doesnotmatter=
 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
+	ssh-keygen -Overify-time=3DINVALID -Y check-novalidate -n "git" -s does=
notmatter 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
=20
 	# Set up keys with key lifetimes
 	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_T=
IMEBOXEDVALID}" >/dev/null &&
--=20
2.41.0.rc2
