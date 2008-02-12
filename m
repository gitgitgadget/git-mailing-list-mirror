From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Tue, 12 Feb 2008 15:39:21 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121533510.2920@woody.linux-foundation.org>
References: <200802081828.43849.kendy@suse.cz>  <200802091627.25913.kendy@suse.cz>  <alpine.LFD.1.00.0802092200350.2732@xanadu.home>  <alpine.LSU.1.00.0802101640570.11591@racer.site>  <alpine.LSU.1.00.0802101845320.11591@racer.site> 
 <alpine.LSU.1.00.0802122036150.3870@racer.site>  <alpine.LFD.1.00.0802121303450.2920@woody.linux-foundation.org>  <9e4733910802121336x42055baawf2b8f3714e2a1eb4@mail.gmail.com>  <alpine.LFD.1.00.0802121356330.2920@woody.linux-foundation.org> 
 <alpine.LFD.1.00.0802121412520.2920@woody.linux-foundation.org> <9e4733910802121443g7b3f5977s1f7dfeb9ba6abaab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:41:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP4kV-0004Bl-9N
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 00:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbYBLXkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 18:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYBLXkl
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 18:40:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33588 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750740AbYBLXkk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 18:40:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CNdQ1h017264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 15:39:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CNdLEA028946;
	Tue, 12 Feb 2008 15:39:21 -0800
In-Reply-To: <9e4733910802121443g7b3f5977s1f7dfeb9ba6abaab@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.741 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73712>



On Tue, 12 Feb 2008, Jon Smirl wrote:
> 
> In the gcc case I wasn't running out memory. I believe was CPU bound
> for an hour processing a single object chain with 2000 entries. That
> sure doesn't feel like O(windowsize).

Well, there's another - and totally unrelated - issue with *pre-existing* 
delta chains that are very deep.

Namely the fact that since such a deep delta chain will exhaust the 
delta-cache, you will now have a O(n*chaindepth) behaviour when you unpack 
the objects (in order to generate the deltas) in the first place!

So that really has nothing to do with the new window (or delta) depth at 
all, just with the _previous_ window depth.

See sha1_file.c: MAX_DELTA_CACHE.

If you have a 2000-deep delta chain, then the delta-cache should be big 
enough that you hit in it regularly without flushing it when you traverse 
down the chain. So MAX_DELTA_CACHE should generally be at _least_ as much 
as the max delta chain length, which is obviously normally the case 
(default max delta chain length: 10).

We could probably fairly easily make that MAX_DELTA_CACHE be a config 
option, but right now you have to recompile to test that theory of mine.

Or just limit your delta depth to something much smaller (ie ~100 or so)

		Linus
