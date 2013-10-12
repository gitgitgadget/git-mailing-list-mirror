From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 0/8] Introduce publish tracking branch
Date: Sat, 12 Oct 2013 02:05:53 -0500
Message-ID: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMz-0004bU-1t
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab3JLHMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:08 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:58123 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab3JLHMC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:02 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so3407505obc.7
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SWrB/c1gDukHopLwNu5ZlOcYiQqTpParwCJNSIx7z7M=;
        b=P/LvLqI8VOvBGx7H2PcjRQ479sMJa4vfQ83DUlavJFC2AhxahL3IlWZ0r9Td7PRb8b
         fSmznf+IrKhJyfjugtkBCepkzdzxNiAFHnJckLdWApbSr6rzA7FheoDBUVTpUGoY48Ru
         e1FxVl9Qoe5GpAEgRmV/xHzYrpsLg7iIfzcWsiKHUUIhtNoxWIndGq8rRT2OoMK4zYwx
         9R9QxN2E2euhZ1xGViOypFJjFo6qDlPxfiSTFNl4lMfTJMeOzewDmG6+6y0K/dFi6Isl
         H5ksk/iD/9uBqhCoFiFrkQO/j5wc7zQ9nwS/JSK0EXGhATm4pN87USBoFTPUEetkKHtr
         P0Xw==
X-Received: by 10.182.40.134 with SMTP id x6mr17794665obk.31.1381561922393;
        Sat, 12 Oct 2013 00:12:02 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id wd7sm28636060obc.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235981>

As it has been discussed before, our support for triangular workflows is
lacking, and the following patch series aims to improve that situation.

We have the concept of upstream branch (e.g. 'origin/master') which is to where
our topic branches eventually should be merged to, so it makes sense that
'git rebase' uses that as the destination, but most people would not push to
such upstream branch, they would push to a publish branch
(e.g.  'github/feature-a'). We could set our upstream to the place we push, and
'git push' would be able to use that as default, and 'git branch --vv' would
show how ahead/behind we are in comparisson to that branch, but then 'git
rebase' (or 'git merge') would be using the wrong branch.

This patch series adds:

 1) git push --set-publish
 2) git branch --set-publish
 3) git branch -vv # uses and shows the publish branch when configured

After this, it becomes much easier to track branches in a triangular workflow.

  master          e230c56 [origin/master, gh/master] Git 1.8.4
* fc/publish      0a105fd [master, gh/fc/publish: ahead 1] branch: display publish branch
  fc/branch/fast  177dcad [master, gh/fc/branch/fast] branch: reorganize verbose options
  fc/trivial      f289b9a [master: ahead 7] branch: trivial style fix
  fc/leaks        d101af4 [master: ahead 2] read-cache: plug a possible leak
  stable          e230c56 Git 1.8.4

Felipe Contreras (8):
  branch: trivial cleanup
  branch: reorganize verbose options
  push: trivial reorganization
  Add concept of 'publish' branch
  branch: allow configuring the publish branch
  t: branch add publish branch tests
  push: add --set-publish option
  branch: display publish branch

 Documentation/git-branch.txt |  11 +++++
 Documentation/git-push.txt   |   9 +++-
 branch.c                     |  43 +++++++++++++++++
 branch.h                     |   2 +
 builtin/branch.c             | 107 +++++++++++++++++++++++++++++++++++++------
 builtin/push.c               |  52 +++++++++++++--------
 remote.c                     |  34 +++++++++++---
 remote.h                     |   4 ++
 t/t3200-branch.sh            |  76 ++++++++++++++++++++++++++++++
 t/t5529-push-publish.sh      |  70 ++++++++++++++++++++++++++++
 t/t6040-tracking-info.sh     |   8 ++--
 transport.c                  |  28 +++++++----
 transport.h                  |   1 +
 13 files changed, 393 insertions(+), 52 deletions(-)
 create mode 100755 t/t5529-push-publish.sh

-- 
1.8.4-fc
