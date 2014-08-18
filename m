From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 11/27] rebase -i: implement reword in terms of do_pick
Date: Mon, 18 Aug 2014 23:22:54 +0200
Message-ID: <3f8d98069b5920883d55b666dd344cc02c174c1e.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:25:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUQy-0001II-RN
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbaHRVYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:06 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:35164 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbaHRVYC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:02 -0400
Received: by mail-la0-f47.google.com with SMTP id mc6so5073812lab.20
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EuX/Hax0cXSZMv+mvC67RnCoQSBetE7VM4PmXwBCgAk=;
        b=YdCknuJwrtcVWCoOlCXD5mcGC/xNWRlbxCDjmSR++Uy8v/AsnB8p7BBjmsel0yIU7P
         7fupDI4wixA4eHufmFGQ/x8N1O22lwrm0v689cupZlNQ5vRqbpfjAZN9uSgzbj/1PhKe
         olHZjJQ+Qc+YhwW9vZ8xBmujJlY8nhfEjNFF7D9KFu/BFw2fCGVFVYNB1JFPLKJukTyc
         lAKXj0dxUlLaVhkYXN1rPMLpzs2JQ62PcPwA1rz1VfqfIBYkRXiDaN1CxNAxkFEvcjgX
         ISJ8VaQ98GE0qrqVIclKjA4Hp5M/uZyuLRrY/vGWerCK2qo2AwZFzPVMJCdEYIff9wGP
         TxAQ==
X-Received: by 10.112.204.164 with SMTP id kz4mr30226661lbc.15.1408397040614;
        Mon, 18 Aug 2014 14:24:00 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255434>

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
index 8a89ced..2d768b3 100644
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
