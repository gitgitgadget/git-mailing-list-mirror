From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 12/27] rebase -i: log the replay of root commits
Date: Mon, 18 Aug 2014 23:22:55 +0200
Message-ID: <93551acf7a6d2bd861c071c6d344247b9b4094dd.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:26:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJURD-0001RZ-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbaHRVYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:05 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:45097 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbaHRVYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:03 -0400
Received: by mail-lb0-f172.google.com with SMTP id z11so4740487lbi.17
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Em45OWenRQUC0qPXG38prbZaP3d4sXSh+/fs4aJdTF4=;
        b=nqLKT8qhZ5FNuV0iCtkHSJjaJlpd/+IKByr6n5vZV9KEhoVS6CN4LryxO5efZV41tp
         cGdMfv0Jo3BBPXRMXtAJXmJtIYNKorjznlwHvUNOQmWAsabRkhLfMj976RBqQ5Bfn/3x
         w/u3L3C11VTqbT2Sg6yRmh7W21IWr/bZ03C/16cusXFwDXFGDj8HJU5r8FQ1kkp0dsja
         NaIw4tu1F9BleQP0G+2yYNgPvgqWaTchRJVtfahEWL/5Jzld6nFEeJRQsdz95Pkm4UzX
         pOK/1R1XxOp1DkXmrOMMI6VIbxepZ2CRBH0eKKe9stTBrGUh17sFcSH8z50eXJfztmgR
         aN/g==
X-Received: by 10.112.219.234 with SMTP id pr10mr29418052lbc.59.1408397042404;
        Mon, 18 Aug 2014 14:24:02 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:01 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255437>

The command line used to recreate root commits specifies the option
`-q` which suppresses the commit summary message. However,
git-rebase--interactive tends to tell the user about the commits it
creates in the final history, if she wishes (cf. command line option
`--verbose`). The code parts handling non-root commits and squash
commits all output commit summary messages. Do not make the replay of
root commits an exception. Remove the option to make the report of
the rebased history complete. Do not forget to wrap the git-commit
command line in `output` so that the summary is shown if git-rebase
is called with the `--verbose` option but suppressed otherwise.

It is OK that the commit summary is still suppressed when git-commit
is used to initialize the authorship of the sentinel commit because
this additional commit is an implementation detail hidden from the
final history. The removed `-q` option was probably introduced as a
copy-and-paste error stemming from that part of the root commit
handling code.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2d768b3..f4bb822 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -510,8 +510,8 @@ do_pick () {
 		git commit --allow-empty --allow-empty-message --amend \
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
-			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -q -C $1 \
+			output git commit --allow-empty --allow-empty-message \
+				   --amend --no-post-rewrite -n -C $1 \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
-- 
2.0.1
