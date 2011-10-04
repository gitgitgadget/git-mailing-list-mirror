From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's
 keychain
Date: Tue, 4 Oct 2011 13:48:40 -0400
Message-ID: <20111004174840.GA31558@sigill.intra.peff.net>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
 <20110929075627.GB14022@sigill.intra.peff.net>
 <CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
 <20110930221111.GB9384@sigill.intra.peff.net>
 <CAG+J_Dww1yOeq1LHQYMiObPKqrWbk4t8Hn=G9WpYWXFBbHiuhQ@mail.gmail.com>
 <20111003105908.GF16078@sigill.intra.peff.net>
 <CAG+J_DxAaw=vVENFUP5Mq9+inuDEpn_3Le_b7sO97wRUW6aFSA@mail.gmail.com>
 <20111004101610.GA11236@sigill.intra.peff.net>
 <7v39f8d6iq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 19:48:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB96m-0008Ce-D5
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 19:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036Ab1JDRso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 13:48:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52253
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab1JDRsn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 13:48:43 -0400
Received: (qmail 10064 invoked by uid 107); 4 Oct 2011 17:53:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 13:53:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 13:48:40 -0400
Content-Disposition: inline
In-Reply-To: <7v39f8d6iq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182780>

On Tue, Oct 04, 2011 at 10:13:33AM -0700, Junio C Hamano wrote:

> Now, I would like to start moving the core part of the credential helper
> series to 'master'. Could people summarize what the current status of
> various moving parts are?
> 
> Here is an example of write-up, based on my understanding (I said it
> should be pretty-much ready, but please correct me if I am mistaken).
> 
>  - The core part have seen some updates while it was cooking in 'next',
>    with help from inputs by credential plug-in authors. The API and the
>    sample implementation should be stable enough that it can be given to
>    people who follow 'master' perhaps with 'experimental, minor details
>    still subject to change' label attached.

No, sadly I don't think we're there yet. The two big open questions are:

  1. Should we be giving more context details to the helpers, and/or
     should we be breaking down the information into pieces?

     I think the answer is probably yes. Certainly OS X would benefit
     from the broken-down pieces. My feeling is that we could hand
     helpers both broken-down pieces as well as an inclusive URL. So
     something like:

       git credential-foo \
         --type=network --protocol=https --host=example.com \
         --username=user1 --path=repo.git \
         --url=https://user1@example.com/repo.git

     and then the helper can pick what it likes from there.

     One thing I haven't figured out is how the user would tell git "no,
     the repo path is not relevant for determining the auth domain".
     That feature can come later, but I want to make sure that helpers
     know they might or might not get the "--path" option. I guess that
     is just a matter of documentation; I'm just a little nervous
     committing to it without having figured out the details.

  2. There has been some talk that the helper interface should perhaps
     be vastly simplified from "get the credentials and give them to
     git" to merely being a store/retrieve system, where the invocations
     would be something like (pretend git is the shell):

       # git asks if we have a stored credential
       git credential-foo --get --url=...,etc | read password

       # we had a successful authentication; ask the helper to store it;
       echo password | git credential-foo --put --url=...,etc

     That makes the helpers much simpler, and makes interacting with the
     user more uniform across helpers.

     It disallows helpers doing specialized interactions or dialogs. I'm
     not sure how much we want that. I thought some systems might find
     that more natural, but that's debatable. Jay implemented a git-like
     pure-terminal prompt in his helper. Lukas used the kde
     password-dialog for the KDE helper. I'm not sure what people really want.

I can produce patches for both if we want to see what they would look
like. But I kind of think it's not a matter of "what will the code look
like" (both of them are pretty straightforward to implement), but "what
do we want the interface to look like". And that is really as much up to
me as to people who are going to write and use the helpers.

-Peff
