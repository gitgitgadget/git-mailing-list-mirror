From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make verify-tag a builtin.
Date: Fri, 27 Jul 2007 14:08:59 -0700
Message-ID: <7vtzrpwo44.fsf@assigned-by-dhcp.cox.net>
References: <46A96F86.2030704@gmail.com>
	<7vr6mu2uo0.fsf@assigned-by-dhcp.cox.net>
	<1b46aba20707271251g7cf968a6o3840739dec548408@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Carlos Rica" <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 23:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEX3a-0006lz-Os
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 23:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933678AbXG0VJD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 17:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762425AbXG0VJD
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 17:09:03 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52186 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761271AbXG0VJB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 17:09:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727210901.GOBX1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 17:09:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ul901X0041kojtg0000000; Fri, 27 Jul 2007 17:09:00 -0400
In-Reply-To: <1b46aba20707271251g7cf968a6o3840739dec548408@mail.gmail.com>
	(Carlos Rica's message of "Fri, 27 Jul 2007 21:51:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53970>

"Carlos Rica" <jasampler@gmail.com> writes:

> In my system, some of the tests give 141 and others give 1 as exit code.
> Dscho said that it could depend on the CPU current load of the computer,
> since he got always 141 as you said, so perhaps it's me.

This is expected.  It depends on how processess are scheduled.

What is happening is:

 1. Your process prepares the whole thing in vtag-tmp, to hand
    to gpg;

 2. You make a pipe and start gpg with the above file telling it
    "here is a detached signature file, the payload will be fed
    through your stdin";

 3-a. You feed the payload to the pipe, expecting gpg to read it.

 3-b. gpg reads the detached signature file, finds no signature in
    the vtag-tmp file because the tag in question is not signed,
    and exits without reading a single byte from the pipe;

Now, 3-a and 3-b run in parallel.  If 3-a is scheduled before
3-b happens, because payload is very often much smaller than the
in-kernel pipe buffer, your write(2) succeeds before gpg gives up
and exits without reading from the pipe.  If 3-b is scheduled
before 3-a, then gpg exits and when 3-a gets around to write(2)
to the pipe, write notices that there is nobody on the other end
of the pipe, and you get SIGPIPE.
