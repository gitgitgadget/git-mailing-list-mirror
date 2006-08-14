From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/9] gitweb: Separate finding project owner into git_get_project_owner
Date: Mon, 14 Aug 2006 02:10:06 +0200
Message-ID: <200608140210.06961.jnareb@gmail.com>
References: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:17:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZV9-0001tP-Ma
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWHNKQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWHNKQn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:24460 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751976AbWHNKQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:39 -0400
Received: by nf-out-0910.google.com with SMTP id a4so20978nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X1r4myxzYfXG1qqg8DNMNk1JBSMnD+GRi0VHBgko/YWJdvxD2w7e3T3H1xq6VF1IfxqDb0wLApVesMaOXFRlHjWNz8XdExykQ32BpJvMhwAR8lGScvKOuBpJERtWIRODL5D0ibFT2WzElCK/juxbkr/Qeq656mafE/PTyvzaNxk=
Received: by 10.48.230.18 with SMTP id c18mr1023622nfh;
        Mon, 14 Aug 2006 03:16:39 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.39;
        Mon, 14 Aug 2006 03:16:39 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608140202.46160.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25340>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
And added some comments, while at it.

 gitweb/gitweb.perl |   50 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5af6e77..6be6c55 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -527,6 +527,37 @@ sub git_get_projects_list {
 	return @list;
 }
 
+sub git_get_project_owner {
+	my $project = shift;
+	my $owner;
+
+	return undef unless $project;
+
+	# read from file (url-encoded):
+	# 'git%2Fgit.git Linus+Torvalds'
+	# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
+	# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
+	if (-f $projects_list) {
+		open (my $fd , $projects_list);
+		while (my $line = <$fd>) {
+			chomp $line;
+			my ($pr, $ow) = split ' ', $line;
+			$pr = unescape($pr);
+			$ow = unescape($ow);
+			if ($pr eq $project) {
+				$owner = decode("utf8", $ow, Encode::FB_DEFAULT);
+				last;
+			}
+		}
+		close $fd;
+	}
+	if (!defined $owner) {
+		$owner = get_file_owner("$projectroot/$project");
+	}
+
+	return $owner;
+}
+
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
@@ -1458,24 +1489,7 @@ sub git_summary {
 	my %co = parse_commit($head);
 	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
-	my $owner;
-	if (-f $projects_list) {
-		open (my $fd , $projects_list);
-		while (my $line = <$fd>) {
-			chomp $line;
-			my ($pr, $ow) = split ' ', $line;
-			$pr = unescape($pr);
-			$ow = unescape($ow);
-			if ($pr eq $project) {
-				$owner = decode("utf8", $ow, Encode::FB_DEFAULT);
-				last;
-			}
-		}
-		close $fd;
-	}
-	if (!defined $owner) {
-		$owner = get_file_owner("$projectroot/$project");
-	}
+	my $owner = git_get_project_owner($project);
 
 	my $refs = git_get_references();
 	git_header_html();
-- 
1.4.1.1
