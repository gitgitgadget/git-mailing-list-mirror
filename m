From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 1/2] gitweb: gravatar support
Date: Sun, 21 Jun 2009 19:57:04 +0200
Message-ID: <1245607025-19296-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245607025-19296-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 20:01:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIRME-0000Ir-Ag
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 20:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZFUSBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbZFUSBY
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 14:01:24 -0400
Received: from mail-fx0-f224.google.com ([209.85.220.224]:61142 "EHLO
	mail-fx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbZFUSBX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 14:01:23 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2009 14:01:22 EDT
Received: by fxm24 with SMTP id 24so215738fxm.37
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1hMb3uWU5siWW4prLDATBhxLGkRFC+9Z8pm0IIIqGeo=;
        b=VlDe2VMQBjdeC8hRbaAiVSB47YNPzaFVuXEyYzTPYYtMmCZc8TjMsh9FD0K/+7lF/u
         8UUlzaDc58VHNVh1PrILp3Fu9yQCND+eoDhAuTGxqWS+tSFcvsif9p3APoaZWw1yuR5o
         aMV2G0wqMr5VDaZYu7g0exuZpVq55dyC4Mv8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QdKSb2FMK+t17V64CBA5nQzLeuRP1eBKnyJ0uhKb7B8lF94yYZT+QBDSj5r7hGXOLW
         uMvnwmDGUeO99PWp0C3UGb/jRyOatWBj9tCJOHUsu10ngryaTqt7KoK/Ml0sTQn+fSsn
         wQejcsZYyY7XGrMXlWUzRtoNreG3j+0D9+zO8=
Received: by 10.204.66.2 with SMTP id l2mr5197123bki.177.1245606968627;
        Sun, 21 Jun 2009 10:56:08 -0700 (PDT)
Received: from localhost (host-78-15-4-45.cust-adsl.tiscali.it [78.15.4.45])
        by mx.google.com with ESMTPS id b17sm10716918fka.36.2009.06.21.10.56.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Jun 2009 10:56:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245607025-19296-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121992>

Introduce gravatar support by adding the appropriate img tag next to
author and committer in commit(diff), history, shortlog and log view.

The feature is disabled by default, and depends on Digest::MD5, which
is a core package since Perl 5.8. If Digest::MD5 cannot be found,
enabling this feature results in a no-op.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    4 +++
 gitweb/gitweb.perl |   60 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index a01eac8..eaf74c3 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -28,6 +28,10 @@ img.logo {
 	border-width: 0px;
 }
 
+img.avatar {
+	vertical-align:middle;
+}
+
 div.page_header {
 	height: 25px;
 	padding: 8px;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1e7e2d8..f5654d7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -195,6 +195,14 @@ our %known_snapshot_format_aliases = (
 	'x-zip' => undef, '' => undef,
 );
 
+# Pixel sizes for avatars. If the default font sizes or lineheights
+# are changed, it may be appropriate to change these values too via
+# $GITWEB_CONFIG.
+our %avatar_size = (
+	'default' => 16,
+	'double'  => 32
+) ;
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -365,6 +373,21 @@ our %feature = (
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
@@ -814,6 +837,10 @@ $git_dir = "$projectroot/$project" if $project;
 our @snapshot_fmts = gitweb_get_feature('snapshot');
 @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
+# check if gravatars are enabled and dependencies are satisfied
+our $git_gravatar_enabled = gitweb_check_feature('gravatar') &&
+	(eval { require Digest::MD5; 1; });
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -3214,12 +3241,28 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+# insert a gravatar for the given $email at the given $size if the feature
+# is enabled
+sub git_get_gravatar {
+	if ($git_gravatar_enabled) {
+		my ($email, %params) = @_;
+		my $pre_white = ($params{'space_before'} ? "&nbsp;" : "");
+		my $post_white = ($params{'space_after'} ? "&nbsp;" : "");
+		my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};
+		return $pre_white . "<img class=\"avatar\" src=\"http://www.gravatar.com/avatar.php?gravatar_id=" .
+		       Digest::MD5::md5_hex(lc $email) . "&amp;size=$size\" />" . $post_white;
+	} else {
+		return "";
+	}
+}
+
 sub git_print_authorship {
 	my $co = shift;
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<div class=\"author_date\">" .
 	      esc_html($co->{'author_name'}) .
+	      git_get_gravatar($co->{'author_email'}, 'space_before' => 1) .
 	      " [$ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
 		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
@@ -4145,7 +4188,7 @@ sub git_shortlog_body {
 		my $author = chop_and_escape_str($co{'author_name'}, 10);
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
+		      "<td>" . git_get_gravatar($co{'author_email'}, 'space_after' => 1) . "<i>" . $author . "</i></td>\n" .
 		      "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
@@ -4196,7 +4239,7 @@ sub git_history_body {
 	# shortlog uses      chop_str($co{'author_name'}, 10)
 		my $author = chop_and_escape_str($co{'author_name'}, 15, 3);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
+		      "<td>" . git_get_gravatar($co{'author_email'}, 'space_after' => 1) . "<i>" . $author . "</i></td>\n" .
 		      "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
 		print format_subject_html($co{'title'}, $co{'title_short'},
@@ -4352,7 +4395,7 @@ sub git_search_grep_body {
 		$alternate ^= 1;
 		my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
+		      "<td>" . git_get_gravatar($co{'author_email'}, 'space_after' => 1) . "<i>" . $author . "</i></td>\n" .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
 		               -class => "list subject"},
@@ -5095,8 +5138,9 @@ sub git_log {
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
 		      "<br/>\n" .
 		      "</div>\n" .
-		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
-		      "</div>\n";
+		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i>&nbsp;" .
+		      git_get_gravatar($co{'author_email'}) .
+		      "<br/>\n</div>\n";
 
 		print "<div class=\"log_body\">\n";
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
@@ -5183,7 +5227,8 @@ sub git_commit {
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n";
-	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
+	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_gravatar($co{'author_email'}, 'size' => 'double') . "</td></tr>\n" .
 	      "<tr>" .
 	      "<td></td><td> $ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
@@ -5195,7 +5240,8 @@ sub git_commit {
 	}
 	print "</td>" .
 	      "</tr>\n";
-	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
+	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_gravatar($co{'committer_email'}, 'size' => 'double') . "</td></tr>\n";
 	print "<tr><td></td><td> $cd{'rfc2822'}" .
 	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
 	      "</td></tr>\n";
-- 
1.6.3.rc1.192.gdbfcb
