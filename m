From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Thu, 27 Oct 2005 16:39:45 -0400
Message-ID: <20051027203945.GC1622@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 27 22:40:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVEXO-0002OU-UO
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 22:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVJ0Ujr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 16:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVJ0Ujr
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 16:39:47 -0400
Received: from eastrmmtao05.cox.net ([68.230.240.34]:29824 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932220AbVJ0Ujq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 16:39:46 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027203942.ULUZ28234.eastrmmtao05.cox.net@localhost>
          for <git@vger.kernel.org>; Thu, 27 Oct 2005 16:39:42 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVEXJ-0001A2-IE
	for git@vger.kernel.org; Thu, 27 Oct 2005 16:39:45 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10726>


I really like gitweb (thanks Kay!), but I thought it would be nice to
have a visual indication of patch size.  I found this helpful when
scanning though the shortlogs.

To see what it looks like with the gitweb for gitweb (meta-gitweb?)
goto:

http://www.codesifter.com/cgi-bin/gitweb.cgi?p=gitweb.git;a=shortlog

I rather like the look of what I've hacked up (the enclosed patch),
but it should be considered as just a prototype: it only affects the
shortlog, it's horribly inefficient, and I don't really do perl.  :)

If anyone thinks this is a good feature, then please tell me an
efficient way to get some heuristic of the patch size.

Right now, I'm using: 

GIT_DIFF_OPTS='-U 0' $gitbin/git-diff-tree -p $hash | wc -l

which is pretty slow.  Any suggestions?

-chris


Subject: [PATCH] initial hack at horizontal bars indicating patch size

---

 gitweb.cgi |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

c8d45f9a3cfdd7080a57e0de315f3ab9475f60bf
diff --git a/gitweb.cgi b/gitweb.cgi
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -53,6 +53,9 @@ if (defined $action) {
 	} elsif ($action eq "opml") {
 		git_opml();
 		exit;
+	} elsif ($action eq "bar.png") {
+	    git_bar_png();
+	    exit;
 	}
 }
 
@@ -358,6 +361,16 @@ sub git_get_type {
 	return $type;
 }
 
+sub git_get_commit_size {
+	my $hash = shift;
+
+	open my $fd, "-|", "GIT_DIFF_OPTS='-U 0' $gitbin/git-diff-tree -p $hash | wc -l" or return;
+	my $size = <$fd>;
+	close $fd or return;
+	chomp $size;
+	return $size;
+}
+
 sub git_read_hash {
 	my $path = shift;
 
@@ -719,6 +732,21 @@ sub git_logo {
 		"\x12\x1c\x9a\xfe\x00\x00\x00\x00\x49\x45\x4e\x44\xae\x42\x60\x82";
 }
 
+# git_bar_png (cached in browser for one day)
+sub git_bar_png {
+	print $cgi->header(-type => 'image/png', -expires => '+1d');
+        # cat bar.png | hexdump -e '"q" 16/1 "w%02x"  "q . \n"' | 
+        #    sed 's/w/\\x/g' | sed 's/q/"/g'
+print "\x89\x50\x4e\x47\x0d\x0a\x1a\x0a\x00\x00\x00\x0d\x49\x48\x44\x52" .
+"\x00\x00\x00\x01\x00\x00\x00\x0c\x08\x02\x00\x00\x00\x2c\xe9\x40" .
+"\x00\x00\x00\x00\x3b\x49\x44\x41\x54\x08\x1d\x01\x30\x00\xcf\xff" .
+"\x00\xba\xba\xff\x02\xf1\xf1\x00\x02\xf2\xf2\x00\x02\xf1\xf2\x00" .
+"\x02\xf2\xf1\x00\x02\xf1\xf1\x00\x02\xf2\xf1\x00\x02\xf1\xf1\x00" .
+"\x02\xf1\xf2\x00\x02\xf1\xf1\x00\x02\xf2\xf2\x00\x02\xf2\xf1\x00" .
+"\x45\x85\x17\x49\x14\x70\x67\xdb\x00\x00\x00\x00\x49\x45\x4e\x44" .
+"\xae\x42\x60\x82";
+}
+
 sub get_file_owner {
 	my $path = shift;
 
@@ -2280,8 +2308,16 @@ sub git_shortlog {
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit"}, "commit") .
 		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$commit"}, "commitdiff") .
-		      "</td>\n" .
+		      "</td>\n";
+		my $scale = 100;
+		my $stretch = 32;
+		# commits of size 1.7*$scale will be $stretch pixels wide 
+		my $size = int(log((git_get_commit_size($commit)+$scale)/$scale)*$stretch);
+		print "<td class=\"bar\">" .
+		      "<img src=\"$my_uri?a=bar.png\" width=\"$size\" height=\"12\"/>" .
+		      "</td>" .
 		      "</tr>";
+
 	}
 	if ($#revlist >= (100 * ($page+1)-1)) {
 		print "<tr>\n" .
