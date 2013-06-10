From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Mon, 10 Jun 2013 18:06:27 -0400
Message-ID: <20130610220627.GB28345@sigill.intra.peff.net>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
 <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
 <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
 <20130609151235.GA22905@serenity.lan>
 <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
 <51B4BBB7.8060807@lyx.org>
 <20130610214504.GG13333@sigill.intra.peff.net>
 <CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 00:06:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmAEW-0003sf-Jr
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 00:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab3FJWGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 18:06:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:48652 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790Ab3FJWGc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 18:06:32 -0400
Received: (qmail 3210 invoked by uid 102); 10 Jun 2013 22:07:22 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 17:07:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 18:06:27 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227395>

On Mon, Jun 10, 2013 at 04:52:57PM -0500, Felipe Contreras wrote:

> On Mon, Jun 10, 2013 at 4:45 PM, Jeff King <peff@peff.net> wrote:
> 
> > That is what libgit.a _is_ now.  I do not mean to imply any additional
> > judgement on what it could be. But if the goal is to make libgit.a
> > "functions that programs outside git.git would want, and nothing else",
> > we may want to additionally split out a "libgit-internal.a" consisting
> > of code that is used by multiple externals in git, but which would not
> > be appropriate for clients to use.
> 
> That might make sense, but that still doesn't clarify what belongs in
> ./*.o, and what belongs in ./builtin/*.o. And right now that creates a
> mess where you have code shared between ./builtin/*.o that is defined
> in cache.h (overlay_tree_on_cache), and some in builtin.h
> (init_copy_notes_for_rewrite). And it's not clear what should be done
> when code in ./*.o needs to access functionality in ./builtin/*.o,
> specially if that code is only useful for git builtins, and nothing
> else.

My general impression of the goal of our current code organization is:

  1. builtin/*.c should each contain a single builtin command and its
     supporting static functions. Each file gets linked into git.o to
     make the "main" git executable.

  2. ./*.c is one of:

       a. Shared code usable by externals and builtins, which gets
          linked into libgit.a

       b. An external command itself, with its own main(). It gets
          linked against libgit.a.

  3. Functions in libgit.a should be defined in a header file specific
     to their module (e.g., refs.h). cache.h picks up the slack for
     things that are general, or too small to get their own header file,
     or otherwise don't group well.

I said it was a "goal", because I know that we do not follow that in
many places, so it is certainly easy to find counter-examples (and nor
do I think it cannot be changed; I am just trying to describe the
current rationale). Under that organization, there is no place for "code
that does not go into libgit.a, but is not a builtin command in itself".
There was never a need in the past, because libgit.a was a bit of a
dumping ground for linkable functions, and nobody cared that it had
everything and the kitchen sink.

If we want to start caring, then we probably need to create a separate
"kitchen sink"-like library, with the rule that things in libgit.a
cannot depend on it. In other words, a support library for Git's
commands, for the parts that are not appropriate to expose as part of a
library API.

-Peff
