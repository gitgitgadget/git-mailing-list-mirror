From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 1/3] gitweb.cgi: git_blame2: an alternative simple working git blame
Date: Sun, 23 Jul 2006 13:34:55 -0700 (PDT)
Message-ID: <20060723203455.95803.qmail@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-756410663-1153686895=:95183"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 23 22:35:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4kfD-00022D-CJ
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 22:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWGWUe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 16:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWGWUe4
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 16:34:56 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:38232 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751305AbWGWUe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 16:34:56 -0400
Received: (qmail 95805 invoked by uid 60001); 23 Jul 2006 20:34:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=juRMm0ztAXj5kE06zFJwQO8vIkJ+n56sanwvZvphcD0dg7nBwFjBPKNSJFGL2P/h6nKuCllLBIPueyoo0rDJnW5jKGbVjQfevD72B5BI5/vnW+jfXU891NHSYluVSMyxZmtJ6qC2O7T50sSabHONoU3zCrxUTmipHjjpjVOGEFk=  ;
Received: from [71.80.232.189] by web31805.mail.mud.yahoo.com via HTTP; Sun, 23 Jul 2006 13:34:55 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24104>

--0-756410663-1153686895=:95183
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This patch adds an alternative simple working git-blame
called git_blame2().  Simple, because it displays just
three columns: the commit, the line number and the line
of code.  Alternative, because the original git_blame()
is left untouched.  Lines of code are printed html
escaped, but as-is.

git_blame2() uses git-blame as opposed to git-annotate
used by git_blame().

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 70 insertions(+), 1 deletions(-)
--0-756410663-1153686895=:95183
Content-Type: text/inline; name="p1.patch"
Content-Description: 2795696785-p1.patch
Content-Disposition: name="p1.patch"; filename="p1.patch"

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 4106cb8..57f4a2e 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -227,7 +227,7 @@ if (!defined $action || $action eq "summ
 	git_tag();
 	exit;
 } elsif ($action eq "blame") {
-	git_blame();
+	git_blame2();
 	exit;
 } else {
 	undef $action;
@@ -1252,7 +1252,75 @@ sub git_tag {
 	git_footer_html();
 }
 
+sub git_read_blame_line {
+	my %bl;
+	$_ = shift;
+
+	($bl{'hash'}, $bl{'lineno'}, $bl{'data'}) = /^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
+
+	return %bl;
+}
+
+sub git_blame2 {
+	my $fd;
+	my $ftype;
+	die_error(undef, "Permission denied.") if (!git_get_project_config_bool ('blame'));
+	die_error('404 Not Found', "File name not defined") if (!$file_name);
+	$hash_base ||= git_read_head($project);
+	die_error(undef, "Reading commit failed") unless ($hash_base);
+	my %co = git_read_commit($hash_base)
+		or die_error(undef, "Reading commit failed");
+	if (!defined $hash) {
+		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
+			or die_error(undef, "Error looking up file");
+	}
+	$ftype = git_get_type($hash);
+	if ($ftype !~ "blob") {
+		die_error("400 Bad Request", "object is not a blob");
+	}
+	open ($fd, "-|", $GIT, "blame", '-l', $file_name, $hash_base)
+		or die_error(undef, "Open failed");
+	git_header_html();
+	print "<div class=\"page_nav\">\n" .
+		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, "summary") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "shortlog") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log")}, "log") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base")}, "commit") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash_base")}, "commitdiff") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") . "<br/>\n";
+	print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
+		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head") . "<br/>\n";
+	print "</div>\n".
+		"<div>" .
+		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) .
+		"</div>\n";
+	git_print_page_path($file_name, $ftype);
+
+	print "<div class=\"page_body\">\n";
+
+	print "<table class=\"blame\">\n";
+	print "<tr><th>Commit</th><th>Line</th><th>Data</th></tr>\n";
+	while (my $line = <$fd>) {
+		my %blame_line = git_read_blame_line($line);
+		my $full_rev = $blame_line{'hash'};
+		my $rev = substr($full_rev, 0, 8);
+		my $lineno = $blame_line{'lineno'};
+		my $data = $blame_line{'data'};
+
+		print "<tr>\n";
+		print "<td class=\"sha1\">" .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$full_rev;f=$file_name")}, esc_html($rev)) . "</td>\n";
+		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" . esc_html($lineno) . "</a></td>\n";
+		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
+		print "</tr>\n";
+	}
+	print "</table>\n";
+	print "</div>";
+
+	close $fd or print "Reading blob failed\n";
+	git_footer_html();
+}
+
 sub git_blame {
 	my $fd;
 	die_error('403 Permission denied', "Permission denied.") if (!git_get_project_config_bool ('blame'));
-- 
1.4.2.rc1.g9b54


--0-756410663-1153686895=:95183--
