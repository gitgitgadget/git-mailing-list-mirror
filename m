From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach git-remote add to fetch and track
Date: Thu, 01 Feb 2007 23:30:03 -0800
Message-ID: <7v1wl9j9tw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 08:30:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCssF-0007Fi-8A
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 08:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423192AbXBBHaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 02:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423194AbXBBHaH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 02:30:07 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:39913 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423192AbXBBHaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 02:30:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202073004.ZHRK1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Feb 2007 02:30:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JXW31W00X1kojtg0000000; Fri, 02 Feb 2007 02:30:04 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38470>

This adds three options to 'git-remote add'.

 * -f (or --fetch) option tells it to also run the initial "git
    fetch" using the newly created remote shorthand.

 * -t (or --track) option tells it not to use the default
    wildcard to track all branches.

 * -m (or --master) option tells it to make the
    remote/$name/HEAD point at a remote tracking branch other
    than master.

For example, with this I can say:

  $ git remote add -f -t master -t quick-start -m master \
    jbf-um git://linux-nfs.org/~bfields/git.git/

to

 (1) create remote.jbf-um.url;

 (2) track master and quick-start branches (and no other); the
     two -t options create these two lines:

       fetch = +refs/heads/master:refs/remotes/jbf-um/master
       fetch = +refs/heads/quick-start:refs/remotes/jbf-um/quick-start

 (3) set up remotes/jbf-um/HEAD to point at jbf-um/master so
     that later I can say "git log jbf-um"

Or I could do

  $ git remote add -t 'ap/*' andy /home/andy/git.git

to make Andy's topic branches kept track of under refs/remotes/andy/ap/.

Other possible improvements I considered but haven't implemented
(hint, hint) are:

 * reject wildcard letters other than a trailing '*' to the -t
   parameter;

 * make -m optional and when the first -t parameter does not
   have the trailing '*' default to that value (so the above
   example does not need to say "-m master");

 * if -m is not given, and -t parameter ends with '*' (i.e. the
   above defaulting did not tell us where to point HEAD at), and
   if we did the fetch with -f, check if 'master' was fetched
   and make HEAD point at it.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 git-remote.perl |   54 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index f16ff21..c56c5a8 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -253,14 +253,30 @@ sub show_remote {
 }
 
 sub add_remote {
-	my ($name, $url) = @_;
+	my ($name, $url, $opts) = @_;
 	if (exists $remote->{$name}) {
 		print STDERR "remote $name already exists.\n";
 		exit(1);
 	}
 	$git->command('config', "remote.$name.url", $url);
-	$git->command('config', "remote.$name.fetch",
-		      "+refs/heads/*:refs/remotes/$name/*");
+	my $track = $opts->{'track'} || ["*"];
+
+	for (@$track) {
+		$git->command('config', '--add', "remote.$name.fetch",
+			      "+refs/heads/$_:refs/remotes/$name/$_");
+	}
+	if ($opts->{'fetch'}) {
+		$git->command('fetch', $name);
+	}
+	if (exists $opts->{'master'}) {
+		$git->command('symbolic-ref', "refs/remotes/$name/HEAD",
+			      "refs/remotes/$name/$opts->{'master'}");
+	}
+}
+
+sub add_usage {
+	print STDERR "Usage: git remote add [-f] [-t track]* [-m master] <name> <url>\n";
+	exit(1);
 }
 
 if (!@ARGV) {
@@ -307,11 +323,37 @@ elsif ($ARGV[0] eq 'prune') {
 	}
 }
 elsif ($ARGV[0] eq 'add') {
+	my %opts = ();
+	while (1 < @ARGV && $ARGV[1] =~ /^-/) {
+		my $opt = $ARGV[1];
+		shift @ARGV;
+		if ($opt eq '-f' || $opt eq '--fetch') {
+			$opts{'fetch'} = 1;
+			next;
+		}
+		if ($opt eq '-t' || $opt eq '--track') {
+			if (@ARGV < 1) {
+				add_usage();
+			}
+			$opts{'track'} ||= [];
+			push @{$opts{'track'}}, $ARGV[1];
+			shift @ARGV;
+			next;
+		}
+		if ($opt eq '-m' || $opt eq '--master') {
+			if ((@ARGV < 1) || exists $opts{'master'}) {
+				add_usage();
+			}
+			$opts{'master'} = $ARGV[1];
+			shift @ARGV;
+			next;
+		}
+		add_usage();
+	}
 	if (@ARGV != 3) {
-		print STDERR "Usage: git remote add <name> <url>\n";
-		exit(1);
+		add_usage();
 	}
-	add_remote($ARGV[1], $ARGV[2]);
+	add_remote($ARGV[1], $ARGV[2], \%opts);
 }
 else {
 	print STDERR "Usage: git remote\n";
