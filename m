From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] git-count-objects: Fix a disk-space under-estimate on Cygwin
Date: Thu, 19 Nov 2009 18:46:24 +0000
Message-ID: <4B059280.40902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 20:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBCGp-0001Rn-M0
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 20:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbZKSTBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 14:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbZKSTBz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 14:01:55 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:45084 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754562AbZKSTBy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 14:01:54 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1NBCGV-0004jT-gT; Thu, 19 Nov 2009 19:02:00 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133245>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Whilst testing an msvc-built git on cygwin, I noticed that
git-count-objects was producing different results to the
cygwin version, viz:

    $ ./git --version
    git version 1.6.5.4.gf034d.MSVC
    $ git --version
    git version 1.6.5

    $ ./git-count-objects
    60 objects, 283 kilobytes

    $ git count-objects
    60 objects, 210 kilobytes

    $ git config core.filemode false

    $ git count-objects
    60 objects, 297 kilobytes
    $ 

Note also that the cygwin version of git gives two different
answers, in the *same* repository, depending on the setting
of core.filemode. (since the "win32 stat() functions" in
compat/cygwin.c are used when core.filemode is false)

Having looked at the msvc code-path, I also noticed something
else a bit odd; the value printed by the msvc version should
be a *lower bound* for the amount of disk-space used (since
it simply totals the actual file sizes). However, as you can
see from the above, when core.filemode is true, the cygwin
version of git is *underestimating* even this (210Kb vs 283kb).

A quick trip to the debugger confirmed that (st.st_blocks * 512)
is less than st.st_size for several files. So, it looked like
the block-size was not in units of 512 bytes; so if we look at
/usr/include/sys/param.h we find:

    #define DEV_BSIZE  1024

and in /usr/include/sys/stat.h we find:

    #define S_BLKSIZE  1024

which seems to indicate a 1K block-size instead. Also, different
filesystem types may use different block-sizes, which is why an
st.st_blksize was added to struct stat; it seems that the Cygwin
struct stat contains the st_blksize field, so lets try a quick
test program:

    $ cat junk.c

    #include <stdio.h>
    #include <sys/stat.h>
    
    int main(int argc, char *argv[])
    {
    	int i, bytes = 0, tot_5 = 0, tot_b = 0;
    
    	for (i=1; i< argc; i++) {
    		struct stat st;
    		if (lstat(argv[i], &st))
    			printf("can't lstat '%s'\n", argv[i]);
    		else {
    			int s = (int)st.st_size;
    			int b = (int)st.st_blocks;
    			int f = (int)st.st_blksize;
    			int d = (b * 512);
    			int e = (b * f);
    
    			printf("%8d, ", s);
    			printf("%2d*512=%-6d (%6d), ", b, d, d-s);
    			printf("%2d*%d=%-6d (%6d)\n", b, f, e, e-s);
    
    			bytes += s;
    			tot_5 += d;
    			tot_b += e;
    		}
    	}
    	printf("total bytes: %6d\n", bytes);
    	printf("b * 512:     %6d  (%d)\n", tot_5, tot_5 - bytes);
    	printf("b * blksize: %6d  (%d)\n", tot_b, tot_b - bytes);
    	exit(0);
    }
    
    $ ls .git/objects/??/* | xargs ./junk.exe
         148,  1*512=512    (   364),  1*1024=1024   (   876)
       10058, 12*512=6144   ( -3914), 12*1024=12288  (  2230)
        3701,  4*512=2048   ( -1653),  4*1024=4096   (   395)
         463,  4*512=2048   (  1585),  4*1024=4096   (  3633)
         148,  1*512=512    (   364),  1*1024=1024   (   876)
       10056, 12*512=6144   ( -3912), 12*1024=12288  (  2232)
         198,  1*512=512    (   314),  1*1024=1024   (   826)
        1782,  4*512=2048   (   266),  4*1024=4096   (  2314)
         192,  1*512=512    (   320),  1*1024=1024   (   832)
        3801,  4*512=2048   ( -1753),  4*1024=4096   (   295)
       14851, 16*512=8192   ( -6659), 16*1024=16384  (  1533)
        3761,  4*512=2048   ( -1713),  4*1024=4096   (   335)
          52,  1*512=512    (   460),  1*1024=1024   (   972)
         956,  4*512=2048   (  1092),  4*1024=4096   (  3140)
         956,  4*512=2048   (  1092),  4*1024=4096   (  3140)
        3703,  4*512=2048   ( -1655),  4*1024=4096   (   393)
       10055, 12*512=6144   ( -3911), 12*1024=12288  (  2233)
    total bytes:  64881
    b * 512:      45568  (-19313)
    b * blksize:  91136  (26255)
    $ 

Note that, in addition to confirming the 1K block-size, it appears
that (on NTFS) files less than 1K are allocated a single block
whereas larger files use a multiple of 4 blocks. Well, that is only
a guess but it at least sounds plausible! ;-)

This patch implements a simple solution which has the useful property
of returning a single answer, irrespective of the core.filemode setting.

ATB,
Ramsay Jones

 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5d5976f..5624563 100644
--- a/Makefile
+++ b/Makefile
@@ -783,6 +783,10 @@ ifeq ($(uname_O),Cygwin)
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	OLD_ICONV = UnfortunatelyYes
+	# The st_blocks field is not in units of 512 bytes, as the code
+	# expects, which leads to an under-estimate of the disk space used.
+	# In order to use an alternate algorithm, we claim to lack st_blocks.
+	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
-- 
1.6.5
