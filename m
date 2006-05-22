From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 10:27:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221013020.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> 
 <446F95A2.6040909@gentoo.org>  <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org>
  <446FA262.7080900@gentoo.org>  <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
  <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>  <44713BE4.9040505@gentoo.org>
  <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> 
 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> 
 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Donnie Berkholz <spyderous@gentoo.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 19:28:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiEC4-0008H3-Lf
	for gcvg-git@gmane.org; Mon, 22 May 2006 19:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWEVR1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 13:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWEVR1d
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 13:27:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750996AbWEVR1c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 13:27:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4MHR5tH017996
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 10:27:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4MHR14n006444;
	Mon, 22 May 2006 10:27:02 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20515>



On Tue, 23 May 2006, Martin Langhoff wrote:
> 
> And there are two patches that I suspect may fix the leak. After
> applying them, the cvsimport process grows up to ~13MB and then tapers
> off, at least as far as my patience has gotten me. It's late on this
> side of the globe so I'll look at the results tomorrow morning.

Ok, initial results are promising. git-cvsimport appears to be still 
slowly growing, but it's at 40M (ie pretty tiny, considering that cvsps 
grew to 800+MB on this archive) and growth seems to actually be slowing.

My conversion is only up to September 2002, but if it doesn't suddenly hit 
some huge growth spurt, I wouldn't expect it to run out of memory. The CVS 
server process itself is tiny, and doesn't seem to grow at all.

As to packing, it doing something like

	while :
	do
		sleep 30

		#
		# repack roughly every 25600 objects
		#
		n=$(ls .git/objects/00 2> /dev/null | wc -l)
		if [ $n -gt 100 ]; then
			git repack -a
			#
			# Stupid sleep to make sure that nobody is still
			# using any unpacked objects after the pack got
			# generated
			#
			sleep 10
			git prune-packed
		fi
	done

or similar (the above is totally untested - I've just done it by hand a 
few times) should work. It's perfectly ok to repack the archive even while 
the cvsimport script is adding more data and changing it.

		Linus
