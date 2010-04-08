From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Thu, 8 Apr 2010 02:34:22 -0400
Message-ID: <20100408063422.GD30473@coredump.intra.peff.net>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
 <20100408044552.GA30473@coredump.intra.peff.net>
 <l2xbe6fef0d1004072307ma8dff5c2ic5dce170b28e5957@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:35:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlKY-0003rK-Cu
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242Ab0DHGex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 02:34:53 -0400
Received: from peff.net ([208.65.91.99]:46225 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756382Ab0DHGem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:34:42 -0400
Received: (qmail 16738 invoked by uid 107); 8 Apr 2010 06:34:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 02:34:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 02:34:22 -0400
Content-Disposition: inline
In-Reply-To: <l2xbe6fef0d1004072307ma8dff5c2ic5dce170b28e5957@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144326>

On Thu, Apr 08, 2010 at 02:07:11PM +0800, Tay Ray Chuan wrote:

> > I don't really see a problem with this. The current behavior produc=
es an
> > error, so it is not as if we are breaking somebody's workflow, and =
the
> > only sensible default is the same one used by the other commands.
>=20
> I'm trying to make it behave like the other commands that deal with
> remotes, such as git-fetch and git-push; when they are run without an=
y
> arguments, they default to "origin" or branch.<name>.remote.
>=20
> Assuming that you and I are talking about the same "other commands",
> than the default isn't an issue; the rules used to determine the
> default remote is done in remote_get(), so they are similar.

The commands I meant were push, fetch, and pull. I couldn't think of an=
y
others.

> >> + =C2=A0 =C2=A0 if (!remote)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Where do you want=
 to list from today?");
> >
> > Heh.
>=20
> Do you think this is too light-hearted for ls-remote's role? If so,
> I'll just revert back exiting with the usage text.

Perhaps. In general that is not a helpful message to show to the user,
but it is very unlikely to be shown at all. You would have to have no
configured remote for your current branch, _and_ you would have had to
delete the config for the "origin" remote.

=46etch's message is equally hard to trigger, I think, which is perhaps
why nobody has complained about it yet.

> > This seems like a very odd thing to be testing. Should you not inst=
ead
> > test that "git ls-remote $foo" still treats $foo as a remote and li=
sts
> > it, which is what we really care about?
>=20
> There are already existing tests to test "git ls-remote $foo" (unless
> you mean '$' to have a special significance, like '*' does).

No, I meant $foo as a variable, as you interpreted.

> The test was to let current and future git hackers/users know that th=
e
> usage of <pattern> as the remote by git-ls-remote ("<pattern> does no=
t
> appear to be a git repository") is indeed expected behaviour.

I think documenting that in the commit message would be fine, but I
don't have a strong opinion. It seems like the existing "git ls-remote
$foo" tests would cover this by correctly interpreting $foo as a remote=
=2E

If you do keep it, it also should use test_must_fail.

Also, I note that you are testing for:

  fatal: 'refs*master' does not appear to be a git repository
  fatal: The remote end hung up unexpectedly

which is coming from two separate processes, which means the output may
have a race condition. I suspect we're OK because the second message is
triggered by closing the fd which must happen after the first message i=
s
printed.

-Peff
