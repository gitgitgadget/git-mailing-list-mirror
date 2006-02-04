From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fmt-merge-msg: show summary of what is merged.
Date: Fri, 03 Feb 2006 23:17:42 -0800
Message-ID: <7vu0bf619l.fsf_-_@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005F34393@hdsmsx401.amr.corp.intel.com>
	<7vy80r97h6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602031841320.3969@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Dave Jones <davej@redhat.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 08:17:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Hg5-0005Md-6O
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 08:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946322AbWBDHRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 02:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946323AbWBDHRp
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 02:17:45 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39878 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1946322AbWBDHRo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 02:17:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204071614.HMSX20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 02:16:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602031841320.3969@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 3 Feb 2006 18:47:08 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15575>

Linus Torvalds <torvalds@osdl.org> writes:

> Yeah, it doesn't show the branch names _and_ it shows the commit that you 
> merged into too, so it looks like
>
>   Parent: 3ee68.. ([SPARC64]: Use compat_sys_futimesat in 32-bit syscall table.)
>   Parent: 876c1.. ([ACPI] Disable C2/C3 for _all_ IBM R40e Laptops)
>   Parent: 729b4.. ([ACPI] fix reboot upon suspend-to-disk)
>   Parent: cf824.. ([ACPI] handle BIOS with implicit C1 in _CST)
>
> but it's actually pretty readable there.

Fair enough.  I myself do not use gitk that often than I use
'git log'.  Something like this patch is what I've been thinking
of doing (it actually works rather nicely if you try to recreate
Len's merge).

-- >8 --
This was prompted by Len's 12-way octopus.  In addition to
the branch names, populate the log message with one-line
description from actual commits that are being merged.

This is experimental.  You need to have 'merge.summary'
in the configuration file to enable it:

	$ git repo-config merge.summary yes

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-fmt-merge-msg.perl |   79 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 2 deletions(-)

b145e0d7a5fc728c00925b55c8a2c2a97788536b
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index 778388e..9ac3c87 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -27,10 +27,47 @@ sub andjoin {
 	return ($m);
 }
 
+sub repoconfig {
+	my $fh;
+	my $val;
+	eval {
+		open $fh, '-|', 'git-repo-config', '--get', 'merge.summary'
+		    or die "$!";
+		($val) = <$fh>;
+		close $fh;
+	};
+	return $val;
+}
+
+sub mergebase {
+	my ($other) = @_;
+	my $fh;
+	open $fh, '-|', 'git-merge-base', '--all', 'HEAD', $other or die "$!";
+	my (@mb) = map { chomp; $_ } <$fh>;
+	close $fh or die "$!";
+	return @mb;
+}
+
+sub shortlog {
+	my ($tip, $limit, @base) = @_;
+	my ($fh, @result);
+	open $fh, '-|', ('git-log', "--max-count=$limit", '--topo-order',
+			 '--pretty=oneline', $tip, map { "^$_" } @base)
+	    or die "$!";
+	while (<$fh>) {
+		s/^[0-9a-f]{40}\s+//;
+		push @result, $_;
+	}
+	close $fh or die "$!";
+	return @result;
+}
+
+my @origin = ();
 while (<>) {
-	my ($bname, $tname, $gname, $src);
+	my ($bname, $tname, $gname, $src, $sha1, $origin);
 	chomp;
-	s/^[0-9a-f]*	//;
+	s/^([0-9a-f]*)	//;
+	$sha1 = $1;
 	next if (/^not-for-merge/);
 	s/^	//;
 	if (s/ of (.*)$//) {
@@ -52,19 +89,30 @@ while (<>) {
 		};
 	}
 	if (/^branch (.*)$/) {
+		$origin = $1;
 		push @{$src{$src}{BRANCH}}, $1;
 		$src{$src}{HEAD_STATUS} |= 2;
 	}
 	elsif (/^tag (.*)$/) {
+		$origin = $_;
 		push @{$src{$src}{TAG}}, $1;
 		$src{$src}{HEAD_STATUS} |= 2;
 	}
 	elsif (/^HEAD$/) {
+		$origin = $src;
 		$src{$src}{HEAD_STATUS} |= 1;
 	}
 	else {
 		push @{$src{$src}{GENERIC}}, $_;
 		$src{$src}{HEAD_STATUS} |= 2;
+		$origin = $src;
+	}
+	if ($src eq '.' || $src eq $origin) {
+		$origin =~ s/^'(.*)'$/$1/;
+		push @origin, [$sha1, "$origin"];
+	}
+	else {
+		push @origin, [$sha1, "$origin of $src"];
 	}
 }
 
@@ -93,3 +141,30 @@ for my $src (@src) {
 	push @msg, $this;
 }
 print "Merge ", join("; ", @msg), "\n";
+
+if (!repoconfig) {
+	exit(0);
+}
+
+# We limit the merge message to the latst 20 or so per each branch.
+my $limit = 20;
+
+for (@origin) {
+	my ($sha1, $name) = @$_;
+	my @mb = mergebase($sha1);
+	my @log = shortlog($sha1, $limit, @mb);
+	if ($limit + 1 <= @log) {
+		print "\n* $name: (" . scalar(@log) . " commits)\n";
+	}
+	else {
+		print "\n* $name:\n";
+	}
+	my $cnt = 0;
+	for my $log (@log) {
+		if ($limit < ++$cnt) {
+			print "  ...\n";
+			last;
+		}
+		print "  $log";
+	}
+}
-- 
1.1.6.ge2129
