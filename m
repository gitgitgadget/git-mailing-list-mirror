From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Clean up write_in_full() users
Date: Thu, 11 Jan 2007 20:43:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701112039100.3594@woody.osdl.org>
References: <Pine.LNX.4.64.0701112014050.3594@woody.osdl.org>
 <20070112043346.GB24195@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 12 05:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5EGm-0003gb-Gm
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 05:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbXALEn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 23:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbXALEn6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 23:43:58 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60315 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030478AbXALEn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 23:43:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0C4hpWi018542
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 20:43:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0C4honX012172;
	Thu, 11 Jan 2007 20:43:51 -0800
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070112043346.GB24195@spearce.org>
X-Spam-Status: No, hits=-0.662 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36661>



On Thu, 11 Jan 2007, Shawn O. Pearce wrote:
> 
> AFAIK the only user of read_or_die is sha1_file.c when it reads in
> the 12 byte pack header and the 20 byte pack trailer to "quickly"
> verify the packfile is sane before using it.  If I recall correctly
> it was correct when I created it, but the read_in_full refactoring
> changed it.

Well, I just sent a patch to hopefully fix it, but I also think that the 
whole function is really misdesigned.

The thing is, "write_or_die()" actually makes sense. If you get a write 
error, things are really seriously broken, and it makes a lot of sense to 
just say "things are totally broken".

HOWEVER. The same thing is not true of a partial read. If a read doesn't 
succeed fully, the most _common_ case is that a file is truncated, and it 
does generally NOT make sense to just die and say "partial file".

So for a write error, it's ok to say "ok, I can't write, I'm dead". 

For a read error, at the very least you have to say WHICH FILE couldn't be 
read, because it's usually a matter of some file just being too short, not 
some system-wide problem.

Looking at the two call-sites of "read_or_die()", they really are better 
off not dying, or if they died, the caller should have passed in the 
_reason_ (ie the name of the pack-file), or should have just used a 
non-dying version and tested the return value and written a message of its 
own.

But at least the function now WORKS after the patch I just sent out. Which 
it didn't do before. 

			Linus
