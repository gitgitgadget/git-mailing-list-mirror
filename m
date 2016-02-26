From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 04/16] bisect: make algorithm behavior independent of DEBUG_BISECT
Date: Fri, 26 Feb 2016 03:04:30 +0100
Message-ID: <1456452282-10325-5-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:06:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7nS-0007dj-1I
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbcBZCGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:06:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:59004 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139AbcBZCFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:45 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MEnjW-1ajWpw2QG2-00FzA6; Fri, 26 Feb 2016 03:05:42
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:FdTmX7/3Vxf8pLT8GjJR1us+bNpHvwtobUqBH6C+S6xgTIjvFi/
 2AFP3YjxS/L98Naj/C/kYoglpmuASrxZLJ0Ou4zCNpwcVFf4R/dOV65vDumHKUjCg6k/AJe
 9YL3M1xTOATgs+XKDiyHLv6qjF8xd3Po/O45iBdmXmU11Xkwlq4b2AQMV2bvJHFbeb/hDFS
 u3CF+ehSlZA3ps+GNHGfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fxlNCTocjrw=:YI8iJIBu7VJ7KKbJ3asoZ8
 7hBmKQs4CKf9nM2inPIFIqijbnYVSg/oDx1w9OQI3gWsyWj0UaBtYqA95q7oA6L9RSaI7PXbH
 6hHfqWCmUE0P1loSfpOfz/vnOmqzQB3WtwrKBAfEWhgQScskS/FznVSOex+M77xvT6pUJ9/Po
 7hwyli5zwH7MiLHw6QpsaSGzBBUj5hJqLSKbHFzEWQHOAKoT7Fdbob0jI7d3hjv15ZNT5EvUo
 nwasaxOO7V7Mt2j16IRdnEgb5NYNj9QCbvGIRM16lOF4YUOxGeRA3v2INB42iiUOee7K+AMtR
 t5eSh8TMojLP+QlmVbacnqn1QqqZAufzf+m9So2PMFPOGR8Jm58sDe63NHhBvXbgHJiG6sqKB
 +YdT/3Kr1Z8C9LmKiAHnfQtLRwdwLEKi2jhtfZdlRGoIKwGunmxM27+A/QwIvZt6HcYQYurGS
 ghvSy4vDMEnUpTWDwz0RDJDyoUGUs9B+5ai6g4kaEjeN4W33W4GudYDd7iK8tmGfSaGFLh8Hk
 NqOLCT8t2iWFuuGHNZUi/eY5Pi0za3AJswTbGY6S7hMCj5vm1G56YzEzqVUnwux8b0Op7y9MZ
 xEqMMRsPj+MUT8puw4iuckm25eZF8UsH+r5KNoyVO4yQJ4OPNlZTEornU9QQaDBj+L5yv5Lql
 TxnJL8KSDXXrZRva3t+SojRAXG4/nCqDdLUkMWNpGrUPai9fhT2ka4CbSP244tKlAQPGud0Uy
 2/Z6kJWyL8jkjC33MjnXnqJ4aJ2WhSV2ZdBmnZ4UHjH2Knx7siwYvzfI1K8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287529>

If DEBUG_BISECT is set to 1, bisect does not only show debug
information but also changes the algorithm behavior: halfway()
is always false.

This commit makes the algorithm independent of DEBUG_BISECT.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 905e63a..412e2c0 100644
--- a/bisect.c
+++ b/bisect.c
@@ -101,8 +101,6 @@ static inline int halfway(struct commit_list *p, int nr)
 	 */
 	if (p->item->object.flags & TREESAME)
 		return 0;
-	if (DEBUG_BISECT)
-		return 0;
 	/*
 	 * 2 and 3 are halfway of 5.
 	 * 3 is halfway of 6 but 2 and 4 are not.
-- 
2.7.1.354.gd492730.dirty
