From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 12/13] git-remote-testgit: only push for non-local repositories
Date: Sat, 28 Aug 2010 22:45:39 -0500
Message-ID: <1283053540-27042-13-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:47:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYrQ-0006pV-NN
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab0H2DrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:47:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab0H2Dqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:52 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Sz37d6heqt0hsb/PkdUQDaw51n+NFXY3mX8VnAcmm7M=;
        b=GR4riiuEDs9K+U4X9Kz9yoV+eJ+21eCSOuDVt4AmUAMDp9/NX+HXIyexAUyCW1Dg0k
         DwRQ02GbdF7dj7Fe9wujbIBP5GD1Aa3H9x58/xlC2MbaszzMvplW+4OLHC3zyjT4BJfr
         zCbYQTsrwXjLmO6DBgh+d0J21c6V9YJke62Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WSCjLm8C/xpESlB+4PDaQP+GB8HwVSHhk0JxYbW3QZmyEcm7ZWOwdzHsGEHQW8OuLG
         1zREo+Eua4PWkgsvqlsJZod6HBb7H2MuW2CFPRhSQlkgVvL1+k3BNulryPNg2eu5O23n
         9oA4Knmdvs7rEigrwCk/OIGyoGTpg/DhN6XiI=
Received: by 10.231.174.206 with SMTP id u14mr3331298ibz.103.1283053612456;
        Sat, 28 Aug 2010 20:46:52 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154678>

Trying to push for local repositories will fail since there is no
local checkout in .git/info/... to push from.

This went unnoticed because the transport helper infrastructure did
not check the return value of the helper.
---

  I guess it also shows how many people look at the verbose output of
  the helper test suite ;-).

 git-remote-testgit.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index e2b213d..b428b1c 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -160,7 +160,9 @@ def do_export(repo, args):
 
     update_local_repo(repo)
     repo.importer.do_import(repo.gitdir)
-    repo.non_local.push(repo.gitdir)
+
+    if not repo.local:
+        repo.non_local.push(repo.gitdir)
 
     print "ok refs/heads/master"
     print
-- 
1.7.2.1.240.g6a95c3
