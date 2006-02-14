From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: maildir / read-tree trivial merging getting in the way?
Date: Mon, 13 Feb 2006 18:32:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602131820490.3691@g5.osdl.org>
References: <Pine.LNX.4.60.0602140217380.19093@mundungus.clifford.ac>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 03:33:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8q0C-0001s4-Ir
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 03:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWBNCdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 21:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWBNCdM
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 21:33:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750875AbWBNCdM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 21:33:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1E2WcDZ010817
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 18:32:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1E2WZ4P019979;
	Mon, 13 Feb 2006 18:32:36 -0800
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <Pine.LNX.4.60.0602140217380.19093@mundungus.clifford.ac>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16104>



On Tue, 14 Feb 2006, Ben Clifford wrote:
> 
> I've spent a few hours playing round with maildir-aware merging.
> 
> The basic idea I'm trying to implement is to flip the index round so that
> instead of looking at how the content has changed for a particular filename,
> I'm looking at how the filenames have changed for a particular content.
> 
> So I'm using git read-tree -m to populate the index with entries for the
> branches to merge so that I can then diddle round with those.
> 
> But the read-tree trivial merge logic seems to be getting in the way a bit.

You are much better off working with "git-ls-tree", or perhaps 
"git-diff-tree".

The latter in particular will show you what got added and what got 
deleted, but will quickly ignore any common entries (which is probably 
exactly what you want).

> So basically my question is: should I feel dirty about doing this and diddle
> read-tree so that there's a flag to not do the trivial merges automatically?

You should try to avoid git-read-tree entirely, I suspect.

All the things git-read-tree does are wrong for you. Notably, it very much 
on purpose will match things up name-by-name, and it does a lot of extra 
work to create a sorted version of the index to do the trivial merges 
quickly. The thing is, it doesn't even do that the smart way.

Now, git-read-tree actually does a _great_ job - don't get me wrong. It's 
just that the job it does isn't really suitable for your usage, and it's 
doing some things the "simple and stupid" way instead of being very smart 
about them, just because they aren't that important under normal loads.

For example, in a three-way merge (with an index), it will basically have 
four sorted inputs that it needs to interleave. Now, there's a _smart_ way 
to interleave sorted input, and there's a stupid one. The smart way is to 
read the sources all together, and just pick the right sorted order, and 
interleave them all together.

That's not what git-read-tree does.

git-read-tree will read them one by one, and use "insertion sort" to 
maintain the result in sorted order. Now, insertion sort isn't totally 
idiotic (it's not doing a bogo-sort, at least), but it _is_ pretty damn 
silly when all the sources are already sorted and known ahead of time.

So git-read-tree does some stupid things, and scales badly with really big 
trees. The good news is that we can fix it - the bad news is that my 
motivation for it is pretty low, since "really big" means "much bigger 
than the kernel" ;)

In contrast "git-diff-tree -r a b" does the _smart_ thing, and scales 
linearly with tree size _and_ can take advantage of subdirectories not 
changing (the latter is apparently not an issue for you, but can be one in 
other circumstances).

(The "raw output" from git-diff-tree is also very easy to parse. Don't do 
the "-p" (patch) form, the raw "this is how the SHA's changed" sounds 
like it's exactly what you want, assuming you're interested in renames 
with no content change)

		Linus
