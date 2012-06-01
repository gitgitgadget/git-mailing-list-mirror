From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Review of current github code [Re: [GSoC] Designing a faster index format - Progress report week 6]
Date: Fri, 1 Jun 2012 14:11:37 +0200
Message-ID: <87vcjb1bba.fsf@thomas.inf.ethz.ch>
References: <20120528214401.GB6449@tgummerer>
	<87pq9k8i4e.fsf@thomas.inf.ethz.ch>
	<7vhauw6x0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>,
	Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 14:11:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaQhl-0008VD-8F
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 14:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759493Ab2FAMLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 08:11:41 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:18858 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904Ab2FAMLk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 08:11:40 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 1 Jun
 2012 14:11:37 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 1 Jun
 2012 14:11:37 +0200
In-Reply-To: <7vhauw6x0p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 31 May 2012 11:11:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198982>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>>   Test                      this tree      
>>   -----------------------------------------
>>   0002.1: v[23]: ls-files   0.13(0.11+0.02)
>>   0002.4: v4: ls-files      0.11(0.08+0.02)
>>   0002.5: v5: ls-files      0.09(0.06+0.02)
>>
>> I made up a hacky perf script on the spot, it's pasted at the far end of
>> this email.  It would most likely still be slower than v4 if we didn't
>> switch away from SHA1, though -- we haven't really spent much time
>> looking into the speed, except for one particular avoidance of name
>> copies that translated into a roughly 30% speedup.
>
> Do you mean by "switch away from SHA-1" that your suspicion is a
> large part of the speed-up may be coming from the fact that the
> index file as a whole is no longer hashed?

Yes.  Since the v5 index is only slightly smaller than v4 one, the
reduction in data read cannot explain the difference alone.

I tried to quantify this a little.  For SHA1 and the v2/v4 index
(25MB/14MB, resp.), I get about 70ms/44ms for

  time git hash-object --stdin <.git/index

On the other hand I get about 35ms/22ms for

  time ~/g/test-crc32 .git/index

I do have a system crc32 utility, but it uses read() in 8k blocks
instead of mmap() and takes about 87ms.

So we can see that the switch from 25MB to 14MB fully explains the
speedup for v2->v4, and the switch from SHA1 to CRC32 explains the
speedup for v4->v5.

However, aside from gaining 20ms here, CRC32 is also suitable for
checking very short chunks of data, as is planned for the partial
loading support in v5.

> As long as the new format allows us to notice corruption in the file
> to a similar degree of confidence by some other means, I personally
> do not see it as a regression in safety.
> 
> We however eventually would need to hook the logic to check for
> index corruption into fsck.  Actually adding such a code to fsck can
> and probably should remain outside the GSoC project, but please make
> sure you have necessary checksums in the format to allow us to do so
> in the future.

I actually expect that a full loading of the index will verify all
checksums that are present in the file.  Since file additions and such
will still need a full rewrite, and thus a full read, I expect this to
happen every so often as a matter of normal operations.  fsck could of
course still learn to load the index at some point, for good measure.


diff --git i/Makefile w/Makefile
index 63eacda..76856bc 100644
--- i/Makefile
+++ w/Makefile
@@ -481,6 +481,7 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
+TEST_PROGRAMS_NEED_X += test-crc32
 TEST_PROGRAMS_NEED_X += test-credential
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
diff --git i/test-crc32.c w/test-crc32.c
index e69de29..092de48 100644
--- i/test-crc32.c
+++ w/test-crc32.c
@@ -0,0 +1,32 @@
+#include "git-compat-util.h"
+#include <zlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+int main (int argc, char *argv[])
+
+{
+	unsigned int crc;
+	struct stat st;
+	int fd;
+	void *map;
+
+	if (argc != 2)
+		die("usage: %s <file>\n", argv[0]);
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0)
+		die_errno("open");
+	if (fstat(fd, &st) < 0)
+		die_errno("fstat");
+	map = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (map == MAP_FAILED)
+		die_errno("mmap");
+
+	crc = crc32(0, map, st.st_size);
+	printf("%8x\n", crc);
+
+	return 0;
+}


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
