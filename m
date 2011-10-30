From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 8/8] gitweb: Add navigation to select side-by-side diff
Date: Mon, 31 Oct 2011 00:36:27 +0100
Message-ID: <1320017787-18048-9-git-send-email-jnareb@gmail.com>
References: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:46:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKf50-0007Qm-LQ
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab1J3XqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:46:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46881 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab1J3XqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:46:14 -0400
Received: by faan17 with SMTP id n17so5070909faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JCfS2Q7G64p8CwzY5jVr5vJpUWap2NTamMMgqnDdOmc=;
        b=sUdttRX62sq09xgy2i376RoE6U81oio4BWoL+OI0gsS3XxaagT597+TKfK3rURcm6I
         gnCrf0R3TAY5dlC6fzrBQBwP7vCm8aj/WcGsRpli1AsvB6Yg3j6km8V/tLQogL5zWZIS
         fmyr36Qbm8aS7S0BZeOr0lAfDK95tXOtS2dCg=
Received: by 10.223.14.3 with SMTP id e3mr25445299faa.25.1320018372893;
        Sun, 30 Oct 2011 16:46:12 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id a26sm19652514fac.2.2011.10.30.16.46.11
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 16:46:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184487>

From: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>

Add to the lower part of navigation bar (the action specific part)
links allowing to switch between 'inline' (ordinary) diff and
'side by side' style diff.

It is not shown for combined / compact combined diff.

Signed-off-by: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was originally part of other commit, but was split into a
separate patch.

Note that "blobdiff" should probably also get this navigation.

 gitweb/gitweb.perl |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ffaea45..f80f259 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7164,6 +7164,7 @@ sub git_blobdiff {
 		my $formats_nav =
 			$cgi->a({-href => href(action=>"blobdiff_plain", -replay=>1)},
 			        "raw");
+		$formats_nav .= diff_style_nav($diff_style);
 		git_header_html(undef, $expires);
 		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
@@ -7221,6 +7222,27 @@ sub git_blobdiff_plain {
 	git_blobdiff('plain');
 }
 
+# assumes that it is added as later part of already existing navigation,
+# so it returns "| foo | bar" rather than just "foo | bar"
+sub diff_style_nav {
+	my ($diff_style, $is_combined) = @_;
+	$diff_style ||= 'inline';
+
+	return "" if ($is_combined);
+
+	my @styles = (inline => 'inline', 'sidebyside' => 'side by side');
+	my %styles = @styles;
+	@styles =
+		@styles[ map { $_ * 2 } 0..$#styles/2 ];
+
+	return join '',
+		map { " | ".$_ }
+		map {
+			$_ eq $diff_style ? $styles{$_} :
+			$cgi->a({-href => href(-replay=>1, diff_style => $_)}, $styles{$_})
+		} @styles;
+}
+
 sub git_commitdiff {
 	my %params = @_;
 	my $format = $params{-format} || 'html';
@@ -7250,6 +7272,7 @@ sub git_commitdiff {
 				$cgi->a({-href => href(action=>"patch", -replay=>1)},
 					"patch");
 		}
+		$formats_nav .= diff_style_nav($diff_style, @{$co{'parents'}} > 1);
 
 		if (defined $hash_parent &&
 		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
-- 
1.7.6
