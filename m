From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 10/23] rebase -i: implement reword in terms of do_pick
Date: Thu,  7 Aug 2014 01:59:17 +0200
Message-ID: <2cf01362ddacead66352229a232d8174e33bb82f.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB96-0004qT-Vp
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbaHGAAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:46 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:43425 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbaHGAAm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:42 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so3562740qgd.37
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m4A5eRmeObvm1N6cbOWJyWQi7c6b5PVQzFxUZbg4EI8=;
        b=XtuSOFArksEb0vwpGiHR+mN72oOyalGI68isPw598l9kATvTKdyyCtW1vQ5bLe+o+f
         WnNlCuroJMk9gqIcyFo/NK1mx/Nap6YMmqJilJ0bSgI3kqzOquqSh1g6J3FRZSlW+DR1
         ySf98PGA6pfCGE1QiJEzJ+OO3P13jdOM1jLP6jqoNbB41WDU5k+Qbery0xiJm/Dg/8ST
         zwB0Gvijv48Vu/oAOzg/kVwRPf/rPr9Lkhwhr+1YI7lndWmqEdjTcfwE5X/XCvzebafW
         +MoPfNSJL1QnukPZpOdxpTtX9DDwhwQByXvtVWyNvi2mQ89nthWKCocpmzNdJ0debocn
         QMCA==
X-Received: by 10.224.1.196 with SMTP id 4mr5679955qag.99.1407369641532;
        Wed, 06 Aug 2014 17:00:41 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254940>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. If one thinks of `pick`
entries as scheduled `cherry-pick` command lines, then `reword`
becomes an alias for the command line `cherry-pick --edit`. The
porcelain `rebase--interactive` defines a function `do_pick` for
processing the `pick` entries on to-do lists. Reimplement `reword` in
terms of `do_pick --edit`.

If the user picks a commit using the to-do list line

    reword fa1afe1 Some change

execute the command `do_pick --edit fa1afe1 "Some change"` which
carries out exactly the same steps as the case arm for `reword` in
`do_next` so far.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index aed2f93..8e1730c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -546,11 +546,7 @@ do_next () {
 		comment_for_reflog reword
 
 		mark_action_done
-		do_pick $sha1 "$rest"
-		output git commit --allow-empty --amend --no-post-rewrite --no-pre-commit ${gpg_sign_opt:+"$gpg_sign_opt"} || {
-			warn "Could not amend commit after successfully picking $sha1... $rest"
-			exit_with_patch $sha1 1
-		}
+		do_pick --edit $sha1 "$rest"
 		record_in_rewritten $sha1
 		;;
 	edit|e)
-- 
2.0.1
