From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add commit count options to git-shortlog
Date: Fri, 06 Oct 2006 15:39:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610061520020.2435@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 21:39:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVvXP-0001xi-Ik
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 21:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWJFTjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 15:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWJFTjL
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 15:39:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:2663 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1422651AbWJFTjK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 15:39:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6Q0059DBX9L5G0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Oct 2006 15:39:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28441>

This patch does 3 things:

1) Output the number of commits along with the name for each author 
   (nice to know for long lists spending more than a screen worth of 
   commit lines).

2) Provide a switch (-n) to sort authors according to their number of 
   commits instead of author alphabetic order.

3) Provide a switch (-s) to supress commit lines and only keep a 
   summary of authors and the number of commits for each of them.

And for good measure a short usage is displayed with -h.  

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

I'm far from a Perl expert.  I just hope that Perl gurus out there won't 
throw up too badly.

With this it is possible to have nice statistics quickly, and 
demonstrate that Junio is really our King.  ;-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 7486ebe..1601d22 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -7,16 +7,29 @@ git-shortlog - Summarize 'git log' outpu
 
 SYNOPSIS
 --------
-git-log --pretty=short | 'git-shortlog'
+git-log --pretty=short | 'git-shortlog' [-h] [-n] [-s]
 
 DESCRIPTION
 -----------
 Summarizes 'git log' output in a format suitable for inclusion
-in release announcements. Each commit will be grouped by author
+in release announcements. Each commit will be grouped by author and
 the first line of the commit message will be shown.
 
 Additionally, "[PATCH]" will be stripped from the commit description.
 
+OPTIONS
+-------
+
+-h::
+	Print a short usage message and exit.
+
+-n::
+	Sort output according to the number of commits per author instead
+	of author alphabetic order.
+
+-s:
+	Supress commit description and Provide a commit count summary only.
+
 FILES
 -----
 '.mailmap'::
diff --git a/git-shortlog.perl b/git-shortlog.perl
index 0b14f83..138c4c5 100755
--- a/git-shortlog.perl
+++ b/git-shortlog.perl
@@ -1,6 +1,18 @@
 #!/usr/bin/perl -w
 
 use strict;
+use Getopt::Std;
+use File::Basename qw(basename dirname);
+
+our ($opt_h, $opt_n, $opt_s);
+getopts('hns');
+
+$opt_h && usage();
+
+sub usage {
+	print STDERR "Usage: ${\basename $0} [-h] [-n] [-s] < <log_data>\n";
+        exit(1);
+}
 
 my (%mailmap);
 my (%email);
@@ -38,16 +50,37 @@ sub by_name($$) {
 
 	uc($a) cmp uc($b);
 }
+sub by_nbentries($$) {
+	my ($a, $b) = @_;
+	my $a_entries = $map{$a};
+	my $b_entries = $map{$b};
+
+	@$b_entries - @$a_entries || by_name $a, $b;
+}
+
+my $sort_method = $opt_n ? \&by_nbentries : \&by_name;
+
+sub summary_output {
+	my ($obj, $num, $key);
+
+	foreach $key (sort $sort_method keys %map) {
+		$obj = $map{$key};
+		$num = @$obj;
+		printf "%s: %u\n", $key, $num;
+	}
+}
 
 sub shortlog_output {
-	my ($obj, $key, $desc);
+	my ($obj, $num, $key, $desc);
+
+	foreach $key (sort $sort_method keys %map) {
+		$obj = $map{$key};
+		$num = @$obj;
 
-	foreach $key (sort by_name keys %map) {
 		# output author
-		printf "%s:\n", $key;
+		printf "%s (%u):\n", $key, $num;
 
 		# output author's 1-line summaries
-		$obj = $map{$key};
 		foreach $desc (reverse @$obj) {
 			print "  $desc\n";
 			$n_output++;
@@ -152,7 +185,7 @@ sub finalize {
 
 &setup_mailmap;
 &changelog_input;
-&shortlog_output;
+$opt_s ? &summary_output : &shortlog_output;
 &finalize;
 exit(0);
 
