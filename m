From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 0/4] Ensure that we can build without libgen.h
Date: Wed, 13 Jan 2016 00:44:42 +0000
Message-ID: <56959DFA.9000704@ramsayjones.plus.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 01:44:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ9YU-00045J-7f
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 01:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbcAMAou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 19:44:50 -0500
Received: from avasout07.plus.net ([84.93.230.235]:34269 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbcAMAot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 19:44:49 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id 5Ckk1s0094mu3xa01CklGX; Wed, 13 Jan 2016 00:44:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=WEvV30OxAs6RDieqEZgA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <cover.1452585382.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283863>


Hi Johannes,

Sorry for not commenting sooner, I've been away from email for
a few days. Also, I have only just looked at what is currently
in pu (@1a05310), which I'm pretty sure is v3 of this series.

On 12/01/16 07:57, Johannes Schindelin wrote:
> This mini series adds a fall-back for the `dirname()` function that we use
> e.g. in git-am. This is necessary because not all platforms have a working
> libgen.h.
> 
> While at it, we ensure that our basename() drop-in conforms to the POSIX
> specifications.

I was somewhat disappointed that you ignored the implementation of
gitbasename() and gitdirname() that was included in the test-libgen.c
file that I sent you. I had hoped they would be (at worst) a good starting
point if you found them to be lacking for your use case (ie. for the
64-bit versions of MSVC/MinGW).

Did you have any test cases that failed? (If so, could you please add
them to the tests).

Hmm, I just had another look at them and recalled one of my TODO items.
Ahem, yes, ... err, replace code which provoked undefined behaviour. :-P

Actually, that took just ten minutes to fix. (patch below)

> 
> In addition to Eric's style improvement, v4 also fixes the signature
> of skip_dos_drive_prefix() in the non-Windows case.

Yes, this fixes one of my comments about v3.

ATB,
Ramsay Jones
-- >8 --
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Date: Tue, 12 Jan 2016 23:28:09 +0000
Subject: [PATCH] test-libgen.c: don't provoke undefined behaviour

---
 test-libgen.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/test-libgen.c b/test-libgen.c
index aa3bd18..3024bf1 100644
--- a/test-libgen.c
+++ b/test-libgen.c
@@ -42,9 +42,11 @@ char *gitbasename (char *path)
 		*p-- = '\0';
 	}
 	/* find begining of last path component */
-	while (p >= path && !is_dir_sep(*p))
+	while (p > path && !is_dir_sep(*p))
 		p--;
-	return p + 1;
+	if (is_dir_sep(*p))
+		p++;
+	return p;
 }
 
 char *gitdirname(char *path)
@@ -71,13 +73,12 @@ char *gitdirname(char *path)
 		*p-- = '\0';
 	}
 	/* find begining of last path component */
-	while (p >= start && !is_dir_sep(*p))
+	while (p > start && !is_dir_sep(*p))
 		p--;
 	/* terminate dirname */
-	if (p < start) {
-		p = start;
+	if (p == start && !is_dir_sep(*p))
 		*p++ = '.';
-	} else if (p == start)
+	else if (p == start)
 		p++;
 	*p = '\0';
 	return path;
-- 
2.7.0
