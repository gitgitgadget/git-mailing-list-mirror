From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] index-pack: Create .keep files with same permissions
 and .pack/.idx
Date: Sun, 03 Apr 2011 03:01:29 +0200
Message-ID: <201104030301.29923.johan@herland.net>
References: <201103311246.25645.johan@herland.net>
 <201104020127.41774.johan@herland.net>
 <7v39m1e110.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 03:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6BhD-0005BU-Rf
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 03:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574Ab1DCBBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 21:01:33 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33728 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757465Ab1DCBBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 21:01:33 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJ100IULXII2P80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 03 Apr 2011 03:01:31 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D86681EEFE02_D97C6EAB	for <git@vger.kernel.org>; Sun,
 03 Apr 2011 01:01:30 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 55C881EEFDC9_D97C6EAF	for <git@vger.kernel.org>; Sun,
 03 Apr 2011 01:01:30 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJ100CRFXIIGB10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 03 Apr 2011 03:01:30 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <7v39m1e110.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170671>

On Saturday 02 April 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > While pushing to a remote repo, Git transiently adds a .keep file for
> > the pack being pushed, to protect it from a concurrent "git gc".
> > Sometimes, when the push fails or is aborted, the .keep file is left
> > stale in the repo. This causes problems for other users of the same
> > repo, since the permissions on the .keep file (0600) make it
> > inaccessible even though the rest of the repo is accessible (0444
> > modulo shared_repository setting).
> 
> I was also wondering why you initialized with 0444 in your patch and then
> even adjusted for shared repository settings.

I was simply emulating what is currently done for idx and pack files (see 
below).

> This is a tangent, but wouldn't it be wrong for index-pack to always
> leave the idx and pack files in 0444 with an explicit chmod() in the
> first place?  I suspect that we simply forgot to fix it when we
> introduced adjust_shared_perm().

Yeah, probablby, but AFAICS in the receive-pack case, final_pack_name and 
final_index_name are both NULL (neither are specified on the index-pack 
command line passed from receive-pack), so the explicit chmod(..., 0444) is 
never called. Instead the pack and idx files are both opened from 
odb_mkstemp() (via open_pack_file() and write_idx_file(), respectively), 
which uses mode 0444. We then call move_temp_to_file(), which calls 
adjust_shared_perm().


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
