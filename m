From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer
Date: Wed, 2 Dec 2009 09:45:42 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912020931560.5582@cone.home.martin.st>
References: <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>  <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>  <1254510286-23155-1-git-send-email-nmiell@gmail.com>  <25718488.post@talk.nabble.com>  <20091127234110.7b7e9993.rctay89@gmail.com>
  <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>  <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st>  <7vzl62zisy.fsf@alter.siamese.dyndns.org> <be6fef0d0912011832k12eaa093o73b057ddf4ab866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810048-2090417351-1259739950=:5582"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 08:46:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFjux-0004Sx-Gv
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 08:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZLBHqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 02:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZLBHqU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 02:46:20 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:49402 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbZLBHqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 02:46:19 -0500
Received: from [88.193.196.75] (88.193.196.75) by kirsi1.inet.fi (8.5.014)
        id 4B03EE3D0097C67C; Wed, 2 Dec 2009 09:45:50 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <be6fef0d0912011832k12eaa093o73b057ddf4ab866@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134314>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810048-2090417351-1259739950=:5582
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 2 Dec 2009, Tay Ray Chuan wrote:

> > What will this result in?  A failed request, then the user increases
> > http.postBuffer, and re-runs the entire command?  I am not suggesting the
> > code should do it differently (e.g.  retry with a larger buffer without
> > having the user to help it).  At least not yet.  That is why my first
> > question above was "what do we do?" and not "what should we do?".
> 
> I guess that by "we" you're referring to the "normal" users of git?
> 
> > I am primarily interested in _documenting_ the expected user experience in
> > the failure case, so that people can notice the message, run "git grep" to
> > find the above line and then run "git blame" to find the commit to read
> > its log message to understand what is going on.
> 
> Yes, the code will just fail. As you might suspect, the code won't
> attempt to mitigate the failure by doing anything, and would require
> intervention on the part of the user.
> 
> What the user could do to make this work:
> 
> 1. Turn off multi-pass authentication and just go with Basic.
> 
> 2. Allow for persistent curl sessions. In theory, we get a 401 the
> first time when we send a GET for info/refs; subsequently, curl knows
> what authentication to use, so the POST request *should* take place
> without the need for rewinding. In theory.

I'd actually put this as number 1 - if this error message pops up for some 
reason, the first thing would be to find out why reusing the previous curl 
sessions didn't work.

Other options are:

- Switch to a HTTP server that handles Expect: 100-continue properly
- Try pushing the data in smaller chunks, e.g. if populating a new repo 
from scratch, don't push the whole history in one single run, or populate 
through some other mechanism and just do the incremental pushs over HTTP.

And possibly: Update curl to a version post 7.19.7, which detects the 
Expect header set by git and tries to await a response from the server 
before proceeding. (The problem that would solve is if we start sending 
and manage to send the whole initial 1 MB buffer before the 401 reply from 
the server is received. But it doesn't solve the case if the server 
doesn't understand the Expect header at all.)

> 3. Increase http.postBuffer size in the config.

As Shawn pointed out, if the whole request would have to be buffered, the 
needed size may be prohibitively large, so I guess this isn't a good hint 
to include in the error message after all. But if the request is sensibly 
sized (e.g. on the order of tens of MBs), this may be a stopgap solution.


So, should we change the error message to something a bit more 
descriptive, and add this discussion into the commit message?

// Martin
---1463810048-2090417351-1259739950=:5582--
