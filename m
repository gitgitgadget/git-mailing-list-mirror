From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 05/11] gitweb: nagivation menu for tags, heads and remotes
Date: Thu, 11 Nov 2010 13:26:12 +0100
Message-ID: <1289478378-15604-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:27:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWF5-0000Sd-RY
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493Ab0KKM0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57901 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab0KKM0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:40 -0500
Received: by mail-ww0-f44.google.com with SMTP id 29so64691wwb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4ublMxvvjdKXJW2n3zW8Du2hx0Zdm/gLNK+Vko8mdws=;
        b=L4PXcVhxtbGia0EEhWowM5m4jpxPof9ZaD2z4yCl9Wx5FzfbWrd0H1SpgP2685nxXF
         GMjIUJCLAAZaoZF6ZdGaiWI6qcliN7pqK/v63P+3/NfEz+Q5JmkTLtj171xel5n35aU9
         dDtXO8MzB35v6tT02yzOZnRMX+JgeApxaxljo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RB53MKAbT27z5jXokTnWnbwF27cNhtZCXV6UB5p2Usu2O3yOEVjgPx/6aMTv3Hez9+
         DdsxlUoRkm4W95h67DPweRuB/SOzxpVw+PjzOI5htpt25tQ8PjJDrBFqpovDaTjTppRh
         /ScJdrchWtx9LCFlhJn5tzvixuL/m074eG8sU=
Received: by 10.216.191.215 with SMTP id g65mr2311812wen.16.1289478399002;
        Thu, 11 Nov 2010 04:26:39 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id w41sm1243847weq.8.2010.11.11.04.26.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:38 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161238>

tags, heads and remotes are all views that inspect a (particular class
of) refs, so allow the user to easily switch between them by adding
the appropriate navigation submenu to each view.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9fcbbb2..7cd50d4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3733,6 +3733,19 @@ sub git_print_page_nav {
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
@@ -5509,7 +5522,7 @@ sub git_blame_data {
 sub git_tags {
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	git_print_page_nav('','', $head,undef,$head,format_ref_views('tags'));
 	git_print_header_div('summary', $project);
 
 	my @tagslist = git_get_tags_list();
@@ -5522,7 +5535,7 @@ sub git_tags {
 sub git_heads {
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	git_print_page_nav('','', $head,undef,$head,format_ref_views('heads'));
 	git_print_header_div('summary', $project);
 
 	my @headslist = git_get_heads_list();
@@ -5538,7 +5551,7 @@ sub git_remotes {
 
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	git_print_page_nav('','', $head,undef,$head,format_ref_views('remotes'));
 	git_print_header_div('summary', $project);
 
 	my @remotelist = git_get_heads_list(undef, 'remotes');
-- 
1.7.3.68.g6ec8
