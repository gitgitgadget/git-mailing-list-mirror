From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn mkdirs ignores compressed unhandled.log files
Date: Thu, 17 Dec 2009 12:08:52 -0800
Message-ID: <20091217200852.GA5797@dcvr.yhbt.net>
References: <8BB233FB-4269-4B14-8703-A4FF1E25FB0D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Zeh <robert.a.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 21:09:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLMeg-00081o-Lo
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 21:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761119AbZLQUI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 15:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935840AbZLQUIz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 15:08:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:35158 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757870AbZLQUIx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 15:08:53 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5E71F50E;
	Thu, 17 Dec 2009 20:08:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8BB233FB-4269-4B14-8703-A4FF1E25FB0D@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135380>

Robert Zeh <robert.a.zeh@gmail.com> wrote:
> It looks like there is a conflict between git svn gc and git svn
> mkdirs.  The git svn mkdirs command only looks at unhandled.log files.
> Shouldn't it also look at any compressed unhandled.log files too?

Hi Robert,

Yes, an oversight. Does this patch work for you? (Highly untested)

Would you mind writing a test case, been a bit busy with other stuff.
Thanks.

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
-- 
Eric Wong
