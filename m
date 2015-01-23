From: Jeff King <peff@peff.net>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 13:37:37 -0500
Message-ID: <20150123183737.GA32191@peff.net>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
 <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
 <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
 <20150122220140.GB6695@peff.net>
 <315bf23981813799d16fdd9b533444f3@www.dscho.org>
 <20150123122317.GA12517@peff.net>
 <6fd8dc170de8be1ab38f8fda89d44f6a@www.dscho.org>
 <20150123133033.GA27692@peff.net>
 <xmqqwq4dqskp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:40:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEj9S-0003XC-4c
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 19:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400AbbAWSho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 13:37:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:37965 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756384AbbAWShm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 13:37:42 -0500
Received: (qmail 20400 invoked by uid 102); 23 Jan 2015 18:37:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 12:37:40 -0600
Received: (qmail 22437 invoked by uid 107); 23 Jan 2015 18:38:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jan 2015 13:38:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2015 13:37:37 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwq4dqskp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262942>

On Fri, Jan 23, 2015 at 10:07:18AM -0800, Junio C Hamano wrote:

> >> diff --git a/fsck.c b/fsck.c
> >> index 15cb8bd..8f8c82f 100644
> >> --- a/fsck.c
> >> +++ b/fsck.c
> >> @@ -107,7 +107,7 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
> >>  {
> >>  	int severity;
> >>  
> >> -	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
> >> +	if (options->msg_severity && ((unsigned int) msg_id) < FSCK_MSG_MAX)
> >>  		severity = options->msg_severity[msg_id];
> >>  	else {
> >>  		severity = msg_id_info[msg_id].severity;
> >> -- snap --
> >> 
> >> What do you think? Michael, does this cause more Clang warnings,
> >> or would it resolve the issue?
> >
> > Hmm, yeah, that does not seem unreasonable, and is more localized.
> 
> Or we could force enum to be signed by defining FSCK_MSG_UNUSED to
> be -1 at the very beginning of enum definition, without changing
> anything else.  Then "msg_id < 0" would become a very valid
> protection against programming mistakes, no?

Yeah, I think that would work, too. It is a little unfortunate in the
sense that it actually makes things _worse_ from the perspective of the
type system. That is, in the current code if you assume that everyone
else has followed the type rules, then an fsck_msg_id you get definitely
is indexable into various arrays. But if you add in a sentinel value,
now you (in theory) have to check for the sentinel value everywhere.

I'm not sure if that matters in practice, though, if you are going to be
defensive against people misusing the enum system in the first place
(e.g., you are worried about them passing a random int and having it
produce a segfault, you have to do range checks either way).

But of all the options outlined, I think I'd much rather just see an
assert() for something that should never happen, rather than mixing it
into the logic.

In that vein, one thing that puzzles me is that the current code looks
like:

  if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
	  severity = options->msg_severity[msg_id];
  else {
	  severity = msg_id_info[msg_id].severity;
	  ...
  }

So if the severity override list given by "options" exists, _and_ if we
are in the enum range, then we use that. Otherwise, we dereference the
global list. But wouldn't an out-of-range condition have the exact same
problem dereferencing that global list?

IOW, should this really be:

  if (msg_id < 0 || msg_id >= FSCK_MSG_MAX)
	die("BUG: broken enum");

  if (options->msg_severity)
	severity = options->msg_severity[msg_id];
  else
	severity = msg_id_info[msg_id].severity;

? And then you can spell that first part as assert(), which I suspect
(but did not test) may shut up clang's warnings.

-Peff
