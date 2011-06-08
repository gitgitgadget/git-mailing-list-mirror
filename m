From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 03/19] t5800: document some non-functional parts of remote helpers
Date: Wed,  8 Jun 2011 20:48:34 +0200
Message-ID: <1307558930-16074-4-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:51:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNqX-0000Sp-It
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab1FHSu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:50:56 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57880 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab1FHStc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:32 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so279692eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=GxadiF8DoAMVs0f/9GgEO2BHa4E0YuRHUBcZKsaWT3E=;
        b=HkmHkkB67EgO2SOknzxVT/FaVfqReAjcBfByYbxCP/n7IGihuJZdMxqxn0Nz4lq9cK
         Jq1ny7U4iLkgxZg29fzPDKTXoLFAxMUHj5ph+ZM2OQkf5tFPn7Sqnc/3O+rtByYzS4B5
         BA9S5UiLr1fmSdRgQz9omxhYy4XgCZmuOC8wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gva+Mq/MznR52b2eMJck8b92eiezBkXBBq51szK53lOFVOi8Ir5R/cL1M6WgjxTV1n
         lOcHxSKokQpLXHzdMA0EMyzQtrIll9YxTTsP7huXralvzjXzChsCHAJGmclJx6qbU2O4
         W0sV5rcKWanyy8eoRir9Trza9wSxr0HXgfkis=
Received: by 10.213.16.199 with SMTP id p7mr421346eba.99.1307558971125;
        Wed, 08 Jun 2011 11:49:31 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175440>

From: Jeff King <peff@peff.net>

These are all things one might expect to work in a helper
that is capable of handling multiple branches (which our
testgit helper in theory should be able to do, as it is
backed by git). All of these bugs are specific to the
import/export codepaths, so they don't affect helpers like
git-remote-curl that use fetch/push commands.

The first and fourth tests are about fetching and pushing
new refs, and demonstrate bugs in the git_remote_helpers
library (so they would be most likely to impact helpers for
other VCSs which import/export git).

The second test is about importing multiple refs; it
demonstrates a bug in git-remote-testgit, which is mostly
for exercising the test code. Therefore it probably doesn't
affect anyone in practice.

The third test demonstrates a bug in git's side of the
helper code when the upstream has added new refs without us.
This could impact git users who use remote helpers to access
foreign VCSs.

All of those bugs have fixes later in this series.

The fifth test is the most complex, and does not have a fix
in this series. It tests pushing a ref via the export
mechanism to a new name on the remote side (i.e.,
"git push $remote old:new").

The problem is that we push all of the work of generating
the export stream onto fast-export, but we have no way of
communicating to fast-export that this name mapping is
happening. So we tell fast-export to generate a stream with
the commits for "old", but we can't tell it to label them
all as "new".

There are two possible solutions:

  1. Indicate the mapping to fast-export, so that it can
     generate the "mapped" names. Unfortunately, this is
     somewhat difficult due to the way fast-import is
     implemented. It feeds its revision parameters to the
     regular rev-walking machinery, asking the revision code
     to mark the "source" of each commit. So if fast-export
     sees that we want commits from "refs/heads/old", but
     also that we want to call commits from old as
     "refs/heads/new", it can't distinguish between the
     case of "I want _only_ new, using the commits of old"
     and "I want _both_ old and new, which happen to point
     to the same commits".

     And it's important to distinguish those cases, because
     in one, the remote will update master, and in the
     other, it will not.

     This isn't an insurmountable obstacle, but it's going
     to mean either fast-export has to take on more of the
     revision argument parsing and revwalking
     responsibility, or the revision walker's show_source
     code will have to learn about mapping names.

  2. Indicate the mapping to the remote helper, who can then
     apply the mapping to the results of the export. Right
     now the export remote helper command has no arguments;
     it simply says "hey, I'm going to dump a fast-export
     stream on you". And the remote-helper looks through the
     results of the stream to decide which refs are being
     pushed. This could be extended instead to something
     like:

       export refs/heads/foo
       export refs/heads/old:refs/heads/new
       <blank line>

     which would allow the remote helper to map names as
     appropriate. This a reasonably elegant solution; the
     downside is that it breaks compatibility with existing
     remote helpers.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from Peff's series.

 t/t5800-remote-helpers.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 3a37ad0..a10a48d 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -81,4 +81,51 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
 	compare_refs clone HEAD server HEAD
 '
 
+test_expect_failure PYTHON_24 'fetch new branch' '
+	(cd public &&
+	 git checkout -b new &&
+	 echo content >>file &&
+	 git commit -a -m five &&
+	 git push origin new
+	) &&
+	(cd localclone &&
+	 git fetch origin new
+	) &&
+	compare_refs public HEAD localclone FETCH_HEAD
+'
+
+test_expect_failure PYTHON_24 'fetch multiple branches' '
+	(cd localclone &&
+	 git fetch
+	) &&
+	compare_refs server master localclone refs/remotes/origin/master &&
+	compare_refs server new localclone refs/remotes/origin/new
+'
+
+test_expect_failure PYTHON_24 'push when remote has extra refs' '
+	(cd clone &&
+	 echo content >>file &&
+	 git commit -a -m six &&
+	 git push
+	) &&
+	compare_refs clone master server master
+'
+
+test_expect_failure PYTHON_24 'push new branch by name' '
+	(cd clone &&
+	 git checkout -b new-name  &&
+	 echo content >>file &&
+	 git commit -a -m seven &&
+	 git push origin new-name
+	) &&
+	compare_refs clone HEAD server refs/heads/new-name
+'
+
+test_expect_failure PYTHON_24 'push new branch with old:new refspec' '
+	(cd clone &&
+	 git push origin new-name:new-refspec
+	) &&
+	compare_refs clone HEAD server refs/heads/new-refspec
+'
+
 test_done
-- 
1.7.5.1.292.g728120
