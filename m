From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv4 2/3] gitweb: support to globally disable a snapshot format
Date: Wed, 5 Aug 2009 09:19:53 -0400
Message-ID: <CDA93DD6-D1FA-4F8A-84D8-FA9A8493FBF9@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 15:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYgPc-0004SZ-57
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 15:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934304AbZHENTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 09:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934290AbZHENTy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 09:19:54 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:34577 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933716AbZHENTx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 09:19:53 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n75DJgga011477
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 5 Aug 2009 09:19:53 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Wed, 05 Aug 2009 09:19:53 -0400 (EDT)
X-Miltered: at psyche with ID 4A7986EE.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on localhost
X-Virus-Status: Clean
X-UUID: b344ec9c-2d49-414a-80b3-d6fedb8e70e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124904>

Now XZ is disabled by default.


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


------->8------------
From: Mark Rada <marada@uwaterloo.ca>
Date: Sat, 1 Aug 2009 13:24:03 -0400
Subject: [PATCH 2/3] gitweb: support to globally disable a snapshot  
format

I added an optional variable, 'disabled', to to the
$known_snapshot_formats keys so that a Gitweb administrator can
globally enable or disable a specific format for snapshots.

All formats are enabled by default, except for the txz format
(explained below), because project specific overriding is disabled by
default.

The txz format is disabled as it is still new and has relatively high
resource requirements (ref. 4f1c1fb73b4cdaf4bcf817fb2af99bd71f1ca61f).

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/gitweb.perl |   11 ++++++++---
  1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3398163..5a628fa 100755
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
@@ -181,7 +182,8 @@ our %known_snapshot_formats = (
  		'type' => 'application/x-xz',
  		'suffix' => '.tar.xz',
  		'format' => 'tar',
-		'compressor' => ['xz']},
+		'compressor' => ['xz'],
+		'disabled' => 1},

  	'zip' => {
  		'display' => 'zip',
@@ -502,7 +504,8 @@ sub filter_snapshot_fmts {
  		exists $known_snapshot_format_aliases{$_} ?
  		       $known_snapshot_format_aliases{$_} : $_} @fmts;
  	@fmts = grep {
-		exists $known_snapshot_formats{$_} } @fmts;
+		exists $known_snapshot_formats{$_} &&
+		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
  }

  our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
@@ -5171,6 +5174,8 @@ sub git_snapshot {
  		die_error(400, "Unknown snapshot format");
  	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
  		die_error(403, "Unsupported snapshot format");
+	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
+		die_error(403, "Snapshot format not allowed");
  	}

  	if (!defined $hash) {
-- 
1.6.4
