From: Jeff King <peff@peff.net>
Subject: Re: Editing the root commit
Date: Wed, 20 Jun 2012 15:29:38 -0400
Message-ID: <20120620192938.GC31520@sigill.intra.peff.net>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
 <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Webb <chris@arachsys.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:29:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQb3-00056O-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757677Ab2FTT3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 15:29:42 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39134
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253Ab2FTT3l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:29:41 -0400
Received: (qmail 27955 invoked by uid 107); 20 Jun 2012 19:29:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 15:29:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 15:29:38 -0400
Content-Disposition: inline
In-Reply-To: <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200336>

On Wed, Jun 20, 2012 at 11:25:32AM -0700, Junio C Hamano wrote:

> What if we do not say --onto here?  I am not asking what the current
> implementation does (we get an error message saying "I want 'onto'
> specified").  What _should_ this command mean to a na=C3=AFve user?
>=20
>     $ git rebase [-i] --root
>=20
> I think it should mean "replay all my history down to root".  The
> original root commit should become the new root commit in the
> rewritten history.

I think that is the only thing that makes sense. And it should be easy
with non-interactive rebase, because we always start with the root comm=
it,
and it always applies cleanly.

=46or interactive rebase, though, it's a little trickier. Earlier you
said:

> For the root commit in the history, you check it out on the detached
> HEAD.  Under "--interactive" if the insn sheet tells you to allow
> the user to "edit/amend/reword" it, give control back the user after
> you have detached HEAD at that commit.  The user experience should
> be identical to the case you are replaying on an existing commit
> after that point.

That makes sense if the first instruction involves picking that first
commit. But if the first commit is deleted (or reordered), then it is
not appropriate to detach to the root; we must detach to the first
picked commit, which we can only do after we see the final instruction
sheet.

Git-rebase tries to do the rewind before dropping to run_specific_rebas=
e.
However, I think we might be OK, as it seems that there is a special
exception for "interactive", and we drop to run_specific_rebase early i=
n
that case.

-Peff

PS I have no clue how multiple roots would do. Without --preserve merge=
s,
   I would except history to be flattened, and that should be OK (the r=
oot
   commit will become a non-root, just as it would if you were actually
   going --onto something else).  But I suspect --preserve-merges might=
 be
   tricky, as you might have to create several root commits during the
   course of processing the instruction sheet.
