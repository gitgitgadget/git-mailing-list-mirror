From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 2/3] gitweb: gravatar support
Date: Wed, 24 Jun 2009 23:16:22 +0200
Message-ID: <1245878183-2967-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 23:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJZpj-0000It-3f
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 23:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbZFXVQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 17:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZFXVQf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 17:16:35 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:57527 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbZFXVQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 17:16:34 -0400
Received: by bwz9 with SMTP id 9so1026851bwz.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C61C1feBFi9OX622BZ2KDobW17mme8cq9lyZ46DwdSE=;
        b=a0aEaH0QsJW8V95QYyZSTPmKDpDgxlQKMn115OYthlynEqWGNM6+GpR1fIFqf6n3w3
         088UnPiKuToMOBfw4aL5q9fAlLmx/FiTFA9LMOxV9QRnynJuDO3fn/Eao/KVjMVpbqGc
         SKXwmt/WkH7ULbMuwLiTRGVpK9UCBPjwW+BuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qPmE/c6Jhi8rViEkuvL60c5o+wkgwlPw+GSfmh9+fTYW1p3N4CIq5UeUNcI+tJPwtA
         WiyYL64ChK4Jd7TTJbpikvN7N4B78Sz4LUWJ9Xr9ma7X7VuyGrqbucaktaB8B5wigcMq
         AwrRY/h3iqZLeDXC14bDp21cEmVuqh3cxvTHQ=
Received: by 10.103.24.11 with SMTP id b11mr1040090muj.90.1245878195744;
        Wed, 24 Jun 2009 14:16:35 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id e10sm7414772muf.44.2009.06.24.14.16.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 14:16:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122156>

Introduce gravatar support by adding the appropriate img tag next to
author and committer in commit(diff), history, shortlog and log view.

The feature is disabled by default, and depends on Digest::MD5, which
is a core package since Perl 5.8. If Digest::MD5 cannot be found,
enabling this feature results in a no-op.

The avatar insertion code is made generic enough to allow other avatar
sources to be added easily.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    4 +++
 gitweb/gitweb.perl |   64 +++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 6 deletions(-)

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
index 223648f..6e807fe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -195,6 +195,14 @@ our %known_snapshot_format_aliases = (
 	'x-zip' => undef, '' => undef,
 );
 
+# Pixel sizes for icons and avatars. If the default font sizes or lineheights
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
+	return "<$tag class=\"author\">" . git_get_avatar($co->{'author_email'}, 'space_after' => 1) . $author . "</$tag>\n";
 }
 
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
@@ -3222,6 +3249,29 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+# Insert an avatar for the given $email at the given $size if the feature
+# is enabled.
+sub git_get_avatar {
+	my ($email, %params) = @_;
+	my $pre_white = ($params{'space_before'} ? "&nbsp;" : "");
+	my $post_white = ($params{'space_after'} ? "&nbsp;" : "");
+	my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};
+	my $url = "";
+	if ($git_gravatar_enabled) {
+		$url = "http://www.gravatar.com/avatar.php?gravatar_id=" .
+			Digest::MD5::md5_hex(lc $email) . "&amp;size=$size";
+	}
+	# Currently only gravatars are supported, but other forms such as
+	# picons can be added by putting an else up here and defining $url
+	# as needed. If no variant puts something in $url, we assume avatars
+	# are completely disabled/unavailable.
+	if ($url) {
+		return $pre_white . "<img class=\"avatar\" src=\"$url\" />" . $post_white;
+	} else {
+		return "";
+	}
+}
+
 # Outputs the author name and date in long form
 sub git_print_authorship {
 	my $co = shift;
@@ -3238,7 +3288,8 @@ sub git_print_authorship {
 		printf(" (%02d:%02d %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	}
-	print "]</$tag>\n";
+	print "]" . git_get_avatar($co->{'author_email'}, 'space_before' => 1)
+		  . "</$tag>\n";
 }
 
 # Outputs the author and commiter name and date in long form
@@ -3246,9 +3297,9 @@ sub git_print_who {
 	my $co = shift;
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
-	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
-	      "<tr>" .
-	      "<td></td><td> $ad{'rfc2822'}";
+	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_avatar($co->{'author_email'}, 'size' => 'double') . "</td></tr>\n" .
+	      "<tr><td></td><td> $ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
 		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
@@ -3258,7 +3309,8 @@ sub git_print_who {
 	}
 	print "</td>" .
 	      "</tr>\n";
-	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td></tr>\n";
+	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_avatar($co->{'committer_email'}, 'size' => 'double') . "</td></tr>\n";
 	print "<tr><td></td><td> $cd{'rfc2822'}" .
 	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
 	      "</td></tr>\n";
-- 
1.6.3.rc1.192.gdbfcb
