From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCH 1/3] gitweb: support to globally disable a snapshot format
Date: Thu, 6 Aug 2009 10:25:39 -0400
Message-ID: <3A789521-06A0-4762-8E13-FFCF737D041D@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 16:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ3un-0000DF-UE
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 16:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZHFOZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 10:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbZHFOZt
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 10:25:49 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:62032 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752782AbZHFOZt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 10:25:49 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n76EPjCT000257
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 6 Aug 2009 10:25:48 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Thu, 06 Aug 2009 10:25:49 -0400 (EDT)
X-Miltered: at mailchk-m04 with ID 4A7AE7E9.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on localhost
X-Virus-Status: Clean
X-UUID: 6b05e162-01f8-446d-bdf8-c868de142dca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125070>

Allow Gitweb administrators to set a 'disabled' key in the
%known_snapshot_formats hash to disable a specific snapshot format.

All formats are enabled by default to maintain backwards compatibility.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/gitweb.perl |    8 ++++++--
  1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 37120a3..a0cdf31 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -160,7 +160,8 @@ our %known_snapshot_formats = (
  	# 	'suffix' => filename suffix,
  	# 	'format' => --format for git-archive,
  	# 	'compressor' => [compressor command and arguments]
-	# 	                (array reference, optional)}
+	# 	                (array reference, optional)
+	# 	'disabled' => boolean (optional)}
  	#
  	'tgz' => {
  		'display' => 'tar.gz',
@@ -494,7 +495,8 @@ sub filter_snapshot_fmts {
  		exists $known_snapshot_format_aliases{$_} ?
  		       $known_snapshot_format_aliases{$_} : $_} @fmts;
  	@fmts = grep {
-		exists $known_snapshot_formats{$_} } @fmts;
+		exists $known_snapshot_formats{$_} &&
+		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
  }

  our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
@@ -5166,6 +5168,8 @@ sub git_snapshot {
  		die_error(400, "Unknown snapshot format");
  	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
  		die_error(403, "Unsupported snapshot format");
+	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
+		die_error(403, "Snapshot format not allowed");
  	}

  	if (!defined $hash) {
-- 
1.6.4
