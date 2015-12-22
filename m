From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 08:11:30 -0800
Message-ID: <CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
 <56796F37.1000600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 22 17:11:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBPXX-0002pR-SI
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 17:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbbLVQLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 11:11:52 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34340 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbbLVQLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 11:11:51 -0500
Received: by mail-vk0-f42.google.com with SMTP id j66so120167948vkg.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 08:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NBd52cPWRO3AR6tgl/0W5PPrPIeidinwmJtULOruJy4=;
        b=EIzlTxI1WqcLRVSwJ+g17Fly4zoSchm+gXCu7Vls0BvP7XncNGT2RRhE3AtlRdgSPZ
         C1QXDAmdulgA4UCKWmFqJ4TD5bqJ2WnhGYrVJqFmdGkphpjw7iS+E2Z6RXo4tNn5npw3
         mvaPqMpntTEOXMdgHuDhXrG1f/o55a1GBvYJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NBd52cPWRO3AR6tgl/0W5PPrPIeidinwmJtULOruJy4=;
        b=MdhcM0DAXIT27Zeid6Q9YOPQMiTdSVxl1tDTSpfPnuud6lpc2sqBjAyYMBPDxRaW/Y
         /PrzsmG5vEEOdQsIkLXb9HZU1XDft9DnrJRT8cslL2fz8qTjr8Qs/Wg5XUKP8vX9/CAx
         aS+W1Uj/rilaqBV7k7x9zwKY8zKs7Ee387KGb6P+Nw2jKS0uqAqL3vaha1bn8+KqjmLM
         lLIEMhq1+zfHAZt5/gI+9YGsA3Qs/HChqPefloWiDb5661ptvjs6bG5XPOVjQI6i0uRj
         PldjQyYTv3GkcY1QPs2yh0sCrjjyIbLR0XCLjlTa1QDPoT1ypEUJsPqRlAPh1tQ2ICKd
         FL6A==
X-Gm-Message-State: ALoCoQnMp64u7XgFldTt2jr6woHssF+W6VJss6/c4SEn0NWoKI03RX3Anc/5VTf0WnYjQS1chbJMLq+gA8GIN86eCtfL0BG+MA==
X-Received: by 10.31.47.204 with SMTP id v195mr16914422vkv.119.1450800710217;
 Tue, 22 Dec 2015 08:11:50 -0800 (PST)
Received: by 10.103.97.197 with HTTP; Tue, 22 Dec 2015 08:11:30 -0800 (PST)
In-Reply-To: <56796F37.1000600@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282883>

On Tue, Dec 22, 2015 at 7:41 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/17/2015 10:02 PM, Shawn Pearce wrote:
>> I started playing around with the idea of storing references directly
>> in Git. Exploiting the GITLINK tree entry, we can associate a name to
>> any SHA-1.
>>
>> By storing all references in a single tree, atomic transactions are
>> possible. Its a simple compare-and-swap of a single 40 byte SHA-1.
>> This of course leads to a bootstrapping problem, where do we store the
>> 40 byte SHA-1? For this example its just $GIT_DIR/refs/txn/committed
>> as a classical loose reference.
>
> I like this general idea a lot, even while recognizing some practical
> problems that other people have pointed out. I especially like the idea
> of having truly atomic multi-reference updates.
>
> I'm curious why you decided to store all of the references in a single
> list, similar to the packed-refs file. This design means that the whole
> object has to be rewritten whenever any reference is updated [1].
> Certainly, storing the references in a single tree *object* is not a
> requirement for having atomic transitions.
>
> I would have expected a design where the layout of the references in
> trees mimics the layout of loose references in the filesystem; e.g., one
> tree object for "refs/", one for "refs/heads/" one for "refs/remotes/"
> etc. This design would reduce the amount of rewriting that is needed
> when one or a few references are updated.

I did use tree objects for each directory component. The ls-tree I
showed was an ls-tree -r.

"heads" is a different subtree from "tags". I just skipped over the
"refs/" top level subtree because its useless here. The root tree
would always have one child, "refs", which normally has two children,
"heads" and "tags". Why bother with the root at that point?

So we do get minimum rewriting, tags tree is unmodified and reuses its
tree node when you update master.

> Another reason that I find a hierarchical layout intriguing would be
> that one could imagine using the SHA-1s of reference namespace subtrees
> to speed up the negotiation phase of "git fetch". In the common case
> that I use the local namespace "refs/remotes/origin" to track an
> upstream repo, the SHA-1 of my "refs/remotes/origin" tree would usually
> represent a complete description of the state of the upstream references
> at the time that I last fetched. My client could tell the server
>
>     have-tree $SHA1
>
> , where $SHA1 is the hash of the tree representing
> "refs/remotes/origin/". If the server keeps a reflog as you have
> described (but hierarchically), then the server could look up $SHA1 and
> immediately know the full set of references, and therefore of objects,
> that I fetched last time. More generally, the negotiation could proceed
> down the reference namespace tree and stop whenever commonality is found.

Yes. Martin Fick and I were discussing a strategy like this at the
Gerrit User Summit in November. I totally forgot about it when I
started this thread, but I'm glad you independently proposed it. Maybe
its not a horrible idea!  :)

One problem is clients don't mirror the heads tree exactly; they add
in HEAD as a symbolic reference in a way that the remote peer doesn't
have. Minor detail.


Martin and I were really thinking about server-server negotiation more
than client-server. Consider a master Git server that Linus pushes
too, and then a small farm of mirror servers that users actually clone
from. If an update hook on the master does a git push to each mirror,
the ls-remote advertisements is a non-trivial amount of data to
exchange. If the mirror servers are supposed to exactly match the
master, they can exchange all of their refs with a single SHA-1
instead of a big listing.

This isn't so important for Linus' repository; its got a relatively
small number of refs. We were thinking more about Gerrit Code Review
where the refs/changes/ namespace is huge and may be causing a
multi-megabyte advertisement. Its common in large companies to have
many mirror slaves in remote offices mirroring the Gerrit server so
that end-users can fetch from their office mirror more quickly.

> There are a lot of "if"s in that last paragraph, and maybe it's not
> workable. For example, if I'm not pruning on fetch, then my reference
> tree won't be identical to one that was ever present on the server and
> this technique wouldn't necessarily help. But if, for example, we change
> the default to pruning, or perhaps record some extra reftree SHA-1's,
> then in most cases I would expect that this trick could reduce the
> effort of negotiation to negligible in most cases, and reduce the time
> of the whole fetch to negligible in the case that the clone is already
> up-to-date.

Right, maybe the client just remember's the server's reftree SHA-1 and
offers it back on reconnection. The server can then diff between the
two reftrees and shows the client only refs that were modified that
the client cares about.


> [1] At GitHub, we store public repositories in networks with a shared
> object store. The central repository in each network can have 10M+
> references. So for us, rewriting that many references for every
> reference update would be unworkable.

Yup, and Gerrit Code Review servers often have 100k+ refs per
repository. We can't rewrite the entire store every time either. So
its not a flat list. Its a directory structure using the / separators
in the ref namespace.

FWIW, JGit is able to scan the canonical trees out of a pack file and
inflate them in approximately the same time it takes to scan the
packed-refs file for some 70k references. So we don't really slow down
much to use this. And there's huge gains to be had by taking advantage
of the tree structure and only inflating the components you need to
answer a particular read.
