From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] reflog: make the 'show' subcommand really the
 default
Date: Tue, 20 Apr 2010 07:37:36 -0400
Message-ID: <20100420113736.GA22907@coredump.intra.peff.net>
References: <1271670750-30297-1-git-send-email-szeder@ira.uka.de>
 <7veiiblzn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 13:38:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4BmS-0007RX-On
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 13:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab0DTLiK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 07:38:10 -0400
Received: from peff.net ([208.65.91.99]:42709 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab0DTLiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 07:38:09 -0400
Received: (qmail 1025 invoked by uid 107); 20 Apr 2010 11:38:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Apr 2010 07:38:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Apr 2010 07:37:36 -0400
Content-Disposition: inline
In-Reply-To: <7veiiblzn9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145364>

On Mon, Apr 19, 2010 at 05:46:02PM -0700, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>=20
> > diff --git a/builtin/reflog.c b/builtin/reflog.c
> > index 64e45bd..d4d4409 100644
> > --- a/builtin/reflog.c
> > +++ b/builtin/reflog.c
> > @@ -712,6 +712,5 @@ int cmd_reflog(int argc, const char **argv, con=
st char *prefix)
> >  	if (!strcmp(argv[1], "delete"))
> >  		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
> > =20
> > -	/* Not a recognized reflog command..*/
> > -	usage(reflog_usage);
> > +	return cmd_log_reflog(argc, argv, prefix);
>=20
> I am not convinced that this is a good change.
>=20
> It may be that show/expire/delete happens to be the _only_ subcommand=
s
> today, but if we had this patch, the command will change the behaviou=
r
> when we add a new subcommand (the name of that subcommand may happen =
to be
> also a refname).

I don't think it is that big a deal. Scripts should always use the
explicit "git reflog show <ref>" form, which will remain safe. "git
reflog <ref>" is handy for humans.

That being said, we tried this same experiment with "git stash [show]
<msg>" and ended up rejecting it. However, the main complaint with that
was the failure mode for typos. Typing "git stash sohw" would make a ne=
w
stash. In this case, typing "git reflog exipre" would get you:

  fatal: ambiguous argument 'exipre': unknown revision or path not in
  the working tree.
  Use '--' to separate paths from revisions

and you would repeat the command with the typo fixed, which is perhaps
not as bad. And unlike stash, "show" is really the dominant command (I
don't think I have ever manually used 'delete' or 'expire'), so it is
more likely to be right than not.

The current behavior is also weirdly inconsistent:

  git reflog ;# works, shows HEAD
  git reflog -p ;# works, shows HEAD with -p
  git reflog -p foo ;# works, shows foo with -p
  git reflog foo ;# does not work

I can see allowing the first two, but the fact that the third works and
the fourth doesn't seems odd to me.

So I don't think the patch is a huge mistake (at least not as huge as
the stash one).  However, I personally "git log -g [--oneline]" to be
much easier to remember to use and to type.

-Peff
