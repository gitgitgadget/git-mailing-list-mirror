From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v7 3/4] poll() exits too early with EFAULT if 1st arg is NULL
Date: Mon, 17 Sep 2012 23:23:17 +0200
Message-ID: <004d01cd951a$a8268f00$f873ad00$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:23:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDin8-0005ey-BG
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 23:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab2IQVXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 17:23:34 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:57792 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab2IQVXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 17:23:33 -0400
Received: from DualCore (dsdf-4db53772.pool.mediaWays.net [77.181.55.114])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M5c8C-1TT2gE41rU-00y1MQ; Mon, 17 Sep 2012 23:23:31 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2VGiUfp3kBpjZhSZyaf6Xp5ganUQ==
Content-Language: de
X-Provags-ID: V02:K0:YQAbXEd1TmRrWWKUzhB+Zu9RwJORQD4MH0l5euGQT/5
 tyYI0MUfT65hEmj1cAs5J2B26J94d62bVOFYGgi0GWxlkVKqbh
 z8a4fofBOVX+BIGvBkMoXuddUeOegMmWtKSP7wD/I6TJvejAtZ
 7F8Tm788CZBGn6fCgVwrleKBhT8LXwaCnmm1WTBfYEIWuxHEVV
 j7EvPejfVUzUQZQeMiHPgkQB6tAjKEO5qeYl2CyTCq8swTMUN+
 8/5Ij2vDsA1oJQZlwjXz/a2Cp8+rdOCh/iqGOnXwS8+hFZSweV
 eud4wZIQBkrMRm9xxgPlp+jTuH7fzw+R/szIi/Vn1QDQ6zib1b
 Sc1DS9dhPPg2FP+BHmCWTd3VBvF9P1riXhAFGnY37FBXljTbol
 vxzCuFcnTTLMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205753>

If poll() is used as a milli-second sleep, like in help.c, by passing a NULL
in the 1st and a 0 in the 2nd arg, it exits with EFAULT.

As per Paolo Bonzini, the original author, this is a bug and to be fixed 
Like in this commit, which is not to exit if the 2nd arg is 0. It got fixed
In gnulib in the same manner the other day.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/poll/poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/poll/poll.c b/compat/win32/poll.c
index 403eaa7..9e7a25c 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -357,7 +357,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
 
   /* EFAULT is not necessary to implement, but let's do it in the
      simplest case. */
-  if (!pfd)
+  if (!pfd && nfd)
     {
       errno = EFAULT;
       return -1;
-- 
1.7.12
