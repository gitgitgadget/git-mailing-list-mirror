From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] xdiff: avoid more compiler warnings with XDL_FAST_HASH
 on 32-bit machines
Date: Tue, 22 May 2012 22:36:39 +0200
Message-ID: <4FBBF8D7.7050701@lsrfire.ath.cx>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com> <4FB4A4B9.3080009@lsrfire.ath.cx> <xmqqmx56rd2r.fsf@junio.mtv.corp.google.com> <4FB5460C.10807@lsrfire.ath.cx> <CAA787rmJixvyKhubHXZCDVYc=DdVk8_vHsHF6bOsLQ_j=39bGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?B?IsOYeXZpbmQgQS4gSG9sbSI=?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue May 22 22:37:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvpC-0005s6-9N
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760561Ab2EVUgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 16:36:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:33104 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932966Ab2EVUgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:36:44 -0400
Received: from [192.168.2.105] (p579BE06F.dip.t-dialin.net [87.155.224.111])
	by india601.server4you.de (Postfix) with ESMTPSA id 7F7A02F8058;
	Tue, 22 May 2012 22:36:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAA787rmJixvyKhubHXZCDVYc=DdVk8_vHsHF6bOsLQ_j=39bGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198244>

Hide literals that can cause compiler warnings for 32-bit architectures=
 in
expressions that evaluate to small numbers there.  Some compilers warn =
that
0x0001020304050608 won't fit into a 32-bit long, others that shifting r=
ight
by 56 bits clears a 32-bit value completely.

The correct values are calculated in the 64-bit case, which is all that=
 matters
in this if-branch.

Reported-by: =C3=98yvind A. Holm <sunny@sunbase.org>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 xdiff/xutils.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 8580da7..78549e3 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -272,7 +272,13 @@ static inline long count_masked_bytes(unsigned lon=
g mask)
 		 * that works for the bytemasks without having to
 		 * mask them first.
 		 */
-		return mask * 0x0001020304050608 >> 56;
+		/*
+		 * return mask * 0x0001020304050608 >> 56;
+		 *
+		 * Doing it like this avoids warnings on 32-bit machines.
+		 */
+		long a =3D (REPEAT_BYTE(0x01) / 0xff + 1);
+		return mask * a >> (sizeof(long) * 7);
 	} else {
 		/*
 		 * Modified Carl Chatfield G+ version for 32-bit *
--=20
1.7.10.2
