From: Junio C Hamano <junkio@cox.net>
Subject: There can be more than two levels of subdirectories
Date: Mon, 31 Jul 2006 19:18:34 -0700
Message-ID: <7vac6p42rp.fsf_-_@assigned-by-dhcp.cox.net>
References: <200607292239.11034.jnareb@gmail.com>
	<200607311833.39524.jnareb@gmail.com>
	<7v3bch7gf8.fsf@assigned-by-dhcp.cox.net> <ealk0e$to2$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 04:18:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7jqB-0005Nr-I3
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 04:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWHACSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 22:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWHACSg
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 22:18:36 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:47564 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750867AbWHACSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 22:18:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801021835.TDYK6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 22:18:35 -0400
To: jnareb@gmail.com
In-Reply-To: <ealk0e$to2$2@sea.gmane.org> (Jakub Narebski's message of "Mon,
	31 Jul 2006 21:00:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24566>

Earlier code to read .git/refs/{tags,heads} hierarchy had a
hardcoded up-to-two-level assumption.  Lift it by using
File::Find.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 4e79390..902b96a 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -14,6 +14,7 @@ use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser);
 use Encode;
 use Fcntl ':mode';
+use File::Find qw();
 binmode STDOUT, ':utf8';
 
 our $cgi = new CGI;
@@ -697,23 +698,14 @@ sub git_read_refs {
 	my @reflist;
 
 	my @refs;
-	opendir my $dh, "$projectroot/$project/$ref_dir";
-	while (my $dir = readdir($dh)) {
-		if ($dir =~ m/^\./) {
-			next;
-		}
-		if (-d "$projectroot/$project/$ref_dir/$dir") {
-			opendir my $dh2, "$projectroot/$project/$ref_dir/$dir";
-			my @subdirs = grep !m/^\./, readdir $dh2;
-			closedir($dh2);
-			foreach my $subdir (@subdirs) {
-				push @refs, "$dir/$subdir"
-			}
-			next;
+	my $pfxlen = length("$projectroot/$project/$ref_dir");
+	File::Find::find(sub {
+		return if (/^\./);
+		if (-f $_) {
+			push @refs, substr($File::Find::name, $pfxlen + 1);
 		}
-		push @refs, $dir;
-	}
-	closedir($dh);
+	}, "$projectroot/$project/$ref_dir");
+
 	foreach my $ref_file (@refs) {
 		my $ref_id = git_read_hash("$project/$ref_dir/$ref_file");
 		my $type = git_get_type($ref_id) || next;
