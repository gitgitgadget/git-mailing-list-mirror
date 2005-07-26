From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Why pack+unpack?
Date: Tue, 26 Jul 2005 09:44:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507260937460.19309@g5.osdl.org>
References: <42D7F415.30609@pobox.com> <Pine.LNX.4.58.0507252145470.6074@g5.osdl.org>
 <42E5C677.2020403@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 18:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxSgj-0002Z6-BV
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 18:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVGZQsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 12:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVGZQpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 12:45:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261805AbVGZQoM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 12:44:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6QGi8jA029576
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Jul 2005 09:44:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6QGi73F031246;
	Tue, 26 Jul 2005 09:44:08 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42E5C677.2020403@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Jul 2005, Jeff Garzik wrote:
> > 
> > Put another way: do you argue that X network transparency is a total waste
> > of time? You could certainly optimize X if you always made it be
> > local-machine only. Or you could make tons of special cases, and have X 
> > have separate code-paths for local clients and for remote clients, rather 
> > than just always opening a socket connection.
> 
> Poor example...   sure it opens a socket, but X certainly does have a 
> special case local path (mit shm), and they're adding more for 3D due 
> the massive amount of data involved in 3D.

.. and that's still a special case. Exactly like git does the "clone -l" 
special case.

> Well, I'm not overly concerned, mostly curious.  The pack+unpack step 
> (a) appears completely redundant and (b) is the step that takes the most 
> time here, for local pulls, after the diffstat.

It's not actually redundant. Some of the _compression_ may be, and you 
could see if you prefer a smaller delta window (use "--window=0" to 
git-pack-objects to totally disable delta compression), but in general you 
can't actually just link the files over like with "git clone", because 
that would create total chaos and a real mess if the other end was packed.

So "git pull" actually needs to copy one object at a time in order to have 
sensible semantics together with "git repack". Now, you could make that 
"one object at a time" thing have its own special cases ("if it's packed, 
extract it as a unpacked object in the destination, if it's unpacked, just 
link it if you can"), but it would just be pretty ugly.

If it ever gets to be a real performance problem, we can certainly fix it,
but in the meantime I _much_ prefer having one single path. I dislike the
rsync (and the http) paths immensely already, but at least I don't have to
use them..

			Linus
