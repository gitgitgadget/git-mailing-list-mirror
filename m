From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-config: git-config --list fixed when GIT_CONFIG
 value starts with ~/
Date: Fri, 14 Nov 2014 14:30:49 -0500
Message-ID: <20141114193049.GB10860@peff.net>
References: <1415989760-20259-1-git-send-email-kuleshovmail@gmail.com>
 <CAPig+cTpUyfKYj4VTK1AT-ga6UvupJrERsTHWTEzNP-Ogc4ujQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 0xAX <kuleshovmail@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Alex Kuleshov <kuleshovmail@gmial.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:30:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpMa7-0002MM-JI
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 20:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbaKNTaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 14:30:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:40437 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965580AbaKNTav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 14:30:51 -0500
Received: (qmail 12408 invoked by uid 102); 14 Nov 2014 19:30:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 13:30:51 -0600
Received: (qmail 15730 invoked by uid 107); 14 Nov 2014 19:31:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 14:31:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2014 14:30:49 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTpUyfKYj4VTK1AT-ga6UvupJrERsTHWTEzNP-Ogc4ujQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 02:19:41PM -0500, Eric Sunshine wrote:

> On Fri, Nov 14, 2014 at 1:29 PM, 0xAX <kuleshovmail@gmail.com> wrote:
> > When we execute git config --list and $GIT_CONFIG value starts with home
> > prefix - ~/ it produces folowing error - fatal: unable to read config
> > file '~/.gitconfig': No such file or directory. This patch fixed it with
> > expand_user_path for configuration file path before git-config --list
> > call.
> 
> Is this special case really warranted? Elsewhere, GIT_CONFIG does not
> get this sort of special treatment. Moreover, it appears that no other
> GIT_* environment variable is subject to such special treatment. (And,
> generally speaking, on Unix, it is generally assumed that a path
> assigned to an environment variable is to be used as-is.)

Yeah, I'd agree it is a little unexpected to expand here. The "~" is
mostly a shell thing, and doing:

  GIT_CONFIG=~/.gitconfig git config --list

from the shell generally works, because the shell will expand the "~"
before it even hits git. If you're not using a shell to set the
variable, you probably should be pre-expanding it yourself.

Note that this code path affects "git config --file=~/.gitconfig", too.
At least there it would be a little bit useful because the shell will
not expand for you, but it still feels a bit unconventional to me.

> >  builtin/config.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/builtin/config.c b/builtin/config.c
> > index 7bba516..df1bee0 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -540,6 +540,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >
> >         if (actions == ACTION_LIST) {
> >                 check_argc(argc, 0, 0);
> > +               const char* newpath = expand_user_path(given_config_source.file);
> > +               given_config_source.file = newpath;

If we _were_ going to do such an expansion, this is absolutely the wrong
place for it. It works only for the "--list" action; if we are going to
expand it, we would want to do so everywhere. And we do not even know if
given_config_source.file is non-NULL here (we could be reading from
stdin, or a blob). Fortunately expand_user_path will pass through a NULL
without segfaulting.

Probably the right place would be the if/else chain around
builtin/config.c:514, where we convert a relative path into an absolute
one. But I'm not convinced it's a good thing to be doing in the first
place.

-Peff
