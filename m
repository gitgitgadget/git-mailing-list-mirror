From: Ilya Basin <basinilya@gmail.com>
Subject: [PATCH 1/2] git-svn: fix occasional "Failed to strip path" error on fetch next commit
Date: Sun, 28 Apr 2013 12:35:27 +0359
Message-ID: <1107347907.20130428123527@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 28 10:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWN6y-0007hh-N5
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 10:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab3D1IhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 04:37:09 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:54846 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3D1IhI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 04:37:08 -0400
Received: by mail-la0-f51.google.com with SMTP id ep20so938640lab.38
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 01:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=VOXUBy6UePkaM1/zdO3d5mky7m57w+0o1rougSxx58U=;
        b=DnfyjO0PutxKQeBfmsQehzuieg5qPES0J3lDNskvioBilLZy43ny8usqdEfSal+tC4
         0yprXXtmCrPRtA6Soy+/pQUI7QyjaV4+J3cjkK+OYfWt7oh4acbb2HKI4AW4oC2dH8Qj
         kKv975ftD6u5e3ENHqJ4YfO1jMvRiTkq2ri6hGBubzNAX9XDhxVmKsYOPy7VcGdthvaj
         J8vVfXK9JfAOCSO4Zadz/p1IZwtRLbEaXYyxX55OQPjKw89LS5HuvknSkQZb6sLQIvva
         PV9G0FQVbMmhMLI3j9Ssx4lZkzOZB0WTuqyc+TivGHXeJbrxQftb63uIsAZzJ5Z12qSU
         u8eA==
X-Received: by 10.152.116.113 with SMTP id jv17mr21432487lab.35.1367138225683;
        Sun, 28 Apr 2013 01:37:05 -0700 (PDT)
Received: from [192.168.0.78] (92-100-235-219.dynamic.avangarddsl.ru. [92.100.235.219])
        by mx.google.com with ESMTPSA id v10sm7640311lae.9.2013.04.28.01.37.03
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 28 Apr 2013 01:37:04 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222732>

When --stdlayout and --preserve-empty-dirs flags are used and a
directory becomes empty, sometimes no empty dir placeholder file
created. Then on fetch next commit git-svn dies with "Failed to strip
path" error.

Test script:

    rm -rf testrepo.svn testrepo.gitsvn
    svnadmin create testrepo.svn
    url=file://`pwd`/testrepo.svn

    svn mkdir -m "" "$url/trunk" "$url/branches" "$url/tags"
    rm -rf testrepo
    svn co "$url" testrepo
    cd testrepo/trunk

    mkdir -p foo/bar/
    svn add foo/
    svn commit -mx

    svn rm foo/bar/
    svn commit -mx

    svn up
    mkdir -p baz/
    svn add baz/
    svn commit -mx

    echo x > fil.txt
    svn add fil.txt
    svn commit -mx

    cd ../..

    git svn clone --stdlayout --preserve-empty-dirs "$url" testrepo.gitsvn
---
 perl/Git/SVN/Fetcher.pm | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 046a7a2..4f96076 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -129,6 +129,7 @@ sub is_path_ignored {
 
 sub set_path_strip {
 	my ($self, $path) = @_;
+	$self->{pathprefix_strip} = length $path ? ($path . "/") : "";
 	$self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;
 }
 
@@ -458,9 +459,12 @@ sub find_empty_directories {
 		my $skip_added = 0;
 		foreach my $t (qw/dir_prop file_prop/) {
 			foreach my $path (keys %{ $self->{$t} }) {
-				if (exists $self->{$t}->{dirname($path)}) {
-					$skip_added = 1;
-					last;
+				if (length $self->git_path($path)) {
+					$path = dirname($path);
+					if ($dir eq $self->git_path($path) && exists $self->{$t}->{$path}) {
+						$skip_added = 1;
+						last;
+					}
 				}
 			}
 			last if $skip_added;
@@ -477,7 +481,7 @@ sub find_empty_directories {
 		delete $files{$_} foreach (@deleted_gpath);
 
 		# Report the directory if there are no filenames left.
-		push @empty_dirs, $dir unless (scalar %files);
+		push @empty_dirs, ($self->{pathprefix_strip} . $dir) unless (scalar %files);
 	}
 	@empty_dirs;
 }
-- 
1.8.1.5
