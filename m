From: Jeff King <peff@peff.net>
Subject: Re: [RFC/GSoC] Proposal Draft: Unifying git branch -l, git tag -l,
 and git for-each-ref
Date: Thu, 26 Mar 2015 12:37:49 -0400
Message-ID: <20150326163748.GF6564@peff.net>
References: <55101080.90805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:38:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbAn6-0001h5-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 17:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbbCZQhw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2015 12:37:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:38781 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752546AbbCZQhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 12:37:51 -0400
Received: (qmail 17282 invoked by uid 102); 26 Mar 2015 16:37:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Mar 2015 11:37:51 -0500
Received: (qmail 25054 invoked by uid 107); 26 Mar 2015 16:38:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Mar 2015 12:38:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2015 12:37:49 -0400
Content-Disposition: inline
In-Reply-To: <55101080.90805@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266336>

On Mon, Mar 23, 2015 at 06:39:20PM +0530, karthik nayak wrote:

> All three commands select a subset of the repository=E2=80=99s refs a=
nd print the
> result. There has been an attempt to unify these commands by Jeff Kin=
g[3]. I
> plan on continuing his work[4] and using his approach to tackle this
> project.

I would be cautious about the work in my for-each-ref-contains-wip
branch. At one point it was reasonably solid, but it's now a year and a
half old, and I've been rebasing it without paying _too_ much attention
to correctness. I think some subtle bugs have been introduced as it has
been carried forward.

Also, the very first patch (factoring out the contains traversal) is
probably better served by this series:

  http://thread.gmane.org/gmane.comp.version-control.git/252472

I don't remember all of the issues offhand that need to be addressed in
it, but there were plenty of review comments.

> For extended selection behaviour such as =E2=80=98--contains=E2=80=99=
 or =E2=80=98--merged=E2=80=99 we could
> implement these within
> the library by providing functions which closely mimic the current me=
thods
> used individually by =E2=80=98branch -l=E2=80=99 and =E2=80=98tag -l=E2=
=80=99. For eg to implement
> =E2=80=98--merged=E2=80=99 we implement a =E2=80=98compute_merge()=E2=
=80=99 function, which with the help of
> the revision API=E2=80=99s will be able to perform the same function =
as =E2=80=98branch -l
> --merged=E2=80=99.

One trick with making a library-like interface is that some of the
selection routines can work on a "streaming" list of refs (i.e., as we
see each ref we can say "yes" or "no") and some must wait until the end
(e.g., --merged does a single big merge traversal). It's probably not
the end of the world to just always collect all the refs, then filter
them, then sort them, then print them. It may delay the start of output
in some minor cases, but I doubt that's a big deal (and anyway, the
packed-refs code will load them all into an array anyway, so collecting
them in a second array is probably not a big deal).

> For formatting functionality provided by =E2=80=98for-each-ref=E2=80=99=
 we replicate the
> =E2=80=98show_ref=E2=80=99 function in =E2=80=98for-each-ref.c=E2=80=99=
 where the format is given to the
> function and the function uses the format to obtain atom values and p=
rints
> the corresponding atom values to the screen. This feature would allow=
 us to
> provide format functionality which could act as a base for the =E2=80=
=98-v=E2=80=99 option
> also.

Yeah, I'd really like to see "--format" for "git branch", and have "-v"
just feed that a hard-coded format string (or even a configurable one).

> Although Jeff has built a really good base to build upon, I shall use
> his work as more of a reference and work on unification of the three
> commands from scratch.

Good. :)

-Peff
