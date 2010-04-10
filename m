From: Jeff King <peff@peff.net>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Sat, 10 Apr 2010 00:26:09 -0400
Message-ID: <20100410042609.GA24295@coredump.intra.peff.net>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 06:26:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0SHH-0002Ef-AE
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 06:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868Ab0DJE0e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 00:26:34 -0400
Received: from peff.net ([208.65.91.99]:51828 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841Ab0DJE0d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 00:26:33 -0400
Received: (qmail 14529 invoked by uid 107); 10 Apr 2010 04:26:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 00:26:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 00:26:09 -0400
Content-Disposition: inline
In-Reply-To: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144501>

On Fri, Apr 09, 2010 at 03:35:42PM -0400, Eugene Sajine wrote:

> In case of this situation
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0B =C2=A0next
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C =C2=A0topic
>=20
>=20
> $ git rebase --onto master topic
> First, rewinding head to replay your work on top of it...
> fatal: Not a range.
> Nothing to do.
>=20
> Which is OK.

I think this doesn't do quite what you thought. It's true there is
"nothing to do" as in "nothing to apply", but it _did_ in fact rewind
topic back to "master".

You seem to be thinking that

  git rebase --onto master topic

means "rebase everything from master to topic onto master". It doesn't.
That would be:

  git rebase master topic

or, if you are already on topic, just

  git rebase master

The "--onto" option takes an argument, which says "put the commits on
top of here, even though it was not the upstream base otherwise
specified". So what your command does is say "using the current branch
(which is topic), take everything built on top of topic (which is
nothing), and rebuild it on top of master".

So no, it's not a bug. Yes, it's a terrible interface. There is really
no reason IMHO for rebase to take a "which branch to operate on"
argument at all. It should just operate on HEAD, like merge does. If yo=
u
want to merge on a different branch, you "git checkout" that branch
first.

That would have made your error less likely, because you would have had
no reason to think you needed to say "topic" at all.

-Peff
