Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257561F453
	for <e@80x24.org>; Fri,  8 Feb 2019 03:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBHDR4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 22:17:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63103 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfBHDRy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 22:17:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70CB714484E;
        Thu,  7 Feb 2019 22:17:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=sb0OmzuBB237boa9fug9dfJ3p
        +Y=; b=LbkKGH+rDWDH8601/t0hPiG4OKy27mQnB4TTVNqPEYubfxjmbDowmieAc
        2jf1/cK2GFj6HcUuJKIV86zxGuvIR619KZjV6eSmSNqmaOZSoBGrdpUkTbGqHTkx
        HfPAMtdYLo8uQLdaTk5RqhVuohCPbg+Y/eTj+0il5xpruypE+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=d55wFmgECYFh376qPMk
        OUcAaZzB+dUEEUcXB5QpkTX5nDC6OgcBCmEjeYzbPB+Mu39R7P1TK+JqB8gXo0/H
        PppwkSi+DkuGPuNSbtQzvpEy4SxhxYMfTaoPtUSiaxUPYdIFEyCKtqbi9JI9bBaD
        koL/yeAMLiZQs3o+fZWsamwI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69FB014484D;
        Thu,  7 Feb 2019 22:17:52 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCD5114484A;
        Thu,  7 Feb 2019 22:17:50 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/2] t/lib-gpg: drop redundant killing of gpg-agent
Date:   Thu,  7 Feb 2019 22:17:46 -0500
Message-Id: <20190208031746.22683-3-tmz@pobox.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208031746.22683-1-tmz@pobox.com>
References: <20190208031746.22683-1-tmz@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 1E6E206A-2B50-11E9-8C30-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 53fc999306 ("gpg-interface t: extend the existing GPG tests with
GPGSM", 2018-07-20), the gpgconf call which kills gpg-agent was copied
from the existing gpg setup code.

The reason for killing gpg-agent is given in 29ff1f8f74 ("t: lib-gpg:
flush gpg agent on startup", 2017-07-20):

  When running gpg-relevant tests, a gpg-daemon is spawned for each
  GNUPGHOME used. This daemon may stay running after the test and cache
  file descriptors for the trash directories, even after the trash
  directory is removed. This leads to ENOENT errors when attempting to
  create files if tests are run multiple times.

  Add a cleanup script to force flushing the gpg-agent for that GNUPGHOME
  (if any) before setting up the GPG relevant-environment.

Killing gpg-agent once per test is sufficient.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-gpg.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 207009793b..8d28652b72 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -64,7 +64,6 @@ then
 		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
=20
 		echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
-		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
 		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
 			-u committer@example.com -o /dev/null --sign - 2>&1 &&
 		test_set_prereq GPGSM
--=20
Todd
