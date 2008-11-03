From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Mon, 03 Nov 2008 11:17:38 +0100
Message-ID: <490ECFC2.1070901@op5.se>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081101173042.GE26229@artemis.corp> <490CA37C.1070107@op5.se> <20081101202922.GB15463@spearce.org> <490CD101.1030604@op5.se> <20081102015041.GG15463@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 11:19:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwwWZ-00067k-4B
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 11:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbYKCKRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 05:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbYKCKRw
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 05:17:52 -0500
Received: from mail.op5.se ([193.201.96.20]:50962 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711AbYKCKRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 05:17:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 36A5A24B0039;
	Mon,  3 Nov 2008 11:12:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jgUMJEk1lwey; Mon,  3 Nov 2008 11:12:35 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 6986E24B0009;
	Mon,  3 Nov 2008 11:12:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081102015041.GG15463@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99927>

Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>> Shawn O. Pearce wrote:
>>> Eh, I disagree here.  In git.git today "struct commit" exposes its
>>> buffer with the canonical commit encoding.  Having that visible
>>> wrecks what Nico and I were thinking about doing with pack v4 and
>>> encoding commits in a non-canonical format when stored in packs.
>>> Ditto with trees.
>> Err... isn't that backwards?
> 
> No.
> 
>> Surely you want to store stuff in the
>> canonical format so you're forced to do as few translations as
>> possible?
> 
> No.  We suspect that canonical format is harder to decompress and
> parse during revision traversal.  Other encodings in the pack file
> may produce much faster runtime performance, and reduce page faults
> (due to smaller pack sizes).
> 
> We hardly ever use the canonical format for actual output; most
> output rips the canonical format apart and then formats the data
> the way it was requested.  If we have the data *already* parsed in
> the pack its much faster to output.
> 

I'll have to look into the pack v4 stuff, as I can't get what you're
saying to make sense to me. Not canonicalizing the data when storing
it means you'll have to have conversion routines from all the various
encodings, unless you first canonicalize it and then encode it in the
way you need it in the pack way. Never using canonical format means
it has no potential for combinatorial explosion, and every converter
needs to know about every other format.


>> Or are you trying to speed up packing by skipping the
>> canonicalization part?
> 
> Wrong; we're trying to speed up reading.  Packing may go slower,
> especially during the first conversion of v2->v4 for any given
> repository, but packing is infrequent so the minor (if any) drop
> in performance here is probably worth the reading performance gains.
> 
>> Well, if macro usage is adhered to one wouldn't have to worry,
>> since the macro can just be rewritten with a function later (if,
>> for example, translation or some such happens to be required).
>> Older code linking to a newer library would work (assuming the
>> size of the commit object doesn't change anyway),
> 
> You are assuming too much magic.  If the older ABI used a macro
> and the newer one (which supports pack v4) organized struct commit
> differently and the user upgrades libgit2.so the older applications
> just broke, horribly.
> 

Naturally. Re-sizing objects that weren't previously protected by
accessor functions will always break the ABI unless the layout of
the previously existing items in the object doesn't change, which
is exactly what I said.

> We know we want to do pack v4 in the near future.  Or at least
> experiment with it and see if it works.  If it does, we don't
> want to have to cause a major ABI breakage across all those newly
> installed libgit2s... yikes.
> 

That's not necessary, although it requires a bit more thought when
changing the objects.

> I'm really in favor of accessor functions for the first version of
> the library.  They can always be converted to macros once someone
> shows that their git visualizer program saves 10 ms on a 8,000 ms
> render operation by avoiding accessor functions.  I'd rather spend
> our brain cycles optimizing the runtime and the in-core data so
> we spend less time in our tight revision traversal loops.
> 

I agree that for early versions they should definitely be functions,
but since we've been talking about "final design" earlier in the
thread, that's what I was referring to here to.

> Seriously.  We make at least 10 or 11 function calls *per commit*
> that comes out of get_revision().  If the formatting application is
> really suffering from its 4 or 5 accessor function calls in order
> to get that returned data, we probably should also be looking at
> how we can avoid function cals in the library.
> 
> Oh, and even with 4 or 5 accessor functions per commit in the
> application that is *still* better than the 10 or so calls the
> application probably makes today scraping "git log --format=raw"
> off a pipe and segment it into the different fields it needs.
> 

Right.

> Unless pipes in Linux somehow allow negative time warping with
> CPU counters.  Though on dual-core systems they might, since the
> two processes can run on different cores.  But oh, you didn't want
> to worry about threading support too much in libgit2, so I guess
> you also don't want to use multi-core systems.
> 

All comps where I use git today are multi-core systems, so I'm very
much in favour of parallell processing. Otoh, I also don't think it
makes sense to jump through hoops to make sure one can, fe, read and
parse all tags in multiple threads simultaneously. In other words, I
don't think we need to bother adding thread-safety for stuff that 
really only should happen if the application is poorly designed
(unless it's straightforward to do so, ofcourse).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
