From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Tue,  8 Jun 2010 02:20:41 +0530
Message-ID: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Mon Jun 07 22:51:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLjHg-0006ic-V8
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 22:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab0FGUuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 16:50:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46715 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab0FGUuy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 16:50:54 -0400
Received: by pwj5 with SMTP id 5so1014636pwj.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0hcLygX2igu5YVK2PRQ/Mhh3HDnbGko9dd8AOB2W1h0=;
        b=BJdAts97dZN5bcsx0Ltnc6AXswlRPMSZvKo3C8w6jF9z2gf8GnLGZka92eBaeTNoQF
         Rncno2nz8zibnYU4FlHYGHLCJDtL08vph6c/BVCT2KWvlKfK9eeEq+tkY2mY/5xeK6Pq
         sxuhnuTa1f6svJEe1NaG/qeFMoD0XrAJaxeDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LeZ1pQ1W0Zfhu10qlWZ+YPqIPEcObJy3QurqBUry1CyH+RiETQAJA1+EYhIH6z9bzv
         /vpYzUYhIuv9uoDdHsqm9xVbKrETTbvNp9QajkwsTbG1ElCnxHXQ6P7zQFvC0KNgN1G5
         owg4m5QdnoLG8hlIY8lYjLe3fpZY1ScNxixrE=
Received: by 10.140.251.13 with SMTP id y13mr12386556rvh.116.1275943853946;
        Mon, 07 Jun 2010 13:50:53 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id o38sm1180853rvp.2.2010.06.07.13.50.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 13:50:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.ga8c50c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148624>

Subroutines moved:
	gitweb_get_feature
	gitweb_check_feature
	filter_snapshot_fmts
	configure_gitweb_features

Subroutines yet to move: (Contains not yet packaged subs & vars)
	feature_bool
	feature_avatar
	feature_snapshot
	feature_pathces

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/gitweb.perl          |   67 --------------------------------------
 gitweb/lib/Gitweb/Config.pm |   74 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9b2fe09..3931064 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -67,40 +67,6 @@ $strict_export = "++GITWEB_STRICT_EXPORT++";
 $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 
-sub gitweb_get_feature {
-	my ($name) = @_;
-	return unless exists $feature{$name};
-	my ($sub, $override, @defaults) = (
-		$feature{$name}{'sub'},
-		$feature{$name}{'override'},
-		@{$feature{$name}{'default'}});
-	# project specific override is possible only if we have project
-	if (!$override || !defined $git_dir) {
-		return @defaults;
-	}
-	if (!defined $sub) {
-		warn "feature $name is not overridable";
-		return @defaults;
-	}
-	return $sub->(@defaults);
-}
-
-# A wrapper to check if a given feature is enabled.
-# With this, you can say
-#
-#   my $bool_feat = gitweb_check_feature('bool_feat');
-#   gitweb_check_feature('bool_feat') or somecode;
-#
-# instead of
-#
-#   my ($bool_feat) = gitweb_get_feature('bool_feat');
-#   (gitweb_get_feature('bool_feat'))[0] or somecode;
-#
-sub gitweb_check_feature {
-	return (gitweb_get_feature(@_))[0];
-}
-
-
 sub feature_bool {
 	my $key = shift;
 	my ($val) = git_get_project_config($key, '--bool');
@@ -159,19 +125,6 @@ sub check_export_ok {
 		(!$export_auth_hook || $export_auth_hook->($dir)));
 }
 
