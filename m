From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] gitweb: only display "next" links in logs if there is a next page
Date: Wed, 28 May 2008 00:31:10 +0200
Message-ID: <1211927470-21170-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 00:32:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K17iA-0003zy-CV
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 00:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949AbYE0WbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 18:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756912AbYE0WbN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 18:31:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:13865 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892AbYE0WbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 18:31:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1626249fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=UwHfrxG/FhuaST9eVPF+dZ19gvkrFEZmhzo+6Di9jHk=;
        b=pyaat8neSvmgMH0CHTuyA4F1C/4ufpuCIJhJREm3smPOntrrAWfVHJ68x6UEMtW9BbMOFvsfP0XXVKahvRVy8iPqfviFnIno44Tb22EOoGljsWMVI9oJ8Ru7Df/HYMqMau9ZdbWBMPNUss15M76OI+zhRio85qePXigJNdakCxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=FJB3okv2P4JSKg1QD0ZkdmmCNjK7hthw5arP249ynSFZjDKnh8NnJeaIft1n6grCrIANP8dYugZdh2GJJxHAqdwMh4SYCpdjxa/CZao15kK/LfxMqXbqpguia//q8LcnhsPp97FF/Xn/ttzna9n6F56ph1im7GM/1d6IXVQPpnA=
Received: by 10.86.97.7 with SMTP id u7mr7971697fgb.19.1211927470823;
        Tue, 27 May 2008 15:31:10 -0700 (PDT)
Received: from fly ( [91.33.209.73])
        by mx.google.com with ESMTPS id a37sm25321145fkc.14.2008.05.27.15.31.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 15:31:10 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K17hG-0005Vm-BW; Wed, 28 May 2008 00:31:10 +0200
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83054>

There was a bug in the implementation of the "next" links in
format_paging_nav (for log and shortlog), which caused the next links
to always be displayed, even if there is no next page.  This fixes it.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 308fde2..874f53a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2752,7 +2752,7 @@ sub git_print_page_nav {
 }
 
 sub format_paging_nav {
-	my ($action, $hash, $head, $page, $has_more_pages) = @_;
+	my ($action, $hash, $head, $page, $has_next_link) = @_;
 	my $paging_nav;
 
 
@@ -2770,7 +2770,7 @@ sub format_paging_nav {
 		$paging_nav .= " &sdot; prev";
 	}
 
-	if ($has_more_pages) {
+	if ($has_next_link) {
 		$paging_nav .= " &sdot; " .
 			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
@@ -4661,7 +4661,7 @@ sub git_log {
 
 	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist > 99);
+	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
 
 	git_header_html();
 	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
@@ -5581,7 +5581,7 @@ sub git_shortlog {
 
 	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#commitlist > 99);
+	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#commitlist >= 100);
 	my $next_link = '';
 	if ($#commitlist >= 100) {
 		$next_link =
-- 
1.5.5.1
