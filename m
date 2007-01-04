From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Thu, 4 Jan 2007 23:31:42 +0200
Message-ID: <20070104213142.GE11861@sashak.voltaire.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 22:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2a4j-0004PA-O5
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 22:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbXADVYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 16:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbXADVYe
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 16:24:34 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:18584 "EHLO
	taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030242AbXADVYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 16:24:33 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 4 Jan 2007 23:24:30 +0200
Received: by sashak (sSMTP sendmail emulation); Thu,  4 Jan 2007 23:31:42 +0200
To: Linus Torvalds <torvalds@osdl.org>, Chris Lee <chris133@gmail.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 04 Jan 2007 21:24:30.0919 (UTC) FILETIME=[B8C63570:01C73046]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35957>

On 17:59 Wed 03 Jan     , Linus Torvalds wrote:
> 
> However, I don't know what the proper magic is for svnimport to do that 
> sane "do it in chunks and tell when you're all done". Or even better - to 
> just make it repack properly and not keep everything in memory.

> As to who knows how to fix git-svnimport to do something saner, I have no 
> clue.. Sasha seems to have touched it last. Sasha?

I guess it should not be hard to do svnimport in incrementally with
repacking. Like this:


diff --git a/git-svnimport.perl b/git-svnimport.perl
index 071777b..afbbe63 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -31,12 +31,13 @@ $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
-    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,$opt_P);
+    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,
+    $opt_P,$opt_R);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from SVN
-       [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
+       [-o branch-for-HEAD] [-h] [-v] [-l max_rev] [-R repack_each_revs]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
        [-m] [-M regex] [-A author_file] [-S] [-F] [-P project_name] [SVN_URL]
@@ -44,7 +45,7 @@ END
 	exit(1);
 }
 
-getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:uv") or usage();
+getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:R:uv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
@@ -52,6 +53,7 @@ my $trunk_name = $opt_T || "trunk";
 my $branch_name = $opt_b || "branches";
 my $project_name = $opt_P || "";
 $project_name = "/" . $project_name if ($project_name);
+my $repack_after = $opt_R || 1000;
 
 @ARGV == 1 or @ARGV == 2 or usage();
 
@@ -938,11 +940,27 @@ if ($opt_l < $current_rev) {
     exit;
 }
 
-print "Fetching from $current_rev to $opt_l ...\n" if $opt_v;
+print "Processing from $current_rev to $opt_l ...\n" if $opt_v;
 
-my $pool=SVN::Pool->new;
-$svn->{'svn'}->get_log("/",$current_rev,$opt_l,0,1,1,\&commit_all,$pool);
-$pool->clear;
+my $from_rev;
+my $to_rev = $current_rev;
+
+while ($to_rev < $opt_l) {
+	$from_rev = $to_rev;
+	$to_rev = $from_rev + $repack_after;
+	$to_rev = $opt_l if $opt_l < $to_rev;
+	print "Fetching from $from_rev to $to_rev ...\n" if $opt_v;
+	my $pool=SVN::Pool->new;
+	$svn->{'svn'}->get_log("/",$from_rev,$to_rev,0,1,1,\&commit_all,$pool);
+	$pool->clear;
+	my $pid = fork();
+	die "Fork: $!\n" unless defined $pid;
+	unless($pid) {
+		exec("git-repack", "-d")
+			or die "Cannot repack: $!\n";
+	}
+	waitpid($pid, 0);
+}
 
 
 unlink($git_index);


Chris, it works fine for me with small repository (~9000 revisions), but
I don't have such huge one as yours. Could you try? Thanks.

Sasha
