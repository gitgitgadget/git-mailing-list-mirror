Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360BD1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeDRWgp (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:36:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDRWgo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:36:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A2D716081C; Wed, 18 Apr 2018 22:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091003;
        bh=1nfeQNbpURwqCtaYWD0Co4lHxZduDGOLBy2iFz+sLW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U92ooGViidL5y0R+KPjHqgw9OHM/LOXb5EaZdFqOP2yb5pSv4l3i69uR0UYFum9uK
         LvFpbojnFcA/FbYITLUvTzlOoO7eOZEYXa9SvAaOJnXQm9uJZogffo/dAOYH3ZUoJZ
         DT0cDgHp05vbwUt/ITi9iizol+s02hjXt2rHTv/c=
Received: from localhost.localdomain (unknown [188.27.164.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eddy.petrisor@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ACFA96025C;
        Wed, 18 Apr 2018 22:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091003;
        bh=1nfeQNbpURwqCtaYWD0Co4lHxZduDGOLBy2iFz+sLW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U92ooGViidL5y0R+KPjHqgw9OHM/LOXb5EaZdFqOP2yb5pSv4l3i69uR0UYFum9uK
         LvFpbojnFcA/FbYITLUvTzlOoO7eOZEYXa9SvAaOJnXQm9uJZogffo/dAOYH3ZUoJZ
         DT0cDgHp05vbwUt/ITi9iizol+s02hjXt2rHTv/c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACFA96025C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eddy.petrisor@codeaurora.org
From:   =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
To:     sbeller@google.com, jrnieder@gmail.com
Cc:     =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        git@vger.kernel.org
Subject: [RFC PATCH v4 1/9] git-submodule.sh:cmd_update: if submodule branch exists, fetch that instead of default
Date:   Thu, 19 Apr 2018 01:35:44 +0300
Message-Id: <20180418223552.18345-1-eddy.petrisor@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
References: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eddy Petrișor <eddy.petrisor@gmail.com>

There are projects such as llvm/clang which use several repositories, and they
might be forked for providing support for various features such as adding Redox
awareness to the toolchain. This typically means the superproject will use
another branch than master, occasionally even use an old commit from that
non-master branch.

Combined with the fact that when incorporating such a hierachy of repositories
usually the user is interested in just the exact commit specified in the
submodule info, it follows that a desireable usecase is to be also able to
provide '--depth 1' or at least have a shallow clone to avoid waiting for ages
for the clone operation to finish.

In theory, this should be straightforward since the git protocol allows
fetching an arbitary commit, but, in practice, some servers do not permit
fetch-by-sha1.

Git submodule seems to be very stubborn and cloning master, although the
wrapper script and the gitmodules-helper could work together to clone directly
the branch specified in the .gitmodules file, if specified.

Signed-off-by: Eddy Petrișor <eddy.petrisor@gmail.com>
---
 git-submodule.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 24914963c..65e3af08b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -589,8 +589,10 @@ cmd_update()
 			branch=$(git submodule--helper remote-branch "$sm_path")
 			if test -z "$nofetch"
 			then
+				# non-default branch refspec
+				br_refspec=$(git submodule-helper remote-branch $sm_path)
 				# Fetch remote before determining tracking $sha1
-				fetch_in_submodule "$sm_path" $depth ||
+				fetch_in_submodule "$sm_path" $depth $br_refspec ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
 			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
-- 
2.16.2

