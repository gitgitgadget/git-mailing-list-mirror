From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 11:44:03 -0400
Message-ID: <20120720154403.GB2862@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <50092993.6010203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:44:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFNE-0001tF-SE
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab2GTPoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:44:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56551 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab2GTPoG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:44:06 -0400
Received: (qmail 11748 invoked by uid 107); 20 Jul 2012 15:44:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Jul 2012 11:44:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2012 11:44:03 -0400
Content-Disposition: inline
In-Reply-To: <50092993.6010203@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201776>

On Fri, Jul 20, 2012 at 11:49:07AM +0200, Michael Haggerty wrote:

> >This patch moves reflog entries into a special "graveyard"
> >namespace, and appends a tilde (~) character, which is
> >not allowed in a valid ref name. This means that the deleted
> >reflogs of these refs:
> >
> >    refs/heads/a
> >    refs/heads/a/b
> >    refs/heads/a/b/c
> >
> >will be stored in:
> >
> >    logs/graveyard/refs/heads/a~
> >    logs/graveyard/refs/heads/a/b~
> >    logs/graveyard/refs/heads/a/b/c~
> >
> >Putting them in the graveyard namespace ensures they will
> >not conflict with live refs, and the tilde prevents D/F
> >conflicts within the graveyard namespace.
> 
> I agree with Junio that long-term, it would be nice to allow
> references "foo" and "foo/bar" to exist simultaneously.  To get
> there, we would have to redesign the mapping between reference names
> and the filenames used for the references and for the reflogs.

Yes, I would really like that, as it could make the alternate namespace
go away, which is the source of about half the code in my patches (i.e.,
we would only need to loosen the reflog reading code to handle reflogs
that do not have a matching ref).

But I fear that the fallouts from that will be much, much larger. Even
with just this change, older versions of git will be slightly unhappy
(e.g., you will get some extra warnings during fsck and reflog
expiration about these reflogs). But changing the on-disk representation
of the refs namespace will mean a totally new representation of locking.
That's going to break old versions of git completely, and possibly even
some user scripts.

> The easiest thing would be to mark files and directories differently;
> something like
> 
>     $GIT_DIR/{,logs/}refs/heads/a/b/c~
> [...]
> The first convention, "logs/refs/heads/a/b/c~" is not usable because
> a reflog for a dead reference with this name would conflict with a
> reflog for a live reference "heads/a" or "heads/a/b" that uses the
> current filename convention.

Right. That's what I started with, then created the graveyard hierarchy
to avoid conflicts between the "old" namespace (that cannot handle D/F
conflicts) and the "new" one (that can, because it represents files and
directories differently).

> or
> 
>     $GIT_DIR/{,logs/}refs/heads~/a~/b~/c
> 
> i.e., munging either directory or file names to strings that are
> illegal in refnames such that it is unambiguous from the name whether
> a path is a file or directory.

This one can have conflicts in the opposite direction if you don't have
any directories. E.g., you have $GIT_DIR/foo, a deleted ref, which has
no tildes because it has no directories in the path. But you want to
create foo/bar under the "old" system, which cannot happen (under the
new system, it is fine, but the point of this exercise is to overlay the
old and new systems).

That may be an OK tradeoff. We are restrictive in what goes into the
top-level. Although I notice that you did not mark "refs" in the above
example. So you could have the same problem with "refs/stash", for
example. Again, though, we don't tend to have arbitrary data at the
top-level (and I think refs/stash gets special cased in a couple places
already). So it might be an acceptable limitation.

If we want to be pedantic, my patch causes conflicts for top-level refs
called "graveyard" (although I know we have talked about restricting
top-level refs to [A-Z_-], I don't recall if that has actually
happened).

> And *if* we did that, then we wouldn't need a separate "graveyard"
> namespace, would we?  The reflogs for dead references could live
> among those for living references.

Right, assuming the limitation above is OK. But note that it doesn't
really save us any code. We still have to convert between refnames and
graveyard versions. _Eventually_ if the refnames were all converted,
that code could go away.

> But the second convention, "logs/refs/heads~/a~/b~/c, cannot conflict
> with current reflog files.  And it would be a step towards allowing
> "foo" and "foo/bar" at the same time.  What do you think about using
> a convention like this instead of the one that you proposed?

I think it's reasonable. As I said, it doesn't save any code _now_, but since
I am pulling a convention out of thin air, it might as well be one that
has a possibility of converging in the future (all other things being
equal, of course; I do find marking the directories a little uglier to
read, but that is mostly because of the tilde).

> Another minor concern is the choice of trailing tilde in the file or
> directory names.  Given that emacs creates backup files by appending
> a tilde to the filename, (1) it would be easy to inadvertently create
> such files, which git might try to interpret as reflogs and (2) there
> might be tools that innately "know" to skip such files in their
> processing. ack-grep, a replacement for grep, is an example that
> springs to mind.

The use of "~" for backup files was actually something that made me
choose it, since these are, after all, backups of the reflog. But they
are probably more precious than editor backup files, so the special
treatment they're given by other programs is probably not desirable.

> Other possibilities (according to git-check-ref-format(1)):
> 
>     refs/.heads/.a/.b/c
>     refs/heads./a./b./c (problematic on some Windows filesystems?)
>     refs/heads../a../b../c
>     refs/heads~dir/a~dir/b~dir/c (or some other suffix)
>     refs/heads..a..b..c (not recommended because it flattens
> directory hierarchy)

I don't like leading-dot, because those files are also often skipped by
directory traversal of some programs (and certainly they are confusing
to work with if you try to use "ls" to debug your $GIT_DIR/logs
directory). Trailing dot is less ugly to me, but I do wonder about its
special meaning as an extension separator. Double-dots just look gross.

Note that we have a few other magic characters available, too. Colon is
probably the least offensive (metacharacters like *, ?, and [ just make
things unnecessarily painful for shell users).

So I think a suffix like ":d" is probably the least horrible.

-Peff
