From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: support repositories with .git-files
Date: Sun, 23 Feb 2014 19:12:35 -0800
Message-ID: <1393211555-50270-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?G=C3=A1bor=20Lipt=C3=A1k?= <gabor.liptak@gmail.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 04:12:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHlyG-0008WS-KU
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 04:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaBXDMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Feb 2014 22:12:40 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37184 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbaBXDMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 22:12:39 -0500
Received: by mail-pd0-f173.google.com with SMTP id z10so514712pdj.4
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 19:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=t5l3ObUapqocdBdj/M0+duzcgu6Voz5Qtq8o8OpkR4I=;
        b=DsiVjoLYL9yhHTUtkx9cYgctD8LSXoRJxGX+1R09k637FzNDkgdU1EuYVfMTqLuJvK
         x/Ggu+K+AKXvDSODKUhojq90xFd+98fEm9V9nAt4eGb4/euNcJQdWl4p2CvP76RhwZaR
         goftyktRv4ynlaLR3gkqlZfpW/1atTg4DA6NHBeiwIezmbK9OUIaElZi9EDVWSeqkq87
         Rz2IAxx6uqCqCgZYck/WaMtZsGOTIWA/8vceDDOMLIEwtHVkTptRMG09/EnRBp3IbzW4
         IEfwgceZbn84wUFM9+sGGYWwUK4ynxXupGSweix5s198nqq5xbDc2zCN3Nzz/C2oy1QY
         iydQ==
X-Received: by 10.66.102.4 with SMTP id fk4mr22022542pab.59.1393211559505;
        Sun, 23 Feb 2014 19:12:39 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id bc4sm44861825pbb.2.2014.02.23.19.12.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 23 Feb 2014 19:12:38 -0800 (PST)
X-Mailer: git-send-email 1.9.0.1.gd20a678
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242556>

Modern versions of "git submodule" use .git-files to setup the
submodule directory.  When run in a "git submodule"-created
repository "git difftool --dir-diff" dies with the following
error:

	$ git difftool -d HEAD~
	fatal: This operation must be run in a work tree
	diff --raw --no-abbrev -z HEAD~: command returned error: 128

core.worktree is relative to the .git directory but the logic
in find_worktree() does not account for it.

Use `git rev-parse --show-toplevel` to find the worktree so that
the dir-diff feature works inside a submodule.

Reported-by: G=C3=A1bor Lipt=C3=A1k <gabor.liptak@gmail.com>
Helped-by: Jens Lehmann <jens.lehmann@web.de>
Helped-by: John Keeping <john@keeping.me.uk>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index e57d3d1..18ca61e 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -39,24 +39,10 @@ USAGE
=20
 sub find_worktree
 {
-	my ($repo) =3D @_;
-
 	# Git->repository->wc_path() does not honor changes to the working
 	# tree location made by $ENV{GIT_WORK_TREE} or the 'core.worktree'
 	# config variable.
-	my $worktree;
-	my $env_worktree =3D $ENV{GIT_WORK_TREE};
-	my $core_worktree =3D Git::config('core.worktree');
-
-	if (defined($env_worktree) and (length($env_worktree) > 0)) {
-		$worktree =3D $env_worktree;
-	} elsif (defined($core_worktree) and (length($core_worktree) > 0)) {
-		$worktree =3D $core_worktree;
-	} else {
-		$worktree =3D $repo->wc_path();
-	}
-
-	return $worktree;
+	return Git::command_oneline('rev-parse', '--show-toplevel');
 }
=20
 sub print_tool_help
@@ -418,7 +404,7 @@ sub dir_diff
 	my $rc;
 	my $error =3D 0;
 	my $repo =3D Git->repository();
-	my $workdir =3D find_worktree($repo);
+	my $workdir =3D find_worktree();
 	my ($a, $b, $tmpdir, @worktree) =3D
 		setup_dir_diff($repo, $workdir, $symlinks);
=20
--=20
1.9.0.1.gd20a678
