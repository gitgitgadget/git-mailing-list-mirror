From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 18:50:41 -0700
Message-ID: <20081102015041.GG15463@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081101173042.GE26229@artemis.corp> <490CA37C.1070107@op5.se> <20081101202922.GB15463@spearce.org> <490CD101.1030604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Nov 02 02:52:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwS8v-0006N3-E0
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 02:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbYKBBun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 21:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbYKBBun
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 21:50:43 -0400
Received: from george.spearce.org ([209.20.77.23]:36737 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbYKBBum (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 21:50:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0AFFC3835F; Sun,  2 Nov 2008 01:50:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <490CD101.1030604@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99798>

Andreas Ericsson <ae@op5.se> wrote:
> Shawn O. Pearce wrote:
>>
>> Eh, I disagree here.  In git.git today "struct commit" exposes its
>> buffer with the canonical commit encoding.  Having that visible
>> wrecks what Nico and I were thinking about doing with pack v4 and
>> encoding commits in a non-canonical format when stored in packs.
>> Ditto with trees.
>
> Err... isn't that backwards?

No.

> Surely you want to store stuff in the
> canonical format so you're forced to do as few translations as
> possible?

No.  We suspect that canonical format is harder to decompress and
parse during revision traversal.  Other encodings in the pack file
may produce much faster runtime performance, and reduce page faults
(due to smaller pack sizes).

We hardly ever use the canonical format for actual output; most
output rips the canonical format apart and then formats the data
the way it was requested.  If we have the data *already* parsed in
the pack its much faster to output.

> Or are you trying to speed up packing by skipping the
> canonicalization part?

Wrong; we're trying to speed up reading.  Packing may go slower,
especially during the first conversion of v2->v4 for any given
repository, but packing is infrequent so the minor (if any) drop
in performance here is probably worth the reading performance gains.

> Well, if macro usage is adhered to one wouldn't have to worry,
> since the macro can just be rewritten with a function later (if,
> for example, translation or some such happens to be required).
> Older code linking to a newer library would work (assuming the
> size of the commit object doesn't change anyway),

You are assuming too much magic.  If the older ABI used a macro
and the newer one (which supports pack v4) organized struct commit
differently and the user upgrades libgit2.so the older applications
just broke, horribly.

We know we want to do pack v4 in the near future.  Or at least
experiment with it and see if it works.  If it does, we don't
want to have to cause a major ABI breakage across all those newly
installed libgit2s... yikes.

I'm really in favor of accessor functions for the first version of
the library.  They can always be converted to macros once someone
shows that their git visualizer program saves 10 ms on a 8,000 ms
render operation by avoiding accessor functions.  I'd rather spend
our brain cycles optimizing the runtime and the in-core data so
we spend less time in our tight revision traversal loops.

Seriously.  We make at least 10 or 11 function calls *per commit*
that comes out of get_revision().  If the formatting application is
really suffering from its 4 or 5 accessor function calls in order
to get that returned data, we probably should also be looking at
how we can avoid function cals in the library.

Oh, and even with 4 or 5 accessor functions per commit in the
application that is *still* better than the 10 or so calls the
application probably makes today scraping "git log --format=raw"
off a pipe and segment it into the different fields it needs.

Unless pipes in Linux somehow allow negative time warping with
CPU counters.  Though on dual-core systems they might, since the
two processes can run on different cores.  But oh, you didn't want
to worry about threading support too much in libgit2, so I guess
you also don't want to use multi-core systems.

-- 
Shawn.
