From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFCv4 3/3] gitweb: link to patch(es) view from commit and log views
Date: Sat,  6 Dec 2008 16:02:35 +0100
Message-ID: <1228575755-13432-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1228575755-13432-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1228575755-13432-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 16:03:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8yhE-0001tF-3t
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 16:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589AbYLFPCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 10:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755964AbYLFPCV
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 10:02:21 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:47170 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589AbYLFPCT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 10:02:19 -0500
Received: by ey-out-2122.google.com with SMTP id 6so180690eyi.37
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 07:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EgwfsPVNS2pCG5NBEJxsDkd6OVq71NO/sNI1pfyPbvA=;
        b=qty+EP/0ZyoErLx6P+1yAEXC4QA+VdWyfZJMOSrQKpEGVXbnkoUPUjgfs5V1t2AWNc
         uf7gBDPFY2t/2xnx2ugjAA/QZrnLCpvsKn0BD3AMOF/koyvfHxEU04p4TDF6vNApisSw
         BrUmshDwTOA4vkzNVPFjGOEHx0V6UCXvYcaUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n11oenHJsldGytdmmDOfdciISlI/oOcHB+7mmli8hGLhUZXbNTW5gYWCcTLxDqMiz9
         vN59rHu1Qb8TdPqgqi4ZYwUeE/RfI6XmdSu2bcL10ZY26Q0EF+EWNsDqsj4K+wJxVeV4
         s0pPMUHQCj3opVzGRElUKT6IAAG2iKDMlZj1s=
Received: by 10.210.88.7 with SMTP id l7mr780140ebb.130.1228575738196;
        Sat, 06 Dec 2008 07:02:18 -0800 (PST)
Received: from localhost ([78.13.53.163])
        by mx.google.com with ESMTPS id f4sm2875676nfh.61.2008.12.06.07.02.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 07:02:17 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1228575755-13432-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102460>

We link to patch view in commit and commitdiff view, and to patches view
in log and shortlog view.

In (short)log view, the link is only offered when the number of commits
shown is no more than the allowed maximum number of patches.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dfc7128..8198875 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5019,6 +5019,15 @@ sub git_log {
 
 	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
 
+	my $patch_max = gitweb_check_feature('patches');
+	if ($patch_max) {
+		if ($patch_max < 0 || @commitlist <= $patch_max) {
+			$paging_nav .= " &sdot; " .
+				$cgi->a({-href => href(action=>"patches", -replay=>1)},
+					@commitlist > 1 ? "patchset" : "patch");
+		}
+	}
+
 	git_header_html();
 	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
 
@@ -5098,6 +5107,11 @@ sub git_commit {
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
@@ -5413,9 +5427,8 @@ sub git_commitdiff {
 	# if only a single commit is passed?
 	my $single_patch = shift && 1;
 
-	my $patch_max;
+	my $patch_max = gitweb_check_feature('patches');
 	if ($format eq 'patch') {
-		$patch_max = gitweb_check_feature('patches');
 		die_error(403, "Patch view not allowed") unless $patch_max;
 	}
 
@@ -5433,6 +5446,11 @@ sub git_commitdiff {
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
@@ -5989,6 +6007,14 @@ sub git_shortlog {
 			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
+	my $patch_max = gitweb_check_feature('patches');
+	if ($patch_max) {
+		if ($patch_max < 0 || @commitlist <= $patch_max) {
+			$paging_nav .= " &sdot; " .
+				$cgi->a({-href => href(action=>"patches", -replay=>1)},
+					@commitlist > 1 ? "patchset" : "patch");
+		}
+	}
 
 	git_header_html();
 	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-- 
1.5.6.5
