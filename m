From: Mike Taht <mike.taht@timesys.com>
Subject: [PATCH] experimental - Performance of various compressors
Date: Wed, 20 Apr 2005 22:22:02 -0700
Message-ID: <4267387A.6040602@timesys.com>
References: <426734DE.3040606@timesys.com> <426736AF.7000900@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 07:18:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOU5V-00034M-0V
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 07:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVDUFXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 01:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDUFXL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 01:23:11 -0400
Received: from mail.timesys.com ([65.117.135.102]:43661 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261222AbVDUFW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 01:22:58 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Apr 2005 01:17:33 -0400
X-Accept-Language: en-us, en
To: Mike Taht <mike.taht@timesys.com>
In-Reply-To: <426736AF.7000900@timesys.com>
X-OriginalArrivalTime: 21 Apr 2005 05:17:33.0437 (UTC) FILETIME=[6C4EC2D0:01C54631]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org




Don't apply this patch and change GIT_COMPRESSION unless you know what 
you are doing and why you are doing it. You will break an older version 
of git. You may break a newer version of git. You have been warned.

I also note that there's a bzlib out there.

cache.h: 828d660ab82bb35a1ca632a2ba4620dc483889bd
--- a/cache.h
+++ b/cache.h
@@ -16,6 +16,8 @@
  #include <openssl/sha.h>
  #include <zlib.h>

+#define GIT_COMPRESSION Z_BEST_COMPRESSION
+
  /*
   * Basic data structures for the directory cache
   *
sha1_file.c: 754e8b4e9ea8104df48152f875d6b874304e2a62
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -199,7 +199,7 @@ int write_sha1_file(char *buf, unsigned

         /* Set it up */
         memset(&stream, 0, sizeof(stream));
-       deflateInit(&stream, Z_BEST_COMPRESSION);
+       deflateInit(&stream, GIT_COMPRESSION);
         size = deflateBound(&stream, len);
         compressed = malloc(size);

update-cache.c: a09883541c745c76413c62109a80f40df4b7a7fb
--- a/update-cache.c
+++ b/update-cache.c
@@ -40,7 +40,7 @@ static int index_fd(unsigned char *sha1,
         SHA1_Final(sha1, &c);

         memset(&stream, 0, sizeof(stream));
-       deflateInit(&stream, Z_BEST_COMPRESSION);
+       deflateInit(&stream, GIT_COMPRESSION);

         /*
          * ASCII size + nul byte



Mike Taht wrote:
> Just to clarify this was a git add of the linux-2.6.11.7 sources (sorry, 
> untimed) , and timing the git commit.
> 
> Mo betta data latah.
> 
> Mike Taht wrote:
> 
>> I started rolling a tool to measure various aspects of git 
>> performance. I will start looking at merge next, and at workloads 
>> different from the kernel (gcc4 anyone?) ...
>>
>> The only data points worth sharing a this point are:
>>
>> That doing the compression at a level of 3, rather than the max of 9, 
>> cuts the cpu time required for a big git commit by over half, and that 
>> that actually translates into a win on the I/O to disk. (these tests 
>> were performed on a dual opteron 842)
>>
>> The benefits of compression aren't very much for git right now.
>>
>> And: A big git commit is I/O bound. But we knew that. Maybe it's 
>> possible to make it less I/O bound.
>>
>> Git branch: 7a4c67965de68ae7bc7aa1fde33f8eb9d8114697
>> Tree: 2.6.11.7 source tree
>> Branch: N/a
>> Merge File: N/a
>> HW: dual opteron 242
>> Mem: 1GB
>> Disk: seagate barracuda
>> Filesystem: Reiser3
>> Git add: N/a
>> Cache: Hot
>> Git Commit: 44.97user 5.94system 1:45.24elapsed 48%CPU
>> Git Merge:
>> Options:
>> Feature: Test of compression=9 (std git)
>>
>> du -s .git/objects  110106  # du is probably not the right thing
>> du -s --apparent-size .git/objects 58979
>>
>> Git branch: 9e272677621c91784cf2533123a41745178f0701
>> Tree: 2.6.11.7 source tree
>> Branch: N/a
>> Merge File: N/a
>> HW: dual opteron 242
>> Mem: 1GB
>> Disk: seagate barracuda
>> Disk mode: udma5
>> Filesystem: Reiser3
>> Git add: N/a
>> Cache: Hot
>> Git Commit: 16.79user 6.15system 1:21.92elapsed 28%CPU
>> Git Merge:
>> Options:
>> Feature: Test of compression=3 (std git)
>>
>> du -s .git/objects  115218
>> du -s --apparent-size .git/objects 64274
>>
>> There's some variety in the best/worst case timings for I/O for the 
>> compressor=3 case...
>>
>> 16.79user 6.15system 1:21.92elapsed 28%CPU
>> 16.68user 5.71system 1:13.19elapsed 30%CPU
> 
> 
> 


-- 

Mike Taht


   ""His mind is like a steel trap -- full of mice."
	-- Foghorn Leghorn"
