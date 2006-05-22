From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 11:03:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221055270.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> <446F95A2.6040909@gentoo.org>
 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org> <446FA262.7080900@gentoo.org>
 <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org> <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
 <44713BE4.9040505@gentoo.org> <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
 <Pine.LNX.4.64.0605221013020.3697@g5.osdl.org> <e4stna$o1g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 20:03:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiEkN-0007v9-2l
	for gcvg-git@gmane.org; Mon, 22 May 2006 20:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWEVSDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWEVSDM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 14:03:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31893 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWEVSDL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 14:03:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4MI36tH019807
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 11:03:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4MI35Y9007760;
	Mon, 22 May 2006 11:03:05 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e4stna$o1g$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20517>



On Mon, 22 May 2006, Jakub Narebski wrote:
>
> Linus Torvalds wrote:
> 
> >                       git repack -a
> >                       #
> >                       # Stupid sleep to make sure that nobody is still
> >                       # using any unpacked objects after the pack got
> >                       # generated
> >                       #
> >                       sleep 10
> >                       git prune-packed
> 
> Is it really necessary (on Linux at least)? Git boast it's atomicity...

I don't think it's necessary in practice.

But people _should_ realize that removing objects is very very special. 
Whether it's done by "git prune-packed" or "git prune", that's a very 
dangerous operations. "git prune" a lot more so than "git prune-packed", 
of course (in fact, you should _never_ run "git prune" on a repository 
that is active - you _will_ corrupt it)-

Doing "git prune-packed" _should_ be mostly safe on UNIX, since the 
objects all exist in packs, and anybody who already opened an object will 
keep the fd open, and not even notice that the name is gone. However, 
there is at least one race:

	object lookup			"git repack -a -d"
	=============			==================

 - a process does its object
   database setup. No new pack-file
   yet.

					 - mv tmp-packfile active-packfile

					 - git prune-packed

 - the process looks up the object,
   and doesn't look in the pack-file
   because it didn't see the pack-file.

   So it tries to look up an object,
   fails, and errors out.

   It's not a fatal error (just re-try)
   but it could break something like a
   cvsimport

Now, in PRACTICE, I doubt you'd ever hit this. But the fact is, pruning 
your repository (whether prune-packed or a full prune) is _the_ special 
operation. It's something that removes a filesystem representation of an 
object that is otherwise immutable.

		Linus
