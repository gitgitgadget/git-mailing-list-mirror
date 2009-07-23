From: Tony Finch <dot@dotat.at>
Subject: Newton-Raphson, was Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 23:48:43 +0100
Message-ID: <alpine.LSU.2.00.0907232310220.22113@hermes-2.csi.cam.ac.uk>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221959330.21520@localhost.localdomain> <alpine.LFD.2.01.0907222009340.21520@localhost.localdomain> <alpine.LSU.2.00.0907231846190.30197@hermes-2.csi.cam.ac.uk> <alpine.LFD.2.01.0907231153010.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-608752897-1248389323=:22113"
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 24 00:48:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU75o-0004Ck-Q9
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 00:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbZGWWsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 18:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbZGWWsp
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 18:48:45 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:52374 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbZGWWso (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 18:48:44 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:34708)
	by ppsw-5.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.155]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MU75f-0000N7-HE (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 23 Jul 2009 23:48:43 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MU75f-0000Ae-AS (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 23 Jul 2009 23:48:43 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <alpine.LFD.2.01.0907231153010.21520@localhost.localdomain>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123895>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-608752897-1248389323=:22113
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Jul 2009, Linus Torvalds wrote:
>
> Some googling found this:
> =09http://marc.info/?l=3Dgit&m=3D117537594112450&w=3D2
> but what got merged (half a year later) was a much fancier thing by Junio=
=2E
> See sha1-lookup.c.

Thanks. Ed=E9sio Costa e Silva also gave me a useful pointer.

> That original "single iteration of newton-raphson" patch was buggy, but
> it's perhaps interesting as a concept patch.

I think Newton-Raphson is a brilliant but misleading idea. (As Junio said,
"egg of Columbus" - it certainly blew my mind!) However, Newton's method
works with smooth curves, but a pack index is a straight line plus
stochastic deviations. If you try to apply Newton's method then the more
you zoom in the more the random variations will send you away from the
place you want to be. So I think your first N-R patch was closer to being
right than its successors.

What you should do is ONE linear interpolation on the entire index. (i.e.
If you have N objects in the pack and you want to find one with SHA-1 id
S, take the top four bytes of S and multiply by N/2^32.) Note that if you
do a level-1 256-way fan-out lookup first then the random variations will
make you LESS likely to land near the right place.

After doing the first-order linear interpolation, it's probably sensible
to do a page-wise linear search (in case you don't land directly on
the page containing the target SHA-1) then a binary search within the
final page for efficiency with a hot cache.

This should give you O(1) seeks in the index per object lookup.

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
--1870870024-608752897-1248389323=:22113--
