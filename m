From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 16:40:12 +0530
Message-ID: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 27 13:11:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V32P4-0004GZ-Rh
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 13:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446Ab3G0LKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 07:10:55 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:49714 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab3G0LKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 07:10:54 -0400
Received: by mail-ob0-f173.google.com with SMTP id er7so6264488obc.32
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 04:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=TTp8m4L8B+zCROvrk86Ihvld/3pxEpuEfjoealVML/k=;
        b=bXFBnSyDZhXSUbdX7Wv5yGXh1gbptiGSQNZLpDelQvRE37+D0pMba2NoW8Qc9f6JyT
         VoniX/6B3KTQgQInSyoo6XySfMTsdq1n4Znq/8ySczuZ0ms2Mx43QI0DhiqB/4a4oUjd
         d48N9fdBEejCa+85MBJEJGDg0YKh4+75rBvdC2jRphwU4LdAqytZay3N3NWex9zh7HTA
         AhOJCvA1VY1RXoEcygryBtUkovpp/xqZmylS3W1huFKUhu1tOr+k8bzaaYO4P7DnL5wG
         I3nSXJUVUiIVbtr4BfMZweUZlgCHt6/v370AHu4wA3KlXIdY6678DDX1SV/TRpeJm12I
         iYdw==
X-Received: by 10.50.72.73 with SMTP id b9mr239041igv.50.1374923453486; Sat,
 27 Jul 2013 04:10:53 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 27 Jul 2013 04:10:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231235>

Hi,

I noticed a regression in the latest master, and I've been trying to
debug it for 30 minutes now.  I'm still clueless about the root cause,
but I'll list whatever I found so far:

I suddenly noticed that I wasn't able to commit to a certain
repository with submodules anymore.  This was because git commit was
opening a COMMIT_EDITMSG in the wrong path.  To reproduce the problem,
you need a setup like mine:

  ~/dotfiles is a repository containing submodules
  ~/.elisp is a symbolic link to ~/dotfiles/.elisp, a normal directory
  ~/.elisp/flx is the submodule repository to which I'm trying to commit

The buffer-file-name of COMMIT_EDITMSG comes out as
/home/artagnon/.git/modules/flx/.git/COMMIT_EDITMSG, which is
completely wrong because ~ does not even contain a .git.

So, I started debugging the issue with this patch:

diff --git a/builtin/commit.c b/builtin/commit.c
index 003bd7d..38a7c77 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -678,6 +678,9 @@ static int prepare_to_commit(const char
                hook_arg2 = "";
        }

+       char *buf = get_current_dir_name();
+       die("DBG: %s | %s", buf, git_path(commit_editmsg));
+
        s->fp = fopen(git_path(commit_editmsg), "w");
        if (s->fp == NULL)
                die_errno(_("could not open '%s'"), git_path(commit_editmsg));

On master, commit returns:

  fatal: DBG: /home/artagnon/.elisp/flx |
../../.git/modules/.elisp/flx/COMMIT_EDITMSG

When backported to v1.8.3.3, commit returns:

  fatal: DBG: /home/artagnon/.elisp/flx |
/home/artagnon/dotfiles/.git/modules/.elisp/flx/COMMIT_EDITMSG

I tried looking through the logs to see what has changed in
path.c/environment.c, but have come up with nothing so far.  I think
I'll have to resort to using a hammer like bisect now.

*scratches head*
