From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Decrease the fetch pack client buffer to the
	lower minimum
Date: Mon, 11 May 2009 07:10:22 -0700
Message-ID: <20090511141021.GJ30527@spearce.org>
References: <1241995685-13260-1-git-send-email-spearce@spearce.org> <1241995685-13260-2-git-send-email-spearce@spearce.org> <7vfxfctqon.fsf@alter.siamese.dyndns.org> <20090511005526.GI30527@spearce.org> <7vr5yws3fe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 16:10:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3WDF-0004Mo-J8
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 16:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbZEKOKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 10:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbZEKOKX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 10:10:23 -0400
Received: from george.spearce.org ([209.20.77.23]:59347 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZEKOKV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 10:10:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 29121381D6; Mon, 11 May 2009 14:10:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vr5yws3fe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118800>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > In step 3 during the first round the client can send up to 2 blocks
> > worth of data, with 32 haves per block.  This means the client
> > writes 2952 bytes of data before it reads.
> 
> Sorry, perhaps I am being extremely slow, but even if the client writes
> millions of bytes before it starts reading, I do not see how it would be a
> problem as long as the other side reads these millions of bytes before
> saying "Ok, I've heard about them and my response so far is Ack-continue
> (or NAK)", which the client needs to read.

Ok, maybe my understanding of the fetch-pack/upload-pack protocol
is incorrect.

If multi_ack is enabled then isn't it possible for the remote to
return "ACK %s continue" for the first 63 "have %s" lines the
client sent?

E.g. the case is the client has only one ref, and has only 1 commit
the other side doesn't have, and the other side has only one ref,
and has only 1 commit the client doesn't have (so the client will
fetch 1 commit).  In such a case, the client will blast 64 have lines
before pausing to listen to the server.  But the server will have
63 of those lines, and will try to send "ACK %s continue" in vain
at the client, hoping it will stop enumerating along that branch.

If there is insufficient buffering along one of those writers,
the entire thing deadlocks.

-- 
Shawn.
