From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 2/2] git-svn: un-break "git svn rebase" when log.abbrevCommit=true
Date: Sun, 12 Feb 2012 00:23:06 +0000
Message-ID: <1329006186-21346-2-git-send-email-avarab@gmail.com>
References: <CACBZZX5cwZ4Xz3-C8B3v4eEmyO0B-JiohfRATu1UhxzST0ar5w@mail.gmail.com>
 <1329006186-21346-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 01:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwNE6-0007PT-Le
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 01:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab2BLAX0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 19:23:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39202 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab2BLAXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 19:23:25 -0500
Received: by mail-ey0-f174.google.com with SMTP id h12so1355298eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 16:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DlOyJXVKzTF7WHVCAwVX4QawEbxgRhY/QUIUUrdXaYU=;
        b=l42bqqsDRLOUd+oryz6PA9ELDLu+jStWAv2fjBhpb6eaCpUU4ZH7yzVQh/2NUssHcu
         nYUISKT0EX+vAbOOe+kkVysDZf7Qa2d2pKBA6T3aBspQubsNpxCanazY5Xz0qWFoB9sr
         kep7Lh51Gj+XaLE7J/nBog0TLgCmHGZVRMkt0=
Received: by 10.14.194.134 with SMTP id m6mr3653510een.4.1329006205151;
        Sat, 11 Feb 2012 16:23:25 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id n58sm41705117een.10.2012.02.11.16.23.24
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 16:23:24 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329006186-21346-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190552>

Change git-svn to use git-rev-list(1) instead of git-log(1) since the
latter is porcelain that'll cause "git svn rebase" to fail completely
if log.abbrevCommit is set to true in the configuration.

Without this patch the code will fail to parse a SHA1, and then just
spew a bunch of "Use of uninitialized value $hash in string eq"
warnings at "if ($c && $c eq $hash) { ..." and never do anything
useful.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-svn.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 712eeeb..bebe38b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1878,8 +1878,7 @@ sub cmt_sha2rev_batch {
=20
 sub working_head_info {
 	my ($head, $refs) =3D @_;
-	my @args =3D qw/log --no-color --no-decorate --first-parent
-	              --pretty=3Dmedium/;
+	my @args =3D qw/rev-list --first-parent --pretty=3Dmedium/;
 	my ($fh, $ctx) =3D command_output_pipe(@args, $head);
 	my $hash;
 	my %max;
--=20
1.7.9
