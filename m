From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 4/8] gitweb: (gr)avatar support
Date: Thu, 25 Jun 2009 12:43:03 +0200
Message-ID: <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 12:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJmQv-0008IK-Ne
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448AbZFYKnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 06:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756293AbZFYKnT
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:43:19 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:57268 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263AbZFYKnP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 06:43:15 -0400
Received: by mail-fx0-f213.google.com with SMTP id 9so1350409fxm.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=x0tX1s5AO3jTYFMmyIrUXLzjRKOBiTgDW+hvlgGbyMY=;
        b=w6bI8xwgeJqIRL0vbmnCpN4KIx/yrypZ+QkhGQ88fI2p3VEVlno26yqOlAbWQIR9K7
         K6XNo+I2onMKxAR8kQMdLmyWfAgSUWvGOCUZoDJFX/xedrjapavJ8dNdpd/1OKBS9x5k
         iXvNHaQ2dGfARSBV2ks5k9+XhIQ+t7O3qIOWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MYtPBqGGP3Cl72AeExVJVyxMKATvKegCXaBkNjt9LJmW8MDdCxmvGCYmbcQWe7FYe6
         elnqihkuKMqmywq7OQhgHn69EhX+vPnkH/aUV8jc193R42p4VGApcNyW/rAPPpqGf7gW
         YD1gMaMvrnbSaVdUK/sU0ijCM0gBOLnUy1GhU=
Received: by 10.204.71.65 with SMTP id g1mr2338545bkj.27.1245926597582;
        Thu, 25 Jun 2009 03:43:17 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id d13sm2861802fka.32.2009.06.25.03.43.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:43:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122200>

Introduce avatar support: the featuer adds the appropriate img tag next
to author and committer in commit(diff), history, shortlog and log view.
Multiple avatar providers are possible, but only gravatar is implemented
at the moment (and not enabled by default).

Gravatar support depends on Digest::MD5, which is a core package since
Perl 5.8. If gravatars are activated but Digest::MD5 cannot be found,
the feature will be automatically disabled.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    4 +++
 gitweb/gitweb.perl |   67 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 7240ed7..ad82f86 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -28,6 +28,10 @@ img.logo {
 	border-width: 0px;
 }
 
+img.avatar {
+	vertical-align: middle;
+}
+
 div.page_header {
 	height: 25px;
 	padding: 8px;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cdfd1d5..f2e0cfe 100755
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
+);
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -365,6 +373,22 @@ our %feature = (
 		'sub' => \&feature_patches,
 		'override' => 0,
 		'default' => [16]},
+
+	# Avatar support. When this feature is enabled, views such as
+	# shortlog or commit will display an avatar associated with
+	# the email of the committer(s) and/or author(s).
+
+	# Currently only the gravatar provider is available, and it
+	# depends on Digest::MD5.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'avatar'}{'default'} = ['gravatar'];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'avatar'}{'override'} = 1;
+	# and in project config gitweb.avatar = gravatar;
+	'avatar' => {
+		'override' => 0,
+		'default' => ['']},
 );
 
 sub gitweb_get_feature {
@@ -814,6 +838,13 @@ $git_dir = "$projectroot/$project" if $project;
 our @snapshot_fmts = gitweb_get_feature('snapshot');
 @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
+# check if avatars are enabled and dependencies are satisfied
+our ($git_avatar) = gitweb_get_feature('avatar');
+if (($git_avatar eq 'gravatar') &&
+   !(eval { require Digest::MD5; 1; })) {
+	$git_avatar = '';
+}
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -1476,7 +1507,9 @@ sub format_author_html {
 	my $tag = shift;
 	my $co = shift;
 	my $author = chop_and_escape_str($co->{'author_name'}, @_);
-	return "<$tag class=\"author\">" . $author . "</$tag>\n";
+	return "<$tag class=\"author\">" .
+	       git_get_avatar($co->{'author_email'}, 'pad_after' => 1) .
+	       $author . "</$tag>\n";
 }
 
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
@@ -3224,6 +3257,29 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+# Insert an avatar for the given $email at the given $size if the feature
+# is enabled.
+sub git_get_avatar {
+	my ($email, %params) = @_;
+	my $pre_white  = ($params{'pad_before'} ? "&nbsp;" : "");
+	my $post_white = ($params{'pad_after'}  ? "&nbsp;" : "");
+	my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};
+	my $url = "";
+	if ($git_avatar eq 'gravatar') {
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
@@ -3243,7 +3299,8 @@ sub git_print_authorship {
 			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 		}
 	}
-	print "]</$tag>\n";
+	print "]" . git_get_avatar($co->{'author_email'}, 'pad_before' => 1)
+		  . "</$tag>\n";
 }
 
 # Outputs table rows containign the full author and commiter information.
@@ -3251,7 +3308,8 @@ sub git_print_full_authorship {
 	my $co = shift;
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
-	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
+	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td>".
+	      "<td rowspan=\"2\">" .git_get_avatar($co->{'author_email'}, 'size' => 'double') . "</td></tr>\n" .
 	      "<tr>" .
 	      "<td></td><td> $ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
@@ -3263,7 +3321,8 @@ sub git_print_full_authorship {
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
