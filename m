From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] index-pack: Create .keep files with same permissions
 and .pack/.idx
Date: Fri, 1 Apr 2011 17:49:41 -0400
Message-ID: <AANLkTimMJxni=Vuja+iHyMp8ydm7ZBvWnkSe68g6+pyH@mail.gmail.com>
References: <201103311246.25645.johan@herland.net> <20110331190429.GC16981@sigill.intra.peff.net>
 <201104010329.05299.johan@herland.net> <7v1v1lfy7q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 23:50:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5mEO-0004QV-Ah
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 23:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757994Ab1DAVuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 17:50:03 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60683 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756932Ab1DAVuB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 17:50:01 -0400
Received: by vxi39 with SMTP id 39so3049571vxi.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 14:50:01 -0700 (PDT)
Received: by 10.52.73.105 with SMTP id k9mr6296399vdv.83.1301694601086; Fri,
 01 Apr 2011 14:50:01 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Fri, 1 Apr 2011 14:49:41 -0700 (PDT)
In-Reply-To: <7v1v1lfy7q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170628>

On Fri, Apr 1, 2011 at 17:39, Junio C Hamano <gitster@pobox.com> wrote:
> While I am not sure if letting a clone proceed while there is a concurrent
> push is even a good idea to begin with,

What? Why?

Are you suggesting that Git hosting sites disable readers while there
is a push occurring?

We have tried hard to design Git to be concurrent reader/writer safe,
*except* the actual garbage collection part of `git gc` that deletes
loose objects. There is no reason to prevent concurrent readers while
there is a push in progress.

The only problem is a cpio based clone, which may link the objects
directory before the refs, and miss linking the new pack but wind up
linking the new ref, making the clone corrupt. But that is a bug in
the cpio clone implementation. Using file:// to use the classical pipe
is safe here, because the refs are scanned before the objects are.
IMHO, if you think clone during push is unsafe because of this, we
should fix the cpio clone path to do a `git ls-remote` on the source,
cache the refs in memory, copy the objects, then write out a
packed-refs file containing the refs we snapshotted *before* linking
the objects directory into the new clone.

-- 
Shawn.
