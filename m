Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2928BEB64DA
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 14:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGSOw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGSOwX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 10:52:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E59BC7
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 07:52:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B611D1FD69;
        Wed, 19 Jul 2023 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689778340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Pz/+ai53udOSvj8mRAtHX/6ot2P1/dABCTyBZ8Qcc+s=;
        b=ajWKdiDS+yfIy/kMn1DJZ4OwCfO6QpV8QuHFDCbxi+oD+x8ehgLcJA6/VF/zxp4FjDz8Jo
        KJ9F/6v1vmhisT5TyAfenLlPryUKzk6NoTaPA8/Q6XGxeXHStyqsY7ToQ6TkubDoWyjAmE
        ADnXADKJ9P7yqG1a0rmHZEEA20OlymQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689778340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Pz/+ai53udOSvj8mRAtHX/6ot2P1/dABCTyBZ8Qcc+s=;
        b=Jrpi12vtw1Lc9lBgEy1ik6fz+gXnhrBCcpFPeJeVLugYgUu5NGDzlDYi10k6NfrxgjvMkI
        VO+8NL3caaGBHTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9018513460;
        Wed, 19 Jul 2023 14:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6DeVIaT4t2TBVQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Wed, 19 Jul 2023 14:52:20 +0000
From:   Andreas Herrmann <aherrmann@suse.de>
To:     git@vger.kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] configure.ac: misc configure fixes
Date:   Wed, 19 Jul 2023 16:29:52 +0200
Message-ID: <20230719145211.17854-2-aherrmann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the configure options are not working as expected.
I first encountered this when using '--with-expat=no'.
Following patches address this.

I've also checked configure options for 'libpcre', 'openssl' (together
with 'make OPENSSL_SHA1=yes ...'), and 'tcltk'. These are working
correctly.

As a test I've run 'make test' when disabling support of a package.
I always had to use 'export GIT_SKIP_TESTS="t5801.1[4-7] t5801.31"' to
skip some failing tests. Those failed also with default build.

When disabling iconv ('configure --without-iconv') further tests are
failing. In this case I've used
'export GIT_SKIP_TESTS="t5801.1[4-7] t5801.31 \
t0028* t2082.2 t3434* t390[01]* \
t4041* t4059* t4060.8 t4201.12 t4205* t4210* t4254.[34] \
t5100* t6006* t7102.2 t8005* t9300.193 t9350*"'
to ensure that 'make test' completed without exiting early.

Andreas Herrmann (3):
  configure.ac: don't overwrite NO_EXPAT option
  configure.ac: don't overwrite NO_CURL option
  configure.ac: always save NO_ICONV to config.status

 configure.ac | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.41.0

