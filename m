From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 04/12] gitweb: nagivation menu for tags, heads and remotes
Date: Fri, 24 Sep 2010 18:02:39 +0200
Message-ID: <1285344167-8518-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAkH-0005n3-Ph
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846Ab0IXQDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:03:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53181 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab0IXQDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:03:18 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so25969wwd.1
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VBgQKdx+930FcM115nCeJxWBZdY8LpArgIGopioSi/Y=;
        b=OxbS0Vg2ayZJ+NCMMfnq8qUpQHpPcuLOGAkD5AniOpdoI4faTLMbFaMWpfV3SA95Q5
         iQg/B6TaxGJhKl/HRayQN287rc/NEXr80+KUxzbYpb5u6ZqC1yRtCFJTtMrgYNaRl6n0
         VzvB0AfFRHOGTkgBxwyC9nl2jWeRgnjDEw9Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LRlZRMF8FfO9M8e63kHkapqvrJuQzenYjBcDWg8GggL12O5qEziPThRh+a28+1Fflv
         R7GZIfKUvTxQqMpaHxTEIwxOfSwYBa+orzkoFmveeIycMf32ICQiyYRqCvUQ6iRJeLVc
         rS/5yWhVKX9rc3hhXkQXyNTHkna8uS4GV8AUQ=
Received: by 10.216.3.19 with SMTP id 19mr2232824weg.108.1285344198069;
        Fri, 24 Sep 2010 09:03:18 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id k7sm1434624wej.2.2010.09.24.09.03.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:03:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157003>

tags, heads and remotes are all views that inspect a (particular class
of) refs, so allow the user to easily switch between them by adding
the appropriate navigation submenu to each view.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fe9f73e..c3ce7a3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3721,6 +3721,20 @@ sub git_print_page_nav {
 	      "</div>\n";
 }
 
+# returns a submenu for the nagivation of the refs views (tags, heads,
+# remotes) with the current view disabled and the remotes view only
+# available if the feature is enabled
+
+sub format_ref_views {
+	my ($current) = @_;
+	my @ref_views = qw{tags heads};
+	push @ref_views, 'remotes' if gitweb_check_feature('remote_heads');
+	return join " | ", map {
+		$_ eq $current ? $_ :
+		$cgi->a({-href => href(action=>$_, -replay=>1)}, $_)
+	} @ref_views
+}
+
 sub format_paging_nav {
 	my ($action, $page, $has_next_link) = @_;
 	my $paging_nav;
@@ -5497,7 +5511,7 @@ sub git_blame_data {
 sub git_tags {
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	git_print_page_nav('','', $head,undef,$head,format_ref_views('tags'));
 	git_print_header_div('summary', $project);
 
 	my @tagslist = git_get_tags_list();
@@ -5510,7 +5524,7 @@ sub git_tags {
 sub git_heads {
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	git_print_page_nav('','', $head,undef,$head,format_ref_views('heads'));
 	git_print_header_div('summary', $project);
 
 	my @headslist = git_get_heads_list(undef, 'heads');
@@ -5526,7 +5540,7 @@ sub git_remotes {
 
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	git_print_page_nav('','', $head,undef,$head,format_ref_views('remotes'));
 	git_print_header_div('summary', $project);
 
 	my @remotelist = git_get_heads_list(undef, 'remotes');
-- 
1.7.3.68.g6ec8
