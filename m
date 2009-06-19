From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2] gitweb: gravatar support
Date: Fri, 19 Jun 2009 20:21:10 +0200
Message-ID: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 20:21:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHiiP-0007nM-IH
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 20:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbZFSSVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 14:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbZFSSVI
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 14:21:08 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:38533 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZFSSVH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 14:21:07 -0400
Received: by fxm8 with SMTP id 8so251205fxm.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=UlOwt5H7cpnYMDOoG1YEd57JpSpCkakp/s/GLE3q0QU=;
        b=xM9MBME8NHLuwOo9yPq7kpAcax26aBaczCqfdfKSgqoAkdvsmjg36oLbukyYBdaMqU
         pQp4Ych3f1oHmcSFGWRhPBWxtmWNSps4xNc7odc4e+r85nkAauEoKRsAcdXtAfY/AmTS
         tS0GgexU0+dto8+XnJMmJqyJslGBwQ9qa++x8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VJYUGZu2xNOgqNYzcoxvdByn7xfRfZ4ugIi6poBSV4IpjW4ytfgSsvGhruaHGBzrHH
         DA+UGQTozPkLlSRVyT17XFUk04GRfMX/Wib4MOY6vHE//pMMVKrU6tnhCSzO0OLhRIvb
         7RCrTbNXA/8PntygghSTxk31GH/zkbRZsRB1w=
Received: by 10.103.224.2 with SMTP id b2mr2057598mur.30.1245435669356;
        Fri, 19 Jun 2009 11:21:09 -0700 (PDT)
Received: from localhost (host-78-13-51-234.cust-adsl.tiscali.it [78.13.51.234])
        by mx.google.com with ESMTPS id s11sm8237507mue.11.2009.06.19.11.21.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 11:21:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121903>

Introduce gravatar support by adding the appropriate img tag next to
author and committer in commit, shortlog and log view.

The feature is disabled by default, and depends on Digest::MD5, which
is available in most Perl installations.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |   51 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 48 insertions(+), 7 deletions(-)

Changes from the previous version include gravatar use in history view,
CSS use and the possibility to override the feature on a per-project basis.

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index a01eac8..ca716e6 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -28,6 +28,10 @@ img.logo {
 	border-width: 0px;
 }
 
+img.gravatar {
+	vertical-align:middle;
+}
+
 div.page_header {
 	height: 25px;
 	padding: 8px;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1e7e2d8..c06356b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -365,6 +365,21 @@ our %feature = (
 		'sub' => \&feature_patches,
 		'override' => 0,
 		'default' => [16]},
+
+	# Gravatar support. When this feature is enabled, views such as
+	# shortlog or commit will display the gravatar associated with
+	# the email of the committer(s) and/or author(s). Please note that
+	# the feature depends on Digest::MD5.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'gravatar'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'gravatar'}{'override'} = 1;
+	# and in project config gitweb.gravatar = 0|1;
+	'gravatar' => {
+		'sub' => sub { feature_bool('gravatar', @_) },
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -814,6 +829,10 @@ $git_dir = "$projectroot/$project" if $project;
 our @snapshot_fmts = gitweb_get_feature('snapshot');
 @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
+# check if gravatars are enabled and dependencies are satisfied
+our $git_gravatar_enabled = gitweb_check_feature('gravatar') &&
+	(eval { use Digest::MD5 qw(md5_hex); 1; });
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -3214,11 +3233,26 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+# insert a gravatar for the given $email at the given $size if the feature
+# is enabled
+sub git_get_gravatar {
+	if ($git_gravatar_enabled) {
+		my ($email, $size, $whitespace) = @_;
+		$whitespace = 0 unless defined($whitespace);
+		$size = 32 if (!defined($size) || $size <= 0);
+		return "<img class=\"gravatar\" src=\"http://www.gravatar.com/avatar.php?gravatar_id=" .
+		       md5_hex(lc $email) . "&amp;size=$size\" />" . ($whitespace ? "&nbsp;" : "");
+	} else {
+		return "";
+	}
+}
+
 sub git_print_authorship {
 	my $co = shift;
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<div class=\"author_date\">" .
+	      git_get_gravatar($co->{'author_email'}, 16, 1) .
 	      esc_html($co->{'author_name'}) .
 	      " [$ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
@@ -4145,7 +4179,7 @@ sub git_shortlog_body {
 		my $author = chop_and_escape_str($co{'author_name'}, 10);
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
+		      "<td>" . git_get_gravatar($co{'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
 		      "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
@@ -4196,7 +4230,7 @@ sub git_history_body {
 	# shortlog uses      chop_str($co{'author_name'}, 10)
 		my $author = chop_and_escape_str($co{'author_name'}, 15, 3);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
+		      "<td>" . git_get_gravatar($co{'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
 		      "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
 		print format_subject_html($co{'title'}, $co{'title_short'},
@@ -4352,7 +4386,7 @@ sub git_search_grep_body {
 		$alternate ^= 1;
 		my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
+		      "<td>" . git_get_gravatar($co{'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
 		               -class => "list subject"},
@@ -5095,8 +5129,9 @@ sub git_log {
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
 		      "<br/>\n" .
 		      "</div>\n" .
-		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
-		      "</div>\n";
+		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i>&nbsp;" .
+		      git_get_gravatar($co{'author_email'}, 16) .
+		      "<br/>\n</div>\n";
 
 		print "<div class=\"log_body\">\n";
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
@@ -5183,7 +5218,8 @@ sub git_commit {
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n";
-	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
+	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_gravatar($co{'author_email'}) . "</td></tr>\n" .
 	      "<tr>" .
 	      "<td></td><td> $ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
@@ -5195,7 +5231,8 @@ sub git_commit {
 	}
 	print "</td>" .
 	      "</tr>\n";
-	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
+	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_gravatar($co{'committer_email'}) . "</td></tr>\n";
 	print "<tr><td></td><td> $cd{'rfc2822'}" .
 	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
 	      "</td></tr>\n";
-- 
1.6.3.rc1.192.gdbfcb
