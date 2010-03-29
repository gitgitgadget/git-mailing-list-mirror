From: Holger =?utf-8?B?V2Vpw58=?= <holger@zedat.fu-berlin.de>
Subject: [PATCH] Don't redefine htonl and ntohl on big-endian
Date: Mon, 29 Mar 2010 12:22:19 +0200
Organization: Freie =?utf-8?Q?Universit=C3=A4t?= Berlin
Message-ID: <20100329102219.GC14869@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 12:49:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwCX4-0005ix-Q2
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 12:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab0C2KtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 06:49:18 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:50849 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755168Ab0C2KtR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 06:49:17 -0400
X-Greylist: delayed 1617 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2010 06:49:17 EDT
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NwC6u-00022Z-1L>; Mon, 29 Mar 2010 12:22:20 +0200
Received: from mail.cis.fu-berlin.de ([160.45.11.138])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NwC6t-0006gP-VS>; Mon, 29 Mar 2010 12:22:20 +0200
Received: by Mail.CIS.FU-Berlin.DE (Exim 4.69)
          for git@vger.kernel.org with local
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1NwC6t-00ATJN-Tc>; Mon, 29 Mar 2010 12:22:19 +0200
Mail-Followup-To: Git List <git@vger.kernel.org>
Content-Disposition: inline
X-Operating-System: IRIX64 6.5.30f
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Originating-IP: 160.45.11.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143453>

Since commit 0fcabdeb52b79775173d009ccc179db104dfbb66, compat/bswap.h
redefined htonl and ntohl to bswap32 not only if bswap32 has been
defined earlier in compat/bswap.h (which is done only on selected
platforms), but also if bswap32 has been defined anywhere else.  This
broke Git at least for NetBSD systems running on big-endian machines
(where ntohl and htonl should, of course, be NOOPs), since NetBSD
defines a bswap32 macro in the system headers.

So, we now undefine any previously defined bswap32 in compat/bswap.h
before defining our own.

Signed-off-by: Holger Wei=C3=9F <holger@zedat.fu-berlin.de>
---
 compat/bswap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index f3b8c44..54756db 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -17,6 +17,8 @@ static inline uint32_t default_swab32(uint32_t val)
 		((val & 0x000000ff) << 24));
 }
=20
+#undef bswap32
+
 #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
=20
 #define bswap32(x) ({ \
--=20
1.7.0.3