-# process alternate names for backward compatibility
-# filter out unsupported (unknown) snapshot formats
-sub filter_snapshot_fmts {
-	my @fmts = @_;
-
-	@fmts = map {
-		exists $known_snapshot_format_aliases{$_} ?
-		       $known_snapshot_format_aliases{$_} : $_} @fmts;
-	@fmts = grep {
-		exists $known_snapshot_formats{$_} &&
-		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
-}
-
 # Get loadavg of system, to compare against $maxload.
 # Currently it requires '/proc/loadavg' present to get loadavg;
 # if it is not present it returns 0, which means no load checking.
@@ -486,26 +439,6 @@ sub evaluate_git_dir {
 	$git_dir = "$projectroot/$project" if $project;
 }
 
-our (@snapshot_fmts, $git_avatar);
-sub configure_gitweb_features {
-	# list of supported snapshot formats
-	our @snapshot_fmts = gitweb_get_feature('snapshot');
-	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
-
-	# check that the avatar feature is set to a known provider name,
-	# and for each provider check if the dependencies are satisfied.
-	# if the provider name is invalid or the dependencies are not met,
-	# reset $git_avatar to the empty string.
-	our ($git_avatar) = gitweb_get_feature('avatar');
-	if ($git_avatar eq 'gravatar') {
-		$git_avatar = '' unless (eval { require Digest::MD5; 1; });
-	} elsif ($git_avatar eq 'picon') {
-		# no dependencies
-	} else {
-		$git_avatar = '';
-	}
-}
-
 # custom error handler: 'die <message>' is Internal Server Error
 sub handle_errors_html {
 	my $msg = shift; # it is already HTML escaped
diff --git a/gitweb/lib/Gitweb/Config.pm b/gitweb/lib/Gitweb/Config.pm
index fdab9f7..3810fda 100644
--- a/gitweb/lib/Gitweb/Config.pm
+++ b/gitweb/lib/Gitweb/Config.pm
@@ -10,13 +10,16 @@ use strict;
 use warnings;
 use Exporter qw(import);
 
-our @EXPORT = qw(evaluate_gitweb_config $version $projectroot $project_maxdepth $mimetypes_file
+our @EXPORT = qw(evaluate_gitweb_config gitweb_check_feature gitweb_get_feature configure_gitweb_features
+                 filter_snapshot_fmts $version $projectroot $project_maxdepth $mimetypes_file $git_avatar
                  $projects_list @git_base_url_list $export_ok $strict_export $home_link_str $site_name
                  $site_header $site_footer $home_text @stylesheets $stylesheet $logo $favicon $javascript
                  $GITWEB_CONFIG $GITWEB_CONFIG_SYSTEM $logo_url $logo_label $export_auth_hook
                  $projects_list_description_width $default_projects_order $default_blob_plain_mimetype
                  $default_text_plain_charset $fallback_encoding @diff_opts $prevent_xss $maxload
-                 %avatar_size %known_snapshot_formats %known_snapshot_format_aliases %feature);
+                 %avatar_size %known_snapshot_formats %feature @snapshot_fmts);
+
+use Gitweb::Git qw($git_dir);
 
 # The following variables are affected by build-time configuration
 # and hence their initialisation is put in gitweb.perl script
@@ -425,4 +428,71 @@ sub evaluate_gitweb_config {
 	}
 }
 
+
+sub gitweb_get_feature {
+	my ($name) = @_;
+	return unless exists $feature{$name};
+	my ($sub, $override, @defaults) = (
+		$feature{$name}{'sub'},
+		$feature{$name}{'override'},
+		@{$feature{$name}{'default'}});
+	# project specific override is possible only if we have project
+	if (!$override || !defined $git_dir) {
+		return @defaults;
+	}
+	if (!defined $sub) {
+		warn "feature $name is not overridable";
+		return @defaults;
+	}
+	return $sub->(@defaults);
+}
+
+# A wrapper to check if a given feature is enabled.
+# With this, you can say
+#
+#   my $bool_feat = gitweb_check_feature('bool_feat');
+#   gitweb_check_feature('bool_feat') or somecode;
+#
+# instead of
+#
+#   my ($bool_feat) = gitweb_get_feature('bool_feat');
+#   (gitweb_get_feature('bool_feat'))[0] or somecode;
+#
+sub gitweb_check_feature {
+	return (gitweb_get_feature(@_))[0];
+}
+
+# process alternate names for backward compatibility
+# filter out unsupported (unknown) snapshot formats
+sub filter_snapshot_fmts {
+	my @fmts = @_;
+
+	@fmts = map {
+		exists $known_snapshot_format_aliases{$_} ?
+		       $known_snapshot_format_aliases{$_} : $_} @fmts;
+	@fmts = grep {
+		exists $known_snapshot_formats{$_} &&
+		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
+}
+
+our (@snapshot_fmts, $git_avatar);
+sub configure_gitweb_features {
+	# list of supported snapshot formats
+	our @snapshot_fmts = gitweb_get_feature('snapshot');
+	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
+
+	# check that the avatar feature is set to a known provider name,
+	# and for each provider check if the dependencies are satisfied.
+	# if the provider name is invalid or the dependencies are not met,
+	# reset $git_avatar to the empty string.
+	our ($git_avatar) = gitweb_get_feature('avatar');
+	if ($git_avatar eq 'gravatar') {
+		$git_avatar = '' unless (eval { require Digest::MD5; 1; });
+	} elsif ($git_avatar eq 'picon') {
+		# no dependencies
+	} else {
+		$git_avatar = '';
+	}
+}
+
 1;
-- 
1.7.1.454.ga8c50c
