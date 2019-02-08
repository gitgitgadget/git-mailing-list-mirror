Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45A51F453
	for <e@80x24.org>; Fri,  8 Feb 2019 03:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBHDSA (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 22:18:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57533 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfBHDRx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 22:17:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFB3F14484C;
        Thu,  7 Feb 2019 22:17:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=BlOgcw+nxmsYilFBcmvXRcNHY
        Po=; b=Rf4e7bB7fkl4Ffr3FmQvuVREC1PcUxkOmtE+7tOr+9tmpGDJuRO43AKAf
        icfMZF5UoeviT5Cc5/tg/6cvmk7uSxXWdtu+PktG5D0mnRTmdX868cjR3MT7EceL
        tbLsahe0gwDkdUqolZar9AoypsZOuI/I9azhB7bXYweXZTIBo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=FvT69kjVPX/eICa/ell
        /6SrVeT3GkSKVbEYiL2yF2N3V0BR3bGoQldwDGqrn30pCVcXrhI9/w4GWmxTP02U
        /jbezhozTG4MFbyMsxziATsUFSUcumQBOj0bN6y/FZrpVmc0BS9ZEO2h9r1b09qq
        dvywPlzSWQv6pSfbU70Axu7s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E694714484B;
        Thu,  7 Feb 2019 22:17:50 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D3E7144847;
        Thu,  7 Feb 2019 22:17:49 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 1/2] t/lib-gpg: quote path to ${GNUPGHOME}/trustlist.txt
Date:   Thu,  7 Feb 2019 22:17:45 -0500
Message-Id: <20190208031746.22683-2-tmz@pobox.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208031746.22683-1-tmz@pobox.com>
References: <20190208031746.22683-1-tmz@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 1D86E0BA-2B50-11E9-80B6-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When gpgsm is installed, lib-gpg.sh attempts to update trustlist.txt to
relax the checking of some root certificate requirements.  The path to
"${GNUPGHOME}" contains spaces which cause an "ambiguous redirect"
warning when bash is used to run the tests:

  $ bash t7030-verify-tag.sh
  /git/t/lib-gpg.sh: line 66: ${GNUPGHOME}/trustlist.txt: ambiguous redir=
ect
  ok 1 - create signed tags
  ok 2 # skip create signed tags x509  (missing GPGSM)
  ...

No warning is issued when using bash called as /bin/sh, dash, or mksh.

Quote the path to ensure the redirect works as intended and sets the
GPGSM prereq.  While we're here, drop the space after ">>".

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index f1277bef4f..207009793b 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -63,7 +63,7 @@ then
 		cut -d" " -f4 |
 		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
=20
-		echo " S relax" >> ${GNUPGHOME}/trustlist.txt &&
+		echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
 		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
 		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
 			-u committer@example.com -o /dev/null --sign - 2>&1 &&
--=20
Todd
