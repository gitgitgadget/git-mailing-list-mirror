From: Ivan Kanis <expire-by-2010-08-14@kanis.fr>
Subject: [PATCH] memory leak reported by valgrind
Date: Mon, 09 Aug 2010 11:48:45 +0200
Message-ID: <wes62zknmki.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 11:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiOyr-0005Na-F0
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 11:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab0HIJtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 05:49:11 -0400
Received: from elysmail.net ([188.165.214.80]:64006 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755919Ab0HIJtK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 05:49:10 -0400
Received: from IVAN (reverse.completel.net [92.103.229.106]) by elysmail.net with SMTP;
   Mon, 9 Aug 2010 10:48:43 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (windows-nt)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
X-Antivirus: avast! (VPS 100808-1, 08/08/2010), Outbound message
X-Antivirus-Status: Clean
X-Declude-Sender: expire-by-2010-08-14@kanis.fr [92.103.229.106]
X-Declude-Spoolname: 11020965.eml
X-Declude-RefID: str=0001.0A0B0202.4C5FCF05.007C,ss=1,fgs=0
X-Declude-Note: Scanned by Declude 4.10.53 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [-1] at 10:48:53 on 09 Aug 2010
X-Declude-Tests: None
X-Country-Chain: FRANCE->destination
X-Declude-Code: f
X-HELO: IVAN
X-Identity: 92.103.229.106 | reverse.completel.net | vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152958>

Hello,

This patches the following memory leak reported by valgrind:

512 bytes in 1 blocks are definitely lost in loss record 5 of 8
=C2=A0 at 0x4C203E4: calloc (vg_replace_malloc.c:397)
=C2=A0 by 0x4C5F9D: xcalloc (wrapper.c:96)
=C2=A0 by 0x445741: cmd_pack_objects (pack-objects.c:2117)
=C2=A0 by 0x4048EE: handle_internal_command (git.c:270)
=C2=A0 by 0x404B03: main (git.c:470)


diff -u git-1.7.2.1/builtin/pack-objects.c git.ivan/builtin/pack-object=
s.c
--- git-1.7.2.1/builtin/pack-objects.c  2010-07-28 19:03:43.000000000 +=
0200
+++ git.ivan/builtin/pack-objects.c     2010-08-09 11:38:40.000000000 +=
0200
@@ -2341,5 +2341,6 @@
                fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
                        " reused %"PRIu32" (delta %"PRIu32")\n",
                        written, written_delta, reused, reused_delta);
+       free(rp_av);
        return 0;
 }

--=20
Ivan Kanis

When you're looking at life
In a strange new room
Maybe drowning soon
Is this the start of it all?
    -- Ian Curtis=20
