From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Improve repository verification
Date: Sat, 21 Apr 2012 13:28:24 +0200
Message-ID: <201204211328.25162.jnareb@gmail.com>
References: <20120403132735.GA12389@camk.edu.pl> <xmqq397zwp4c.fsf@junio.mtv.corp.google.com> <201204192146.09853.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Junio C Hamano <jch@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 13:28:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLYUV-0004mS-Ot
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 13:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052Ab2DUL2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 07:28:30 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52698 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab2DUL23 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 07:28:29 -0400
Received: by wibhq7 with SMTP id hq7so1456702wib.1
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=qcFaOq5MX+wger4DLjW4fRQG5iilHXRKpVPYLv1G0uY=;
        b=SVDRyCp9g2GHE42B5rNz6HZt9pQJrbCClprw2ysROzzLA0+Xp01AYm17v8O4XVztCD
         85gp8dN9TrAyq/s+qZgMdzjRtlEqF5Yb6fZaJKYBWiiynY9IlxjjO7Fav+8kMD44HO4P
         tKS7LsKfN6jezRhkYlWurBv05zbtTSluDaHCua/7bbE+widaxTCVP1JNoHduCzHS99qK
         ZFTvTYvcsJvU37zDsMhQIl87lF8KR0GKP0e7CgO2XNYTLDaZ7bubR7MTKr0tqYdR5Y/5
         awHPnjmC2t2oBrC7S4y0CIKv0rH9gb9LX6Oz2royVuVXB0XmMtN6YBWCae+myIrctS5M
         WcZw==
Received: by 10.180.105.194 with SMTP id go2mr903892wib.22.1335007708339;
        Sat, 21 Apr 2012 04:28:28 -0700 (PDT)
Received: from [192.168.1.13] (addg45.neoplus.adsl.tpnet.pl. [79.184.58.45])
        by mx.google.com with ESMTPS id ff9sm4996524wib.2.2012.04.21.04.28.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Apr 2012 04:28:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201204192146.09853.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196048>

On Thu, 19 April 2012, Jakub Narebski wrote:
> On Thu, 19 April 2012, Junio C Hamano wrote:

> > By the way, I wonder (1) if it is worth adding support for the textual
> > ".git" file that contains "gitdir: $path", and (2) if so how big a
> > change would we need to do so.
> 
> I don't think that it would be big change to add support for "gitlink"
> files, assuming that 'git --git-dir=<gitlink file> ...' works correctly.
> I would put that addition in a separate commit, though.

Well, I actually tried to write such commit, adding support for
'gitlink' files, and it turned out to be harder than I thought.
The problem that stumped me for now is that gitweb tries to read
many files inside git repository ('export-ok', 'description',
'cloneurl', 'category', etc.), allof which must be redirected to
real git directory.

I still think it is doable, but I wonder if it is worth it...

Below there is work in progress patch, which doesn't use resolve_gitdir
yet, and without any tests.

-- >8 ---------- >8 --
Subject: [PATCH] gitweb: Add support for "gitdir: <path>" gitfile

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   54 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 767d7a5..8d70a0a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -639,6 +639,52 @@ sub is_git_directory {
 		validate_headref("$dir/HEAD");
 }
 
+# Try to read the location of the git directory from the .git file,
+# return path to git directory if found.
+#
+# See read_gitfile in setup.c
+sub read_gitfile {
+	my $path = shift;
+	# note: the "basename eq '.git'" check isn't in setup.c version
+	return unless ($path =~ m!(?:^|/)\.git/*$! && -f $path);
+
+	open my $fh, '<', $path or return;
+	my $contents = do { local $/ = undef; <$fh> };
+	close $fh or return;
+	return unless defined $contents;
+	chomp($contents);
+
+	return unless ($contents =~ s!^gitdir: !!);
+
+	if (!File::Spec->file_name_is_absolute($contents)) {
+		$contents = File::Spec->catfile(File::Basename::dirname($path), $contents);
+	}
+
+	return unless is_git_directory($contents);
+	return $contents;
+}
+
+# Test if it looks like we're at a git repository
+#
+#  - a '.git' file containing "gitdir: <path>",
+#  - a git directory.
+sub is_git_repository {
+	my $path = shift;
+	return defined(read_gitfile($path)) || is_git_directory($path);
+}
+
+# Return directory of a git repository, resolving '.git' files
+# (file containing "gitdir: <path>") if any
+#
+# See resolve_gitdir in setup.c
+sub resolve_gitdir {
+	my $suspect = shift;
+	if (is_git_directory($suspect)) {
+		return $suspect;
+	}
+	return read_gitfile($suspect);
+}
+
 # Check HEAD file, that it is either
 #
 #  - a "refs/heads/.." symlink, or
@@ -665,7 +711,7 @@ sub validate_headref {
 
 sub check_export_ok {
 	my ($dir) = @_;
-	return (is_git_directory($dir) &&
+	return (is_git_repository($dir) &&
 		(!$export_ok || -e "$dir/$export_ok") &&
 		(!$export_auth_hook || $export_auth_hook->($dir)));
 }
@@ -874,7 +920,7 @@ sub evaluate_path_info {
 	# find which part of PATH_INFO is project
 	my $project = $path_info;
 	$project =~ s,/+$,,;
-	while ($project && !is_git_directory("$projectroot/$project")) {
+	while ($project && !is_git_repository("$projectroot/$project")) {
 		$project =~ s,/*[^/]*$,,;
 	}
 	return unless $project;
@@ -3094,8 +3140,8 @@ sub git_get_projects_list {
 				our $projectroot;
 				# skip project-list toplevel, if we get it.
 				return if (m!^[/.]$!);
-				# only directories can be git repositories
-				return unless (-d $_);
+				# only directories or gitlink files can be git repositories
+				return unless (-d $_ || (-f _ && $File::Find::name =~ m!(?:^|/)\.git!));
 				# don't traverse too deep (Find is super slow on os x)
 				# $project_maxdepth excludes depth of $projectroot
 				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {
-- 
1.7.9
