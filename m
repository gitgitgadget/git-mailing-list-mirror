Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E5C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359239AbiELWkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359242AbiELWjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:39:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97331282037
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:39:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E29C9136A82;
        Thu, 12 May 2022 18:39:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Lryk2v9Clf8y07PricQ294QYF
        Z4rDypDlliHxaNsa8c=; b=QTx9UGTWeRqmOzbXdU4PYgp7+fEFkQlQxUAt5SKtb
        fqLZZrLUtm8PPme+vVxABZCzhCF/NlAlPy3vaq9dAqiS7ESctIVJTDOkvOSxrI//
        o4oRn0RbAYXU2qJxaZShrUbzYtojz5dTBc8DlDrMt3j+WdbvPWz+oxW2TFTUgcZn
        4o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB7E4136A81;
        Thu, 12 May 2022 18:39:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 413C1136A80;
        Thu, 12 May 2022 18:39:52 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/4] ci: use https, not http to download binaries from perforce.com
Date:   Thu, 12 May 2022 15:39:40 -0700
Message-Id: <20220512223940.238367-5-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <20220512223940.238367-1-gitster@pobox.com>
References: <20220423142559.32507-1-carenas@gmail.com>
 <20220512223940.238367-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7026D37C-D244-11EC-82FF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Since 522354d70f4 (Add Travis CI support, 2015-11-27) the CI has used
http://filehost.perforce.com/perforce/ to download binaries from
filehost.perforce.com, they were then moved to this script in
657343a602e (travis-ci: move Travis CI code into dedicated scripts,
2017-09-10).

Let's use https instead for good measure. I don't think we need to
worry about the DNS or network between the GitHub CI and perforce.com
being MitM'd, but using https gives us extra validation of the payload
at least, and is one less thing to worry about when checking where
else we rely on non-TLS'd http connections.

Also, use the same download site at perforce.com for Linux and macOS
tarballs for consistency.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index c150bce2d9..107757a1fe 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,7 +5,7 @@
=20
 . ${0%/*}/lib.sh
=20
-P4WHENCE=3Dhttp://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
+P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=3Dhttps://github.com/github/git-lfs/releases/download/v$LINUX_=
GIT_LFS_VERSION
 UBUNTU_COMMON_PKGS=3D"make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-per=
l
--=20
2.36.1-338-g1c7f76a54c

