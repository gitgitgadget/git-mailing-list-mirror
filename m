From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 04/10] gitweb: nagivation menu for tags, heads and remotes
Date: Sun, 24 Oct 2010 12:45:30 +0200
Message-ID: <1287917136-26103-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5w-0004rf-PI
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467Ab0JXKqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:46:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45935 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464Ab0JXKqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:46:03 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2370311wyf.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AAazEY7NBIOcWcRLSNEx3zRYOn0CSl04NavphykoBss=;
        b=DXfJfEBHfIFrpRdmBSzA2ZrOmDJz2kXO4OaoURPH59Rebvb3NNxiTi4h+MvsHprZrX
         folq1M1zOv1EkPAVCDQVwcrlEHyKlkGCyLWwlsRlw1XWoDy5GKdy+Nl4/QVdvgca+SlT
         iMALY1SJ8dLZfi3eKwtB3qSuf6bOyuSUf++zU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uHKDYTYyZpeEwLufRGKCfoRFJVnQfZgi2gvs8/ET0TKWXBgdFZVV/qQF3LtwzglGIL
         HGJv9FpUrI68t3cCDVRYyZE6TU+KyR/RENuSKUmbI9iVAQCGvcuvpmtzcZNTl/LbVZZl
         mTvOeCCkOlQRaHzzZhuwLWvbFrQUqtU9W2ruc=
Received: by 10.216.87.20 with SMTP id x20mr1629499wee.52.1287917163013;
        Sun, 24 Oct 2010 03:46:03 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id n40sm3310559weq.5.2010.10.24.03.46.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:46:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159852>

tags, heads and remotes are all views that inspect a (particular class
of) refs, so allow the user to easily switch between them by adding
the appropriate navigation submenu to each view.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 667c11b..f4592ad 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3736,6 +3736,19 @@ sub git_print_page_nav {
 	      "</div>\n";
 }
 
+# returns a submenu for the nagivation of the refs views (tags, heads,
+# remotes) with the current view disabled and the remotes view only
+# available if the feature is enabled
+sub format_ref_views {
+	my ($current) = @_;
+	my @ref_views = qw{tags heads};
+	push @ref_views, 'remotes' if gitweb_check_feature('remote_heads');
+	return join " | ", map {
+		$_ eq $current ? $_ :
+		$cgi->a({-href => href(action=>$_)}, $_)
+	} @ref_views
+}
+
 sub format_paging_nav {
 	my ($action, $page, $has_next_link) = @_;
 	my $paging_nav;
@@ -5512,7 +5525,7 @@ sub git_blame_data {
 sub git_tags {
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	git_print_page_nav('','', $head,undef,$head,format_ref_views('tags'));
 	git_print_header_div('summary', $project);
 
 	my @tagslist = git_get_tags_list();
@@ -5525,7 +5538,7 @@ sub git_tags {
 sub git_heads {
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	git_print_page_nav('','', $head,undef,$head,format_ref_views('heads'));
 	git_print_header_div('summary', $project);
 
 	my @headslist = git_get_heads_list(undef, 'heads');
@@ -5541,7 +5554,7 @@ sub git_remotes {
 
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	git_print_page_nav('','', $head,undef,$head,format_ref_views('remotes'));
 	git_print_header_div('summary', $project);
 
 	my @remotelist = git_get_heads_list(undef, 'remotes');
-- 
1.7.3.68.g6ec8
