Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8FA020375
	for <e@80x24.org>; Sun,  8 Oct 2017 21:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbdJHVaz (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 17:30:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42280 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752060AbdJHVay (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 17:30:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2C8FF20375;
        Sun,  8 Oct 2017 21:30:54 +0000 (UTC)
Date:   Sun, 8 Oct 2017 21:30:53 +0000
From:   Eric Wong <e@80x24.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Special strings in commit messages
Message-ID: <20171008213053.GA8568@starla>
References: <f54bea17-c245-c644-f974-ca2ac84901c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f54bea17-c245-c644-f974-ca2ac84901c6@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Weimer <fweimer@redhat.com> wrote:
> Based on strace output, something in git rebase calls git mailsplit, and it
> probably sees the "\nFrom " string and treats it as a start of a new mail
> message, and things go downhill from there.
> 
> I will escape "\nFrom " in commit messages (probably as "\n.From " or maybe
> "\n>From ", plus escaping for "\n."/"\n>" to make the encoding reversible),
> but I wonder if there is something else I need to escape while I'm at it.

I suppose it's safe to start using mboxrd internally when
there's little danger of mixing different git versions.

Totally untested (but passes "make test"), can you try this?

-----8<------
Subject: [PATCH] rebase: use mboxrd format to avoid split errors

The mboxrd format allows the use of embedded "From " lines in
commit messages without being misinterpreted by mailsplit

Reported-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 git-rebase--am.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 6e64d40d6f..14c50782e0 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -53,6 +53,7 @@ else
 
 	git format-patch -k --stdout --full-index --cherry-pick --right-only \
 		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
+		--pretty=mboxrd \
 		$git_format_patch_opt \
 		"$revisions" ${restrict_revision+^$restrict_revision} \
 		>"$GIT_DIR/rebased-patches"
@@ -83,6 +84,7 @@ else
 	fi
 
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
+		--patch-format=mboxrd \
 		$allow_rerere_autoupdate \
 		${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
 	ret=$?
-- 
EW
