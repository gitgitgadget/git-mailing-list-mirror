From: Matt McClure <matthewlmcclure@gmail.com>
Subject: [PATCH] difftool: Make directory diff symlink working tree
Date: Wed, 13 Mar 2013 11:21:40 -0400
Message-ID: <CAJELnLEbYrDWUjZH6iWnovEFDh8xFvpJL5wtEcPGOpkhPo+XEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 16:22:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFnVJ-0006vq-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 16:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933007Ab3CMPVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 11:21:42 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:58668 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab3CMPVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 11:21:41 -0400
Received: by mail-da0-f52.google.com with SMTP id f10so460330dak.39
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=hW+mkubqw5ib5MWAbLu7MaVMk4hzXdPzR0SbEU6DPII=;
        b=a8iKDkC9SHWjQroiEQ4uEutZb+BhitvBQnJJK6KX0thnix456ZxQgcoayFTx8L37sY
         INtDltx9ah51Pciq1apkgaiKd6lzB44qwslwd0+gw/Cdsu/3oKL346A8mV4tWHuORCt1
         a2l4/NHyj9sPspKeld53o8nq73wXu0oByEGk7b3WobnZg7msLxyrFkgF1u0I7clSXumz
         fG4OBcgR6AdEJeDGFyeDvblAtHH/s7KikXz4FX3qqODe8pSy3NE3AUValI8iYUVvckOY
         R662jEy+WCnJMVvO34ofB+IH78HBUfDKvmN456XhZ8dvS1rp/etTVr9L5Iq8oGuKFBkD
         ZOwA==
X-Received: by 10.68.213.104 with SMTP id nr8mr47057689pbc.200.1363188100886;
 Wed, 13 Mar 2013 08:21:40 -0700 (PDT)
Received: by 10.68.49.65 with HTTP; Wed, 13 Mar 2013 08:21:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218057>

On Wed, Mar 13, 2013 at 4:24 AM, David Aguilar <davvid@gmail.com> wrote:
> This is a nice straightforward approach.
>
> As Junio mentioned, a good next step would be this patch
> in combination with making the truly temporary files
> created by dir-diff readonly.
>
> Will that need a win32 platform check?
> Does anyone want to take this and whip it into a proper patch?

An attempt:

>From 429ae282ffd7202b6d2fb024a92dea543b8af376 Mon Sep 17 00:00:00 2001
From: Matt McClure <matthewlmcclure@gmail.com>
Date: Wed, 13 Mar 2013 11:14:22 -0400
Subject: [PATCH] difftool: Make directory diff symlink working tree

...primarily so that a user can edit working tree files in his difftool.

difftool -d formerly knew how to symlink to the working tree when the
work tree contains uncommitted changes. In practice, prior to this
change, it would not symlink to the working tree in case there were no
uncommitted changes, even when the user invoked difftool with the form:

    git difftool -d [--options] <commit> [--] [<path>...]
        This form is to view the changes you have in your working tree
        relative to the named <commit>. You can use HEAD to compare it
        with the latest commit, or a branch name to compare with the tip
        of a different branch.

Instead, prior to this change, difftool would use the file's blob SHA1
to find its content in the index rather than use the working tree
content. This change teaches `git difftool` to compare the blob SHA1 to
the file's working tree blob SHA1 and use the working tree file if the
SHA1s are the same.

Author: John Keeping <john@keeping.me.uk>

Conversation:
http://thread.gmane.org/gmane.comp.version-control.git/217979/focus=218014
---
 git-difftool.perl | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 0a90de4..5f093ae 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -83,6 +83,21 @@ sub exit_cleanup
 	exit($status | ($status >> 8));
 }

+sub use_wt_file
+{
+	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
+	my $null_sha1 = '0' x 40;
+
+	if ($sha1 eq $null_sha1) {
+		return 1;
+	} elsif (not $symlinks) {
+		return 0;
+	}
+
+	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
+	return $sha1 eq $wt_sha1;
+}
+
 sub setup_dir_diff
 {
 	my ($repo, $workdir, $symlinks) = @_;
@@ -159,10 +174,10 @@ EOF
 		}

 		if ($rmode ne $null_mode) {
-			if ($rsha1 ne $null_sha1) {
-				$rindex .= "$rmode $rsha1\t$dst_path\0";
-			} else {
+			if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
 				push(@working_tree, $dst_path);
+			} else {
+				$rindex .= "$rmode $rsha1\t$dst_path\0";
 			}
 		}
 	}
-- 
1.8.1.5



-- 
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
