From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 3/3] gitweb: link to patch(es) view in commit(diff) and (short)log view
Date: Tue, 16 Dec 2008 11:11:30 +0100
Message-ID: <1229422290-6213-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1229422290-6213-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1229422290-6213-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 11:13:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCWvX-0001zn-2I
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 11:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbYLPKLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 05:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbYLPKLo
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 05:11:44 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:46170 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbYLPKLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 05:11:42 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so3470952bwz.13
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 02:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6ErbfCiOOVCmlFhdXftMk2D/zTN8q7ol4a4hXV2W53s=;
        b=CgRtxtUjp8zs3zRfzFB2L/LQhG7l0cmGd5K0MfZmMiZbLqQLeBAO7fs8DnYkcSNHlL
         jcaPGg1QirWuIImAoE8IBtT0GgI9UVtTgxXXI6TyjTL8CEOApFbR8scsHkRS8hMF8Vjx
         VVesRukITSx7HG7BiwH5choCZYVRw5s3ePzJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LEO/q+2YtDk6QI4OT8zxM5JojfLP2s+iw+0WAasFsus1ROnNs04Zppr+EM9cAd4CSX
         40cbITyMe0UxeiPRglSm7H1u6knTcfNAcdqCjR6B5wETCPIWRo66czzcYzz2ctJgjiq9
         6XNYHhNE6h10xUKtScgV6V84SXiNy2PWp7ZNY=
Received: by 10.223.114.207 with SMTP id f15mr7675026faq.90.1229422301232;
        Tue, 16 Dec 2008 02:11:41 -0800 (PST)
Received: from localhost ([78.13.57.58])
        by mx.google.com with ESMTPS id k29sm9352559fkk.23.2008.12.16.02.11.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Dec 2008 02:11:40 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1229422290-6213-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103267>

We link to patch view in commit and commitdiff view, and to patches view
in log and shortlog view.

In (short)log view, the link is only offered when the number of commits
shown is no more than the allowed maximum number of patches.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e7a6477..168deb7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5024,6 +5024,15 @@ sub git_log {
 
 	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
 
+	my ($patch_max) = gitweb_get_feature('patches');
+	if ($patch_max) {
+		if ($patch_max < 0 || @commitlist <= $patch_max) {
+			$paging_nav .= " &sdot; " .
+				$cgi->a({-href => href(action=>"patches", -replay=>1)},
+					"patches");
+		}
+	}
+
 	git_header_html();
 	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
 
@@ -5103,6 +5112,11 @@ sub git_commit {
 			} @$parents ) .
 			')';
 	}
+	if (gitweb_check_feature('patches')) {
+		$formats_nav .= " | " .
+			$cgi->a({-href => href(action=>"patch", -replay=>1)},
+				"patch");
+	}
 
 	if (!defined $parent) {
 		$parent = "--root";
@@ -5416,9 +5430,8 @@ sub git_commitdiff {
 	my $format = shift || 'html';
 	my %params = @_;
 
-	my $patch_max;
+	my ($patch_max) = gitweb_get_feature('patches');
 	if ($format eq 'patch') {
-		($patch_max) = gitweb_get_feature('patches');
 		die_error(403, "Patch view not allowed") unless $patch_max;
 	}
 
@@ -5436,6 +5449,11 @@ sub git_commitdiff {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
 			        "raw");
+		if ($patch_max) {
+			$formats_nav .= " | " .
+				$cgi->a({-href => href(action=>"patch", -replay=>1)},
+					"patch");
+		}
 
 		if (defined $hash_parent &&
 		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
@@ -5992,6 +6010,14 @@ sub git_shortlog {
 			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
+	my $patch_max = gitweb_check_feature('patches');
+	if ($patch_max) {
+		if ($patch_max < 0 || @commitlist <= $patch_max) {
+			$paging_nav .= " &sdot; " .
+				$cgi->a({-href => href(action=>"patches", -replay=>1)},
+					"patches");
+		}
+	}
 
 	git_header_html();
 	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-- 
1.5.6.5
