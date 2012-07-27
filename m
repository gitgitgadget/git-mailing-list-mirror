From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 7/8] Extract Git::SVN::GlobSpec from git-svn.
Date: Thu, 26 Jul 2012 17:26:06 -0700
Message-ID: <1343348767-86446-8-git-send-email-schwern@pobox.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 02:27:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuYOa-0004ZF-EZ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 02:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab2G0A0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 20:26:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58418 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab2G0A0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 20:26:47 -0400
Received: by pbbrp8 with SMTP id rp8so4045203pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1TmBncZYp3mG3Q1ZvOjssAzdpbjmtYrNzMegh2yI3lA=;
        b=t5/PuorLH4Dhn2jVnB7DFkmY63wSSxo7ONtj3RxOjqb0HDLfBRLGTQWqlHZZKMWO1d
         jx5dmpYA9YvVjV51DQIL7q0eAC9wR4GLapT6Bs2e0yXvm9RuJ8qun6NEF6PNT73mp33t
         nwGv9DTd/Kv6oD/ggPyQYCicjOPxmDUqBDQFmiDWnXTENg8zfuXCherT9cLBcaqNP2oa
         m/RcytAEXgNX3i4lXL1pP8t8PUJReVvmKXy+VruGRlJiDtnVHKnNH/jSeItqobjVDSNj
         BbgR404ia15eqnsSqfTd+2muS8of08l429yNKyGH8vAtpj/p3eKppk7dI/in8QmUR081
         OBCQ==
Received: by 10.68.136.229 with SMTP id qd5mr9330411pbb.2.1343348807111;
        Thu, 26 Jul 2012 17:26:47 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id jz4sm692556pbc.17.2012.07.26.17.26.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 17:26:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202325>

From: "Michael G. Schwern" <schwern@pobox.com>

Straight cut & paste.  That's the last class.

* Make Git::SVN load it on its own, its the only thing that needs it.
---
 git-svn.perl             | 59 ------------------------------------------------
 perl/Git/SVN.pm          |  2 ++
 perl/Git/SVN/GlobSpec.pm | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile            |  1 +
 t/Git-SVN/00compile.t    |  3 ++-
 5 files changed, 64 insertions(+), 60 deletions(-)
 create mode 100644 perl/Git/SVN/GlobSpec.pm

diff --git a/git-svn.perl b/git-svn.perl
index 0856a77..584e93a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2040,65 +2040,6 @@ sub gc_directory {
 	}
 }
 
-
-package Git::SVN::GlobSpec;
-use strict;
-use warnings;
-
-sub new {
-	my ($class, $glob, $pattern_ok) = @_;
-	my $re = $glob;
-	$re =~ s!/+$!!g; # no need for trailing slashes
-	my (@left, @right, @patterns);
-	my $state = "left";
-	my $die_msg = "Only one set of wildcard directories " .
-				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
-	for my $part (split(m|/|, $glob)) {
-		if ($part =~ /\*/ && $part ne "*") {
-			die "Invalid pattern in '$glob': $part\n";
-		} elsif ($pattern_ok && $part =~ /[{}]/ &&
-			 $part !~ /^\{[^{}]+\}/) {
-			die "Invalid pattern in '$glob': $part\n";
-		}
-		if ($part eq "*") {
-			die $die_msg if $state eq "right";
-			$state = "pattern";
-			push(@patterns, "[^/]*");
-		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
-			die $die_msg if $state eq "right";
-			$state = "pattern";
-			my $p = quotemeta($1);
-			$p =~ s/\\,/|/g;
-			push(@patterns, "(?:$p)");
-		} else {
-			if ($state eq "left") {
-				push(@left, $part);
-			} else {
-				push(@right, $part);
-				$state = "right";
-			}
-		}
-	}
-	my $depth = @patterns;
-	if ($depth == 0) {
-		die "One '*' is needed in glob: '$glob'\n";
-	}
-	my $left = join('/', @left);
-	my $right = join('/', @right);
-	$re = join('/', @patterns);
-	$re = join('\/',
-		   grep(length, quotemeta($left), "($re)", quotemeta($right)));
-	my $left_re = qr/^\/\Q$left\E(\/|$)/;
-	bless { left => $left, right => $right, left_regex => $left_re,
-	        regex => qr/$re/, glob => $glob, depth => $depth }, $class;
-}
-
-sub full_path {
-	my ($self, $path) = @_;
-	return (length $self->{left} ? "$self->{left}/" : '') .
-	       $path . (length $self->{right} ? "/$self->{right}" : '');
-}
-
 __END__
 
 Data structures:
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 2e0d7f0..b8b3474 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -207,6 +207,8 @@ sub read_all_remotes {
 			    . "must start with 'refs/'\n")
 				unless $remote_ref =~ m{^refs/};
 			$local_ref = uri_decode($local_ref);
