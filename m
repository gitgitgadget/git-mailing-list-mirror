From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv5] Add Gitweb support for XZ compressed snapshots
Date: Fri, 31 Jul 2009 20:40:33 -0400
Message-ID: <B05AF655-7430-420A-A22E-389601558B0D@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 02:40:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MX2ed-0001UM-UR
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 02:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbZHAAkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 20:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbZHAAkm
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 20:40:42 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:44806 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751862AbZHAAkm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 20:40:42 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n710ecSf002925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 31 Jul 2009 20:40:41 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Fri, 31 Jul 2009 20:40:41 -0400 (EDT)
X-Miltered: at psyche with ID 4A738F06.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m01
X-Virus-Status: Clean
X-UUID: 0ded884d-2c28-4de2-8bdd-f23c7be95f04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124602>


 >Note that for me the above results are not aligned in table.
 >This is a cosmetic issue.

The table formatting issue was due to a bad habit of mixing tabs and  
spaces,
I decided to go with spaces this time :)


 >One thing that would concern me greatly, is not so much the CPU time  
(though that's a *huge* change in comparison to gz) but the memory  
usage.  Where gzip and bzip2 are chewing 4M and 13M respectively, xz  
chews 102M.  >From a 'beefy' server perspective chewing up that much  
memory per snapshot for that long could be bad.  This is likely  
something that needs to have some sort of enable/disable switch if  
it's going to be included.

True, and there are two solutions I can think of for this "problem".

	1. My tests were at the default compression level, the XZ documentation
	says that at lower levels you will get resource usage and compression
	ratios that are comparable to BZip2. However, I'm not sure where you
	would change the compression level variable for this (globally for the
	system, somewhere in $GITWEB_CONFIG, a git config variable). Does
	someone know the correct answer here?

	2. Implement snapshot caching for Gitweb.


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


From: Mark Rada <marada@uwaterloo.ca>
Date: Thu, 30 Jul 2009 08:56:42 -0400
Subject: [PATCH] Add Gitweb support for XZ compressed snapshots

The XZ compression format uses the LZMA2 compression algorithm, which
often yields higher compression ratios than both GZip and BZip2 at the
cost of using more CPU time and RAM. Though, while XZ is the slowest
for compression, it is much faster than BZip2 for decompression, almost
comparable to GZip (see benchmarks below).

You can enable XZ compressed snapshots by adding 'txz' to the list of
default options for snapshots in your $GITWEB_CONFIG.

I did some simple benchmarks, starting with an already tarballed
archive of the repos listed below. Memory usage seemed to be consistent
for any given algorithm at their default compression level. Timings were
gathered using the `time' command.

CPU: AMD Sempron 3400+ (1 core @ 1.8GHz with 256K L2 cache)
Virtual Memory Usage
	GZip: 4152K	BZip2: 13352K	XZ: 102M

Linux 2.6 series (f5886c7f96f2542382d3a983c5f13e03d7fc5259)   349M
gzip    23.70s user   0.47s system  99% cpu   24.227 total    76M
gunzip  3.74s user    0.74s system  94% cpu   4.741 total
bzip2   130.96s user  0.53s system  99% cpu   2:11.97 total   59M
bunzip2 31.05s user   1.02s system  99% cpu   32.355 total
xz      448.78s user  0.91s system  99% cpu   7:31.28 total   51M
unxz    7.67s user    0.80s system  98% cpu   8.607 total

Git (0a53e9ddeaddad63ad106860237bbf53411d11a7)                11M
gzip    0.77s user    0.03s system  99% cpu   0.792 total     2.5M
gunzip  0.12s user    0.02s system  98% cpu   0.142 total
bzip2   3.42s user    0.02s system  99% cpu   3.454 total     2.1M
bunzip2 0.95s user    0.03s system  99% cpu   0.984 total
xz      12.88s user   0.14s system  98% cpu   13.239 total    1.9M
unxz    0.27s user    0.03s system  99% cpu   0.298 total

XZ (669413bb2db954bbfde3c4542fddbbab53891eb4)                 1.8M
gzip    0.12s user    0.00s system  95% cpu   0.132 total     442K
gunzip  0.02s user    0.00s system  97% cpu   0.027 tota
bzip2   1.28s user    0.01s system  99% cpu   1.298 total     363K
bunzip2 0.15s user    0.01s system  100% cpu  0.157 total
xz      1.62s user    0.03s system  99% cpu   1.652 total     347K
unxz    0.05s user    0.00s system  99% cpu   0.058 total

Purely from a time and memory perspective, nothing compares to GZip in
each of the three tests. Though, if you have an average upload speed of
20KB/s, it would take ~400 seconds longer to transfer the kernel
snapshot that was BZip2 compressed than it would the XZ compressed
snapshot, the transfer time difference is even greater when compared to
the GZip compressed snapshot. The wall clock time savings are
relatively the same for all test cases, but less dramatic for the
smaller repositories.

The obvious downside for XZ compressed snapshots is the large CPU and
memory load put on the server to actualy generate the snapshot. Though
XZ will eventually have good threading support, and I suspect then that
the wall clock time for making an XZ compressed snapshot would go down
considerably if the server had a beefy multi-core CPU.

I have not enabled XZ compression by default because the current default
is GZip, and XZ is only really competitive with BZip2. Also, the XZ
format is still fairly new (the format was declared stable about 6
months ago), and there have been no "stable" releases of the utils yet.

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
