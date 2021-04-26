Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE1C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E42613B2
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhDZRs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbhDZRsg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:48:36 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612AFC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:47:53 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 95DD080594;
        Mon, 26 Apr 2021 13:47:52 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v2 19/30] subtree: Don't fuss with PATH
Date:   Mon, 26 Apr 2021 11:45:14 -0600
Message-Id: <20210426174525.3937858-20-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174525.3937858-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210426174525.3937858-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Scripts needing to fuss with with adding $(git --exec-prefix) PATH
before loading git-sh-setup is a thing of the past.  As far as I can
tell, it's been a thing of the past since since Git v1.2.0 (2006-02-12),
or more specifically, since 77cb17e940 (Exec git programs without using
PATH, 2006-01-10).  However, it stuck around in contrib scripts and in
third-party scripts for long enough that it wasn't unusual to see.

Originally `git subtree` didn't fuss with PATH, but when people
(including the original subtree author) had problems, because it was a
common thing to see, it seemed that having subtree fuss with PATH was a
reasonable solution.

Here is an abridged history of fussing with PATH in subtree:

  2987e6add3 (Add explicit path of git installation by 'git --exec-path', Gianluca Pacchiella, 2009-08-20)

    As pointed out by documentation, the correct use of 'git-sh-setup' is
    using $(git --exec-path) to avoid problems with not standard
    installations.

    -. git-sh-setup
    +. $(git --exec-path)/git-sh-setup

  33aaa697a2 (Improve patch to use git --exec-path: add to PATH instead, Avery Pennarun, 2009-08-26)

    If you (like me) are using a modified git straight out of its source
    directory (ie. without installing), then --exec-path isn't actually correct.
    Add it to the PATH instead, so if it is correct, it'll work, but if it's
    not, we fall back to the previous behaviour.

    -. $(git --exec-path)/git-sh-setup
    +PATH=$(git --exec-path):$PATH
    +. git-sh-setup

  9c632ea29c ((Hopefully) fix PATH setting for msysgit, Avery Pennarun, 2010-06-24)

    Reported by Evan Shaw.  The problem is that $(git --exec-path) includes a
    'git' binary which is incompatible with the one in /usr/bin; if you run it,
    it gives you an error about libiconv2.dll.

    +OPATH=$PATH
     PATH=$(git --exec-path):$PATH
     . git-sh-setup
    +PATH=$OPATH  # apparently needed for some versions of msysgit

  df2302d774 (Another fix for PATH and msysgit, Avery Pennarun, 2010-06-24)

    Evan Shaw tells me the previous fix didn't work.  Let's use this one
    instead, which he says does work.

    This fix is kind of wrong because it will run the "correct" git-sh-setup
    *after* the one in /usr/bin, if there is one, which could be weird if you
    have multiple versions of git installed.  But it works on my Linux and his
    msysgit, so it's obviously better than what we had before.

    -OPATH=$PATH
    -PATH=$(git --exec-path):$PATH
    +PATH=$PATH:$(git --exec-path)
     . git-sh-setup
    -PATH=$OPATH  # apparently needed for some versions of msysgit

First of all, I disagree with Gianluca's reading of the documentation:
 - I haven't gone back to read what the documentation said in 2009, but
   in my reading of the 2021 documentation is that it includes "$(git
   --exec-path)/" in the synopsis for illustrative purposes, not to say
   it's the proper way.
 - After being executed by `git`, the git exec path should be the very
   first entry in PATH, so it shouldn't matter.
 - None of the scripts that are part of git do it that way.

But secondly, the root reason for fussing with PATH seems to be that
Avery didn't know that he needs to set GIT_EXEC_PATH if he's going to
use git from the source directory without installing.

And finally, Evan's issue is clearly just a bug in msysgit.  I assume
that msysgit has since fixed the issue, and also msysgit has been
deprecated for 6 years now, so let's drop the workaround for it.

So, remove the line fussing with PATH.  However, since subtree *is* in
'contrib/' and it might get installed in funny ways by users
after-the-fact, add a sanity check to the top of the script, checking
that it is installed correctly.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 3105eb8033..af636fbb43 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -5,6 +5,22 @@
 # Copyright (C) 2009 Avery Pennarun <apenwarr@gmail.com>
 #
 
+if test -z "$GIT_EXEC_PATH" || test "${PATH#"${GIT_EXEC_PATH}:"}" = "$PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
+then
+	echo >&2 'It looks like either your git installation or your'
+	echo >&2 'git-subtree installation is broken.'
+	echo >&2
+	echo >&2 "Tips:"
+	echo >&2 " - If \`git --exec-path\` does not print the correct path to"
+	echo >&2 "   your git install directory, then set the GIT_EXEC_PATH"
+	echo >&2 "   environment variable to the correct directory."
+	echo >&2 " - Make sure that your \`${0##*/}\` file is either in your"
+	echo >&2 "   PATH or in your git exec path (\`$(git --exec-path)\`)."
+	echo >&2 " - You should run git-subtree as \`git ${0##*/git-}\`,"
+	echo >&2 "   not as \`${0##*/}\`." >&2
+	exit 126
+fi
+
 OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <ref>
@@ -28,8 +44,6 @@ rejoin        merge the new branch back into HEAD
 squash        merge subtree changes as a single commit
 "
 
-PATH=$PATH:$(git --exec-path)
-
 arg_debug=
 arg_command=
 arg_prefix=
-- 
2.31.1

