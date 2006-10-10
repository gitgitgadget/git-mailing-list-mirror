From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add commit count options to git-shortlog
Date: Mon, 09 Oct 2006 22:45:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610092222030.2435@xanadu.home>
References: <Pine.LNX.4.64.0610061520020.2435@xanadu.home>
 <7vodsotqqd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 04:46:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX7d4-0003c7-5P
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 04:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWJJCpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 22:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWJJCpu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 22:45:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42588 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751990AbWJJCpt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 22:45:49 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6W00ACGFOCLY10@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Oct 2006 22:45:49 -0400 (EDT)
In-reply-to: <7vodsotqqd.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28597>

On Sat, 7 Oct 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > This patch does 3 things:
> >...
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> >
> > ---
> >
> > I'm far from a Perl expert.  I just hope that Perl gurus out there won't 
> > throw up too badly.
> >
> > With this it is possible to have nice statistics quickly, and 
> > demonstrate that Junio is really our King.  ;-)
> 
> I only talk passable Perl but I did not find much objectionable
> stuff there.  But I am not sure how this is useful aside from
> stroking your own ego.

While stroking your own ego might sometimes be a good thing (hackers 
are in it for free because they have some pride back), I think it is 
most interesting for the pure statistic values.  It is often nice to 
know who the main contributors are and by what margin, or to have a look 
at the contribution spectrum to have a feel of participation to a given 
project.

Linus recently wanted to know the opinion of an arbitrary number of top 
developers to the Linux kernel.  He used a criteria to determine who 
those developers were which was based on amount of sign-off lines, but 
the number of pure contribution is otherwise the metric that most 
projects are likely to be interested in.

Oh, and BitKeeper had that feature.

> Also I get the following.
> 
> $ git log --pretty=short v1.4.2..abd6970 |
>   perl ./git-shortlog.perl -n -s >/dev/null
> parse error: input records != output records

Please find new patch below (only one line added) with that issue fixed.

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
index 0b14f83..334fec7 100755
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
@@ -38,16 +50,38 @@ sub by_name($$) {
 
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
+		$n_output += $num;
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
@@ -152,7 +186,7 @@ sub finalize {
 
 &setup_mailmap;
 &changelog_input;
-&shortlog_output;
+$opt_s ? &summary_output : &shortlog_output;
 &finalize;
 exit(0);
 
