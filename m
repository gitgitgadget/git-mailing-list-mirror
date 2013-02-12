From: Jeff King <peff@peff.net>
Subject: Re: Pushing a git repository to a new server
Date: Tue, 12 Feb 2013 15:42:10 -0500
Message-ID: <20130212204210.GA25330@sigill.intra.peff.net>
References: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com>
 <20130211075040.GJ5210@localhost.localdomain>
 <CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com>
 <20130211162714.GB16402@sigill.intra.peff.net>
 <511A2775.9050209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ethan Reesor <firelizzard@gmail.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 21:43:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Mgr-0008Fi-88
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979Ab3BLUmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:42:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45463 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755324Ab3BLUmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:42:13 -0500
Received: (qmail 5426 invoked by uid 107); 12 Feb 2013 20:43:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Feb 2013 15:43:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2013 15:42:10 -0500
Content-Disposition: inline
In-Reply-To: <511A2775.9050209@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216192>

On Tue, Feb 12, 2013 at 12:28:53PM +0100, Michael J Gruber wrote:

> I'm not sure providers like GitHub would fancy an interface which allows
> the programmatic creation of repos (giving a new meaning to "fork
> bomb"). But I bet you know better ;-)

You can already do that:

  http://developer.github.com/v3/repos/#create

We rate-limit API requests, and I imagine we might do something similar
with create-over-git. But that is exactly the kind of implementation
detail that can go into a custom create-repo script.

> An alternative would be to teach git (the client) about repo types and
> how to create them. After all, a repo URL "ssh://host/path" gives a
> clear indication that "ssh host git init path" will create a repo.

But that's the point of a microformat. It _doesn't_ always work, because
the server may not allow arbitrary commands, or may have special
requirements on top of the "init". You can make the microformat be "git
init path", and servers can intercept calls to "git init" and translate
them into custom magic. But I think the world is a little simpler if we
define a new service type (alongside git-upload-pack, git-receive-pack,
etc), and let clients request it. Then it's clear what the client is
trying to do, it's easy for servers to hook into it, we can request it
over http, etc. And it can be extended over time to take more fields
(like repo description, etc).

I'm really not suggesting anything drastic. The wrapper case for ssh
would be as simple as a 3-line shell script which calls "git init" under
the hood, but it provides one level of indirection that makes
replacing/hooking it much simpler for servers. So the parts that are in
stock git would not be much work (most of the work would be on _calling_
it, but that is the same for adding a call to "git init").

I think the main reason the idea hasn't gone anywhere is that nobody
really cares _that_ much. People just don't create repositories that
often. I feel like this is one of those topics that comes up once a
year, and then nothing happens on it, because people just make their
repo manually and then stop caring about it.

Just my two cents, of course. :)

-Peff
