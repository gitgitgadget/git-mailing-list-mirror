From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 07:38:51 -0700
Message-ID: <20090310143851.GP11989@spearce.org>
References: <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302> <49B64ADC.2090406@viscovery.net> <49B64C3A.50909@viscovery.net> <alpine.DEB.1.00.0903101236480.14295@intel-tinevez-2-302> <49B659B4.5000705@viscovery.net> <alpine.DEB.1.00.0903101343530.14295@intel-tinevez-2-302> <49B6788F.2080609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 15:40:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh384-00083L-QT
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 15:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbZCJOiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 10:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754779AbZCJOix
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 10:38:53 -0400
Received: from george.spearce.org ([209.20.77.23]:41635 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbZCJOix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 10:38:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2A6ED38211; Tue, 10 Mar 2009 14:38:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49B6788F.2080609@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112819>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> But don't you see that are mixing a high-level concept of "terminal" into
> the low-level function that you want it to be? In its current form,
> recv_sideband() is *not* a low-level utility, it's already at a high level
> that knows about the line-oriented nature of band #2. What you need for
> GitTorrent is a different function that *only* demultiplexes the sideband
> protocol data into different streams without munging them. That's a
> totally different function that *maybe* can share some code with the
> current recv_sideband().

ACK.

The definition of the streams in the current sideband protocol
are rather well defined for the one protocol that uses it,
fetch-pack/receive-pack:

  stream #1:  pack data
  stream #2:  stderr messages, progress, meant for tty
  stream #3:  oh-sh*t abort message, remote is dead, goodbye!

The stream number is encoded as a byte.  Anyone trying to reuse the
sideband protocol within the fetch-pack/receive-pack protocol to
carry *extra* data should use new channel numbers.  We have another
252 remaining.  I don't think we're lacking on description space.
 
> With reference to Peter's reply, I'm not the only one who gets nervous if
> write() is replaced in a non-trivial way.
> 
> After all, you are sneaking the high-level concept "terminal emulation"
> into the low-level write() function.

Oh god.  Please do not do this.  I usually ignore the Win32 port
stuff.  But I agree with you Hannes, please do not do this.
 
> I'm absolutely not annoyed. And I am as married to my POV as you are to
> yours. ;) In this case we perhaps need a tie-breaker.

I cast my vote in with you Hannes.  Your original RFC patch made
sense as a cleanup in the code.

I agree with you that the way the code is currently structured
and used, sideband #2 should always dump to the stderr channel
of the process.  We also assume in a lot of other places that
fprintf(stderr, ...) is a good way to report progress to the
end-user.  This is no different, its just progress data from the
remote system rather than the local system.

Huge refactorings would be necessary to split sideband #2 into
something other than stderr.  You would also want to replace nearly
all references to stderr.  We're not going down that road.

FWIW, JGit takes the meanings of the streams as I described them
above.  Stream #1 goes to the pack processing, stream #2 gets parsed
and converted into updates calls to our ProgressMonitor API (which in
turn goes to GUI progress meters in the host IDE), stream #3, if it
ever shows up, turns into the message of an exception being thrown
up the stack.  That is the definition of this particular protocol.
Accept it, and move it.  :-)

The sideband protocol is fairly simple.  If we ever needed to use
it for other data, we could probably refactor some of the header
formatting/parsing out a bit and create a more generalized split
function, under a different name.  But that's all in the future
and something we just don't have an immediate need to worry about.
So don't worry about it.

-- 
Shawn.
