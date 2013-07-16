From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 00/19] Index-v5
Date: Tue, 16 Jul 2013 22:03:40 +0100
Message-ID: <51E5B52C.7050603@ramsay1.demon.co.uk>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 23:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzD2V-0001se-T9
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 23:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933657Ab3GPVoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 17:44:01 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:34261 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933284Ab3GPVoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 17:44:00 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 27C0A1280AE;
	Tue, 16 Jul 2013 22:43:58 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id C34AB1280A8;
	Tue, 16 Jul 2013 22:43:56 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Tue, 16 Jul 2013 22:43:54 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230587>

Thomas Gummerer wrote:
> Hi,
> 
> previous rounds (without api) are at $gmane/202752, $gmane/202923,
> $gmane/203088 and $gmane/203517, the previous round with api was at
> $gmane/229732.  Thanks to Junio, Duy and Eric for their comments on
> the previous round.

If I remember correctly, the original version of this series had the
same problem as Michael's "Fix some reference-related races" series
(now in master). In particular, you had introduced an 'index_changed()'
function which does essentially the same job as 'stat_validity_check()'
in the new reference handling API. I seem to remember advising you
not to compare st_uid, st_gid and st_ino on __CYGWIN__.

I haven't had time to look at this version of your series yet, but it
may be worth taking a look at stat_validity_check(). (although that is
causing failures on cygwin at the moment! ;-)

Also, I can't recall if I mentioned it to you at the time, but your
index reading code was (unnecessarily) calling munmap() twice on the
same buffer (without an intervening mmap()). This causes problems for
systems that have the NO_MMAP build variable set. In particular, the
compat/mmap.c code will attempt to free() the allocated memory block
twice, with unpredictable results.

I wrote a patch to address this at the time (Hmm, seems to be built
on v1.8.1), but didn't submit it since your patch didn't progress. :-D
I have included the patch below.

ATB,
Ramsay Jones

-- >8 --
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Sun, 9 Sep 2012 20:50:32 +0100
Subject: [PATCH] mmap.c: Keep log of mmap() blocks to avoid double-delete bug

When compiling with the NO_MMAP build variable set, the built-in
'git_mmap()' and 'git_munmap()' compatibility routines use simple
memory allocation and file I/O to emulate the required behaviour.
The current implementation is vulnerable to the "double-delete" bug
(where the pointer returned by malloc() is passed to free() two or
more times), should the mapped memory block address be passed to
munmap() multiple times.

In order to guard the implementation from such a calling sequence,
we keep a list of mmap-block descriptors, which we then consult to
determine the validity of the input pointer to munmap(). This then
allows 'git_munmap()' to return -1 on error, as required, with
errno set to EINVAL.

Using a list in the log of mmap-ed blocks, along with the resulting
linear search, means that the performance of the code is directly
proportional to the number of concurrently active memory mapped
file regions. The number of such regions is not expected to be
excessive.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/mmap.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/compat/mmap.c b/compat/mmap.c
index c9d46d1..400e034 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -1,14 +1,61 @@
 #include "../git-compat-util.h"
 
+struct mmbd {  /* memory mapped block descriptor */
+	struct mmbd *next;  /* next in list */
+	void   *start;      /* pointer to memory mapped block */
+	size_t length;      /* length of memory mapped block */
+};
+
+static struct mmbd *head;  /* head of mmb descriptor list */
+
+
+static void add_desc(struct mmbd *desc, void *start, size_t length)
+{
+	desc->start = start;
+	desc->length = length;
+	desc->next = head;
+	head = desc;
+}
+
+static void free_desc(struct mmbd *desc)
+{
+	if (head == desc)
+		head = head->next;
+	else {
+		struct mmbd *d = head;
+		for (; d; d = d->next) {
+			if (d->next == desc) {
+				d->next = desc->next;
+				break;
+			}
+		}
+	}
+	free(desc);
+}
+
+static struct mmbd *find_desc(void *start)
+{
+	struct mmbd *d = head;
+	for (; d; d = d->next) {
+		if (d->start == start)
+			return d;
+	}
+	return NULL;
+}
+
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
 	size_t n = 0;
+	struct mmbd *desc = NULL;
 
 	if (start != NULL || !(flags & MAP_PRIVATE))
 		die("Invalid usage of mmap when built with NO_MMAP");
 
 	start = xmalloc(length);
-	if (start == NULL) {
+	desc = xmalloc(sizeof(*desc));
+	if (!start || !desc) {
+		free(start);
+		free(desc);
 		errno = ENOMEM;
 		return MAP_FAILED;
 	}
@@ -25,18 +72,26 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 			if (errno == EAGAIN || errno == EINTR)
 				continue;
 			free(start);
+			free(desc);
 			errno = EACCES;
 			return MAP_FAILED;
 		}
 
 		n += count;
 	}
+	add_desc(desc, start, length);
 
 	return start;
 }
 
 int git_munmap(void *start, size_t length)
 {
+	struct mmbd *d = find_desc(start);
+	if (!d) {
+		errno = EINVAL;
+		return -1;
+	}
+	free_desc(d);
 	free(start);
 	return 0;
 }
-- 
1.8.3
