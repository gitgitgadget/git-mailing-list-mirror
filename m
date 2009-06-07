From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Comments pack protocol description in "Git Community Book"
	(second round)
Date: Sun, 7 Jun 2009 13:13:24 -0700
Message-ID: <20090607201324.GB16497@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906062338.02451.jnareb@gmail.com> <d411cc4a0906061458g494d80dbwe3a5358edfd1d49e@mail.gmail.com> <200906071021.08922.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Tony Finch <dot@dotat.at>,
	Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 22:13:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDOkG-0001rk-4S
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbZFGUNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754401AbZFGUNW
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:13:22 -0400
Received: from george.spearce.org ([209.20.77.23]:57557 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbZFGUNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:13:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4406F381FD; Sun,  7 Jun 2009 20:13:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906071021.08922.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120994>

Jakub Narebski <jnareb@gmail.com> wrote:
> In description of sideband:
> 
> >  When a sideband is used, 2 means "progress messages, most likely
> >  suitable for stderr". 1 means "pack data". 3 means "fatal error
> >  message, and we're dead now".  No other channels are used or valid.
> 
> it is true that no other channels are used, but it is not true that 
> other channels are invalid. If they are not supported by client, there 
> are simply dropped. This opens possibility of future extension. I guess 
> that channel 0 is invalid, because it would be understood as _input_ 
> channel (for sending data from client to server), though.
> 
> Please correct me if I am wrong here...

An implementation reading a muxed stream SHOULD fail fast if it
encounters a channel number it doesn't understand.

JGit already fails fast with an error if it gets anything not in 1-3.
C Git already fails fast with an error as well.

An implementation writing a muxed stream shouldn't produce a channel
number unless it knows the reader can support it.

To add a new channel number to the supported set, a new capability
should be introduced to the protocol, and enabled if both sides
have agreed to support it.

Currently, stream 0 and stream 4-255 are undefined.  That is,
any new capability could claim that stream and start to use it,
if it needed to.

I think the primary Git contributors would prefer to see new channels
in the 4-255 range, as then 0 can continue to stay invalid... aka
"not true" in C.  Like in the pack type codes, we might want to save
0 for the day when all 1-255 are filled and we need to expand the
channel number range into 2 bytes.  But even then, we could just
do a new side-band-64kv2 capability or something.  :-)
 
-- 
Shawn.
