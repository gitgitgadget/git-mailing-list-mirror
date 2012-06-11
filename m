From: Jeff King <peff@peff.net>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 14:55:07 -0400
Message-ID: <20120611185507.GF20134@sigill.intra.peff.net>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
 <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr>
 <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: konglu@minatec.inpg.fr,
	=?utf-8?B?Q2zDoXVkaW8gTG91cmVuw6dv?= <pt.smooke@gmail.com>,
	git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9lk-0004OY-Ss
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab2FKSzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 14:55:12 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50258
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab2FKSzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:55:10 -0400
Received: (qmail 7502 invoked by uid 107); 11 Jun 2012 18:55:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 14:55:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 14:55:07 -0400
Content-Disposition: inline
In-Reply-To: <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199697>

On Mon, Jun 11, 2012 at 02:34:01PM -0400, Leila wrote:

> When you create a branch, it will contain everything committed on the
> branch you created it from at that given point. So if you commit more
> things on the master branch like you have done (after creating b),
> then switch to branch b, they won't appear. This is the correct
> behavior. Does that answer your question?

No, the problem is more subtle:

> >> smooke =C2=A0teste $ git rm something
> >> rm 'something'
> >> smooke =C2=A0teste $ mkdir something
> >> smooke =C2=A0teste $ cd something/
> >> smooke =C2=A0something $ touch f1
> >> smooke =C2=A0something $ echo c > f1
> >> smooke =C2=A0something $ cd ..
> >> smooke =C2=A0teste $ git add something/f1
> >> smooke =C2=A0teste $ git checkout b
> >> Switched to branch 'b'
> >> smooke =C2=A0teste $ ls
> >> f

We have lost "something/f1" during the switch, which was not committed
anywhere. This is presumably an error because we see that "something"
used to be tracked, and now we are tracking something different there.

If we had put some new content into the file "something", git would
rightfully complain with:

  $ git checkout b
  error: Your local changes to the following files would be overwritten
  by checkout:
          something
  Please, commit your changes or stash them before you can switch branc=
hes.
  Aborting

But it misses the case when "something" switches from a file into a
directory, which is probably a bug.

-Peff
