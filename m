From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: introduce _fetchfile() method and used a 1M buffer to read()
Date: Tue, 23 May 2006 20:08:58 +1200
Message-ID: <11483717381774-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue May 23 10:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiRri-0004dM-Sn
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWEWIDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWEWIDj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:03:39 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:14212 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751316AbWEWIDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 04:03:38 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1FiRrc-00068z-1I; Tue, 23 May 2006 20:03:36 +1200
Received: from mltest ([127.0.0.1] helo=localhost.localdomain)
	by mltest with esmtp (Exim 3.36 #1 (Debian))
	id 1FiRwq-0000nj-00; Tue, 23 May 2006 20:09:00 +1200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0.g9927-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20573>

File retrieval from the socket is now moved to _fetchfile() and we now
cap reads at 1MB. This should limit the memory growth of the cvsimport
process.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---

 git-cvsimport.perl |   36 +++++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 17 deletions(-)

c06eea55b2b061abe6c09fa0737d6bb87afa9d39
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 5b68671..ace7087 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -315,15 +315,7 @@ sub _line {
 			chomp $cnt;
 			die "Duh: Filesize $cnt" if $cnt !~ /^\d+$/;
 			$line="";
-			$res=0;
-			while($cnt) {
-				my $buf;
-				my $num = $self->{'socketi'}->read($buf,$cnt);
-				die "Server: Filesize $cnt: $num: $!\n" if not defined $num or $num<=0;
-				print $fh $buf;
-				$res += $num;
-				$cnt -= $num;
-			}
+			$res = $self->_fetchfile($fh, $cnt);
 		} elsif($line =~ s/^ //) {
 			print $fh $line;
 			$res += length($line);
@@ -335,14 +327,7 @@ sub _line {
 			chomp $cnt;
 			die "Duh: Mbinary $cnt" if $cnt !~ /^\d+$/ or $cnt<1;
 			$line="";
-			while($cnt) {
-				my $buf;
-				my $num = $self->{'socketi'}->read($buf,$cnt);
-				die "S: Mbinary $cnt: $num: $!\n" if not defined $num or $num<=0;
-				print $fh $buf;
-				$res += $num;
-				$cnt -= $num;
-			}
+			$res += $self->_fetchfile($fh, $cnt);
 		} else {
 			chomp $line;
 			if($line eq "ok") {
@@ -384,6 +369,23 @@ sub file {
 
 	return ($name, $res);
 }
+sub _fetchfile {
+	my ($self, $fh, $cnt) = @_;
+	my $res;
+	my $bufsize = 1024 * 1024;
+	while($cnt) {
+	    if ($bufsize > $cnt) {
+		$bufsize = $cnt;
+	    }
+	    my $buf;      
+	    my $num = $self->{'socketi'}->read($buf,$bufsize);
+	    die "Server: Filesize $cnt: $num: $!\n" if not defined $num or $num<=0;
+	    print $fh $buf;
+	    $res += $num;
+	    $cnt -= $num;
+	}
+	return $res;
+}
 
 
 package main;
-- 
1.3.2.g82000
