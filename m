From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 11/23] rebase -i: log the replay of root commits
Date: Thu,  7 Aug 2014 01:59:18 +0200
Message-ID: <2666e31872a679c1cc00c00fce542ce8be40fe09.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8i-0004DU-Qz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbaHGAAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:46 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:44388 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbaHGAAo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:44 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so3301304qaj.35
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TQAfGooGNC+5bVWlDYc9cK2TrfwS0FAjVr5Olo4RpoY=;
        b=xtCDcPw6elC/FMhROqNGydUCUCftmJmT3dAn9MF7/J0Cf2MPgg0nwIEvneHlVNOTjz
         SW2f+SO+8iOhltXGAzqmPO4hHVLsXS12qImZi/5Pf2+I4/f60Z4nf8xauGIsMm96O8t/
         3mLy5+sP6yDdMZCpZ/61LGNa3HgbxqN+5Zhk8KGpp6jrDjxKgVz2Jq2aSjhanA7n90+s
         eaOIJpQPDAGkT5T3cqQR8k81fNUur0S1ATEIHdDG/690v1UyJMH3sK8T5/Jd6otozdT4
         Yc1TEG7zejemJrfgZE7nuzNFKGRI0wsoPIG0PNLHujtrz55+VaHOa2zhyJmbKEEcEOHN
         EaPQ==
X-Received: by 10.224.55.131 with SMTP id u3mr21527258qag.98.1407369643369;
        Wed, 06 Aug 2014 17:00:43 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254927>

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
index 8e1730c..91ef0f7 100644
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
