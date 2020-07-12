Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EFAC433E0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 19:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02D72067D
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 19:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgGLTL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 15:11:27 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:17633 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbgGLTL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 15:11:27 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jul 2020 15:11:25 EDT
Received: from [178.112.81.104] (helo=localhost.localdomain)
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <tobi@isticktoit.net>)
        id 1juhFJ-0007kK-5Z; Sun, 12 Jul 2020 21:02:41 +0200
From:   Tobias Girstmair <tobi@isticktoit.net>
To:     git@vger.kernel.org
Cc:     Tobias Girstmair <tobi@isticktoit.net>
Subject: [PATCH v3] gitweb: Replace <base> tag with full URLs (when using PATH_INFO)
Date:   Sun, 12 Jul 2020 20:33:30 +0200
Message-Id: <20200712183329.3358-1-tobi@isticktoit.net>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200711203947.23520-1-tobi@isticktoit.net>
References: <20200711203947.23520-1-tobi@isticktoit.net>
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
Apologies; missed a typo.

	tobias

 gitweb/gitweb.perl | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0959a78..f426060 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1616,6 +1616,19 @@ sub esc_url {
 	return $str;
 }
 
+# the stylesheet, favicon etc urls won't work correctly with path_info
+# unless we set the appropriate base URL. not using a <base> tag to not
+# also change relative URLs inserted by the user.
+sub esc_url_base {
+	my $url = shift;
+	my $prefix = $ENV{'PATH_INFO'}? esc_url($base_url)."/" : "";
+	if ($url !~ m{^(https?:)?//?}) {
+		return $prefix . esc_url($url);
+	} else {
+		return esc_url($url);
+	}
+}
+
 # quote unsafe characters in HTML attributes
 sub esc_attr {
 
@@ -2232,7 +2245,7 @@ sub git_get_avatar {
 		return $pre_white .
 		       "<img width=\"$size\" " .
 		            "class=\"avatar\" " .
-		            "src=\"".esc_url($url)."\" " .
+		            "src=\"".esc_url_base($url)."\" " .
 			    "alt=\"\" " .
 		       "/>" . $post_white;
 	} else {
@@ -4099,17 +4112,17 @@ sub print_header_links {
 	# print out each stylesheet that exist, providing backwards capability
 	# for those people who defined $stylesheet in a config file
 	if (defined $stylesheet) {
-		print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
+		print '<link rel="stylesheet" type="text/css" href="'.esc_url_base($stylesheet).'"/>'."\n";
 	} else {
 		foreach my $stylesheet (@stylesheets) {
 			next unless $stylesheet;
-			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
+			print '<link rel="stylesheet" type="text/css" href="'.esc_url_base($stylesheet).'"/>'."\n";
 		}
 	}
 	print_feed_meta()
 		if ($status eq '200 OK');
 	if (defined $favicon) {
-		print qq(<link rel="shortcut icon" href=").esc_url($favicon).qq(" type="image/png" />\n);
+		print qq(<link rel="shortcut icon" href=").esc_url_base($favicon).qq(" type="image/png" />\n);
 	}
 }
 
@@ -4212,11 +4225,6 @@ sub git_header_html {
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
@@ -4234,7 +4242,7 @@ sub git_header_html {
 	if (defined $logo) {
 		print $cgi->a({-href => esc_url($logo_url),
 		               -title => $logo_label},
-		              $cgi->img({-src => esc_url($logo),
+		              $cgi->img({-src => esc_url_base($logo),
 		                         -width => 72, -height => 27,
 		                         -alt => "git",
 		                         -class => "logo"}));
@@ -4299,7 +4307,7 @@ sub git_footer_html {
 		insert_file($site_footer);
 	}
 
-	print qq!<script type="text/javascript" src="!.esc_url($javascript).qq!"></script>\n!;
+	print qq!<script type="text/javascript" src="!.esc_url_base($javascript).qq!"></script>\n!;
 	if (defined $action &&
 	    $action eq 'blame_incremental') {
 		print qq!<script type="text/javascript">\n!.
@@ -8273,7 +8281,7 @@ sub git_feed {
 		if (defined $logo || defined $favicon) {
 			# prefer the logo to the favicon, since RSS
 			# doesn't allow both
-			my $img = esc_url($logo || $favicon);
+			my $img = esc_url_base($logo || $favicon);
 			print "<image>\n" .
 			      "<url>$img</url>\n" .
 			      "<title>$title</title>\n" .
@@ -8299,11 +8307,11 @@ sub git_feed {
 		      # use project owner for feed author
 		      "<author><name>$owner</name></author>\n";
 		if (defined $favicon) {
-			print "<icon>" . esc_url($favicon) . "</icon>\n";
+			print "<icon>" . esc_url_base($favicon) . "</icon>\n";
 		}
 		if (defined $logo) {
 			# not twice as wide as tall: 72 x 27 pixels
-			print "<logo>" . esc_url($logo) . "</logo>\n";
+			print "<logo>" . esc_url_base($logo) . "</logo>\n";
 		}
 		if (! %latest_date) {
 			# dummy date to keep the feed valid until commits trickle in:
-- 
2.21.3

