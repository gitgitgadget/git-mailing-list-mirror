From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 3/3] commit: disable status hints when writing to COMMIT_EDITMSG
Date: Thu, 12 Sep 2013 12:50:06 +0200
Message-ID: <1378983006-3980-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1378983006-3980-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: javierdo1@gmail.com, jrnieder@gmail.com, judge.packham@gmail.com,
	peff@peff.net, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 12 12:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK4Tr-0004C6-8E
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 12:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab3ILKuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 06:50:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53737 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab3ILKuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 06:50:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8CAo8nU003337
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Sep 2013 12:50:08 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VK4TS-0002AM-3i; Thu, 12 Sep 2013 12:50:10 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VK4TR-00013N-Pe; Thu, 12 Sep 2013 12:50:09 +0200
X-Mailer: git-send-email 1.8.4.8.g834017f
In-Reply-To: <1378983006-3980-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 12 Sep 2013 12:50:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8CAo8nU003337
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379587811.22979@AfovyNpV58sotNiKNhWHwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234646>

This turns the template COMMIT_EDITMSG from e.g

  # [...]
  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unstage)
  #
  #	modified:   builtin/commit.c
  #
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #	t/foo
  #

to

  # [...]
  # Changes to be committed:
  #	modified:   builtin/commit.c
  #
  # Untracked files:
  #	t/foo
  #

Most status hints were written to be accurate when running "git status"
before running a commit. Many of them are not applicable when the commit
has already been started, and should not be shown in COMMIT_EDITMSG. The
most obvious are hints advising to run "git commit",
"git rebase/am/cherry-pick --continue", which do not make sense when the
command has already been run.

Other messages become slightly inaccurate (e.g. hint to use "git add" to
add untracked files), as the suggested commands are not immediately
applicable during the editing of COMMIT_EDITMSG, but would be applicable
if the commit is aborted. These messages are both potentially helpful and
slightly misleading. This patch chose to remove them too, to avoid
introducing too much complexity in the status code.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Unchanged since v1.

 builtin/commit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7bfce94..e32246a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -705,6 +705,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (s->fp == NULL)
 		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
 
+	/*
+	 * Most hints are counter-productive when the commit has
+	 * already started.
+	 */
+	s->hints = 0;
+
 	if (clean_message_contents)
 		stripspace(&sb, 0);
 
-- 
1.8.4.8.g834017f
