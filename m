From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with git-daemon and mmap.
Date: Wed, 25 Apr 2007 09:13:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704250858530.9964@woody.linux-foundation.org>
References: <1177483875.12689.22.camel@localhost>
 <20070425074354.GH5942@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Tim Ansell <mithro@mithis.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 18:14:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgk83-0004Jk-7u
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 18:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992800AbXDYQNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 12:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992812AbXDYQNs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 12:13:48 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:60429 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992800AbXDYQNq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2007 12:13:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3PGDFtt000935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Apr 2007 09:13:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3PGDEdo006866;
	Wed, 25 Apr 2007 09:13:14 -0700
In-Reply-To: <20070425074354.GH5942@spearce.org>
X-Spam-Status: No, hits=-3.035 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45536>



On Wed, 25 Apr 2007, Shawn O. Pearce wrote:
> 
> And that was the last window in this packfile.  So we closed it.
> Way to go us.  Our xmmap does not expect release_pack_memory
> to close the fd its about to map...

Yeah, that looks like a real bug - it means that if we only have enough 
memory to have _one_ window open, the whole pack-file windowing doesn't 
work.

Now, in this case, it looks like Tim's problem was just some way too tight 
memory limits by his Debian install, and is fixed for him now, but this 
does seem to be a beauty wart that should be fixed.

> But that strace above shows a secondary bug when we get into this
> sort of situation.  Not pretty.

Yeah. 

	ulimit -S -v 65536
	git clone linux-2.6 test-linux-2.6

or similar should be able to reproduce it, if you just set the pack-file 
window to something like 32MB. Maybe.

			Linus
