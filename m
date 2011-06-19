From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 07/20] git_remote_helpers: push all refs during a non-local export
Date: Sun, 19 Jun 2011 17:18:32 +0200
Message-ID: <1308496725-22329-8-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:19:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJn3-0003jn-Ja
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376Ab1FSPTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:47 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab1FSPTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:43 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981189ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=pe4+2SIgsNijVO8Woos1HX2q9PkUnmSsyUMg6TLQl2c=;
        b=en3+P+BpJvDlaSoMFllSFu8BePtst03k6dxwm8pbZSOL/Bwi+addrGuZCvHcQGxpqZ
         2cIpJP/ILKzlzuxV/YJlkPsPa6vgNxItFi328ssI1wdgsg1BemkxMTIdws+QunZo8oGY
         wfnRj6RxiMTeMlSkPQS8Ga7elQDsZLksNH4Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oxdFiujOGwk3ar7jfNhVn4OhTs446tu4112syAPtYiOH43ijbyXpnBQ8m1JpHh15A0
         gjM2bFeA2xnDB6qiH21zbWKTS0AHFDW6ElIldCaN6W0RGGo8SM9tGufZaQm9+lY2bhd1
         gOpSjm2KjHC8kCQjH00N0JOQAplByzj2SzOTM=
Received: by 10.213.110.139 with SMTP id n11mr1688914ebp.114.1308496782631;
        Sun, 19 Jun 2011 08:19:42 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176007>

From: Jeff King <peff@peff.net>

When a remote helper exports to a non-local git repo, the
steps are roughly:

  1. fast-export into a local staging area; the set of
     interesting refs is defined by what is in the fast-export
     stream

  2. git push from the staging area to the non-local repo

In the second step, we should explicitly push all refs, not
just matching ones. This will let us push refs that do not
yet exist in the remote repo.

This does not deal with forced (not-fast-forward) pushes.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Added last line to the commit message.

 git_remote_helpers/git/non_local.py |    2 +-
 t/t5800-remote-helpers.sh           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git_remote_helpers/git/non_local.py b/git_remote_helpers/git/non_local.py
index f27389b..c53e074 100644
--- a/git_remote_helpers/git/non_local.py
+++ b/git_remote_helpers/git/non_local.py
@@ -63,7 +63,7 @@ class NonLocalGit(object):
         if not os.path.exists(path):
             die("could not find repo at %s", path)
 
-        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath]
+        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath, "--all"]
         child = subprocess.Popen(args)
         if child.wait() != 0:
             raise CalledProcessError
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index ceb0010..12f471c 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -115,7 +115,7 @@ test_expect_success 'push when remote has extra refs' '
 	compare_refs clone master server master
 '
 
-test_expect_failure 'push new branch by name' '
+test_expect_success 'push new branch by name' '
 	(cd clone &&
 	 git checkout -b new-name  &&
 	 echo content >>file &&
-- 
1.7.5.1.292.g728120
