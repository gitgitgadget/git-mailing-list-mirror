From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Time::HiRes is in core for Perl 5.8
Date: Tue, 09 Nov 2010 19:27:54 +0100
Message-ID: <20101109182754.15256.996.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 19:28:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFsvq-0003RG-Ta
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 19:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab0KIS21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 13:28:27 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33408 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab0KIS21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 13:28:27 -0500
Received: by ywc21 with SMTP id 21so4526329ywc.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 10:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=sxQYc/yq5FjMBwfaUfbAql/KzMOpPK0xXLu5YqEihbM=;
        b=IuxrXJm1KEsR+qpLjWaHoBk8YshMoQgFMiNNWybqHwb400cILeJ9fsBucXp1J1Zi66
         CjVb3/9FaaIgq/6kjxHAVYcVQyZvMf2K1cuV6v94YnDdAeF6eqzn5IkGN7CAyuVMiC8y
         PvlFn0YMd1OQD8Oa0LttmdLsat8lc786SkuBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=UPI/qegyZqnCLWWG+/OOHuEowuXSj1Ia1fTvRtocQMJ9flCZEUNBHsbewoK+1gx4Su
         qYU8pHbPtsuuxZUax7GS3AuS8D/nax7FJM8tTklDkhQ+YtFJI5qeGNQNAtjynC90Ai7j
         JXPHkrvAWNWVuGlzJr2YGEkqRWh3OEeimQFTo=
Received: by 10.204.99.68 with SMTP id t4mr6865954bkn.40.1289327303046;
        Tue, 09 Nov 2010 10:28:23 -0800 (PST)
Received: from localhost.localdomain (abwj130.neoplus.adsl.tpnet.pl [83.8.233.130])
        by mx.google.com with ESMTPS id g8sm1247812bkg.11.2010.11.09.10.28.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 10:28:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oA9IRtR8015284;
	Tue, 9 Nov 2010 19:28:06 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161063>



Therefore there is no need to check if it is installed.  We can also
import gettimeofday and tv_interval.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5445159..0813479 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -17,12 +17,10 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
+use Time::HiRes qw(gettimeofday tv_interval);
 binmode STDOUT, ':utf8';
 
-our $t0;
-if (eval { require Time::HiRes; 1; }) {
-	$t0 = [Time::HiRes::gettimeofday()];
-}
+our $t0 = [ gettimeofday() ];
 our $number_of_git_cmds = 0;
 
 BEGIN {
@@ -1065,7 +1063,7 @@ sub dispatch {
 }
 
 sub reset_timer {
-	our $t0 = [Time::HiRes::gettimeofday()]
+	our $t0 = [ gettimeofday() ]
 		if defined $t0;
 	our $number_of_git_cmds = 0;
 }
@@ -3601,7 +3599,7 @@ sub git_footer_html {
 		print "<div id=\"generating_info\">\n";
 		print 'This page took '.
 		      '<span id="generating_time" class="time_span">'.
-		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
+		      tv_interval($t0, [ gettimeofday() ]).
 		      ' seconds </span>'.
 		      ' and '.
 		      '<span id="generating_cmd">'.
@@ -5310,7 +5308,7 @@ sub git_blame_common {
 		print 'END';
 		if (defined $t0 && gitweb_check_feature('timed')) {
 			print ' '.
-			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
+			      tv_interval($t0, [ gettimeofday() ]).
 			      ' '.$number_of_git_cmds;
 		}
 		print "\n";
