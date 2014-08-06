From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 05/23] rebase -i: failed reword prints redundant error message
Date: Thu,  7 Aug 2014 01:59:12 +0200
Message-ID: <452efde97c066275d6ed05b18a1fd79b475d3d6e.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:00:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8O-0003kY-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbaHGAAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:35 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33974 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbaHGAAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:33 -0400
Received: by mail-qg0-f44.google.com with SMTP id e89so3617252qgf.31
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZIsTSrpMFAsOOP/k7oPda+3v99dVnlZDZaH3gWuoaMo=;
        b=YHucdBECQyr96Nr3hTKJR1e3uhiMNcWKUAaW+YruFFSzvWzzTi2yoXwm+lFfPDSOn/
         +4Ca5QGQdOta4bNAM3Uuw40QFhb3RQUcBDYPtMJaHNnl2LVMTgBGq3phtlDWjEV1aofd
         1+5u6kTOQG34ojLmtIPH5RGo8miVIOgzK0jPoh8WCxbIl+YhhX6kuYiM3UdSp2xwH9Q3
         t71HbuKK+aQMYu9Tz2GDYFyjBfdQCSn1zbsbSN9pEt8Smm2GUMzk5ST7kwTqfTN19VYX
         ZRBi5ax7tHCAQ/6ARkg18hGelsEGgH86+i8XA3r3RtWbRCQVxdaFniKuj2MHcRxyQ3uE
         Tm5w==
X-Received: by 10.224.95.6 with SMTP id b6mr22229155qan.17.1407369633019;
        Wed, 06 Aug 2014 17:00:33 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254924>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. If the edited log
message is empty or is found ill-formatted by one of the commit
hooks, git-rebase--interactive prints three error messages to the
console.

    1. The git-commit output, which contains all the output from hook
       scripts.
    2. A rebase diagnosis saying at which task on the to-do list it
       got stuck.
    3. Generic presumptions about what could have triggered the
       error.

The third message contains redundant information and does not add any
enlightenment either, which makes the output unnecessarily longish
and different from the other command's output. For instance, this is
what the output looks like if the log message is empty (contains
duplicate Signed-off-by lines).

    (1.) Aborting commit due to empty commit message. (Duplicate Signed-off-by lines.)
    (2.) Could not amend commit after successfully picking fa1afe1... Some change
    (3.) This is most likely due to an empty commit message, or the pre-commit hook
         failed. If the pre-commit hook failed, you may need to resolve the issue before
         you are able to reword the commit.

Discard the third message.

It is true that a failed hook script might not output any diagnosis
but then the generic message is not of much help either. Since this
lack of information affects the built-in git commands for commit,
merge and cherry-pick first, the solution would be to keep track of
the failed hooks in their output so that the user knows which of her
hooks require improvement.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5dfdf13..3ee13c2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -506,9 +506,6 @@ do_next () {
 		do_pick $sha1 "$rest"
 		output git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
-			warn "This is most likely due to an empty commit message, or the pre-commit hook"
-			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
-			warn "you are able to reword the commit."
 			exit_with_patch $sha1 1
 		}
 		record_in_rewritten $sha1
-- 
2.0.1
