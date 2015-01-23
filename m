From: Jeff King <peff@peff.net>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 08:30:34 -0500
Message-ID: <20150123133033.GA27692@peff.net>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
 <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
 <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
 <20150122220140.GB6695@peff.net>
 <315bf23981813799d16fdd9b533444f3@www.dscho.org>
 <20150123122317.GA12517@peff.net>
 <6fd8dc170de8be1ab38f8fda89d44f6a@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:30:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEeJs-0007SX-Vl
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 14:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbbAWNah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 08:30:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:37837 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752662AbbAWNag (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 08:30:36 -0500
Received: (qmail 4590 invoked by uid 102); 23 Jan 2015 13:30:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 07:30:36 -0600
Received: (qmail 20008 invoked by uid 107); 23 Jan 2015 13:31:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 08:31:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2015 08:30:34 -0500
Content-Disposition: inline
In-Reply-To: <6fd8dc170de8be1ab38f8fda89d44f6a@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262927>

On Fri, Jan 23, 2015 at 01:38:17PM +0100, Johannes Schindelin wrote:

> > Unless we are willing to drop the ">= 0" check completely. I think it is
> > valid to do so regardless of the compiler's representation decision due
> > to the numbering rules I mentioned above. It kind-of serves as a
> > cross-check that we haven't cast some random int into the enum, but I
> > think we would do better to find those callsites (since they are not
> > guaranteed to work, anyway; in addition to signedness, it might choose a
> > much smaller representation).
> 
> Yeah, well, this check is really more of a safety net in case I messed
> up anything; I was saved so many times by my own defensive programming
> that I try to employ it as much as I can.

Yeah, I am all in favor of defensive programming. But I am not sure that
it is defending much here, as we silently fall back to an alternate
value for the severity. Would we notice, or would that produce subtly
wrong results? IOW, would this be better as:

  assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);

or something?

> -- snip --
> diff --git a/fsck.c b/fsck.c
> index 15cb8bd..8f8c82f 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -107,7 +107,7 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
>  {
>  	int severity;
>  
> -	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
> +	if (options->msg_severity && ((unsigned int) msg_id) < FSCK_MSG_MAX)
>  		severity = options->msg_severity[msg_id];
>  	else {
>  		severity = msg_id_info[msg_id].severity;
> -- snap --
> 
> What do you think? Michael, does this cause more Clang warnings, or would it resolve the issue?

Hmm, yeah, that does not seem unreasonable, and is more localized.

-Peff
