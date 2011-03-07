From: Jeff King <peff@peff.net>
Subject: Re: Q about the date format in "git commit --date=..." and such
Date: Mon, 7 Mar 2011 11:54:48 -0500
Message-ID: <20110307165448.GD11934@sigill.intra.peff.net>
References: <4D73B158.5040409@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 07 17:55:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwdhy-0004tk-Fi
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 17:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab1CGQyx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 11:54:53 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56198 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab1CGQyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 11:54:53 -0500
Received: (qmail 5918 invoked by uid 111); 7 Mar 2011 16:54:51 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 16:54:51 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 11:54:48 -0500
Content-Disposition: inline
In-Reply-To: <4D73B158.5040409@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168596>

On Sun, Mar 06, 2011 at 05:07:52PM +0100, Dirk S=C3=BCsserott wrote:

> I frequently change a file in my repo and commit it with
> "git commit -a -C deadbeef", i.e. using an older commit message. The
> "-C" switch also re-uses the author timestamp of the given SHA1, whic=
h
> is not what I want. So I tried the "--date=3D..." switch in addition,
> which works fine.

I also do something like this; I have a repository which gets a weekly
update, and I tend to reuse last week's commit message as a template
with "git commit -c HEAD --reset-author".

Note that it will _also_ reset the author to you if you were not the
original author. But that is probably what you want if you are resettin=
g
the timestamp; it is semantically "take ownership of this commit".

> Instead of giving an exact timestamp (like "--date=3D'06.03.2011 16:5=
0'")
> I'd prefer to just say "--date=3Dnow". Is that somehow possible? If n=
ot:
> would the community appreciate it, if I would try to implement this?

I mentioned --reset-author above, which I think solves your problem. As
far as --date=3Dnow goes, it doesn't sound like a terrible idea. But th=
ere
is some question of how far we should take it. We basically have two
date-parsing interfaces: parse_date and approxidate.

The former is reasonably strict and accepts what you showed above. We
use it for "commit --date=3D" as well as parsing $GIT_AUTHOR_DATE.

Approxidate, on the other hand, will try to turn any nonsense into a
date. So you can say "3 weeks ago" or "tea.time.on.january.1.2011", or
even "bogus" (the last of which turns into "now"). So it's flexible, bu=
t
it may not do what you want. We use this for "log --since",
"branch@{date}", and other places.

I think the original rationale was that it's OK for us to allow some
sloppiness when _viewing_ commits, since you will generally notice the
problem. But when making commits, it's better to be careful, since you
may be setting the sha1 in stone.

These days we have two tools that could help:

  1. approxidate_careful will do a regular approxidate, but keep track
     of whether we found anything even remotely useful. That doesn't
     mean you can't still get unexpected results, but at least some
     truly useless cases return errors.

  2. For commits with a different author and committer, we mention the
     author name in the post-commit summary. We could do the same with =
a
     timestamp that was given (i.e., mentioning it in a standard format=
)
     to give the user another opportunity to double-check what we
     parsed.

That being said, with --reset-author I have never needed --date, so I
don't personally care if it gets done or not.

-Peff
