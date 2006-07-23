From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 2/4] gitweb.cgi: Include direct link to "raw" files from "history"
Date: Sun, 23 Jul 2006 13:28:55 -0700 (PDT)
Message-ID: <20060723202855.54712.qmail@web31811.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-804659209-1153686535=:54705"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 23 22:29:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4kZP-00089Y-Af
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 22:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWGWU24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 16:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWGWU24
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 16:28:56 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:21141 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751310AbWGWU24 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 16:28:56 -0400
Received: (qmail 54714 invoked by uid 60001); 23 Jul 2006 20:28:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QqHOiQcikdXCz6Vg2JH0yFjG1tAgYKoQSp5GI/RmWzVJ9HYZhQmXMiO5JKncZTd8+OlYFe5YtpxNBBhE4nh15MUo3bRmpPEAQT4iuHbVaI8ocb5JRmIm0G97MruvFzhvm8H80B0MN3uK0up7WyrJipLMUiFPZFxdYM3zITUrUdg=  ;
Received: from [71.80.232.189] by web31811.mail.mud.yahoo.com via HTTP; Sun, 23 Jul 2006 13:28:55 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24101>

--0-804659209-1153686535=:54705
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

In "history" view, the "page_path" is now also a URL link to
the "raw" format of the file, which will always give you
the latest version in the repository.

This is helpful for externally linking files, such that
the latest version is always referenced and in "raw" format.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |   35 +++++++++++++++++++++++++++++------
 1 files changed, 29 insertions(+), 6 deletions(-)

--0-804659209-1153686535=:54705
Content-Type: text/inline; name="p2.patch"
Content-Description: 3952834181-p2.patch
Content-Disposition: name="p2.patch"; filename="p2.patch"

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index d976d4a..7a61de4 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1531,6 +1531,14 @@ sub git_blob_plain_mimetype {
 }
 
 sub git_blob_plain {
+	if (!defined $hash) {
+                if (defined $file_name) {
+                        my $base = $hash_base || git_read_head($project);
+                        $hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
+                } else {
+                        die_error(undef, "No file name defined.");
+                }
+        }
 	my $type = shift;
 	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error("Couldn't cat $file_name, $hash");
 
@@ -1554,10 +1562,14 @@ sub git_blob_plain {
 }
 
 sub git_blob {
-	if (!defined $hash && defined $file_name) {
-		my $base = $hash_base || git_read_head($project);
-		$hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
-	}
+	if (!defined $hash) {
+                if (defined $file_name) {
+                        my $base = $hash_base || git_read_head($project);
+                        $hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
+                } else {
+                        die_error(undef, "No file name defined.");
+                }
+        }
 	my $have_blame = git_get_project_config_bool ('blame');
 	open my $fd, "-|", "$GIT cat-file blob $hash" or die_error(undef, "Open failed.");
 	my $mimetype = git_blob_plain_mimetype($fd, $file_name);
@@ -1687,7 +1699,7 @@ sub git_tree {
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$t_hash$base_key;f=$base$t_name")}, "blob") .
 #			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$t_hash$base_key;f=$base$t_name")}, "blame") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$hash_base;f=$base$t_name")}, "history") .
+			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;h=$t_hash;hb=$hash_base;f=$base$t_name")}, "history") .
 			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$t_hash;f=$base$t_name")}, "raw") .
 			      "</td>\n";
 		} elsif ($t_type eq "tree") {
@@ -2314,8 +2326,18 @@ sub git_history {
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) . "\n" .
 	      "</div>\n";
-	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
+	if (defined $hash) {
+		my $ftype = git_get_type($hash);
+
+		if ($ftype =~ "blob") {
+		    print "<div class=\"page_path\"><b>/" .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;f=$file_name")}, esc_html($file_name)) . "</b><br/></div>\n";
+		} else {
+		    print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
+		}
+	} else {
+		print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
+	}
 
 	open my $fd, "-|",
 		"$GIT rev-list --full-history $hash_base -- \'$file_name\'";
-- 
1.4.2.rc1.g9b54


--0-804659209-1153686535=:54705--
