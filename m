From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 3/3] gitweb.cgi: git_blame2: Revision blocks now have alternating colors
Date: Sun, 23 Jul 2006 13:37:53 -0700 (PDT)
Message-ID: <20060723203753.60963.qmail@web31814.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1313228900-1153687073=:59137"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 23 22:37:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4ki4-00036H-Op
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 22:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWGWUhy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 16:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWGWUhy
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 16:37:54 -0400
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:48244 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751307AbWGWUhx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 16:37:53 -0400
Received: (qmail 60965 invoked by uid 60001); 23 Jul 2006 20:37:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Y3dQZIuykShBFYgZWkDFI1/kCMadLIEWgdev71lrZoEr80z/5Psa5B9M08uHwF+4Zan3J9nwyO/UfvOCtSBMun32NX4Ym9DRO2jQNt6myBL/JbZvJDc+pqBnH70G4sGRTI1vT6ZEmsTrNKcYsgcdrBjvY80dZ+A83pg4wIbaXKU=  ;
Received: from [71.80.232.189] by web31814.mail.mud.yahoo.com via HTTP; Sun, 23 Jul 2006 13:37:53 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24106>

--0-1313228900-1153687073=:59137
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

A revision block is the largest number of adjacent
lines of code originating from the same revision.

This patch adds color to git_blame2(), in that no two
adjacent revision blocks have the same color.  The color
alternates between light and dark.

As we annotate the code lines, we alternate the color
(light, dark) of code lines _per revision_.  This makes it
easier to see line conglomerations per revision.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)
--0-1313228900-1153687073=:59137
Content-Type: text/inline; name="p3.patch"
Content-Description: 963471848-p3.patch
Content-Disposition: name="p3.patch"; filename="p3.patch"

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 2c2d9c8..16340f2 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1295,9 +1295,11 @@ sub git_blame2 {
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
 		"</div>\n";
 	git_print_page_path($file_name, $ftype);
-
+	my @rev_color = (qw(light dark));
+	my $num_colors = scalar(@rev_color);
+	my $current_color = 0;
+	my $last_rev;
 	print "<div class=\"page_body\">\n";
-
 	print "<table class=\"blame\">\n";
 	print "<tr><th>Commit</th><th>Line</th><th>Data</th></tr>\n";
 	while (my $line = <$fd>) {
@@ -1307,7 +1309,13 @@ sub git_blame2 {
 		my $lineno = $blame_line{'lineno'};
 		my $data = $blame_line{'data'};
 
-		print "<tr>\n";
+		if (!defined $last_rev) {
+			$last_rev = $full_rev;
+		} elsif ($last_rev ne $full_rev) {
+			$last_rev = $full_rev;
+			$current_color = ++$current_color % $num_colors;
+		}
+		print "<tr class=\"$rev_color[$current_color]\">\n";
 		print "<td class=\"sha1\">" .
 			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$full_rev;f=$file_name")}, esc_html($rev)) . "</td>\n";
 		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" . esc_html($lineno) . "</a></td>\n";
@@ -1316,8 +1324,6 @@ sub git_blame2 {
 	}
 	print "</table>\n";
 	print "</div>";
-
 	close $fd or print "Reading blob failed\n";
 	git_footer_html();
 }
-- 
1.4.2.rc1.g9b54


--0-1313228900-1153687073=:59137--
