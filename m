Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1809C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359237AbiELWju (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbiELWjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:39:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E16282028
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:39:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7DE211C53C;
        Thu, 12 May 2022 18:39:44 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=6kIivxInNghCOuS+33Q2V8MNF
        7e6uUntHjr9oswjCTY=; b=wdDU2pY7lNun96NLs7Q9q4t70LFNe3bBE22utC8B3
        rBczkxwkoTv/6P7dMck7MuT+F68VZP8Pn4RhDMHDQ5MTebdbV3v/HBdF9OL8pxBj
        4UGebiHEW1h84+i2dyFXcbZKsFu7NNoTWfIUsoas2zajizqZ76s7IonS7+5RaR2J
        6o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFFC911C53A;
        Thu, 12 May 2022 18:39:44 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4240011C539;
        Thu, 12 May 2022 18:39:44 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 1/4] ci: make failure to find perforce more user friendly
Date:   Thu, 12 May 2022 15:39:37 -0700
Message-Id: <20220512223940.238367-2-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <20220512223940.238367-1-gitster@pobox.com>
References: <20220423142559.32507-1-carenas@gmail.com>
 <20220512223940.238367-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 6B62CA62-D244-11EC-A5CE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

In preparation for a future change that will make perforce installation
optional in macOS, make sure that the check for it is done without
triggering scary looking errors and add a user friendly message instead.

All other existing uses of 'type <cmd>' in our shell scripts that
check the availability of a command <cmd> send both standard output
and error stream to /dev/null to squelch "<cmd> not found" diagnostic
output, but this script left the standard error stream shown.

Redirect it just like everybody else to squelch this error message that
we fully expect to see.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb..fa620f8fcd 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -78,15 +78,19 @@ linux-gcc-default)
 	;;
 esac
=20
-if type p4d >/dev/null && type p4 >/dev/null
+if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
 	p4d -V | grep Rev.
 	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
 	p4 -V | grep Rev.
+else
+	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
 fi
-if type git-lfs >/dev/null
+if type git-lfs >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
 	git-lfs version
+else
+	echo >&2 "WARNING: git-lfs wasn't installed, see above for clues why"
 fi
--=20
2.36.1-338-g1c7f76a54c

