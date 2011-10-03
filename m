From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git checkout $tree path
Date: Mon, 3 Oct 2011 06:26:47 -0400
Message-ID: <20111003102647.GD16078@sigill.intra.peff.net>
References: <7vk48rq854.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 12:26:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAfjb-0000pY-FU
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 12:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab1JCK0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 06:26:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51543
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755037Ab1JCK0t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 06:26:49 -0400
Received: (qmail 27301 invoked by uid 107); 3 Oct 2011 10:31:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 06:31:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 06:26:47 -0400
Content-Disposition: inline
In-Reply-To: <7vk48rq854.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182649>

On Thu, Sep 29, 2011 at 03:46:31PM -0700, Junio C Hamano wrote:

> According to that definition, because "master" has dir/file1, and the
> index is unchanged since "next", we would add dir/file1 to the index, and
> then check dir/file1 and dir/file3 out of the index. Hence, we end up
> resurrecting dir/file3 out of the index, even though "master" does not
> have that path.
> 
> This is somewhat surprising.

Agreed, it is surprising.

> It may make sense to tweak the semantics a little bit. We can grab the
> paths out of the named tree ("master" in this case), update the index, and
> update the working tree with only with these paths we grabbed from the
> named tree. By doing so, we will keep the local modification to dir/file3
> (in this case, the modification is to "delete", but the above observation
> hold equally true if dir/file3 were modified).

Hmm. I can see that being what the user expects in some cases. For
example, when "master" has nothing to do with dir/file3 in the first
place. But I can also see this:

> An alternative semantics could be to first remove paths that match the
> given pathspec from the index, then update the index with paths taken from
> the named tree, and update the working tree. "git checkout master dir"
> would then mean "replace anything currently in dir with whatever is in dir
> in master". It is more dangerous, and it can easily emulated by doing:

being what the user expects. As in, "master deleted this file; shouldn't
checkout pull the deletion to my new branch when I ask it to?".

But we can't distinguish those two cases without actually having a merge
base. And this isn't a merge; it's not about picking changes from
master, it's about saying "make dir look like it does in master". So
in that sense, the most straightforward thing is your second
alternative: afterwards, we should have only the files in "dir" that
master has.

A related question is what does this do:

  git reset master -- dir

My mental model is that it makes the index for "dir" look just like
master:dir. And that seems pretty accurate; it deletes dir/file3 (which
does not exist in "master") from the index.

My mental model of "git checkout master -- dir" is similar. It should
make the index for "dir" look like master:dir, and then check that out.
IOW, I think of it as:

  git reset master -- dir &&
  git checkout -- dir

Maybe that is not accurate (well, clearly it does not match the current
behavior), but I think it is at least easy to explain and relatively
sane. So it is something to shoot for, and makes "git checkout"
consistent with "git reset".

>  * This is a behaviour change, but it may qualify as a bugfix. I dunno.

I think it is a bug. I can see both of the alternatives you outlined
above making some sense, but checking out content that has _nothing_ to
do with master is just confusing. Either make it look like master, or
leave it alone.

-Peff
