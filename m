From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 17:45:04 -0400
Message-ID: <20130610214504.GG13333@sigill.intra.peff.net>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
 <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
 <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
 <20130609151235.GA22905@serenity.lan>
 <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
 <51B4BBB7.8060807@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:45:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9tr-0006h3-Rt
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab3FJVpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:45:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:48489 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907Ab3FJVpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:45:08 -0400
Received: (qmail 2034 invoked by uid 102); 10 Jun 2013 21:45:59 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 16:45:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 17:45:04 -0400
Content-Disposition: inline
In-Reply-To: <51B4BBB7.8060807@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227389>

On Sun, Jun 09, 2013 at 07:30:31PM +0200, Vincent van Ravesteijn wrote:

> I think that libgit.a should contain all code to be able to carry out
> all functions of git. The stuff in builtin/ is just a command-line
> user interface. Whether or not sequencer should be in builtin depends
> on whether the sequencer is only part of this command-line user
> interface.

One code organization issue I have not seen mentioned is that there is
more CLI than what is in builtin, and libgit.a does more than simply
provide code for the sources in builtin/. There are also external
commands shipped in git.git that are not linked against git.c or the
other builtins.

Once upon a time, all commands were that way, and that was the origin of
libgit.a: the set of common code used by all of the C commands in
git.git. Over time, those commands became builtins (mostly to keep the
size of the libexec dir down). These days there are only a handful of
external commands left, mostly ones that have startup time overhead from
the dynamic loader (e.g., remote-curl, http-push, imap-send).

That is what libgit.a _is_ now.  I do not mean to imply any additional
judgement on what it could be. But if the goal is to make libgit.a
"functions that programs outside git.git would want, and nothing else",
we may want to additionally split out a "libgit-internal.a" consisting
of code that is used by multiple externals in git, but which would not
be appropriate for clients to use.

For example, I think most of "http.c" is in that boat, as it is full of
wrappers for curl code that are of enough quality to reuse within git,
but a little too half-baked to be part of a stable API.

We can always link directly against http.o, too, of course. The point of
putting the files into a static library is that it makes the link
faster, and if there are only a handful of such links, it may not be
worth the effort.

-Peff
