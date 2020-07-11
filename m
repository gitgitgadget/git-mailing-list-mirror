Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5693C433E1
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F2C206A5
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 21:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGKVCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:02:15 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:58039 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGKVCP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jul 2020 17:02:15 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jul 2020 17:02:14 EDT
Received: from [178.112.81.104] (helo=localhost.localdomain)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <tobi@isticktoit.net>)
        id 1juMWK-0004xe-7H; Sat, 11 Jul 2020 22:54:52 +0200
From:   Tobias Girstmair <tobi@isticktoit.net>
To:     git@vger.kernel.org
Cc:     Tobias Girstmair <tobi@isticktoit.net>
Subject: [PATCH] gitweb: Replace <base> tag with full URLs (when using PATH_INFO)
Date:   Sat, 11 Jul 2020 22:39:48 +0200
Message-Id: <20200711203947.23520-1-tobi@isticktoit.net>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: dC5naXJzdG1haXJAaXN0aWNrdG9pdC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

using a base tag has the side-effect of not just changing the few URLs
of gitweb's static resources, but all other relative links (e.g. those
in a README.html), too.

Signed-off-by: Tobias Girstmair <tobi@isticktoit.net>
---
My exact use case is this: Many of my repositories have README.{rst,md}
files with relative links to more md/rst files. I'm generating a
README.html from that file with a post-update hook, and rewrite links,
so they display the file. Some cloned repos' READMEs even have images in
them, whose links I'm fixing up as well.

Due to the precence of the <base> tag, I can't just prepend
"blob_plain/HEAD:" to the URLs, but have to recreate the full URL,
including the last few directories of $GIT_DIR. That's annoying to keep
portable (move a repo from e.g. /srv/git/foo.git to
/srv/git/**public**/foo.git and the URL must be changed in the hook, and
the hook re-executed).

Looking forward to your feedback,
	tobias

 gitweb/gitweb.perl | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0959a78..049bb64 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2232,7 +2232,7 @@ sub git_get_avatar {
 		return $pre_white .
 		       "<img width=\"$size\" " .
 		            "class=\"avatar\" " .
-		            "src=\"".esc_url($url)."\" " .
+		            "src=\"".get_base_url().esc_url($url)."\" " .
 			    "alt=\"\" " .
 		       "/>" . $post_white;
 	} else {
@@ -2674,6 +2674,13 @@ sub get_feed_info {
 	return %res;
 }
 
+# the stylesheet, favicon etc urls won't work correctly with path_info
+# unless we set the appropriate base URL. not using a <base> tag to not
+# also change relative URLs inserted by the user.
+sub get_base_url {
+	return $ENV{'PATH_INFO'}? esc_url($base_url)."/" : "";
+}
+
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
@@ -4099,17 +4106,17 @@ sub print_header_links {
 	# print out each stylesheet that exist, providing backwards capability
 	# for those people who defined $stylesheet in a config file
 	if (defined $stylesheet) {
-		print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
+		print '<link rel="stylesheet" type="text/css" href="'.get_base_url().esc_url($stylesheet).'"/>'."\n";
 	} else {
 		foreach my $stylesheet (@stylesheets) {
 			next unless $stylesheet;
-			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
+			print '<link rel="stylesheet" type="text/css" href="'.get_base_url().esc_url($stylesheet).'"/>'."\n";
 		}
 	}
 	print_feed_meta()
 		if ($status eq '200 OK');
 	if (defined $favicon) {
-		print qq(<link rel="shortcut icon" href=").esc_url($favicon).qq(" type="image/png" />\n);
+		print qq(<link rel="shortcut icon" href=").get_base_url().esc_url($favicon).qq(" type="image/png" />\n);
 	}
 }
 
@@ -4212,11 +4219,6 @@ sub git_header_html {
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 EOF
-	# the stylesheet, favicon etc urls won't work correctly with path_info
-	# unless we set the appropriate base URL
-	if ($ENV{'PATH_INFO'}) {
-		print "<base href=\"".esc_url($base_url)."\" />\n";
-	}
 	print_header_links($status);
 
 	if (defined $site_html_head_string) {
@@ -4234,7 +4236,7 @@ sub git_header_html {
 	if (defined $logo) {
 		print $cgi->a({-href => esc_url($logo_url),
 		               -title => $logo_label},
-		              $cgi->img({-src => esc_url($logo),
+		              $cgi->img({-src => get_base_url().esc_url($logo),
 		                         -width => 72, -height => 27,
 		                         -alt => "git",
 		                         -class => "logo"}));
@@ -4299,7 +4301,7 @@ sub git_footer_html {
 		insert_file($site_footer);
 	}
 
-	print qq!<script type="text/javascript" src="!.esc_url($javascript).qq!"></script>\n!;
+	print qq!<script type="text/javascript" src="!.get_base_url().esc_url($javascript).qq!"></script>\n!;
 	if (defined $action &&
 	    $action eq 'blame_incremental') {
 		print qq!<script type="text/javascript">\n!.
@@ -8273,7 +8275,7 @@ sub git_feed {
 		if (defined $logo || defined $favicon) {
 			# prefer the logo to the favicon, since RSS
 			# doesn't allow both
-			my $img = esc_url($logo || $favicon);
+			my $img = get_base_url().esc_url($logo || $favicon);
 			print "<image>\n" .
 			      "<url>$img</url>\n" .
 			      "<title>$title</title>\n" .
@@ -8299,11 +8301,11 @@ sub git_feed {
 		      # use project owner for feed author
 		      "<author><name>$owner</name></author>\n";
 		if (defined $favicon) {
-			print "<icon>" . esc_url($favicon) . "</icon>\n";
+			print "<icon>" . get_base_url() . esc_url($favicon) . "</icon>\n";
 		}
 		if (defined $logo) {
 			# not twice as wide as tall: 72 x 27 pixels
-			print "<logo>" . esc_url($logo) . "</logo>\n";
+			print "<logo>" . get_base_url() . esc_url($logo) . "</logo>\n";
 		}
 		if (! %latest_date) {
 			# dummy date to keep the feed valid until commits trickle in:
-- 
2.21.3

