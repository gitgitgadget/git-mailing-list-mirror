From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: complete the cvsps run before starting the import
Date: Tue, 30 May 2006 20:08:50 +1200
Message-ID: <11489765301990-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue May 30 10:03:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkzBt-0006Jc-G5
	for gcvg-git@gmane.org; Tue, 30 May 2006 10:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWE3ICr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 04:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWE3ICr
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 04:02:47 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:13775 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932183AbWE3ICq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 04:02:46 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1FkzBb-000691-DN; Tue, 30 May 2006 20:02:43 +1200
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1FkzHW-0000i7-00; Tue, 30 May 2006 20:08:50 +1200
To: junio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g5498
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21021>

On 5/24/06, Linus Torvalds <torvalds@osdl.org> wrote:
> It's entirely possible that the fact that it now seems to work for me is
> purely timing-related, since I also ended up using "-P cvsps-output" to
> avoid having a huge cvsps binary in memory at the same time.

We now capture the output of cvsps to a tempfile, and then read it in.
cvsps 2.1 works quite a bit "in memory", and only prints its patchset info
once it has finished talking with cvs, but apparently retaining all that
memory allocation. With this patch, cvsps is finished and reaped before
cvsimport start working (and growing). So the footprint of the whole
process is much lower.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---

I don't particularly like the idea of switching from a safe system() call
to this ugly one. But this patch makes a huge difference importing gentoo's
repo, and I could not find a way to get system() to do redirection.

Of course, we could do the redirection in Perl. Ugly vs uglier?

---

 git-cvsimport.perl |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)

5ce458e0883f39ae774ec67211e6565b65139b7f
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 60fc86a..2239c67 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -529,24 +529,36 @@ if ($opt_A) {
 	write_author_info("$git_dir/cvs-authors");
 }
 
-my $pid = open(CVS,"-|");
-die "Cannot fork: $!\n" unless defined $pid;
-unless($pid) {
+#
+# run cvsps into a file unless it's provided already
+#
+my $cvspsfile;
+if ($opt_P) {
+       $cvspsfile = $opt_P;
+} else {
+	my $cvspsfh;
+	($cvspsfh, $cvspsfile) = tempfile('gitXXXXXX', SUFFIX => '.cvsps',
+					  DIR => File::Spec->tmpdir());
+	close ($cvspsfh);
+	my ($cvspserrfh, $cvspserr)  = tempfile('gitXXXXXX', SUFFIX => '.err',
+						DIR => File::Spec->tmpdir());
+	close ($cvspserrfh);
+
 	my @opt;
 	@opt = split(/,/,$opt_p) if defined $opt_p;
 	unshift @opt, '-z', $opt_z if defined $opt_z;
-	unshift @opt, '-q'         unless defined $opt_v;
+	unshift @opt, '-q'	   unless defined $opt_v;
 	unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
 		push @opt, '--cvs-direct';
 	}
-	if ($opt_P) {
-	    exec("cat", $opt_P);
-	} else {
-	    exec("cvsps","--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
-	    die "Could not start cvsps: $!\n";
-	}
+
+	print "Running cvsps\n"		  if $opt_v;
+	system(join(' ', "cvsps","--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree, "1>$cvspsfile" ))
+		or die "Error in cvsps: $!\n";
 }
 
+open (CVS, "<$cvspsfile") 
+        or die "Cannot open cvsps output file $cvspsfile: $!\n";
 
 ## cvsps output:
 #---------------------
-- 
1.3.2.g82000
