From: Jeff King <peff@peff.net>
Subject: Re: =?utf-8?Q?Schr=C3=B6dinger's?= diff
Date: Tue, 7 Jul 2009 16:48:06 -0400
Message-ID: <20090707204806.GA1278@coredump.intra.peff.net>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
 <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
 <20090707193605.GA30945@coredump.intra.peff.net>
 <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
 <279b37b20907071330y732fad4dxe4e21edeab9ff179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:48:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOHaN-0006qv-3z
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 22:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbZGGUsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 16:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756658AbZGGUsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 16:48:09 -0400
Received: from peff.net ([208.65.91.99]:54921 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755611AbZGGUsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 16:48:08 -0400
Received: (qmail 6279 invoked by uid 107); 7 Jul 2009 20:50:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Jul 2009 16:50:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2009 16:48:06 -0400
Content-Disposition: inline
In-Reply-To: <279b37b20907071330y732fad4dxe4e21edeab9ff179@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122875>

On Tue, Jul 07, 2009 at 01:30:47PM -0700, Eric Raible wrote:

> > I personally do not think it is worth it. =C2=A0If you change the c=
rlf,
> > clean/smudge, or anything of that sort, just doing a "rm .git/index=
"
> > followed by "git reset --hard" would restore sanity to your work tr=
ee, no?
>=20
> Is there any technical reason why "git reset --hard" shouldn't repopu=
late
> the index by doing a "git read-tree" or equivalent [1]?  After all th=
e
> docs claim it
> "Matches the working tree and index to that of the tree being switche=
d to".

Yes; relying on the stat cache is what makes "git reset --hard" really
fast, instead of having to re-hash each file. The real problem is that
we are invalidating the contents of that cache, but not marking the
entry as dirty.

Right now we don't mark the entries, and you get stale data until you
manually mark them as dirty. But marking them dirty on every reset will
mean that reset can't make use of the cache, which is slow. So ideally
we would have a way of marking them dirty only when necessary. One way
would be a "git reset --hard --reset-me-harder", but that obviously
still involves manual work; you're just making the command a little
easier to find and use.

As I suggested before, you could include the changed bits (i.e., the
attributes and config) as part of the cache validity information.  But =
I
suspect it would be hard to implement, as it involves new fields in the
index. It also involves arbitrary user commands, so getting it 100%
right would be impossible (e.g., we can record the string
"my-clean-filter" as the filter name, but we can't know when that
filter's behavior has changed); however, in practice, I think we can
assume that a string containing a text command will have stable output.

-Peff
