From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Improve repository verification
Date: Thu, 19 Apr 2012 18:07:31 +0200
Message-ID: <201204191807.32410.jnareb@gmail.com>
References: <20120403132735.GA12389@camk.edu.pl> <20120416213938.GB22574@camk.edu.pl> <201204180136.08570.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 18:08:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKttm-0006Vp-Tg
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 18:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab2DSQHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 12:07:38 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38212 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab2DSQHg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 12:07:36 -0400
Received: by wibhj6 with SMTP id hj6so1940452wib.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=P3S2LMjwFc+FqGjdnfEVAqNy1DCTBmZzEhJh6LyJBLY=;
        b=S5XMQ69EnmFr9z/UIO+hHur+uUfp+A4NOAmC4DmTpfOGxYU8FnT3NgntZ4n+bIMF9V
         p3NZX2E2lX2DBuoSgvJf7T1AynC4Wejnw8AkmufHU4yJLmrg4ZxMUKKDvnK6YpnejgI7
         Bcrpa+Yj/ENmFVwqCEzM9Lb72TwpFMhsMLrHUFrLElqQQvK6VqwYalAh75kQX/KpNxFu
         ZSTJ4zxfz5EgdIFqugs/bZrbOdvFayjXUB06AXi5rb4Q96CSEvqHWcoOhYYuGbnVf/f0
         PbVXq0ZMc0gD3wSVBq8Eppe4JZABySq0QTUodBt2vYWou48XBakMJFRb1XPQDEFfZUH4
         OZ5Q==
Received: by 10.180.95.34 with SMTP id dh2mr6592107wib.15.1334851654720;
        Thu, 19 Apr 2012 09:07:34 -0700 (PDT)
Received: from [192.168.1.13] (epp52.neoplus.adsl.tpnet.pl. [83.20.57.52])
        by mx.google.com with ESMTPS id 6sm43122598wiz.1.2012.04.19.09.07.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 09:07:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201204180136.08570.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195951>

Bring repository verification in check_export_ok() to standards of
is_git_directory function from setup.c (core git), and validate_headref()
to standards of the same function in path.c,... and a bit more.

validate_headref() replaces check_head_link(); note that the former
requires path to HEAD file, while the late latter path to repository.

Issues of note:
* is_git_directory() in gitweb is a bit stricter: it checks that
  "/objects" and "/refs" are directories, and not only 'executable'
  permission,
* validate_headref() in gitweb is a bit stricter: it checks that
  reference symlink or symref points to starts with "refs/heads/",
  and not only with "refs/",
* calls to check_head_link(), all of which were meant to check if
  given directory can be a git repository, were replaced by newly
  introduced is_git_directory().

This change is preparation for removing "Last change" column from list
of projects, which is currently used also for validating repository.

Suggested-by: Kacper Kornet <draenog@pld-linux.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Here is how such first step could look like...

 gitweb/gitweb.perl |   52 ++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 098e527..767d7a5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -621,19 +621,51 @@ sub feature_avatar {
 	return @val ? @val : @_;
 }
 
-# checking HEAD file with -e is fragile if the repository was
-# initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
-# and then pruned.
-sub check_head_link {
-	my ($dir) = @_;
-	my $headfile = "$dir/HEAD";
-	return ((-e $headfile) ||
-		(-l $headfile && readlink($headfile) =~ /^refs\/heads\//));
+# Test if it looks like we're at a git directory.
+# We want to see:
+#
+#  - an objects/ directory,
+#  - a refs/ directory,
+#  - either a HEAD symlink or a HEAD file that is formatted as
+#    a proper "ref:", or a regular file HEAD that has a properly
+#    formatted sha1 object name.
+#
+# See is_git_directory() in setup.c
+sub is_git_directory {
+	my $dir = shift;
+	return
+		-x "$dir/objects" && -d _ &&
+		-x "$dir/refs"    && -d _ &&
+		validate_headref("$dir/HEAD");
+}
+
+# Check HEAD file, that it is either
+#
+#  - a "refs/heads/.." symlink, or
+#  - a symbolic ref to "refs/heads/..", or
+#  - a detached HEAD.
+#
+# See validate_headref() in path.c
+sub validate_headref {
+	my $headfile = shift;
+	if (-l $headfile) {
+		return readlink($headfile) =~ m!^refs/heads/!;
+
+	} elsif (-e _) {
+		open my $fh, '<', $headfile or return;
+		my $line = <$fh>;
+		close $fh or return;
+
+		return
+			$line =~ m!^ref:\s*refs/heads/! ||  # symref
+			$line =~ m!^[0-9a-z]{40}$!i;        # detached HEAD
+	}
+	return;
 }
 
 sub check_export_ok {
 	my ($dir) = @_;
-	return (check_head_link($dir) &&
+	return (is_git_directory($dir) &&
 		(!$export_ok || -e "$dir/$export_ok") &&
 		(!$export_auth_hook || $export_auth_hook->($dir)));
 }
@@ -842,7 +874,7 @@ sub evaluate_path_info {
 	# find which part of PATH_INFO is project
 	my $project = $path_info;
 	$project =~ s,/+$,,;
-	while ($project && !check_head_link("$projectroot/$project")) {
+	while ($project && !is_git_directory("$projectroot/$project")) {
 		$project =~ s,/*[^/]*$,,;
 	}
 	return unless $project;
-- 
1.7.9