+
+			require Git::SVN::GlobSpec;
 			my $rs = {
 			    t => $t,
 			    remote => $remote,
diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
new file mode 100644
index 0000000..96cfd98
--- /dev/null
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -0,0 +1,59 @@
+package Git::SVN::GlobSpec;
+use strict;
+use warnings;
+
+sub new {
+	my ($class, $glob, $pattern_ok) = @_;
+	my $re = $glob;
+	$re =~ s!/+$!!g; # no need for trailing slashes
+	my (@left, @right, @patterns);
+	my $state = "left";
+	my $die_msg = "Only one set of wildcard directories " .
+				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
+	for my $part (split(m|/|, $glob)) {
+		if ($part =~ /\*/ && $part ne "*") {
+			die "Invalid pattern in '$glob': $part\n";
+		} elsif ($pattern_ok && $part =~ /[{}]/ &&
+			 $part !~ /^\{[^{}]+\}/) {
+			die "Invalid pattern in '$glob': $part\n";
+		}
+		if ($part eq "*") {
+			die $die_msg if $state eq "right";
+			$state = "pattern";
+			push(@patterns, "[^/]*");
+		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
+			die $die_msg if $state eq "right";
+			$state = "pattern";
+			my $p = quotemeta($1);
+			$p =~ s/\\,/|/g;
+			push(@patterns, "(?:$p)");
+		} else {
+			if ($state eq "left") {
+				push(@left, $part);
+			} else {
+				push(@right, $part);
+				$state = "right";
+			}
+		}
+	}
+	my $depth = @patterns;
+	if ($depth == 0) {
+		die "One '*' is needed in glob: '$glob'\n";
+	}
+	my $left = join('/', @left);
+	my $right = join('/', @right);
+	$re = join('/', @patterns);
+	$re = join('\/',
+		   grep(length, quotemeta($left), "($re)", quotemeta($right)));
+	my $left_re = qr/^\/\Q$left\E(\/|$)/;
+	bless { left => $left, right => $right, left_regex => $left_re,
+	        regex => qr/$re/, glob => $glob, depth => $depth }, $class;
+}
+
+sub full_path {
+	my ($self, $path) = @_;
+	return (length $self->{left} ? "$self->{left}/" : '') .
+	       $path . (length $self->{right} ? "/$self->{right}" : '');
+}
+
+1;
diff --git a/perl/Makefile b/perl/Makefile
index 2428e59..22e3e81 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -31,6 +31,7 @@ modules += Git/SVN
 modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
 modules += Git/SVN/Editor
+modules += Git/SVN/GlobSpec
 modules += Git/SVN/Log
 modules += Git/SVN/Migration
 modules += Git/SVN/Prompt
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
index 5419438..c92fee4 100644
--- a/t/Git-SVN/00compile.t
+++ b/t/Git-SVN/00compile.t
@@ -3,7 +3,7 @@
 use strict;
 use warnings;
 
-use Test::More tests => 6;
+use Test::More tests => 7;
 
 require_ok 'Git::SVN';
 require_ok 'Git::SVN::Utils';
@@ -11,3 +11,4 @@ require_ok 'Git::SVN::Ra';
 require_ok 'Git::SVN::Log';
 require_ok 'Git::SVN::Migration';
 require_ok 'Git::IndexInfo';
+require_ok 'Git::SVN::GlobSpec';
-- 
1.7.11.1
