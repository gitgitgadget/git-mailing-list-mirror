From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history?
Date: Fri, 19 Feb 2010 12:04:15 +1100
Message-ID: <2cfc40321002181704i73eb87demd03faaddf9bb108@mail.gmail.com>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com>
	 <20100218051129.GD10970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, apenwarr@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 02:04:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiHI5-0005AW-QX
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 02:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab0BSBEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 20:04:16 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38019 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab0BSBEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 20:04:16 -0500
Received: by pwj8 with SMTP id 8so1780806pwj.19
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 17:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=pUAfLdYXNamEbs1XSCPwPuUIE1oob3V6IhdYn78iyGM=;
        b=ww+4D1Nr2wsbCPgtjrXgrtaxbzRbfGDiDh+yWRISh5B5o/eXTUhWI+nhTD243anbjS
         5+AygpjbfBjgUGGzzj5SUu+4lXhMAXrZi/viYM/evUIMRorbPk3XOXFHg9sLAZF5iE9t
         FFX5MCn5GLxJp4Uh/8yEcFs6QSNTs4UcDsEBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jooCCyrPH/7MvlqXLMYhDTMM3Edb1tCIncd8PQ7jjB2e1j4aDddUoicW6e8O3ppz+b
         OTqVdEVha0CMqXSg1HyPBRCWB/QqB9qgaCVg9jKhzraKsZrqMoAc9bv6wvf3Gy7B+abV
         2QsBu6qFJIYDdkKsAKTViQaYMt+M3aHYUtJPc=
Received: by 10.114.49.7 with SMTP id w7mr7101271waw.34.1266541455516; Thu, 18 
	Feb 2010 17:04:15 -0800 (PST)
In-Reply-To: <20100218051129.GD10970@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140399>

Jeff,

The use case is extracting a patch series from a developer who has
been frequently pulling (and thus merging) with an upstream but has
not successfully delivered anything upstream.

I want to be able to unpick the upstream merge history and reconstruct
a reasonable faithful representation of the developer's edits in a
linear series of commits that can then be reviewed, edited, squashed,
re-ordered as necessary as part of integration activities. I also want
to handle the cases where a (bad) upstream rebase occurred or the
developer has (incorrectly) merged with history from a peer that has
also not been integrated upstream

This places a useful constraint on the DAG rewrite that I need to do -
I can restrict the rewrite to the reverse of linear traversal from the
developer's current head back to the first commit that has not been
integrated upstream.

Avery's script almost does what I need, except the rewritten diffs
corresponding to the merge commits introduces unnecessary noise (from
upstream deltas) in the series and potentially complicate eventual
merges of the linear history back into the upstream.

What I am doing at the moment is doing a piece-wise replacement of
each merge with an equivalent rebase  from the other branch of the
merge, starting with the oldest merge. While doing this, there arises
the possibility of a merge conflict between a commit made by the
developer and a commit on the other branch of the merge. For my
purposes, at the point of the pick where the conflict is detected, the
conflicted blob is resolved in favour of the developer's blob. This
technically introduces an error into the history since resolving the
conflict in this way is almost certainly not correct. However, it does
mean that all subsequent picks on that segment for that blob will
apply correctly. At the end of each the rewrite of each segment, the
conflicted blob is replaced with the result of the developer's
original merge so that the introduced error is then corrected with a
perfect correction (assuming the developer did a sane merge in the
first place). In effect, each conflict introduces two deltas into the
history - one to enable the subsequent picks to apply cleanly and one
to reapply the developer's original resolution of the conflict.

This approach has several consequences:

* the rewrite is completely automated
* by construction, the tree will be consistent with developer's tree
at the commit corresponding to each merge the developer did.
* there is one commit in the rewritten history for each commit in the
original history + two commits for each auto-resolved conflict (one
that introduces the error to and one that later corrects it using the
developer's merge)

It is true that the rewritten history does contain periods where the
intervening commits are not strictly consistent (periods between the
error introducing delta and its subsequent correction), but if this is
really important, these can be resolved with an interactive rebase as
required. On the otherhand, rewritten history will be fully consistent
at well-specified points - particularly at commits corresponding to
the original merge commits and on any segment that was not affected by
a merge conflict.

Regards,

jon seymour.

On 18/02/2010, at 16:11, Jef King <peff@peff.net> wrote:

> On Thu, Feb 18, 2010 at 01:35:07PM +1100, Jon Seymour wrote:
>
>> Does the git toolset currently support rewriting a restricted git DAG
>> as a linear history in a completely automated way?
>
> Not really. It's a hard problem in the general case. Consider a
> history
> like:
>
>    B
>   / \
>  A   D
>   \ /
>    C
>
> That is, two branches fork, each make a commit, and then merge. You
> want
> something like:
>
>  A--B--C'
>
> If there is a merge conflict when making D, then you know that B and C
> conflict. In this simple case, you can apply the same conflict
> resolution used in D to the creation of C' (in other words, you use
> the
> combined tree state given in D as the tree for C'). But what if C is a
> string of commits? Some of the conflict resolution in D will be
> applicable to some of the conflicts you will encounter when rebasing
> C,
> but you don't know which.
>
> One simple strategy would be to squash all side-branch development
> into
> a single commit. So you would turn:
>
>    B--C--D
>   /       \
>  A         H
>   \       /
>    E--F--G
>
> into
>
>  A--B--C--D--X
>
> where X has the same tree as H, but contains all of the commit
> messages
> of E, F, and G.
>
> You are of course losing quite a bit of information there, but you
> haven't really told us what your use case is, so I don't know whether
> that's unacceptable or not.
>
> -Peff
