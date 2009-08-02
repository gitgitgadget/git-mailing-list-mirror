From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv3 2/3] gitweb: support to globally disable a snapshot format
Date: Sat, 1 Aug 2009 22:53:22 -0400
Message-ID: <BFCA40C6-A2D8-4BCD-9F9A-57CBC5AFFC6A@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 04:53:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXRCf-00008K-AN
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 04:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbZHBCxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 22:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbZHBCx1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 22:53:27 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:40063 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751730AbZHBCxW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 22:53:22 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n722rGjT019601
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 1 Aug 2009 22:53:22 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sat, 01 Aug 2009 22:53:22 -0400 (EDT)
X-Miltered: at mailchk-m01 with ID 4A74FF9D.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-x02
X-Virus-Status: Clean
X-UUID: 84c95c79-2153-417d-8167-2cc6e4b374f6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124656>

I decided to go with the less intrusive change...


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


--------->8------------
From: Mark Rada <marada@uwaterloo.ca>
Date: Sat, 1 Aug 2009 13:24:03 -0400
Subject: [PATCH 2/3] gitweb: support to globally disable a snapshot  
format

I added a 'disabled' variable to to the $known_snapshot_formats keys so
that a Gitweb administrator can globally enable or disable a specific
format for snapshots.

All formats are enabled by default because project specific overriding
is disabled by default.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/gitweb.perl |    8 ++++++--
  1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3398163..04aa7b2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -160,7 +160,8 @@ our %known_snapshot_formats = (
  	# 	'suffix' => filename suffix,
  	# 	'format' => --format for git-archive,
  	# 	'compressor' => [compressor command and arguments]
-	# 	                (array reference, optional)}
+	# 	                (array reference, optional),
+	# 	'disabled' => boolean (optional)}
  	#
  	'tgz' => {
  		'display' => 'tar.gz',
@@ -502,7 +503,8 @@ sub filter_snapshot_fmts {
  		exists $known_snapshot_format_aliases{$_} ?
  		       $known_snapshot_format_aliases{$_} : $_} @fmts;
  	@fmts = grep {
-		exists $known_snapshot_formats{$_} } @fmts;
+		exists $known_snapshot_formats{$_} &&
+		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
  }

  our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
@@ -5171,6 +5173,8 @@ sub git_snapshot {
  		die_error(400, "Unknown snapshot format");
  	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
  		die_error(403, "Unsupported snapshot format");
+	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
+		die_error(403, "Snapshot format not allowed");
  	}

  	if (!defined $hash) {
-- 
1.6.4
