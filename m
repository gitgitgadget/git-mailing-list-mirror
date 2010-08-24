From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] upload-pack timing issue on windows?
Date: Tue, 24 Aug 2010 21:24:23 +0200
Message-ID: <201008242124.23890.j6t@kdbg.org>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com> <40aa078e1002080318n16918f91r5a5f4cd9b76a8436@mail.gmail.com> <AANLkTimk+SsmiHk7zWCTEeghk3sYjapDCDeZX=TP9UH_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 24 21:24:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onz6n-0007J7-6C
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 21:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab0HXTY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 15:24:28 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:25040 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833Ab0HXTY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 15:24:27 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id ACA74A7EB0;
	Tue, 24 Aug 2010 21:24:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id EB6FA19F74E;
	Tue, 24 Aug 2010 21:24:23 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTimk+SsmiHk7zWCTEeghk3sYjapDCDeZX=TP9UH_@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154340>

On Montag, 23. August 2010, Erik Faye-Lund wrote:
> - The culprit seems to be our poll-emulation. My understanding is that
> poll() was called by create_pack_file() in upload-pack.c with nfds=1
> (it's 2 until one of the fds are closed) when there's no data
> available in the pipe. Since our poll() always returns POLLIN when
> nfds=1, the check for xread(...) == 0 further down in
> create_pack_file() cause the fd to be closed, leading to an error on
> the client-side.
> -  Just removing the nfds=1-hack works for me, but I'm suspecting the
> nfds=1-hack is there for some socket-reason. So instead I've replaced
> our poll-emulation with gnulib's in my branch (with a couple of
> patches on top), and it seems to do the trick for me. I still haven't
> tested it heavily, though.

The nfds == 1 hack is an "optimization": When only one channel must be 
observed, then we can let (x)read() wait for data instead of doing it inside 
poll() in some way.

I'm not happy with our poll emulation because it contains a busy-loop. 
Gnulib's version looks quite capable, but I haven't studied it in detail. 
Until then, I trust that it does the right thing.

--Hannes
