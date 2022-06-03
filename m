Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAEBC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 14:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiFCOZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiFCOZx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 10:25:53 -0400
Received: from nmsh5.e.nsc.no (nmsh5.e.nsc.no [148.123.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39E350466
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 07:25:51 -0700 (PDT)
Received: from Lorule.wifi.realnett.no (unknown [194.19.73.58])
        (Authenticated sender: joak-pet@online.no)
        by nmsh5.e.nsc.no (smtp.online.no) with ESMTPA id C71465204D;
        Fri,  3 Jun 2022 16:25:49 +0200 (CEST)
From:   Joakim Petersen <joak-pet@online.no>
To:     git@vger.kernel.org
Cc:     Joakim Petersen <joak-pet@online.no>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: [PATCH v3] git-prompt: make colourization consistent
Date:   Fri,  3 Jun 2022 16:25:21 +0200
Message-Id: <20220603142521.42863-1-joak-pet@online.no>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220602145935.10512-1-joak-pet@online.no>
References: <20220602145935.10512-1-joak-pet@online.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The short upstream state indicator inherits the colour of the last short
state indicator before it (if there is one), and the sparsity state
indicator inherits this colour as well. Make the colourization of these
state indicators consistent by clearing any colour before printing the
short upstream state indicator, as this immediately follows the last
coloured indicator.

As of 0ec7c23cdc6 (git-prompt: make upstream state indicator location
consistent, 2022-02-27), colourization in the output of __git_ps1 has
changed such that the short upstream state indicator inherits the colour
of the last short state indicator before it (if there is one), while
before this change it was white/the default text colour. Some examples
to illustrate this behaviour (assuming all indicators are enabled and
colourization is on):
 * If the local tree is clean and there is something in the stash, both
   the '$' and the short upstream state indicator following it will be
   blue.
 * If the local tree has new, untracked files, both the '%' and the
   short upstream state indicator will be red.
 * If all local changes are added to the index and the stash is empty,
   both the '+' and the short upstream state indicator following it will
   be green.
 * If the local tree is clean and there is nothing in the stash, the
   short upstream state indicator will be white/${default text colour}.

This appears to be an unintended side-effect of the change, and makes
little sense semantically (e.g. why is it bad to be in sync with
upstream when you have uncommitted local changes?). The cause of the
change is that previously, the short upstream state indicator appeared
immediately after the rebase/revert/bisect/merge state indicator (note
the position of $p in $gitstring):

	local f="$h$w$i$s$u"
	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
	
Said indicator is prepended with the clear colour code, and the short
upstream state indicator is thus also uncoloured. Now, the short
upstream state indicator follows the sequence of colourized indicators,
without any clearing of colour (again note the position of $p, now in
$f):

	local f="$h$w$i$s$u$p"
	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"

If the user is in a sparse checkout, the sparsity state indicator
follows a similar pattern to the short upstream state indicator.However,
adding a clearing of colour before the short upstream state indicator
will change how the sparsity state indicator is colourized only when the
short upstream state indicator is present, as it currently inherits (and
before the change referenced also inherited) the colour of the last
short state indicator before it. Reading the commit message of the
change that introduced the sparsity state indicator, afda36dbf3b
(git-prompt: include sparsity state as well, 2020-06-21), it appears
this colourization also was unintended, so clearing the colour for said
indicator further increases consistency.

Signed-off-by: Joakim Petersen <joak-pet@online.no>
---
Changes since v2:
 * Wrapped clearing of $p's colour in a check for emptiness to avoid
   multiple colour clears in the final gitstring.
 * Added clearing of colour for $sparse, as it wouldn't acutally be
   cleared consistently with only the change from the previous bullet
    - Having the short upstream state indicator disabled would leave the
      sparse state indicator as it is without this patch.

Range-diff against v2:
1:  e235caa7a8 < -:  ---------- git-prompt: make colourization consistent
-:  ---------- > 1:  0e107d0496 git-prompt: make colourization consistent

 contrib/completion/git-prompt.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 87b2b916c0..4997545ee5 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -286,6 +286,12 @@ __git_ps1_colorize_gitstring ()
 	if [ -n "$u" ]; then
 		u="$bad_color$u"
 	fi
+	if [ -n "$p" ]; then
+		p="$c_clear$p"
+	fi
+	if [ -n "$sparse" ]; then
+		sparse="$c_clear$sparse"
+	fi
 	r="$c_clear$r"
 }
 
-- 
2.36.1

