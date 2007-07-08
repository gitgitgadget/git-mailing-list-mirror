From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Dynamic window size on repack?
Date: Sun, 8 Jul 2007 14:35:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707081429500.31544@woody.linux-foundation.org>
References: <20070708211606.GF4087@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7eQA-0003YQ-W9
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457AbXGHVff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757484AbXGHVfe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:35:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49799 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757457AbXGHVfd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jul 2007 17:35:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l68LZC4n009943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 Jul 2007 14:35:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l68LZ696025437;
	Sun, 8 Jul 2007 14:35:06 -0700
In-Reply-To: <20070708211606.GF4087@lavos.net>
X-Spam-Status: No, hits=-3.142 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51922>



On Sun, 8 Jul 2007, Brian Downing wrote:
> 
> I think what I'd like is an extra option to repack to limit window
> memory usage.  This would dynamically scale the window size down if it
> can't fit within the limit, then scale it back up once you're off of the
> nasty file.  This would let me repack my repository with --window=100
> and have it actually finish someday on the machines I have access to.
> The big file may not be as efficiently packed as possible, but I can
> live with that.
> 
> My question is, is this sane?  Does the repack algorithm depend on having
> a fixed window size to work?  I'd rather not look into implementing this
> if it's silly on the face of it.

It doesn't sound silly, and it should even be fairly easy. The window code 
is all in builtin-pack-objects.c (find_deltas()) and while it's currently 
coded for a constant-sized window, it shouldn't be too hard to free more 
old entries if you allocate one big one to make sure that the "array" 
thing doesn't grow to contain too much data.

In other words, just look at how the variables "struct unpacked *array" 
(the whole window array) and the "struct unpacked *n" (the "next entry" in 
the array using a simple circular queue using "idx") are accessed.

		Linus
