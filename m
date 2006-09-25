From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] svnimport add support for parsing From lines for author
Date: Mon, 25 Sep 2006 12:08:13 +0100
Message-ID: <20060925110813.GA4419@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 13:09:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRoKH-0000o0-Mx
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 13:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWIYLIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 07:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWIYLIh
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 07:08:37 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:37001
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751133AbWIYLIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 07:08:36 -0400
Received: from apw by localhost.localdomain with local (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1GRoJp-00019M-JB; Mon, 25 Sep 2006 12:08:13 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27733>

svnimport: add support for parsing From: lines for author

When commiting a non-signed off contribution you cannot just add
a Signed-off-by: from the author as they did not sign it off.
But if you then commit it, and necessarily sign it off yourself,
the change appears to be yours.  In this case it is common to use
the following form:

	Commentry

	From: originator <email>
	Signed-of-by: me <my email>

Now that we have support for parsing Signed-off-by: for author
information it makes sense to handle From: as well.  This patch
adds a new -F which will handle From: lines in the comments.  It
may be used in combination with -S.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/git-svnimport.perl b/git-svnimport.perl
index ed62897..988514e 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -31,7 +31,7 @@ die "Need SVN:Core 1.2.1 or better" if $
 $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
-    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S);
+    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F);
 
 sub usage() {
 	print STDERR <<END;
@@ -39,12 +39,12 @@ Usage: ${\basename $0}     # fetch/updat
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-       [-m] [-M regex] [-A author_file] [-S] [SVN_URL]
+       [-m] [-M regex] [-A author_file] [-S] [-F] [SVN_URL]
 END
 	exit(1);
 }
 
-getopts("A:b:C:dDhiI:l:mM:o:rs:t:T:Suv") or usage();
+getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:Suv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
@@ -548,8 +548,12 @@ sub commit {
 		$committer_name = $committer_email = $author;
 	}
 
-	if ($opt_S && $message =~ /Signed-off-by:\s+(.*?)\s+<(.*)>\s*\n/) {
+	if ($opt_F && $message =~ /From:\s+(.*?)\s+<(.*)>\s*\n/) {
 		($author_name, $author_email) = ($1, $2);
+		print "Author from From: $1 <$2>\n" if ($opt_v);;
+	} elsif ($opt_S && $message =~ /Signed-off-by:\s+(.*?)\s+<(.*)>\s*\n/) {
+		($author_name, $author_email) = ($1, $2);
+		print "Author from Signed-off-by: $1 <$2>\n" if ($opt_v);;
 	} else {
 		$author_name = $committer_name;
 		$author_email = $committer_email;
