From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv8 4/7] gitweb: (gr)avatar support
Date: Tue, 30 Jun 2009 00:00:51 +0200
Message-ID: <1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 00:01:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOv3-0005Hd-AB
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 00:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758697AbZF2WBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 18:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758663AbZF2WBD
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 18:01:03 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53425 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758217AbZF2WAy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 18:00:54 -0400
Received: by mail-fx0-f218.google.com with SMTP id 18so1264489fxm.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 15:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=f7OAzhaqXC3+vnxVQ1mfigcfdBRFMYn5kjIckagkI9Y=;
        b=C/tWuZ6P/RusXfF8jBa7QyRzT4Uc2KElECTLHtBdM+jdqR7gZm1dfzZzslR9tdiSqp
         enVJwST7TTsls8KFVR/cIce3AzNWQOhMHf+E1gXpucJUJAml93Qk8qadIixD0pMPCxJY
         XFT0f/277BQVdLQfPujewss1KHXxl5GuSX7BA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZZf2bMkMZQ4MItZ57F9WLDWgkmM7IAqUFPKCjTFf0YtmE5yqHZvIfJiF8MO5GybnpE
         LovYGMtshRt+O9fCl4Ga7isLgNJ8Jgpkt/4IrKENQBadDWXMkCVaQwKXOmObgqtuTj6i
         cv/OR9RqlsBmMLGQdphILvwGyeAD2IsD21zdM=
Received: by 10.204.65.65 with SMTP id h1mr7631142bki.18.1246312857691;
        Mon, 29 Jun 2009 15:00:57 -0700 (PDT)
Received: from localhost (host-78-13-59-48.cust-adsl.tiscali.it [78.13.59.48])
        by mx.google.com with ESMTPS id 9sm9942241fks.58.2009.06.29.15.00.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 15:00:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122472>

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
 gitweb/gitweb.perl                     |   83 ++++++++++++++++++++++++++++++-
 t/t9500-gitweb-standalone-no-errors.sh |    2 +
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 68b22ff..d05bc37 100644
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
index a393ac6..92695a3 100755
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
@@ -365,6 +373,24 @@ our %feature = (
 		'sub' => \&feature_patches,
 		'override' => 0,
 		'default' => [16]},
+
+	# Avatar support. When this feature is enabled, views such as
+	# shortlog or commit will display an avatar associated with
+	# the email of the committer(s) and/or author(s).
+
+	# Currently only the gravatar provider is available, and it
+	# depends on Digest::MD5. If an unknown provider is specified,
+	# the feature is disabled.
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
@@ -433,6 +459,12 @@ sub feature_patches {
 	return ($_[0]);
 }
 
+sub feature_avatar {
+	my @val = (git_get_project_config('avatar'));
+
+	return @val ? @val : @_;
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -814,6 +846,17 @@ $git_dir = "$projectroot/$project" if $project;
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
@@ -1469,6 +1512,34 @@ sub format_subject_html {
 	}
 }
 
+# Insert an avatar for the given $email at the given $size if the feature
+# is enabled.
+sub git_get_avatar {
+	my ($email, %opts) = @_;
+	my $pre_white  = ($opts{-pad_before} ? "&nbsp;" : "");
+	my $post_white = ($opts{-pad_after}  ? "&nbsp;" : "");
+	$opts{-size} ||= 'default';
+	my $size = $avatar_size{$opts{-size}} || $avatar_size{'default'};
+	my $url = "";
+	if ($git_avatar eq 'gravatar') {
+		$url = "http://www.gravatar.com/avatar/" .
+			Digest::MD5::md5_hex(lc $email) . "?s=$size";
+	}
+	# Currently only gravatars are supported, but other forms such as
+	# picons can be added by putting an else up here and defining $url
+	# as needed. If no variant puts something in $url, we assume avatars
+	# are completely disabled/unavailable.
+	if ($url) {
+		return $pre_white .
+		       "<img width=\"$size\" " .
+		            "class=\"avatar\" " .
+		            "src=\"$url\" " .
+		       "/>" . $post_white;
+	} else {
+		return "";
+	}
+}
+
 # format the author name of the given commit with the given tag
 # the author name is chopped and escaped according to the other
 # optional parameters (see chop_str).
@@ -1476,7 +1547,9 @@ sub format_author_html {
 	my $tag = shift;
 	my $co = shift;
 	my $author = chop_and_escape_str($co->{'author_name'}, @_);
-	return "<$tag class=\"author\">" . $author . "</$tag>";
+	return "<$tag class=\"author\">" .
+	       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
+	       $author . "</$tag>";
 }
 
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
@@ -3252,7 +3325,8 @@ sub git_print_authorship {
 	      esc_html($co->{'author_name'}) .
 	      " [$ad{'rfc2822'}";
 	print_local_time(%ad) if ($opts{-localtime});
-	print "]</$tag>\n";
+	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
+		  . "</$tag>\n";
 }
 
 # Outputs table rows containing the full author or committer information,
@@ -3267,7 +3341,10 @@ sub git_print_authorship_rows {
 	@people = ('author', 'committer') unless @people;
 	foreach my $who (@people) {
 		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
-		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td></tr>\n".
+		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td>" .
+		      "<td rowspan=\"2\">" .
+		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
+		      "</td></tr>\n" .
 		      "<tr>" .
 		      "<td></td><td> $wd{'rfc2822'}";
 		print_local_time(%wd);
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
