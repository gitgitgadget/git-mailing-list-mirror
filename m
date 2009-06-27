From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 5/9] gitweb: (gr)avatar support
Date: Sat, 27 Jun 2009 14:05:01 +0200
Message-ID: <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 14:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWfj-0007Dq-7V
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbZF0MFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 08:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbZF0MFY
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:05:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:40331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbZF0MFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:05:09 -0400
Received: by fg-out-1718.google.com with SMTP id e21so627857fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fIHvzyZsrbEHv5Voudk60074PVYQEKGhpmG+GIGcxyY=;
        b=ntpFIErxKa1dfQTgt7NPymJ5poOPo+d/GO3QOzR+SInVABr4FFdP7VPLGYLQAG2sZg
         eb+20Fp5t4DMztKxfmS132omsDFZQnq1XnD19qIimnjbwFfeQZsnKU/qoAODv8MtOIVA
         PI60Lng1dBo1Lg/gVf9f1kYTGp0q94wTfisWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f0QNUWeWR0GyP793jxZzPr7uvv4lBfnV6UmhMi8syQpl1a70bNUFTjkCtRzr++Guuv
         NHwHLVwotCQRZhu4YRaxPy3H6jKoZZOiUmN6sXWCbkDNmJWZNuv7XY/HyTgExvbipGio
         1nxgORsGsyYOItdcUYWz3WwlC10bY5Fa6oc74=
Received: by 10.86.23.9 with SMTP id 9mr218819fgw.5.1246104312709;
        Sat, 27 Jun 2009 05:05:12 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-10-227.clienti.tiscali.it [94.37.10.227])
        by mx.google.com with ESMTPS id l19sm8506444fgb.26.2009.06.27.05.05.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:05:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122359>

Introduce avatar support: the feature adds the appropriate img tag next
to author and committer in commit(diff), history, shortlog, log and tag
views. Multiple avatar providers are possible, but only gravatar is
implemented at the moment.

Gravatar support depends on Digest::MD5, which is a core package since
Perl 5.8. If gravatars are activated but Digest::MD5 cannot be found,
the feature will be automatically disabled.

No avatar provider is selected by default, except in the t9500 test.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css                      |    4 ++
 gitweb/gitweb.perl                     |   81 ++++++++++++++++++++++++++++++-
 t/t9500-gitweb-standalone-no-errors.sh |    2 +
 3 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index ef24a1b..cd8066d 100644
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
index 7183ad2..ad9ae31 100755
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
@@ -365,6 +373,23 @@ our %feature = (
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
+		'sub' => \&feature_avatar,
+		'override' => 0,
+		'default' => ['']},
 );
 
 sub gitweb_get_feature {
@@ -433,6 +458,16 @@ sub feature_patches {
 	return ($_[0]);
 }
 
+sub feature_avatar {
+	my @val = (git_get_project_config('avatar'));
+
+	if (@val) {
+		return @val;
+	}
+
+	return @_;
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -814,6 +849,17 @@ $git_dir = "$projectroot/$project" if $project;
 our @snapshot_fmts = gitweb_get_feature('snapshot');
 @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
+# check that the avatar feature is set to a known provider name,
+# and for each provider check if the dependencies are satisfied.
+# if the provider name is invalid or the dependencies are not met,
+# reset $git_avatar to the empty string.
+our ($git_avatar) = gitweb_get_feature('avatar');
+if ($git_avatar eq 'gravatar') {
+	$git_avatar = '' unless (eval { require Digest::MD5; 1; });
+} else {
+	$git_avatar = '';
+}
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -1469,6 +1515,29 @@ sub format_subject_html {
 	}
 }
 
+# Insert an avatar for the given $email at the given $size if the feature
+# is enabled.
+sub git_get_avatar {
+	my ($email, %opts) = @_;
+	my $pre_white  = ($opts{'pad_before'} ? "&nbsp;" : "");
+	my $post_white = ($opts{'pad_after'}  ? "&nbsp;" : "");
+	my $size = $avatar_size{$opts{'size'}} || $avatar_size{'default'};
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
+		return $pre_white . "<img width=\"$size\" class=\"avatar\" src=\"$url\" />" . $post_white;
+	} else {
+		return "";
+	}
+}
+
 # format the author name of the given commit with the given tag
 # the author name is chopped and escaped according to the other
 # optional parameters (see chop_str).
@@ -1476,7 +1545,9 @@ sub format_author_html {
 	my $tag = shift;
 	my $co = shift;
 	my $author = chop_and_escape_str($co->{'author_name'}, @_);
-	return "<$tag class=\"author\">" . $author . "</$tag>";
+	return "<$tag class=\"author\">" .
+	       git_get_avatar($co->{'author_email'}, 'pad_after' => 1) .
+	       $author . "</$tag>";
 }
 
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
@@ -3249,7 +3320,8 @@ sub git_print_authorship {
 			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 		}
 	}
-	print "]</$tag>\n";
+	print "]" . git_get_avatar($co->{'author_email'}, 'pad_before' => 1)
+		  . "</$tag>\n";
 }
 
 # Outputs table rows containing the full author or committer information,
@@ -3264,7 +3336,10 @@ sub git_print_authorship_rows {
 	@people = ('author', 'committer') unless @people;
 	foreach my $who (@people) {
 		my %ad = parse_date($co->{$who . '_epoch'}, $co->{$who . '_tz'});
-		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td></tr>\n".
+		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td>" .
+		      "<td rowspan=\"2\">" .
+		      git_get_avatar($co->{$who . '_email'}, 'size' => 'double') .
+		      "</td></tr>\n" .
 		      "<tr>" .
 		      "<td></td><td> $ad{'rfc2822'}";
 		if ($ad{'hour_local'} < 6) {
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index d539619..6275181 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -660,6 +660,7 @@ cat >>gitweb_config.perl <<EOF
 
 \$feature{'blame'}{'override'} = 1;
 \$feature{'snapshot'}{'override'} = 1;
+\$feature{'avatar'}{'override'} = 1;
 EOF
 
 test_expect_success \
@@ -671,6 +672,7 @@ test_expect_success \
 	'config override: tree view, features disabled in repo config' \
 	'git config gitweb.blame no &&
 	 git config gitweb.snapshot none &&
+	 git config gitweb.avatar gravatar &&
 	 gitweb_run "p=.git;a=tree"'
 test_debug 'cat gitweb.log'
 
-- 
1.6.3.rc1.192.gdbfcb
