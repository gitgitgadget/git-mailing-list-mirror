From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/4] gitweb: Divide page path into directories -- path's "breadcrumbs"
Date: Mon, 4 Sep 2006 18:17:58 +0200
Message-ID: <200609041817.59054.jnareb@gmail.com>
References: <200609041810.09838.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 04 18:37:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKHRb-0002bY-Co
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 18:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWIDQg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 12:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWIDQg5
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 12:36:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:6629 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751472AbWIDQg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 12:36:56 -0400
Received: by nz-out-0102.google.com with SMTP id n1so855128nzf
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 09:36:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FPUdajsHOMPVYaHxKMJjWnO7jkIe0npC1RBsAmiQb/i86qAzQmN5LDF9mUzybVgs9Li+XDaJ8XuvXFhG9TCkAkriV0wVsjxhwAafa0EIp210K300zT7ImdfYaCV4qWtWLOIVIsb2uVcQQ3Fh3fCPEFlIA1t+cJmwaRd280wTEsY=
Received: by 10.65.176.7 with SMTP id d7mr3496530qbp;
        Mon, 04 Sep 2006 09:36:55 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id c5sm3859928qbc.2006.09.04.09.36.54;
        Mon, 04 Sep 2006 09:36:55 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609041810.09838.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26424>

Divide page path into directories, so that each part of path links to
the "tree" view of the $hash_base (or HEAD, if $hash_base is not set)
version of the directory.

If the entity is blob, final part (basename) links to $hash_base or
HEAD revision of the "raw" blob ("blob_plain" view).  If the entity is
tree, link to the "tree" view.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3b5c0e2..4240a30 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1375,19 +1375,32 @@ sub git_print_page_path {
 
 	if (!defined $name) {
 		print "<div class=\"page_path\">/</div>\n";
-	} elsif (defined $type && $type eq 'blob') {
+	} else {
+		my @dirname = split '/', $name;
+		my $basename = pop @dirname;
+		my $fullname = '';
+
 		print "<div class=\"page_path\">";
-		if (defined $hb) {
+		foreach my $dir (@dirname) {
+			$fullname .= $dir . '/';
+			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
+			                             hash_base=>$hb),
+			              -title => $fullname}, esc_html($dir));
+			print "/";
+		}
+		if (defined $type && $type eq 'blob') {
 			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
-			                             hash_base=>$hb)},
-			              esc_html($name));
+			                             hash_base=>$hb),
+			              -title => $name}, esc_html($basename));
+		} elsif (defined $type && $type eq 'tree') {
+			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
+			                             hash_base=>$hb),
+			              -title => $name}, esc_html($basename));
+			print "/";
 		} else {
-			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name)},
-			              esc_html($name));
+			print esc_html($basename);
 		}
 		print "<br/></div>\n";
-	} else {
-		print "<div class=\"page_path\">" . esc_html($name) . "<br/></div>\n";
 	}
 }
 
-- 
1.4.1.1
