From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git-svn: un-break "git svn rebase" when log.abbrevCommit=true
Date: Sun, 29 Jan 2012 02:11:13 +0000
Message-ID: <1327803073-7000-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 03:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrKFN-0004Cv-HK
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 03:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753Ab2A2CLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jan 2012 21:11:46 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36757 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab2A2CLY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 21:11:24 -0500
Received: by eekc14 with SMTP id c14so1010013eek.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 18:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=5hPhgh81kHAonscFQBjTN8TqmLMW9m1ROPyVmDVVTGc=;
        b=nuzLcJfT3s5IdKNkX+xomqirQ7YF7WZsH8UX1CBtlGAvzd8K1ADswAmRWlC7phF+ik
         eF3NRDvcThJI/pWlMDgkRLlL6XvCCrwJzrs4MOwt6vTZcJTxjNCmZ47HV74PBNyGryLd
         WEb3ks/gfhLVGiEAS+M1DoWsV4DMh4cqddg7g=
Received: by 10.14.4.101 with SMTP id 77mr3824098eei.87.1327803082810;
        Sat, 28 Jan 2012 18:11:22 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id b3sm711270een.2.2012.01.28.18.11.21
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jan 2012 18:11:22 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189271>

Change git-svn to parse --no-abbrev-commit --no-decorate to git-log
since it's trying to parse the log output, and the parsing will fail
completely if log.abbrevCommit is set to true in the configuration,
also set --no-decorate so we won't fail if we're processing a commit
that has a tag pointing to it.

Without this patch the code will fail to parse a SHA1, and then just
spew a bunch of "Use of uninitialized value $hash in string eq"
warnings at "if ($c && $c eq $hash) { ..." and never do anything
useful.

A real fix would be to make git-svn not use any porcelain utilities,
but just work around it for now.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eeb83d3..570fe9c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1879,7 +1879,8 @@ sub cmt_sha2rev_batch {
 sub working_head_info {
 	my ($head, $refs) =3D @_;
 	my @args =3D qw/log --no-color --no-decorate --first-parent
-	              --pretty=3Dmedium/;
+	              --pretty=3Dmedium --no-abbrev-commit --no-decorate/;
+
 	my ($fh, $ctx) =3D command_output_pipe(@args, $head);
 	my $hash;
 	my %max;
--=20
1.7.8.3
