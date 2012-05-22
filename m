From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] xdiff: import new 32-bit version of count_masked_bytes()
Date: Tue, 22 May 2012 22:36:57 +0200
Message-ID: <4FBBF8E9.7020103@lsrfire.ath.cx>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com> <4FB4A4B9.3080009@lsrfire.ath.cx> <xmqqmx56rd2r.fsf@junio.mtv.corp.google.com> <4FB5460C.10807@lsrfire.ath.cx> <CAA787rmJixvyKhubHXZCDVYc=DdVk8_vHsHF6bOsLQ_j=39bGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?B?IsOYeXZpbmQgQS4gSG9sbSI=?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue May 22 22:37:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvpa-0005s6-N0
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933106Ab2EVUhN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 16:37:13 -0400
Received: from india601.server4you.de ([85.25.151.105]:33107 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933077Ab2EVUhC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:37:02 -0400
Received: from [192.168.2.105] (p579BE06F.dip.t-dialin.net [87.155.224.111])
	by india601.server4you.de (Postfix) with ESMTPSA id E74682F8058;
	Tue, 22 May 2012 22:37:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAA787rmJixvyKhubHXZCDVYc=DdVk8_vHsHF6bOsLQ_j=39bGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198246>

Import the latest 32-bit implementation of count_masked_bytes() from
Linux (arch/x86/include/asm/word-at-a-time.h).  It's shorter and avoids
overflows and negative numbers.

This fixes test failures on 32-bit, where negative partial results had
been shifted right using the "wrong" method (logical shift right instea=
d
of arithmetic short right).  The compiler is free to chose the method,
so it was only wrong in the sense that it didn't work as intended by us=
=2E

Reported-by: =C3=98yvind A. Holm <sunny@sunbase.org>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Does this fix all the warnings, and do the tests pass?  I can only
reproduce the "shifting to far to the right" warning..

 xdiff/xutils.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 78549e3..9504eae 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -280,19 +280,11 @@ static inline long count_masked_bytes(unsigned lo=
ng mask)
 		long a =3D (REPEAT_BYTE(0x01) / 0xff + 1);
 		return mask * a >> (sizeof(long) * 7);
 	} else {
-		/*
-		 * Modified Carl Chatfield G+ version for 32-bit *
-		 *
-		 * (a) gives us
-		 *   -1 (0, ff), 0 (ffff) or 1 (ffffff)
-		 * (b) gives us
-		 *   0 for 0, 1 for (ff ffff ffffff)
-		 * (a+b+1) gives us
-		 *   correct 0-3 bytemask count result
-		 */
-		long a =3D (mask - 256) >> 23;
-		long b =3D mask & 1;
-		return a + b + 1;
+		/* Carl Chatfield / Jan Achrenius G+ version for 32-bit */
+		/* (000000 0000ff 00ffff ffffff) -> ( 1 1 2 3 ) */
+		long a =3D (0x0ff0001 + mask) >> 23;
+		/* Fix the 1 for 00 case */
+		return a & mask;
 	}
 }
=20
--=20
1.7.10.2
