From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach import-tars about GNU tar's @LongLink extension.
Date: Tue, 1 May 2007 23:42:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705012335530.4010@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue May 01 23:42:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj07Q-000124-4f
	for gcvg-git@gmane.org; Tue, 01 May 2007 23:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945911AbXEAVmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 17:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945962AbXEAVmg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 17:42:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:42431 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945943AbXEAVme (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 17:42:34 -0400
Received: (qmail invoked by alias); 01 May 2007 21:42:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 01 May 2007 23:42:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/z41Jlx37zOxpP+TzIMzN8Xtw1+G849rrGbZHboq
	ky7a6WLw/IRVtu
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45980>


This extension allows GNU tar to process file names in excess of the 100 
characters defined by the original tar standard. It does this by faking a 
file, named '././@LongLink' containing the true file name, and then adding 
the file with a truncated name. The idea is that tar without this 
extension will write out a file with the long file name, and write the 
contents into a file with truncated name.

Unfortunately, GNU tar does a lousy job at times. When truncating results 
in a _directory_ name, it will happily use _that_ as a truncated name for 
the file.

An example where this actually happens is gcc-4.1.2, where the full path 
of the file WeThrowThisExceptionHelper.java truncates _exactly_ before the 
basename. So, we have to support that ad-hoc extension.

This bug was noticed by Chris Riddoch on IRC.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Does anybody know why they decided to limit the LongLink to 256 
	characters, when 512 bytes are wasted _anyway_?

	BTW I am a little too tired to find out why import-tars failed so 
	badly without this patch. It _should_ have behaved like tar
	without that extension. Instead, it tripped completely, losing the 
	correct block boundary.

 contrib/fast-import/import-tars.perl |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index d2363a4..a43b2c5 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -52,6 +52,25 @@ foreach my $tar_file (@ARGV)
 			Z8 Z1 Z100 Z6
 			Z2 Z32 Z32 Z8 Z8 Z*', $_;
 		last unless $name;
+		if ($name eq '././@LongLink') {
+			# GNU tar extension
+			if (read(I, $_, 512) != 512) {
+				die ('Short archive');
+			}
+			$name = unpack 'Z257', $_;
+			next unless $name;
+
+			my $dummy;
+			if (read(I, $_, 512) != 512) {
+				die ('Short archive');
+			}
+			($dummy, $mode, $uid, $gid, $size, $mtime,
+			$chksum, $typeflag, $linkname, $magic,
+			$version, $uname, $gname, $devmajor, $devminor,
+			$prefix) = unpack 'Z100 Z8 Z8 Z8 Z12 Z12
+			Z8 Z1 Z100 Z6
+			Z2 Z32 Z32 Z8 Z8 Z*', $_;
+		}
 		next if $name =~ m{/\z};
 		$mode = oct $mode;
 		$size = oct $size;
-- 
1.5.2.rc1.2428.g1b62-dirty
