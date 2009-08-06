From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv5 1/3] gitweb: support to globally disable a snapshot format
Date: Thu, 6 Aug 2009 00:24:53 -0400
Message-ID: <35210404-7E4C-4CB9-881C-45C9E61ACECE@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 06:25:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYuXl-0008Vx-Hv
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbZHFEZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbZHFEZE
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:25:04 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:39125 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750715AbZHFEZD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 00:25:03 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n764Owj8006942
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 6 Aug 2009 00:25:02 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Thu, 06 Aug 2009 00:25:02 -0400 (EDT)
X-Miltered: at mailchk-w05 with ID 4A7A5B1A.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on localhost
X-Virus-Status: Clean
X-UUID: 865fc4c4-be4f-4e2e-a2de-17d9d9f1fde4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125034>

Re-ordered, as suggested by Junio.

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


--->8---
From: Mark Rada <marada@uwaterloo.ca>
Date: Wed, 5 Aug 2009 21:02:54 -0400
Subject: [PATCH 1/3] gitweb: support to globally disable a snapshot  
format

I added an optional variable, 'disabled', to to the
$known_snapshot_formats keys so that a Gitweb administrator can
globally enable or disable a specific format for snapshots.

All formats are enabled by default because project specific overriding
is disabled by default.

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
