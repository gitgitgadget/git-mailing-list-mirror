From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 06/11] run-command: add kill_async() and  is_async_alive()
Date: Fri, 27 Nov 2009 20:59:25 +0100
Message-ID: <200911272059.25934.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <200911262246.13342.j6t@kdbg.org> <40aa078e0911270804i1a828ea6we1611047d37869f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 27 20:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE6yn-00075C-BH
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 20:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbZK0T7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 14:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZK0T7d
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 14:59:33 -0500
Received: from [93.83.142.38] ([93.83.142.38]:63565 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752133AbZK0T7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 14:59:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0D42E19F610;
	Fri, 27 Nov 2009 20:59:26 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e0911270804i1a828ea6we1611047d37869f7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133928>

On Freitag, 27. November 2009, Erik Faye-Lund wrote:
> Do you really think it's better to unconditionally take down the
> entire process with an error, instead of having a relatively small
> chance of stuff blowing up without any sensible error? I'm not 100%
> convinced - but let's hope we'll find a proper fix.

"relatively small chance of stuff blowing up"? The docs of 
TerminateThread: "... the kernel32 state for the thread's process could be 
inconsistent." That's scary if we are talking about a process that should run 
for days or weeks without interruption.

The reason why we are killing a thread is to prevent keeping lots of 
connections open (to the same IP address). There are two situations to take 
care of:

1. We are in a lengthy computation without paying attention to the socket.

2. The client does not send or accept data for a long time.

Case 1 could happen if upload-pack is "counting objects" on a large 
repository. We would need some way to kill upload-pack. Since it is a 
separate process anyway, we could use TerminateProcess().

Case 2 could be achieved by using setsockopt() with SO_RCVTIMEO and 
SO_SNDTIMEO and a tiny timeout. But notice that we would set a timeout in one 
thread while another thread is waiting in ReadFile() or WriteFile(). Would 
that work?

-- Hannes
