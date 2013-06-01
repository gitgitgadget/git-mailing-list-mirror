From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 13:01:48 -0400
Message-ID: <20130601170147.GA19234@sigill.intra.peff.net>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8Df-O=D5LQBXCbiVLB=uHfn6ETbAxADWq3hd-9pPX4+mg@mail.gmail.com>
 <CAMP44s0L1M+_s2eDM=Ogy=rxLhpZYwSb8qWTuEe30pB4KGDVtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 19:01:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UipBi-0000UJ-RN
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 19:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427Ab3FARBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 13:01:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:42374 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab3FARBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 13:01:50 -0400
Received: (qmail 21878 invoked by uid 102); 1 Jun 2013 17:02:33 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Jun 2013 12:02:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Jun 2013 13:01:48 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0L1M+_s2eDM=Ogy=rxLhpZYwSb8qWTuEe30pB4KGDVtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226139>

On Sat, Jun 01, 2013 at 09:30:50AM -0500, Felipe Contreras wrote:

> > The original commit that introduces this says
> >
> >     run_command: encode deadly signal number in the return value
> >
> >     We now write the signal number in the error message if the program
> >     terminated by a signal. The negative return value is constructed such that
> >     after truncation to 8 bits it looks like a POSIX shell's $?:
> >
> >        $ echo 0000 | { git upload-pack .; echo $? >&2; } | :
> >        error: git-upload-pack died of signal 13
> >        141
> >
> >     Previously, the exit code was 255 instead of 141.
> >
> > So this is part of the interface to the user. With your changes, the
> > exit code is now different. I tested by force segfaulting upload-pack.
> > $? returned 11. So NAK.
> 
> Yeah, and last year we returned a different code. The world didn't
> end, because nobody is checking for the specific code. But if you want
> to retain complexity forever, suit yourselves.

Last year we returned a different code from the function that other C
code saw. But what got returned via exit() to exterior programs was
always 141 in the SIGPIPE case, both before and after my 709ca730. That
is explained in the first two paragraphs here:

> commit 709ca730f8e093005cc882bfb86c0ca9c83d345b
> Author: Jeff King <peff@peff.net>
> Date:   Sat Jan 5 09:49:49 2013 -0500
> 
>     run-command: encode signal death as a positive integer
> 
>     When a sub-command dies due to a signal, we encode the
>     signal number into the numeric exit status as "signal -
>     128". This is easy to identify (versus a regular positive
>     error code), and when cast to an unsigned integer (e.g., by
>     feeding it to exit), matches what a POSIX shell would return
>     when reporting a signal death in $? or through its own exit
>     code.
> 
>     So we have a negative value inside the code, but once it
>     passes across an exit() barrier, it looks positive (and any
>     code we receive from a sub-shell will have the positive
>     form). E.g., death by SIGPIPE (signal 13) will look like
>     -115 to us in inside git, but will end up as 141 when we
>     call exit() with it. And a program killed by SIGPIPE but run
>     via the shell will come to us with an exit code of 141.

Your patch changes the error code that is propagated via exit() in this
case. We cannot know "nobody is checking for the specific code", because
the list of callers is every shell script or program which execs git.
Some of them do care about the exit code. I can give an example of a
case I have that cares, but I do not think it is even important. The
point is that we would be regressing an existing interface, and cannot
know who is broken by it.

-Peff
