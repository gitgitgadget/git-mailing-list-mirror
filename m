Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D4EC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359247AbiELWj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359238AbiELWjv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:39:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C3A282000
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:39:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E6341A0396;
        Thu, 12 May 2022 18:39:49 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=VBFZKMTgLFv7BTEaGtRBzOKJr
        eg7RjsOqL2Rf/IHXD8=; b=sUHn6MLCjeVLdOPDy5pRgUefvkloA0ZZNpKGuoDz/
        eRTOCtpNZ2EcvT/l3UqcZYXiRcxxGd7jxk3Wi827X5UOHdIGalcTSqUMfn/dLFCf
        bdIDWSohX6mV9bDgunLr1HGj7zCJIPmXYV/Ti2rOkL0ExAoOr1dne5a7r0C0SN4n
        gE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3745D1A0395;
        Thu, 12 May 2022 18:39:49 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D90A41A0394;
        Thu, 12 May 2022 18:39:45 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 2/4] ci: avoid brew for installing perforce
Date:   Thu, 12 May 2022 15:39:38 -0700
Message-Id: <20220512223940.238367-3-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <20220512223940.238367-1-gitster@pobox.com>
References: <20220423142559.32507-1-carenas@gmail.com>
 <20220512223940.238367-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 6C593730-D244-11EC-889E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Perfoce's cask in brew is meant[1] to be used only by humans, so replace
its use from the CI with a scripted binary download which is less likely
to fail, as it is done in Linux.

Kept the logic together so it will be less likely to break when moved
around as on the fly code changes in this area are settled, at which
point it will also feasable to ammend it to avoid some of the hardcoded
values by using similar variables to the ones Linux does.

In that same line, a POSIX sh syntax is used instead of the similar one
used in Linux in preparation for an unrelated future change that might
change the shell currently configured for it.

This change reintroduces the risk that the installed binaries might not
work because of being quarantined that was fixed with 5ed9fc3fc86 (ci:
prevent `perforce` from being quarantined, 2020-02-27) but fixing that
now was also punted for simplicity and since the affected cloud provider
is scheduled to be retired with an on the fly change, but should be
addressed if that other change is not integrated further.

The discussion on the need to keep 2 radically different versions of
the binaries to be tested with Linux vs macOS or how to upgrade to
newer versions now that brew won't do that automatically for us has
been punted for now as well.  On that line the now obsolete comment
about it in lib.sh was originally being updated by this change but
created conflicts as it is moved around by other on the fly changes,
so will be addressed independently as well.

[1] https://github.com/Homebrew/homebrew-cask/pull/122347#discussion_r856=
026584

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index fa620f8fcd..8e796fa669 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,13 +37,14 @@ macos-latest)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	brew install --cask --no-quarantine perforce || {
-		# Update the definitions and try again
-		cask_repo=3D"$(brew --repository)"/Library/Taps/homebrew/homebrew-cask=
 &&
-		git -C "$cask_repo" pull --no-stat --ff-only &&
-		brew install --cask --no-quarantine perforce
-	} ||
-	brew install homebrew/cask/perforce
+	mkdir -p $HOME/bin
+	(
+		cd $HOME/bin
+		wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_=
64/helix-core-server.tgz" &&
+		tar -xf helix-core-server.tgz
+	)
+	PATH=3D"$PATH:${HOME}/bin"
+	export PATH
=20
 	if test -n "$CC_PACKAGE"
 	then
--=20
2.36.1-338-g1c7f76a54c

