From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Tue, 12 Feb 2008 13:59:47 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121356330.2920@woody.linux-foundation.org>
References: <200802081828.43849.kendy@suse.cz>  <m3ejbngtnn.fsf@localhost.localdomain>  <200802091627.25913.kendy@suse.cz>  <alpine.LFD.1.00.0802092200350.2732@xanadu.home>  <alpine.LSU.1.00.0802101640570.11591@racer.site>  <alpine.LSU.1.00.0802101845320.11591@racer.site>
  <alpine.LSU.1.00.0802122036150.3870@racer.site>  <alpine.LFD.1.00.0802121303450.2920@woody.linux-foundation.org> <9e4733910802121336x42055baawf2b8f3714e2a1eb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:01:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP3BZ-0001wz-Oq
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 23:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbYBLWAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 17:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbYBLWAa
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 17:00:30 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57236 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029AbYBLWA3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 17:00:29 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CLxmPd011129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 13:59:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CLxl9X024389;
	Tue, 12 Feb 2008 13:59:47 -0800
In-Reply-To: <9e4733910802121336x42055baawf2b8f3714e2a1eb4@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.739 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73700>



On Tue, 12 Feb 2008, Jon Smirl wrote:
>
> How many diffs should it take to compress a 2000 delta chain with
> window/depth=250?

There's no fixed answer. We do various culling heurstics to avoid actually 
generating a diff at all if it looks unlikely to succeed etc. But in 
general, the way the window works is that 
 (a) we only need to generate the _unpacked_ object once
 (b) we compare each object to the "window-1" preceding objects, which is 
     how I got the O(windowsize^2) 
 (c) but then that "compare" relatively seldom involves actually 
     generating a whole diff!

So the answer is: in _theory_ each object may be compared to 
(windowsize-1) other objects, but in practice it's much less than that.

			Linus
