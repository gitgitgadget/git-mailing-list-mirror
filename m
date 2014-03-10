From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 11:52:30 -0400
Message-ID: <20140310155230.GA29801@sigill.intra.peff.net>
References: <531D9B50.5030404@alum.mit.edu>
 <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:52:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN2VK-0003yD-6r
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 16:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbaCJPwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 11:52:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:36497 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753045AbaCJPwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 11:52:32 -0400
Received: (qmail 3795 invoked by uid 102); 10 Mar 2014 15:52:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 10:52:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 11:52:30 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243770>

On Mon, Mar 10, 2014 at 07:30:45AM -0700, Shawn Pearce wrote:

> > * Store references in a SQLite database, to get correct transaction
> >   handling.
> 
> No to SQLLite in git-core. Using it from JGit requires building
> SQLLite and a JNI wrapper, which makes JGit significantly less
> portable. I know SQLLite is pretty amazing, but implementing
> compatibility with it from JGit will be a big nightmare for us.

That seems like a poor reason not to implement a pluggable feature for
git-core. If we implement it, then a site using only git-core can take
advantage of it. Sites with JGit cannot, and would use a different
pluggable storage mechanism that's supported by both. But if we don't
implement, it hurts people using only git-core, and it does not help
sites using JGit at all.

That's assuming that attention spent on implementing the feature does
not take away from implementing some other parallel scheme that does the
same thing but does not use SQLite. I don't know what that would be
offhand; mapping the ref and reflog into a relational database is pretty
simple, and we get a lot of robustness and efficiency benefits for free.
We could perhaps have some kind of "relational" backend could use an
ODBC-like abstraction to point to a database. I have no idea if people
would want to ever store refs in a "real" server-backend RDBMS, but I
suspect Java has native support for such things.

Certainly I think we should aim for compatibility where we can, but if
there's not a compatible way to do something, I don't think the
limitations of one platform should drag other ones down. And that goes
both ways; we had to reimplement disk-compatible EWAH from scratch in C
for git-core to have bitmaps, whereas JGit just got to use a ready-made
library. I don't think that was a bad thing.  People in
mixed-implementation environments couldn't use it, but people with
JGit-only environments were free to take advantage of it.

At any rate, the repository needs to advertise "this is the ref storage
mechanism I use" in the config. We're going to need to bump
core.repositoryformatversion for such cases (because an old version of
git should not blindly lock and write to a refs/ directory that nobody
else is ever going to look at). And I'd suggest with that bump adding in
something like core.refstorage, so that an implementation can say
"foobar ref storage? Never heard of it" and barf. Whether it's because
that implementation doesn't support "foobar", because it's an old
version that doesn't understand "foobar" yet, or because it was simply
built without "foobar" support.

-Peff
