From: Jim Meyering <jim@meyering.net>
Subject: don't accept bogus N in `HEAD~N'
Date: Sun, 21 May 2006 23:35:50 +0200
Message-ID: <87d5e7hxhl.fsf_-_@rho.meyering.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 23:36:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhvac-0005y7-LI
	for gcvg-git@gmane.org; Sun, 21 May 2006 23:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWEUVfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 17:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWEUVfv
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 17:35:51 -0400
Received: from mx.meyering.net ([82.230.74.64]:1683 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S964939AbWEUVfv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 17:35:51 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A0F5C34AF3; Sun, 21 May 2006 23:35:50 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bf3jl15.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 21 May 2006 11:21:58 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20462>

In a very shallow audit, I spotted code where overflow was not detected.
But it's hardly critical.

Currently,

  git-diff HEAD HEAD

is equivalent to this

  git-diff HEAD HEAD~18446744073709551616   # aka 2^64

Exercising git-rev-parse directly, currently I get this:

  $ git-rev-parse --no-flags --sq HEAD~18446744073709551616
  '639ca5497279607665847f2e3a11064441a8f2a6'

It'd be better to produce a diagnostic and fail:

  $ ./git-rev-parse --no-flags --sq -- HEAD~18446744073709551616 > /dev/null
  fatal: ambiguous argument 'HEAD~18446744073709551616': unknown revision or filename

The code in question is in sha1_name.c (get_sha1_1):

               int num = 0;
               ...
               while (cp < name + len)
                       num = num * 10 + *cp++ - '0';

Looking at how to fix it, my first reflex was to replace that loop
with this one:

		while (cp < name + len) {
			int tmp = num * 10 + *cp++ - '0';
			if (INT_MAX / 10 < num || tmp < num)
				return -1;
			num = tmp;
		}

But INT_MAX is used nowhere else, so I wonder if git avoids using
it for some reason.  At least `make check' gripes about __INT_MAX__.
Anyhow, here's the patch I used.  With it, git still passes `make test'.

diff --git a/sha1_name.c b/sha1_name.c
index dc68355..c813ba0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -429,8 +429,12 @@ static int get_sha1_1(const char *name,
 		int num = 0;
 		int len1 = cp - name;
 		cp++;
-		while (cp < name + len)
-			num = num * 10 + *cp++ - '0';
+		while (cp < name + len) {
+			int tmp = num * 10 + *cp++ - '0';
+			if (INT_MAX / 10 < num || tmp < num)
+				return -1;
+			num = tmp;
+		}
 		if (has_suffix == '^') {
 			if (!num && len1 == len - 1)
 				num = 1;
