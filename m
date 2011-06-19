From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 04/20] t5800: document some non-functional parts of remote helpers
Date: Sun, 19 Jun 2011 17:18:29 +0200
Message-ID: <1308496725-22329-5-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJn1-0003jn-Gs
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab1FSPTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab1FSPTg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:36 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981189ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=4avgRH9CWTGbVWI1lidYkcOiiWW/fgs8AADFM9OGXnc=;
        b=Pnx7SNl67S4Q3oi1aANXq3fdZnDP+xHXdMB7cXPrt8Hy9iNAqAPSDBqp9MF8T8jRLM
         cmsgVdIUYVI9C8LcYDcjfdhktW2tT40VaEMJds0TxQkbmM5CW+HoyiXJ8EM+/Iw2oUmR
         ljzBVspvAsIPep4pwAoyvxaDGt6Stfcm8oqfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MUPBeoByIZfO4PpcSKmpvH7DcrAQafsMbjlseERORy6UUSHwTTb5Tr2RLuE69iIe5c
         4nQo/rhhR8Js6oT6TkMU68ZEi6rJHcb3cGUHykokGC1avJv+vu1c+owvcVcxaxYAecEc
         W1TgaSHCNqXK+odfd0B+hrQaNjEBxWoxY03b4=
Received: by 10.14.9.212 with SMTP id 60mr1589817eet.182.1308496776270;
        Sun, 19 Jun 2011 08:19:36 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176004>

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
helper code when the upstream has added refs that we do not
have locally. This could impact git users who use remote
helpers to access foreign VCSs.

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

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Culled the part of the commit message that is discussion of a
  possible implementation, but kept the parts describing the tests
  and why the last one is failing.

 t/t5800-remote-helpers.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index f6796e3..9db8ca8 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -85,4 +85,51 @@ test_expect_success 'pushing remote local repo' '
 	compare_refs clone HEAD server HEAD
 '
 
+test_expect_failure 'fetch new branch' '
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
+test_expect_failure 'fetch multiple branches' '
+	(cd localclone &&
+	 git fetch
+	) &&
+	compare_refs server master localclone refs/remotes/origin/master &&
+	compare_refs server new localclone refs/remotes/origin/new
+'
+
+test_expect_failure 'push when remote has extra refs' '
+	(cd clone &&
+	 echo content >>file &&
+	 git commit -a -m six &&
+	 git push
+	) &&
+	compare_refs clone master server master
+'
+
+test_expect_failure 'push new branch by name' '
+	(cd clone &&
+	 git checkout -b new-name  &&
+	 echo content >>file &&
+	 git commit -a -m seven &&
+	 git push origin new-name
+	) &&
+	compare_refs clone HEAD server refs/heads/new-name
+'
+
+test_expect_failure 'push new branch with old:new refspec' '
+	(cd clone &&
+	 git push origin new-name:new-refspec
+	) &&
+	compare_refs clone HEAD server refs/heads/new-refspec
+'
+
 test_done
-- 
1.7.5.1.292.g728120
