From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 14:31:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607171431010.2478@evo.osdl.org>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org>
 <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <1F90D448-5347-4CEB-80DE-3CC86C1CC16F@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Florian Weimer <fw@deneb.enyo.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 17 23:31:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2ag7-0001A7-FS
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 23:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWGQVay (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 17:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWGQVay
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 17:30:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10648 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751201AbWGQVay (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 17:30:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6HLUZnW005683
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Jul 2006 14:30:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6HLUEiH026302;
	Mon, 17 Jul 2006 14:30:15 -0700
To: Geert Bosch <bosch@adacore.com>
In-Reply-To: <1F90D448-5347-4CEB-80DE-3CC86C1CC16F@adacore.com>
X-Spam-Status: No, hits=-0.693 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23985>


On Mon, 17 Jul 2006, Geert Bosch wrote:
> 
> Or we can avoid doing an mmap of the entire pack file, and instead
> try to be somewhat smart on limiting the size of the mmap's.
> This might be sufficient to help Windows and also solve the
> issue of finding contiguous address space for large packs on
> 32-bit systems.

Well, the thing is, you really _do_ want to mmap as much as possible of 
the pack-file as possible, if mmap() works.

So even with large pack-files, you do want to mmap a huge chunk at a time, 
even if it turns out that you only need a very small part of it.

For example, the commit data is at the very beginning of the pack-file, so 
if you only look at the history, you only look at a very small part of the 
pack-file, but you should not have to know how much you'll need ahead of 
time, so you'd still want the pack-file operations to act in a way that is 
efficient for the general case (which is to mmap as much as possible).

So yes, we'll need to have some chunking layer at some point (when people 
have gigabyte pack-files) but I think that's a totally separate issue from 
the fact that we _do_ actually want mmap() (the _real_ kind of mmap) for 
pack-files.

			Linus
