From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 13:12:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 22:07:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do5JX-0008BU-82
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 22:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbVF3UNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 16:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbVF3UNf
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 16:13:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263133AbVF3UKW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 16:10:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5UKA4jA021128
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 13:10:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5UKA3uL029428;
	Thu, 30 Jun 2005 13:10:03 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, Daniel Barkalow wrote:
> 
> The right solution probably involves getting each pack file you push to
> the mirrors as well as to the master. They'll probably update no less
> frequently than you push, and they should go through a series of states
> which matches the master, so it's not necessary to have anything smart on
> master sending them, and they only have to unpack the files they get (and
> update the refs afterward).

Hmm, yes. That would work, together with just fetching the heads.

It won't _really_ solve the problem, since the pushed pack objects will
grow at a proportional rate to the current objects - it's just a constant
factor (admittedly a potentially fairly _big_ constant factor)  
improvement both in size and in number of files.

So the mirroring ends up getting slowly slower and slower as the number of 
pack files go up. In contrast, a git-aware thing can be basically 
constant-time, and mirroring expense ends up being relative to the size of 
the change rather than the size of the repository.

But mirroring just pack-files might solve the problem for the forseeable 
future, so..

"git-receive-pack" would need to take a flag to tell it to instead of
unpacking just check the object instead (ie call "git-unpack-object" with
the "-n" flag - it will check that everything looks ok, including the
embedded protecting SHA1 hash), and write it out to the filesystem (as it
comes in) and then rename it to the right place.

			Linus
