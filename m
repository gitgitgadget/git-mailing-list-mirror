From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-hg: do not fail on invalid bookmarks
Date: Sun, 29 Dec 2013 12:30:02 +0100
Message-ID: <1388316602-22443-1-git-send-email-apelisse@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 29 12:30:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxEZa-0006SV-99
	for gcvg-git-2@plane.gmane.org; Sun, 29 Dec 2013 12:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab3L2LaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Dec 2013 06:30:14 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:61565 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab3L2LaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Dec 2013 06:30:12 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so9253725wes.41
        for <git@vger.kernel.org>; Sun, 29 Dec 2013 03:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jywW5GBDjTAHzvMC+gpjc9+88IYTi8CofR/R6APakQA=;
        b=EaUCksNxirBOVL/jJKKYU7AZlRVKlmi4TWFEKXVwyycG4yJsdgGrFYM+XDQA2b1oUA
         tNgNFdsVE6O35tDvlWSJvXylXlkWg6KisVzejnqCZ7SUAB4rrVaApHeMHOyoo+aRrb9v
         xaz92Ds41MFQGHLbANTftTKtT51eIKTenIhcOVSQwx62ouxnAoRzWhU6b/VJpcRUAlaM
         7kb1J37303CBzUaEBDKN4HOTQYfdWc402bjdGkxu+Rwmm8erT8RYzl/6GN2KdUFchV45
         IEjkLqdUrjB20MGopFfZWzfRiNtl1cdNe0Mg8SSMAbKIR7dzMrGiVdGCrBMCGnokp5E+
         /UkQ==
X-Received: by 10.180.93.130 with SMTP id cu2mr9412499wib.38.1388316611458;
        Sun, 29 Dec 2013 03:30:11 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id j3sm61515990wiy.3.2013.12.29.03.30.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Dec 2013 03:30:10 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.97.g8d784da.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239797>

Mercurial can have bookmarks pointing to "nullid" (the empty root
revision), while Git can not have references to it.
When cloning or fetching from a Mercurial repository that has such a
bookmark, the import will fail because git-remote-hg will not be able to
create the corresponding reference.

Warn the user about the invalid reference, and continue the import,
instead of stopping right away.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index eb89ef6..12d850e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -625,6 +625,9 @@ def list_head(repo, cur):
 def do_list(parser):
     repo = parser.repo
     for bmark, node in bookmarks.listbookmarks(repo).iteritems():
+        if node == '0000000000000000000000000000000000000000':
+            warn("Ignoring invalid bookmark '%s'", bmark)
+            continue
         bmarks[bmark] = repo[node]
 
     cur = repo.dirstate.branch()
-- 
1.8.5.1.97.g8d784da.dirty
