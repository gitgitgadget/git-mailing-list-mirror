From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: gravatar support
Date: Fri, 19 Jun 2009 11:58:15 +0200
Message-ID: <1245405495-7712-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 11:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHarg-0007hU-8T
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 11:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbZFSJ6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 05:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZFSJ6W
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 05:58:22 -0400
Received: from mail-fx0-f206.google.com ([209.85.220.206]:56657 "EHLO
	mail-fx0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbZFSJ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 05:58:21 -0400
Received: by fxm2 with SMTP id 2so161826fxm.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=J5ZYN//ZL0Xvg9mio9lKlwBA5wIjJzp1XhXyIHhO2nw=;
        b=JGrhc8GSTfaZNsjvNYBDsYtL5ArNjpJM7zpQSuu7709XZGyHkCt9DrohTldJKSnpZM
         2IJwsdbxZISACDL9etzNkDt4eBF9p/Cw+9ABcaNh+ggpzL/BnTaf2J9jEqsIrUHLVMlT
         UexRuwfg4Lsu4kCvupHCY53Y+AhI/gsAwcEpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=A50INVydKa/Wl47mWI9AnzBa/dTUvmF2EYepMa9FzPh57gMWwAwQdfXICCTrO0Lvw0
         OTALJyWyy7uAIRN/+ypFDFkC6WH7cwi1Th/Ty/JFkAjhT09Qjt8Fr9B/l6mVzgvVJGyl
         l+cm5wZwBJ9XTx4lakjvgrT7nfen/bxx3m7f0=
Received: by 10.86.51.2 with SMTP id y2mr3071006fgy.3.1245405502498;
        Fri, 19 Jun 2009 02:58:22 -0700 (PDT)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id 4sm3830391fge.28.2009.06.19.02.58.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 02:58:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.282.g9f93
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121892>

Introduce gravatar support by adding the appropriate img tag next to
author and committer in commit, shortlog and log view.

The feature is disabled by default, and depends on Digest::MD5.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   41 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1e7e2d8..9f40070 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -365,6 +365,18 @@ our %feature = (
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
+	# Project specific override is not supported.
+	'gravatar' => {
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -814,6 +826,9 @@ $git_dir = "$projectroot/$project" if $project;
 our @snapshot_fmts = gitweb_get_feature('snapshot');
 @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
+# check if gravatars are enabled and dependencies are satisfied
+our $git_gravatar_enabled = gitweb_check_feature('gravatar') && (eval { use Digest::MD5 qw(md5_hex); 1; });
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -4123,6 +4138,19 @@ sub git_project_list_body {
 	print "</table>\n";
 }
 
+# insert a gravatar for the given $email at the given $size if the feature
+# is enabled
+sub git_get_gravatar {
+	if ($git_gravatar_enabled) {
+		my ($email, $size) = @_;
+		$size = 32 if $size <= 0;
+		return "<img src=\"http://www.gravatar.com/avatar.php?gravatar_id=" .
+		       md5_hex($email) . "&amp;size=$size\" style=\"vertical-align:middle\" />";
+	} else {
+		return "";
+	}
+}
+
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($commitlist, $from, $to, $refs, $extra) = @_;
@@ -4145,7 +4173,7 @@ sub git_shortlog_body {
 		my $author = chop_and_escape_str($co{'author_name'}, 10);
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
+		      "<td>" . git_get_gravatar($co{'author_email'}, 16) . "&nbsp;<i>" . $author . "</i></td>\n" .
 		      "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
@@ -5095,8 +5123,9 @@ sub git_log {
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
@@ -5183,7 +5212,8 @@ sub git_commit {
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n";
-	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
+	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_gravatar(lc $co{'author_email'}) . "</td></tr>\n" .
 	      "<tr>" .
 	      "<td></td><td> $ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
@@ -5195,7 +5225,8 @@ sub git_commit {
 	}
 	print "</td>" .
 	      "</tr>\n";
-	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
+	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_gravatar(lc $co{'committer_email'}) . "</td></tr>\n";
 	print "<tr><td></td><td> $cd{'rfc2822'}" .
 	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
 	      "</td></tr>\n";
-- 
1.6.3.1.282.g9f93
