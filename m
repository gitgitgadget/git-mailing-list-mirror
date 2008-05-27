From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] gitweb: only display "next" links in logs if there is a next page
Date: Wed, 28 May 2008 01:25:42 +0200
Message-ID: <1211930742-24978-1-git-send-email-LeWiemann@gmail.com>
References: <483C97E7.2020504@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 01:26:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K18Yu-0000Xa-OW
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 01:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbYE0XZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 19:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbYE0XZp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 19:25:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:39881 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbYE0XZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 19:25:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1634956fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=2q9YpHRiJjqtEipxA4MbgnF34TliDqhkB97/GZ/ahPs=;
        b=gYUCDrrEz14hRvUPXQcwgCbdmm51ZSqYVs38kb7/QHzl7mVZ68U7K0aqfAKqge3PEb7PQMFNSFGrRo1ujXfDDPQQKF6f0BTBDuDLkwC+3bvi5CARrh1pPCSlQ9xklx7rYP6cc0lAj9A0viSnuKUnaotzLuAPzAgOvJo40B27T9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=qO+bLZ9tDKnRC0fBrJLbyljuZ3xSeVhVSKSTIMtylZDnolBe24kCM1aEvbHrBw9fRTRzi2vB5S4CMxdcrFtHHsQLlJoR1fXohH8j9oDxjTlf+0re6nLagc7wBZ7XAFvjmJV7EUTbZ/j2pGIHUC6ase3B+LlrvGZ1okBcNbx1/8k=
Received: by 10.86.73.3 with SMTP id v3mr126429fga.68.1211930743402;
        Tue, 27 May 2008 16:25:43 -0700 (PDT)
Received: from fly ( [91.33.209.73])
        by mx.google.com with ESMTPS id 12sm16084253fgg.0.2008.05.27.16.25.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 16:25:42 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K18Y2-0006Vl-H5; Wed, 28 May 2008 01:25:42 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <483C97E7.2020504@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83062>

There was a bug in the implementation of the "next" links in
format_paging_nav (for log and shortlog), which caused the next links
to always be displayed, even if there is no next page.  This fixes it.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8308e22..57a1905 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2756,7 +2756,7 @@ sub git_print_page_nav {
 }
 
 sub format_paging_nav {
-	my ($action, $hash, $head, $page, $nrevs) = @_;
+	my ($action, $hash, $head, $page, $has_next_link) = @_;
 	my $paging_nav;
 
 
@@ -2774,7 +2774,7 @@ sub format_paging_nav {
 		$paging_nav .= " &sdot; prev";
 	}
 
-	if ($nrevs >= (100 * ($page+1)-1)) {
+	if ($has_next_link) {
 		$paging_nav .= " &sdot; " .
 			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
@@ -4665,7 +4665,7 @@ sub git_log {
 
 	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav('log', $hash, $head, $page, (100 * ($page+1)));
+	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
 
 	git_header_html();
 	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
@@ -5585,7 +5585,7 @@ sub git_shortlog {
 
 	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
-	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
+	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, $#commitlist >= 100);
 	my $next_link = '';
 	if ($#commitlist >= 100) {
 		$next_link =
-- 
1.5.5.1
