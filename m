From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: 26 Oct 2005 07:24:22 -0700
Message-ID: <86u0f4fjah.fsf@blue.stonehenge.com>
References: <86y84gfjv4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 26 16:29:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUmDH-0006wI-NX
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 16:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVJZOY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 10:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbVJZOY2
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 10:24:28 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:43387 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751495AbVJZOY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 10:24:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C602B8F74B
	for <git@vger.kernel.org>; Wed, 26 Oct 2005 07:24:22 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 03585-01-53 for <git@vger.kernel.org>;
 Wed, 26 Oct 2005 07:24:22 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 5F90C8F798; Wed, 26 Oct 2005 07:24:22 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.13.7; tzolkin = 4 Manik; haab = 5 Zac
In-Reply-To: <86y84gfjv4.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10667>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> gcc -o sha1_file.o -c -g -O2 -Wall -I/usr/local/include -L/usr/local/lib -Dstrcasestr=gitstrcasestr -DNO_STRCASESTR=1 -DSHA1_HEADER='<openssl/sha.h>' sha1_file.c
Randal> sha1_file.c: In function `move_temp_to_file':
Randal> sha1_file.c:1247: error: `ENOTSUP' undeclared (first use in this function)
Randal> sha1_file.c:1247: error: (Each undeclared identifier is reported only once
Randal> sha1_file.c:1247: error: for each function it appears in.)
Randal> gmake: *** [sha1_file.o] Error 1

got it... a bit messy, but here it is:

Subject: [PATCH] fix for openbsd

---

 sha1_file.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

applies-to: b16bae041dfd1c1081873f2e88a5f82858fb2051
28dcc3eaf13856585a81a24f1b4393032f825053
diff --git a/sha1_file.c b/sha1_file.c
index 7fdc469..1079ca5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1244,7 +1244,11 @@ int move_temp_to_file(const char *tmpfil
 		 * When this succeeds, we just return 0. We have nothing
 		 * left to unlink.
 		 */
-		if ((ret == EXDEV || ret == ENOTSUP) && !rename(tmpfile, filename))
+		if ((ret == EXDEV
+#ifdef ENOTSUP
+                     || ret == ENOTSUP
+#endif
+		     ) && !rename(tmpfile, filename))
 			return 0;
 		ret = errno;
 	}
---
0.99.8.GIT



-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
