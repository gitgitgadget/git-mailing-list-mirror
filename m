From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv2 2/2] gitweb: support to globally enable/disable a snapshot format
Date: Sat, 1 Aug 2009 16:06:49 -0400
Message-ID: <1CE4F545-1ACA-4786-B0F2-EE7C746E6585@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 22:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXKr5-0006NC-15
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 22:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZHAUGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 16:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbZHAUGv
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 16:06:51 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:56780 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752203AbZHAUGu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 16:06:50 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n71K6I4Y019245
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 1 Aug 2009 16:06:50 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sat, 01 Aug 2009 16:06:50 -0400 (EDT)
X-Miltered: at mailchk-m03 with ID 4A74A03A.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on localhost
X-Virus-Status: Clean
X-UUID: e1f9a144-8dd0-4056-9b3f-4d37b57623f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124646>

Comments? I've integrated Jakub Narebski's  suggestions.


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


------->8-------------
From: Mark Rada <marada@uwaterloo.ca>
Date: Sat, 1 Aug 2009 13:24:03 -0400
Subject: [PATCH 2/2] gitweb: support to globally enable/disable a  
snapshot format

I added a 'disabled' variable to to the $known_snapshot_formats keys so
that a Gitweb administrator can globally enable or disable a specific
format for snapshots.

All formats are enabled by default because project specific overriding
is disabled by default.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/gitweb.perl |   17 ++++++++++++-----
  1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3398163..a59569f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -167,27 +167,31 @@ our %known_snapshot_formats = (
  		'type' => 'application/x-gzip',
  		'suffix' => '.tar.gz',
  		'format' => 'tar',
-		'compressor' => ['gzip']},
+		'compressor' => ['gzip'],
+		'disabled' => 0},

  	'tbz2' => {
  		'display' => 'tar.bz2',
  		'type' => 'application/x-bzip2',
  		'suffix' => '.tar.bz2',
  		'format' => 'tar',
-		'compressor' => ['bzip2']},
+		'compressor' => ['bzip2'],
+		'disabled' => 0},

  	'txz' => {
  		'display' => 'tar.xz',
  		'type' => 'application/x-xz',
  		'suffix' => '.tar.xz',
  		'format' => 'tar',
-		'compressor' => ['xz']},
+		'compressor' => ['xz'],
+		'disabled' => 0},

  	'zip' => {
  		'display' => 'zip',
  		'type' => 'application/x-zip',
  		'suffix' => '.zip',
-		'format' => 'zip'},
+		'format' => 'zip',
+		'disabled' => 0},
  );

  # Aliases so we understand old gitweb.snapshot values in repository
@@ -502,7 +506,8 @@ sub filter_snapshot_fmts {
  		exists $known_snapshot_format_aliases{$_} ?
  		       $known_snapshot_format_aliases{$_} : $_} @fmts;
  	@fmts = grep {
-		exists $known_snapshot_formats{$_} } @fmts;
+		exists $known_snapshot_formats{$_} &&
+		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
  }

  our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
@@ -5171,6 +5176,8 @@ sub git_snapshot {
  		die_error(400, "Unknown snapshot format");
  	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
  		die_error(403, "Unsupported snapshot format");
+	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
+		die_error(403, "Snapshot format not allowed");
  	}

  	if (!defined $hash) {
-- 
1.6.4
