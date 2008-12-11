From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git fsck segmentation fault
Date: Thu, 11 Dec 2008 07:27:53 +0100
Message-ID: <20081211062753.GA17683@auto.tuwien.ac.at>
References: <200811271814.06941.simon@lst.de> <200811272021.56108.simon@lst.de> <alpine.LFD.2.00.0811271449500.14328@xanadu.home> <200811280919.10685.simon@lst.de> <alpine.LFD.2.00.0812091408560.14328@xanadu.home> <20081210075338.GA7776@auto.tuwien.ac.at> <7vljunwidr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Simon Hausmann <simon@lst.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 07:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAf3D-0003pd-E6
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 07:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbYLKG14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Dec 2008 01:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbYLKG14
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 01:27:56 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37067 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbYLKG14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 01:27:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id BA7E2680507D;
	Thu, 11 Dec 2008 07:27:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ax8w+MjPgTlj; Thu, 11 Dec 2008 07:27:53 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 94A626804342; Thu, 11 Dec 2008 07:27:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vljunwidr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102781>

On Wed, Dec 10, 2008 at 06:33:20PM -0800, Junio C Hamano wrote:
> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> A similar change would be needed for other callers of fsck_walk(), no=
?
> There seem to be one in builtin-unpack-objects.c (check_object calls
> fsck_walk as itself as the callback).=20

buitin-unpack-objects.c is different. First, its intended for the
small case [default unpack_limit is 100; it keeps the unpacked content
of trees/commits in memory], which will not overflow the
stack. Second, it may only write an object after all of its connected
objects have been written out. So it would need a totally different
logic.

> Another caller is in index-pack.c (sha1_object() calls fsck_walk with
> mark_link as the callback), but I do not think it would  recurse for =
the
> depth of the history, so we are safe there.

mark_link only sets a flag on the direct connected objects, so yes, it
needs no change.

> I initially expected that the fix would be to introduce this "userspa=
ce
> work queue" (i.e. your objectstack) to be maintained on the
> fsck.c:fsck_walk() side (perhaps as an extra parameter to an actual q=
ueue
> for reentrancy), not by making the callee not to recurse, though.

fsck_walk has been designed to call a function on all directly
connected objected. There are callers, which expected this behaviour
(eg. index-pack, mark_used in fsck).

mfg Martin K=F6gler
