Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61559C5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08397216C4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ty/uO3YJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKLUcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:32:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55861 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgKLUcG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 15:32:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46A27FAB4F;
        Thu, 12 Nov 2020 15:32:03 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EKHVNEwj5rkh
        4d/yyxzunExPelQ=; b=Ty/uO3YJc+xZJxgkPXoRqteqG7IZcUplhrHZ6u4yJT0u
        mn4O++l7PIyvFT7H0broWqCgDehP9VDpdUSFMWx/C8avYVk80+wzValaS0YvCpnP
        Uy99FR/JQzpnV6PBVSGO3FphRrJoPBg5kA3VJRuh15hR3nakILL9I6OkBXa/OgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SkoZ3k
        Cc28+qH2+vF6UQ0MJQGjey8veQ8+z9d1W4rbBlzBsnoYkeN1Kfk/O000OLhygzwk
        UbI/9gHsq9Srbrp5ix3549MZAdScWlGKA3ueYSilYRxsMtWYHv1ZLw/085fBw5Mk
        RRihXLWPG1Is2yn8+zPGXE31AwZzmLJ98PreM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FF17FAB4D;
        Thu, 12 Nov 2020 15:32:03 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E695FAB4A;
        Thu, 12 Nov 2020 15:32:00 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] parse-remote: move used code to git-submodule.sh
Date:   Thu, 12 Nov 2020 12:31:54 -0800
Message-Id: <20201112203155.3342586-2-gitster@pobox.com>
X-Mailer: git-send-email 2.29.2-442-ga30192deef
In-Reply-To: <20201112203155.3342586-1-gitster@pobox.com>
References: <xmqqwnyr4zv8.fsf@gitster.c.googlers.com>
 <20201112203155.3342586-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 1DE2A11C-2526-11EB-A93B-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Move the get_default_remote () helper from git-parse-remote.sh to
git-submodule.sh, as the latter is the only user.

There are two more helper functions, get_remote_merge_branch() and
error_on_missing_default_upstream(), in the git-parse-remote shell
function library, but they are not referenced by git-submodule.sh;
stop dot-sourcing the git-parse-remote.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-parse-remote.sh | 7 -------
 git-submodule.sh    | 8 +++++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index d3c39980f3..0c2a5ef6c4 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -6,13 +6,6 @@
 # this would fail in that case and would issue an error message.
 GIT_DIR=3D$(git rev-parse -q --git-dir) || :;
=20
-get_default_remote () {
-	curr_branch=3D$(git symbolic-ref -q HEAD)
-	curr_branch=3D"${curr_branch#refs/heads/}"
-	origin=3D$(git config --get "branch.$curr_branch.remote")
-	echo ${origin:-origin}
-}
-
 get_remote_merge_branch () {
 	case "$#" in
 	0|1)
diff --git a/git-submodule.sh b/git-submodule.sh
index 7ce52872b7..e7962e1a45 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -20,7 +20,6 @@ USAGE=3D"[--quiet] [--cached]
 OPTIONS_SPEC=3D
 SUBDIRECTORY_OK=3DYes
 . git-sh-setup
-. git-parse-remote
 require_work_tree
 wt_prefix=3D$(git rev-parse --show-prefix)
 cd_to_toplevel
@@ -413,6 +412,13 @@ is_tip_reachable () (
 	test -z "$rev"
 )
=20
+get_default_remote () {
+	curr_branch=3D$(git symbolic-ref -q HEAD)
+	curr_branch=3D"${curr_branch#refs/heads/}"
+	origin=3D$(git config --get "branch.$curr_branch.remote")
+	echo ${origin:-origin}
+}
+
 fetch_in_submodule () (
 	sanitize_submodule_env &&
 	cd "$1" &&
--=20
2.29.2-442-ga30192deef

