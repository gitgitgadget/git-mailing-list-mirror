From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 2/2] gitweb: gravatar support
Date: Tue, 23 Jun 2009 00:49:59 +0200
Message-ID: <1245710999-17763-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245710999-17763-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 00:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIsKI-0006dF-Ly
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 00:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbZFVWtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 18:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbZFVWtD
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 18:49:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:15132 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbZFVWtB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 18:49:01 -0400
Received: by fg-out-1718.google.com with SMTP id d23so684746fga.17
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 15:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bfAbBxS5ZrEDZRvB9kD3RexWZ73rFXr+Ooa6AMjuZqM=;
        b=rVtW6nNeAt0DdKNIKC7rlrjwl64wdU6kxber3256rDYwqdcE1G5XkkWKXbM9Vxn5Ve
         En19BMomdRtOJLePuqM4EK6xwNDAFs5FwIZ4FF6AIeFjSlxon/f1kSlEsHjXZZvNuhSw
         GD5B2SCj80/rL6aQsd2cNxCwt8acYSx3BSdDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xScnaXK/weOi/P0zIfpxSqkiW3tfnRAeRMwrjXtuSn6ttNPoscqZtm/VxWon1DaWqC
         jYXuCDb4CqKeok+/KLT30l4FXsf6B662vXcOj4jCXiT+bpWJG4TxyRCIuyoDOiT2fG/7
         rC2o3DMCCv1PssbgY8fZn+W/vG89owYoc7q1w=
Received: by 10.86.3.11 with SMTP id 11mr7441410fgc.11.1245710942821;
        Mon, 22 Jun 2009 15:49:02 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-34-214.clienti.tiscali.it [94.37.34.214])
        by mx.google.com with ESMTPS id 4sm2114787fgg.12.2009.06.22.15.49.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 15:49:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245710999-17763-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122067>

Introduce gravatar support by adding the appropriate img tag next to
author and committer in commit(diff), history, shortlog and log view.

The feature is disabled by default, and depends on Digest::MD5, which
is a core package since Perl 5.8. If Digest::MD5 cannot be found,
enabling this feature results in a no-op.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    4 +++
 gitweb/gitweb.perl |   56 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 68b22ff..ddf982b 100644
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
index 223648f..531d589 100755
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
@@ -1474,7 +1501,7 @@ sub format_author_html {
 	my $tag = shift;
 	my $co = shift;
 	my $author = chop_and_escape_str($co->{'author_name'}, @_);
-	return "<$tag class=\"author\">" . $author . "</$tag>\n";
+	return "<$tag class=\"author\">" . git_get_gravatar($co->{'author_email'}, 'space_after' => 1) . $author . "</$tag>\n";
 }
 
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
@@ -3222,6 +3249,21 @@ sub git_print_header_div {
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
 # Outputs the author name and date in long form
 sub git_print_authorship {
 	my $co = shift;
@@ -3238,7 +3280,8 @@ sub git_print_authorship {
 		printf(" (%02d:%02d %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	}
-	print "]</$tag>\n";
+	print "]" . git_get_gravatar($co->{'author_email'}, 'space_before' => 1)
+		  . "</$tag>\n";
 }
 
 # Outputs the author and commiter name and date in long form
@@ -3246,9 +3289,9 @@ sub git_print_who {
 	my $co = shift;
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
-	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
-	      "<tr>" .
-	      "<td></td><td> $ad{'rfc2822'}";
+	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_gravatar($co->{'author_email'}, 'size' => 'double') . "</td></tr>\n" .
+	      "<tr><td></td><td> $ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
 		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
@@ -3258,7 +3301,8 @@ sub git_print_who {
 	}
 	print "</td>" .
 	      "</tr>\n";
-	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td></tr>\n";
+	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_gravatar($co->{'committer_email'}, 'size' => 'double') . "</td></tr>\n";
 	print "<tr><td></td><td> $cd{'rfc2822'}" .
 	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
 	      "</td></tr>\n";
-- 
1.6.3.rc1.192.gdbfcb
