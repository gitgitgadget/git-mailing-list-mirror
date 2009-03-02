From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] optimize compat/ memmem()
Date: Tue, 03 Mar 2009 00:19:30 +0100
Message-ID: <49AC6982.6000804@lsrfire.ath.cx>
References: <cover.1235629933.git.gitster@pobox.com> <49AC6527.5010808@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:21:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeHRj-0004s0-OU
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 00:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbZCBXTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 18:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbZCBXTe
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 18:19:34 -0500
Received: from india601.server4you.de ([85.25.151.105]:59551 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbZCBXTd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 18:19:33 -0500
Received: from [10.0.1.101] (p57B7FBAD.dip.t-dialin.net [87.183.251.173])
	by india601.server4you.de (Postfix) with ESMTPSA id 415822F8055;
	Tue,  3 Mar 2009 00:19:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <49AC6527.5010808@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111976>

When memmem() was imported from glibc 2.2 into compat/, an optimization
was dropped in the process, in order to make the code smaller and simpler.
It was OK because memmem() wasn't used in performance-critical code.  Now
the situation has changed and we can benefit from this optimization.

The trick is to avoid calling memcmp() if the first character of the needle
already doesn't match.  Checking one character directly is much cheaper
than the function call overhead.  We keep the first character of the needle
in the variable named point and the rest in the one named tail.

The following commands were run in a Linux kernel repository and timed, the
best of five results is shown:

  $ STRING='Ensure that the real time constraints are schedulable.'
  $ git log -S"$STRING" HEAD -- kernel/sched.c >/dev/null

On Windows Vista x64, before:

  real    0m8.470s
  user    0m0.000s
  sys     0m0.000s

And after the patch:

  real    0m1.887s
  user    0m0.000s
  sys     0m0.000s

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This performance fix is a good idea, even if we later decide to import
the latest version of memmem() from Gnulib, I think.  And I'm not so
sure any more that we want to do that in the first place.  More
measurements are needed (which goes for these two patches, too, of
course), but this version should provide a better baseline.

 compat/memmem.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/compat/memmem.c b/compat/memmem.c
index cd0d877..56bcb42 100644
--- a/compat/memmem.c
+++ b/compat/memmem.c
@@ -5,6 +5,8 @@ void *gitmemmem(const void *haystack, size_t haystack_len,
 {
 	const char *begin = haystack;
 	const char *last_possible = begin + haystack_len - needle_len;
+	const char *tail = needle;
+	char point;
 
 	/*
 	 * The first occurrence of the empty string is deemed to occur at
@@ -20,8 +22,9 @@ void *gitmemmem(const void *haystack, size_t haystack_len,
 	if (haystack_len < needle_len)
 		return NULL;
 
+	point = *tail++;
 	for (; begin <= last_possible; begin++) {
-		if (!memcmp(begin, needle, needle_len))
+		if (*begin == point && !memcmp(begin + 1, tail, needle_len - 1))
 			return (void *)begin;
 	}
 
-- 
1.6.2.rc2
