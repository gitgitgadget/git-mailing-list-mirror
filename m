From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v3 0/5] push: update remote tags only with force
Date: Sun, 11 Nov 2012 22:08:03 -0600
Message-ID: <1352693288-7396-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 05:10:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXlM6-0000Xp-DF
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 05:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab2KLEKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 23:10:22 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56404 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab2KLEKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 23:10:22 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so8424320iea.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 20:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=g7q90BfSk3IWlwkgWdBCANwVgdXoll3CsXlprCfedLw=;
        b=oBbIIMOI8c0YbxiWJZ2xr1Ea8dY/gaXro4eoXjXKFlT3hOtFtD2P4l1RhhQjDXYlvk
         hOvXq+RWGzI/h/I+pQ+jfSpF07NoCtmGfWcj+TYigiIB46Def+r7nXYtEAxqMrie7ki5
         CMHvZLD50nhnaQlfflkLvApAWltjaOGLiZXybljpB3f3jyPIbQVQEYT2F3eE53UMNZMd
         Zzzovdlpw3Nm1q9g8PTR7DIwHob+Hws8ElHUW5ewl6FAwtQ4gAySJxoAWDsuykw1pExu
         FsW15gCAd7s6YAbPJnWxVkUk0bpWnkoeKGxH9lgCgyqorT1P9yT3vOtwjdlpb/pwRLii
         XKEQ==
Received: by 10.42.119.133 with SMTP id b5mr17697502icr.56.1352693421794;
        Sun, 11 Nov 2012 20:10:21 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id wm10sm7396117igc.2.2012.11.11.20.10.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 20:10:21 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209463>

Minor changes since from v2 set.  Reposting primarily because I mucked
up the Cc: list (again) and hoping to route feedback to the appropriate
audience.

This patch set can be divided into two sets:

  1. Provide useful advice for rejected tag references.

     push: return reject reasons via a mask
     push: add advice for rejected tag reference

     Recommending a merge to resolve a rejected tag update seems
     nonsensical since the tag does not come along for the ride.  These
     patches change the advice for rejected tags to suggest using
     "push -f".

  2. Require force when updating tag references, even on a fast-forward.

     push: flag updates
     push: flag updates that require force
     push: update remote tags only with force

     An email thread initiated by Angelo Borsotti did not come to a
     consensus on how push should behave with regard to tag references.
     I think a key point is that you currently cannot be sure your push
     will not clobber a tag (lightweight or not) in the remote.  Also, I
     wonder what workflow would rely on this fast-forward feature of
     pushed tag references that would not be better served a branch?

This patch set contains some minor updates from the previous set:

  * remote.c: remove redundant check of ref->update
  * transport.c: remove extraneous tab in indent
  * builtin/send-pack.c: fix call to transport_print_push_status() (per
      feedback from Peff)

Also, rebased against the latest master in git://github.com/peff/git.git
to pickup changes in nd/builtin-to-libgit.

Chris Rorvick (5):
  push: return reject reasons via a mask
  push: add advice for rejected tag reference
  push: flag updates
  push: flag updates that require force
  push: update remote tags only with force

 Documentation/git-push.txt | 10 +++++-----
 builtin/push.c             | 24 +++++++++++++++---------
 builtin/send-pack.c        |  9 +++++++--
 cache.h                    |  7 ++++++-
 remote.c                   | 38 ++++++++++++++++++++++++++++++--------
 send-pack.c                |  1 +
 t/t5516-fetch-push.sh      | 30 +++++++++++++++++++++++++++++-
 transport-helper.c         |  6 ++++++
 transport.c                | 25 +++++++++++++++----------
 transport.h                | 10 ++++++----
 10 files changed, 120 insertions(+), 40 deletions(-)

-- 
1.8.0
