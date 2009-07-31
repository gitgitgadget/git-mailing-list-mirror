From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv3] Gitweb support for XZ compressed snapshots
Date: Thu, 30 Jul 2009 22:43:01 -0400
Message-ID: <A51E105D-8E32-4EDE-9D56-16BB88498D37@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 04:43:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWi5Z-0005rv-4d
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 04:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbZGaCnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 22:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbZGaCnK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 22:43:10 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:57848 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268AbZGaCnK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 22:43:10 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n6V2h6HE027714
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 30 Jul 2009 22:43:09 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Thu, 30 Jul 2009 22:43:09 -0400 (EDT)
X-Miltered: at mailchk-w04 with ID 4A725A3A.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at minos
X-Virus-Status: Clean
X-UUID: d1b0296f-a36c-466c-bc14-2d11d5a05b0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124499>

Fix'd


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


----->8-------
From: Mark Rada <marada@uwaterloo.ca>
Date: Thu, 30 Jul 2009 08:56:42 -0400
Subject: [PATCH] Gitweb support for XZ compressed snapshots

The XZ compression format uses the LZMA compression algorithm, which
generally is capable of yielding higher compression ratios than both
GZip and BZip2 at the cost of using more CPU time and RAM (lots more).
It is relevant to note that while LZMA is the slowest of the mentioned
algorithms for compression, it is much faster than BZip2 for
decompression (but still slower than GZip).

You can enable XZ compressed snapshots by adding 'txz' to the list of
default options for snapshots in $GITWEB_CONFIG or adding txz to an
individual repository using the gitweb.snapshot variable for the config
file.

I did some simple benchmarks, starting with an already tarballed
archive of the repos listed below. Memory usage seemed to be consistent
for any given algorithm. All tests done at default compression level.

CPU: AMD Sempron 3400+ (1 core @ 1.8GHz with 256K L2 cache)

			Virtual Memory
			GZip: 	 4152K
			BZip2: 	13352K
			XZ: 	  102M

Linux 2.6 series (f5886c7f96f2542382d3a983c5f13e03d7fc5259) 	349M
gzip 	23.70s user    	0.47s system  	99% cpu  24.227 total 	76M
gunzip 	3.74s user     	0.74s system  	94% cpu  4.741 total
bzip2 	130.96s user   	0.53s system  	99% cpu  2:11.97 total 	59M
bunzip2 31.05s user    	1.02s system  	99% cpu  32.355 total
xz 	448.78s user 	0.91s system  	99% cpu  7:31.28 total 	51M
unxz 	7.67s user     	0.80s system  	98% cpu  8.607 total

Git (0a53e9ddeaddad63ad106860237bbf53411d11a7) 			11M
gzip 	0.77s user 	0.03s system 	99% cpu  0.792 total 	2.5M
gunzip 	0.12s user 	0.02s system 	98% cpu  0.142 total
bzip2 	3.42s user 	0.02s system 	99% cpu  3.454 total 	2.1M
bunzip2 0.95s user 	0.03s system 	99% cpu  0.984 total
xz 	12.88s user 	0.14s system 	98% cpu  13.239 total 	1.9M
unxz 	0.27s user 	0.03s system 	99% cpu  0.298 total

XZ (669413bb2db954bbfde3c4542fddbbab53891eb4) 			1.8M
xz 	1.62s user 	0.03s system 	99% cpu  1.652 total 	442K
unxz   	0.05s user 	0.00s system 	99% cpu  0.058 total
bzip2  	1.28s user 	0.01s system 	99% cpu  1.298 total 	363K
bunzip2 0.15s user 	0.01s system 	100% cpu 0.157 total
gzip  	0.12s user 	0.00s system 	95% cpu  0.132 total 	347K
gunzip 	0.02s user 	0.00s system 	97% cpu  0.027 total

I don't think it should be the default format, at least not right now,
simply because the XZ format is still fairly new (the format was
declared stable about 6 months ago), and there have been no "stable"
releases of the utils yet.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/gitweb.perl |    8 ++++++++
  1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fbd5ff..3398163 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -176,6 +176,13 @@ our %known_snapshot_formats = (
  		'format' => 'tar',
  		'compressor' => ['bzip2']},

+	'txz' => {
+		'display' => 'tar.xz',
+		'type' => 'application/x-xz',
+		'suffix' => '.tar.xz',
+		'format' => 'tar',
+		'compressor' => ['xz']},
+
  	'zip' => {
  		'display' => 'zip',
  		'type' => 'application/x-zip',
@@ -188,6 +195,7 @@ our %known_snapshot_formats = (
  our %known_snapshot_format_aliases = (
  	'gzip'  => 'tgz',
  	'bzip2' => 'tbz2',
+	'xz'    => 'txz',

  	# backward compatibility: legacy gitweb config support
  	'x-gzip' => undef, 'gz' => undef,
-- 
1.6.4
