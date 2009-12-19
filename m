From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: make empty directory creation gc-aware
Date: Sat, 19 Dec 2009 14:27:38 -0800
Message-ID: <20091219222738.GA20331@dcvr.yhbt.net>
References: <8BB233FB-4269-4B14-8703-A4FF1E25FB0D@gmail.com> <20091217200852.GA5797@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Zeh <robert.a.zeh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 23:27:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM7m4-0002tr-I0
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 23:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbZLSW1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 17:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZLSW1k
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 17:27:40 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:59815 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786AbZLSW1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 17:27:39 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB561F513;
	Sat, 19 Dec 2009 22:27:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091217200852.GA5797@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135505>

The "git svn gc" command creates and appends to unhandled.log.gz
files which should be parsed before the uncompressed
unhandled.log files.

Reported-by: Robert Zeh
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Eric Wong <normalperson@yhbt.net> wrote:
  > Robert Zeh <robert.a.zeh@gmail.com> wrote:
  > > It looks like there is a conflict between git svn gc and git svn
  > > mkdirs.  The git svn mkdirs command only looks at unhandled.log files.
  > > Shouldn't it also look at any compressed unhandled.log files too?
  > 
  > Hi Robert,
  > 
  > Yes, an oversight. Does this patch work for you? (Highly untested)

  Test case included and pushed out to git://git.bogomips.org/git-svn

  More pushes hopefully coming as Sam and Andrew work out the mergeinfo
  performance problems and I look into crossing svn-remote boundaries
  for parent lookups.

 git-svn.perl                  |   45 +++++++++++++++++++++++++++++++----------
 t/t9146-git-svn-empty-dirs.sh |   24 +++++++++++++++++++++
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a4b052c..d362de7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2740,21 +2740,44 @@ sub do_fetch {
 
 sub mkemptydirs {
 	my ($self, $r) = @_;
+
+	sub scan {
+		my ($r, $empty_dirs, $line) = @_;
+		if (defined $r && $line =~ /^r(\d+)$/) {
+			return 0 if $1 > $r;
+		} elsif ($line =~ /^  \+empty_dir: (.+)$/) {
+			$empty_dirs->{$1} = 1;
+		} elsif ($line =~ /^  \-empty_dir: (.+)$/) {
+			my @d = grep {m[^\Q$1\E(/|$)]} (keys %$empty_dirs);
+			delete @$empty_dirs{@d};
+		}
+		1; # continue
+	};
+
 	my %empty_dirs = ();
+	my $gz_file = "$self->{dir}/unhandled.log.gz";
+	if (-f $gz_file) {
+		if (!$can_compress) {
+			warn "Compress::Zlib could not be found; ",
+			     "empty directories in $gz_file will not be read\n";
+		} else {
+			my $gz = Compress::Zlib::gzopen($gz_file, "rb") or
+				die "Unable to open $gz_file: $!\n";
+			my $line;
+			while ($gz->gzreadline($line) > 0) {
+				scan($r, \%empty_dirs, $line) or last;
+			}
+			$gz->gzclose;
+		}
+	}
 
-	open my $fh, '<', "$self->{dir}/unhandled.log" or return;
-	binmode $fh or croak "binmode: $!";
-	while (<$fh>) {
-		if (defined $r && /^r(\d+)$/) {
-			last if $1 > $r;
-		} elsif (/^  \+empty_dir: (.+)$/) {
-			$empty_dirs{$1} = 1;
-		} elsif (/^  \-empty_dir: (.+)$/) {
-			my @d = grep {m[^\Q$1\E(/|$)]} (keys %empty_dirs);
-			delete @empty_dirs{@d};
+	if (open my $fh, '<', "$self->{dir}/unhandled.log") {
+		binmode $fh or croak "binmode: $!";
+		while (<$fh>) {
+			scan($r, \%empty_dirs, $_) or last;
 		}
+		close $fh;
 	}
-	close $fh;
 
 	my $strip = qr/\A\Q$self->{path}\E(?:\/|$)/;
 	foreach my $d (sort keys %empty_dirs) {
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 9b8d046..3f2d719 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -114,5 +114,29 @@ test_expect_success 'removed top-level directory does not exist' '
 	test ! -e removed/d
 
 '
+unhandled=.git/svn/refs/remotes/git-svn/unhandled.log
+test_expect_success 'git svn gc-ed files work' '
+	(
+		cd removed &&
+		git svn gc &&
+		: Compress::Zlib may not be available &&
+		if test -f "$unhandled".gz
+		then
+			svn mkdir -m gz "$svnrepo"/gz &&
+			git reset --hard $(git rev-list HEAD | tail -1) &&
+			git svn rebase &&
+			test -f "$unhandled".gz &&
+			test -f "$unhandled" &&
+			for i in a b c "weird file name" gz "! !"
+			do
+				if ! test -d "$i"
+				then
+					echo >&2 "$i does not exist"
+					exit 1
+				fi
+			done
+		fi
+	)
+'
 
 test_done
-- 
Eric Wong
