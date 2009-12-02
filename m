From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 06/11] run-command: add kill_async() and  is_async_alive()
Date: Wed, 2 Dec 2009 20:27:23 +0100
Message-ID: <200912022027.23344.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <200911272059.25934.j6t@kdbg.org> <40aa078e0912020757i3b63ef6eh71c3d4d99047f1f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 20:27:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFurk-0003DD-CW
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbZLBT1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbZLBT1g
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:27:36 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:42043 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755160AbZLBT1f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:27:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AD258CDF89;
	Wed,  2 Dec 2009 20:27:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6C33219F60D;
	Wed,  2 Dec 2009 20:27:23 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e0912020757i3b63ef6eh71c3d4d99047f1f2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134380>

On Mittwoch, 2. Dezember 2009, Erik Faye-Lund wrote:
> On Fri, Nov 27, 2009 at 8:59 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > "relatively small chance of stuff blowing up"? The docs of
> > TerminateThread: "... the kernel32 state for the thread's process could
> > be inconsistent." That's scary if we are talking about a process that
> > should run for days or weeks without interruption.
>
> I think there's a misunderstanding here. I thought your suggestion was
> to simply call die(), which would take down the main process. After
> reading this explanation, I think you're talking about giving an error
> and rejecting the connection instead. Which makes more sense than to
> risk crashing the main-process, indeed.

Just rejecting a connection is certainly the simplest do to keep the daemon 
process alive. But the server can be DoS-ed from a single source IP.

Currently git-daemon can only be DDoS-ed because there is a maximum number of 
connections, which are not closed if all of them originate from different 
IPs.

> > Case 2 could be achieved by using setsockopt() with SO_RCVTIMEO and
> > SO_SNDTIMEO and a tiny timeout. But notice that we would set a timeout in
> > one thread while another thread is waiting in ReadFile() or WriteFile().
> > Would that work?
>
> I think it should work fine, but I won't give you a guarantee ;)
> Perhaps we should have a configurable global max timeout, and just set
> that on all sockets? Or does this open for DDOS attacks?

I'm sure that there is a global timeout already, but it is in the order of 
minutes, which is too long. Here I mean it to be set to zero or one 
milli-second so that the connection closes right away - as if the process on 
the server side had been killed.

Hm - perhaps it is possible to really *close* the socket while some other 
thread waits in ReadFile() or WriteFile()?

-- Hannes
