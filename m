From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/6] Introduce publish tracking branch
Date: Sun,  1 Sep 2013 03:26:36 -0500
Message-ID: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 10:31:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG34V-00015p-Gb
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 10:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab3IAIba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 04:31:30 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:64262 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab3IAIbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 04:31:25 -0400
Received: by mail-oa0-f54.google.com with SMTP id n10so3200031oag.27
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 01:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hDs4VUWgMWwFWcMfk80zih1v9nxZa6m8gg1w7WL7b8I=;
        b=f0Mj8jGigZSlBNwBQe9lq28otdcZEyrEZ38+u/9eMHBR20m1RcT7PjCZ/8zrLDB9gs
         oLMrchoTcN4+FFYj5S/5BU/DIJZy2+S4HznawZT2KJaIhcuVllZ8iNao5R0XmOGz7awX
         IKf8GeUqPejqKzLqNYZwF95aJUDAK/GPQYT72SGA1a4fbLA3k6zj7QXtwLNcASo7y5rZ
         gPA/gyiUbfs3p98SVbagn4Do8AhBAzXOFWWyyyr30P5ajBLC08FcoLn8DDqe49z4TWwF
         DBLOtH3SSMc32e+zR2oz9oWL/IEIwx9EKhZxEz3dN1rGf/8bbuALDzmVWEKUxIS4vhMf
         7axw==
X-Received: by 10.182.119.229 with SMTP id kx5mr12917898obb.23.1378024284475;
        Sun, 01 Sep 2013 01:31:24 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm7761372oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 01:31:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233572>

Hi,

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

Felipe Contreras (6):
  push: trivial reorganization
  Add concept of 'publish' branch
  branch: allow configuring the publish branch
  t: branch add publish branch tests
  push: add --set-publish option
  branch: display publish branch

 Documentation/git-branch.txt |  11 +++++
 Documentation/git-push.txt   |   9 +++-
 branch.c                     |  43 ++++++++++++++++++
 branch.h                     |   2 +
 builtin/branch.c             | 101 +++++++++++++++++++++++++++++++++++++++----
 builtin/push.c               |  52 ++++++++++++++--------
 remote.c                     |  34 ++++++++++++---
 remote.h                     |   4 ++
 t/t3200-branch.sh            |  76 ++++++++++++++++++++++++++++++++
 t/t5529-push-publish.sh      |  70 ++++++++++++++++++++++++++++++
 transport.c                  |  28 ++++++++----
 transport.h                  |   1 +
 12 files changed, 388 insertions(+), 43 deletions(-)
 create mode 100755 t/t5529-push-publish.sh

-- 
1.8.4-337-g7358a66-dirty
