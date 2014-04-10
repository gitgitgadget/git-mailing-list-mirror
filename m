From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/9] Introduce publish tracking branch
Date: Thu, 10 Apr 2014 14:04:37 -0500
Message-ID: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:14:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKR3-00060A-4g
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbaDJTOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:14:49 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48819 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030242AbaDJTOq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:14:46 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so4910536obb.18
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lwPtqg+Gi/eJNeCTuREX/Re32fizZOcE+zj+pxcKL3o=;
        b=zaJJqV3lU2fWchaO2w2TN99eosj96o5EF7IkXa5XOQzFoWYXeCsnE0ZCTA7Kg1cLaq
         y2G+EUi9Lkza+bsRmQge5LzdHyg6y0gg9wVrXZleeYlH4jxX5NEk4MJmWQhsDZcFwZ+h
         2Inp1Ph8rpBM6sFOv4LwJfYS7mtJPrYcVryac2fWhU/HPs89sg/sZy4AtXuN3G72zOcX
         u6fn2q4Z+bdvFyFT0poOoSEFijHt2YJNI2GhIZE2/1OALpAZJpAOfwfjCZfvc3d3PT/N
         hk5LG3fZIL7FLuatB98GCtBlNvpraAVlu1qQNHJjjrD6qQyGf1hfycR8cjFcsZf3Ch08
         TEvQ==
X-Received: by 10.60.92.132 with SMTP id cm4mr8870438oeb.49.1397157285855;
        Thu, 10 Apr 2014 12:14:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cq1sm21280830oeb.4.2014.04.10.12.14.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:14:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246038>

As it has been discussed before, our support for triangular workflows is
lacking, and the following patch series aims to improve that situation.

We have the concept of upstream branch (e.g. 'origin/master') which is to where
our topic branches eventually should be merged to, so it makes sense that
'git rebase' uses that as the destination, but most people would not push to
such upstream branch, they would push to a publish branch
(e.g. 'github/feature-a'). We could set our upstream to the place we push, and
'git push' would be able to use that as default, and 'git branch --vv' would
show how ahead/behind we are in comparisson to that branch, but then
'git rebase' (or 'git merge') would be using the wrong branch.

This patch series adds:

 1) git push --set-publish
 2) git branch --set-publish
 3) git branch -vv # uses and shows the publish branch when configured
 4) @{publish} and @{p} marks
 5) branch.$name.{push,pushremote} configurations

After this, it becomes much easier to track branches in a triangular workflow.

The publish branch is used instead of the upstream branch for tracking
information in 'git branch --vv' and 'git status' if present, otherwise there
are no changes (upstream is used).

  master          e230c56 [origin/master, gh/master] Git 1.8.4
* fc/publish      0a105fd [master, gh/fc/publish: ahead 1] branch: display publish branch
  fc/branch/fast  177dcad [master, gh/fc/branch/fast] branch: reorganize verbose options
  fc/trivial      f289b9a [master: ahead 7] branch: trivial style fix
  fc/leaks        d101af4 [master: ahead 2] read-cache: plug a possible leak
  stable          e230c56 Git 1.8.4

Changes since v1:

 * Added @{publish} and @{p} marks

Felipe Contreras (9):
  push: trivial reorganization
  Add concept of 'publish' branch
  branch: allow configuring the publish branch
  t: branch add publish branch tests
  push: add --set-publish option
  branch: display publish branch
  sha1_name: cleanup interpret_branch_name()
  sha1_name: simplify track finding
  sha1_name: add support for @{publish} marks

 Documentation/git-branch.txt | 11 +++++++
 Documentation/git-push.txt   |  9 +++++-
 Documentation/revisions.txt  |  4 +++
 branch.c                     | 43 +++++++++++++++++++++++++
 branch.h                     |  2 ++
 builtin/branch.c             | 74 ++++++++++++++++++++++++++++++++++++++----
 builtin/push.c               | 52 +++++++++++++++++++-----------
 remote.c                     | 34 ++++++++++++++++----
 remote.h                     |  4 +++
 sha1_name.c                  | 62 ++++++++++++++++++++++--------------
 t/t1508-at-combinations.sh   |  5 +++
 t/t3200-branch.sh            | 76 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5529-push-publish.sh      | 70 ++++++++++++++++++++++++++++++++++++++++
 t/t6040-tracking-info.sh     |  5 +--
 transport.c                  | 28 ++++++++++------
 transport.h                  |  1 +
 16 files changed, 415 insertions(+), 65 deletions(-)
 create mode 100755 t/t5529-push-publish.sh

-- 
1.9.1+fc1
