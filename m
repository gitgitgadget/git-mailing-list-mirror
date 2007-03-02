From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: identifying blobs (was Re: Memory overrun in http-push.c)
Date: Fri, 2 Mar 2007 15:10:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703021505380.3953@woody.linux-foundation.org>
References: <20070228151516.GC57456@codelabs.ru> <200703011040.35971.andyparkins@gmail.com>
 <200702281541.41164.andyparkins@gmail.com> <20070301051323.GG57456@codelabs.ru>
 <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
 <7vslcpux62.fsf@assigned-by-dhcp.cox.net> <20070301120042.GD63606@codelabs.ru>
 <es9cnt$egh$1@sea.gmane.org> <Pine.LNX.4.63.0703021617040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6s7dzrh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 00:10:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNGte-0007Qc-SF
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 00:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992716AbXCBXKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 18:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992720AbXCBXKj
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 18:10:39 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46181 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992716AbXCBXKi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 18:10:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l22NAUq8005523
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Mar 2007 15:10:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l22NAUdl021896;
	Fri, 2 Mar 2007 15:10:30 -0800
In-Reply-To: <7vr6s7dzrh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.456 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41257>



On Fri, 2 Mar 2007, Junio C Hamano wrote:
> 
> It wasn't that identifying the commit that contained the version
> of the file was not needed.  It is just there already is a way
> to do so, and "to create git command" turns out to be
> unnecessary.  Something like:
> 
> 	$ hash=`git hash-object --stdin <$file_in_question`
> 	$ git log -z --raw -r --abbrev=40 |
>           grep -z '^:[0-7][0-7]* [0-7][0-7]* [0-9a-f][0-9a-f]* '"$hash"'

That's not very nice, because if the blob is already in the *top* commit, 
and isn't changed in a long long time, you'll not see it until it changes 
(which is potentially at the root commit when it was introduced).

So it's better to do something like

 - get the hash

	hash=`git hash-object --stdin <$file_in_question`

 - see if it is in the current top of the tree

	git ls-tree -r HEAD | cut -d3- | grep ^$hash

 - after that, start doing the backwards searching for things where it 
   went away if it was there before (roughly your "git log -z ...")

which should be fairly simple and straightforward.

For extra bonus points, the script could be trivially written so that it 
allows the user to specify a path limiter, so that you say "can you tell 
me which version this blob existed in, but I only want to know about 
drivers/scsi/ and include/scsi/"

		Linus
