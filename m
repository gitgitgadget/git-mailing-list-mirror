From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 3/8] Improve our URL canonicalization to be more like SVN 1.7's.
Date: Sat, 28 Jul 2012 02:47:47 -0700
Message-ID: <1343468872-72133-4-git-send-email-schwern@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:49:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3e7-0005aT-8A
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab2G1Jst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:48:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42332 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab2G1JsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:48:07 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6503059pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WhgQW74/iOTF22K7TyYRGjgtsC3RQBHjrpq5Qs7fLMk=;
        b=waatx2nB8JFMEi7Cxo4MPXZ6LAt2HOJCzM6WGPU343t5a0Sheg9XBPlQaS8epAl8LJ
         Pz0pMvN5yG5NeuIb+BheL7Yb9Wt//RNQurm4e+ZDI59jMLTE2plYNkgA85Z/f+6q1+YL
         XV9UanhuqkEofKmGwwmaOt+DWioUcU7H7zXza28YW2ygOF/2Cz8EPSUtbuG8+AcDqk7D
         YoLpfvOgkJ7pYFyWmhGrdMtob1npj+QhlbmlAyMy2nFi1Jr7X4gpjbg08M0Gud8X+tq+
         F/INTNO9D9wIsZaUVKJKC34AcHpJCzAsyMJX46cR7xbUAodELO91fS4gFWnYQsnJEzIy
         B1PQ==
Received: by 10.68.222.40 with SMTP id qj8mr19980170pbc.139.1343468886978;
        Sat, 28 Jul 2012 02:48:06 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id nv6sm3692274pbc.42.2012.07.28.02.48.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:48:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202427>

From: "Michael G. Schwern" <schwern@pobox.com>

Previously, our URL canonicalization didn't do much of anything.
Now it actually escapes and collapses slashes.  This is mostly a cut & paste
of escape_url from git-svn.

This is closer to how SVN 1.7's canonicalization behaves.  Doing it with
1.6 lets us chase down some problems caused by more effective canonicalization
without having to deal with all the other 1.7 issues on top of that.

* Remote URLs have to be canonicalized otherwise Git::SVN->find_existing_remote
  will think they're different.

* The SVN remote is now written to the git config canonicalized.  That
  should be ok.  Adjust a test to account for that.
---
 perl/Git/SVN.pm                    |  4 ++--
 perl/Git/SVN/Utils.pm              | 19 +++++++++++++++++--
 t/Git-SVN/Utils/canonicalize_url.t | 26 ++++++++++++++++++++++++++
 t/t9107-git-svn-migrate.sh         |  4 +++-
 4 files changed, 48 insertions(+), 5 deletions(-)
 create mode 100644 t/Git-SVN/Utils/canonicalize_url.t

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 798f6c4..cb6d83a 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -201,9 +201,9 @@ sub read_all_remotes {
 		} elsif (m!^(.+)\.usesvmprops=\s*(.*)\s*$!) {
 			$r->{$1}->{svm} = {};
 		} elsif (m!^(.+)\.url=\s*(.*)\s*$!) {
-			$r->{$1}->{url} = $2;
+			$r->{$1}->{url} = canonicalize_url($2);
 		} elsif (m!^(.+)\.pushurl=\s*(.*)\s*$!) {
-			$r->{$1}->{pushurl} = $2;
+			$r->{$1}->{pushurl} = canonicalize_url($2);
 		} elsif (m!^(.+)\.ignore-refs=\s*(.*)\s*$!) {
 			$r->{$1}->{ignore_refs_regex} = $2;
 		} elsif (m!^(.+)\.(branches|tags)=$svn_refspec$!) {
diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index 7ae6fac..dab6e4d 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -147,10 +147,25 @@ sub canonicalize_url {
 }
 
 
+sub _canonicalize_url_path {
+	my ($uri_path) = @_;
+
+	my @parts;
+	foreach my $part (split m{/+}, $uri_path) {
+		$part =~ s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
+		push @parts, $part;
+	}
+
+	return join('/', @parts);
+}
+
 sub _canonicalize_url_ourselves {
 	my ($url) = @_;
-	$url =~ s#^([^:]+://[^/]*/)(.*)$#$1 . canonicalize_path($2)#e;
-	return $url;
+	if ($url =~ m#^([^:]+)://([^/]*)(.*)$#) {
+		my ($scheme, $domain, $uri) = ($1, $2, _canonicalize_url_path(canonicalize_path($3)));
+		$url = "$scheme://$domain$uri";
+	}
+	$url;
 }
 
 
diff --git a/t/Git-SVN/Utils/canonicalize_url.t b/t/Git-SVN/Utils/canonicalize_url.t
new file mode 100644
index 0000000..05795ab
--- /dev/null
+++ b/t/Git-SVN/Utils/canonicalize_url.t
@@ -0,0 +1,26 @@
+#!/usr/bin/env perl
+
+# Test our own home rolled URL canonicalizer.  Test the private one
+# directly because we can't predict what the SVN API is doing to do.
+
+use strict;
+use warnings;
+
+use Test::More 'no_plan';
+
+use Git::SVN::Utils;
+my $canonicalize_url = \&Git::SVN::Utils::_canonicalize_url_ourselves;
+
+my %tests = (
+	"http://x.com"			=> "http://x.com",
+	"http://x.com/"			=> "http://x.com",
+	"http://x.com/foo/bar"		=> "http://x.com/foo/bar",
+	"http://x.com//foo//bar//"	=> "http://x.com/foo/bar",
+	"http://x.com/  /%/"		=> "http://x.com/%20%20/%25",
+);
+
+for my $arg (keys %tests) {
+	my $want = $tests{$arg};
+
+	is $canonicalize_url->($arg), $want, "canonicalize_url('$arg') => $want";
+}
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index cfb4453..ee73013 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -27,6 +27,8 @@ test_expect_success 'setup old-looking metadata' '
 head=`git rev-parse --verify refs/heads/git-svn-HEAD^0`
 test_expect_success 'git-svn-HEAD is a real HEAD' "test -n '$head'"
 
+svnrepo_escaped=`echo $svnrepo | sed 's/ /%20/'`
+
 test_expect_success 'initialize old-style (v0) git svn layout' '
 	mkdir -p "$GIT_DIR"/git-svn/info "$GIT_DIR"/svn/info &&
 	echo "$svnrepo" > "$GIT_DIR"/git-svn/info/url &&
@@ -35,7 +37,7 @@ test_expect_success 'initialize old-style (v0) git svn layout' '
 	! test -d "$GIT_DIR"/git-svn &&
 	git rev-parse --verify refs/${remotes_git_svn}^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
-	test "$(git config --get svn-remote.svn.url)" = "$svnrepo" &&
+	test "$(git config --get svn-remote.svn.url)" = "$svnrepo_escaped" &&
 	test `git config --get svn-remote.svn.fetch` = \
              ":refs/${remotes_git_svn}"
 	'
-- 
1.7.11.3
