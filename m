From: Ari Entlich <lmage11@twcny.rr.com>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 01:55:58 -0400
Message-ID: <1192859758.13347.148.camel@g4mdd.entnet>
References: <c594999b2337.2337c594999b@nyroc.rr.com>
	 <20071019015419.GV14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 07:56:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7K6-0007kg-DA
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 07:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758965AbXJTF4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 01:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759262AbXJTF4G
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 01:56:06 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:62100 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758963AbXJTF4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 01:56:03 -0400
Received: from [192.168.123.196] (cpe-24-59-99-35.twcny.res.rr.com [24.59.99.35])
	by ms-smtp-03.nyroc.rr.com (8.13.6/8.13.6) with ESMTP id l9K5twgg013378;
	Sat, 20 Oct 2007 01:55:59 -0400 (EDT)
In-Reply-To: <20071019015419.GV14735@spearce.org>
X-Mailer: Evolution 2.10.3 
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61788>

On Thu, 2007-10-18 at 21:54 -0400, Shawn O. Pearce wrote:
> Line wrapping email at under 80 columns would be nice. It makes it
> easier to read the message, and more importantly, easier to quote
> a few times during discussion.

Yeah, sorry about that. As I said, the crappy webmail client I was using
was screwing up. I'm using a real email client now.

> I'm somewhat hesistant to change existing behavior, as users may
> be used to it or relying upon it within their scripts. But you
> make an excellent argument about why the current git-mv behavior
> is perhaps less than ideal.

See my response to Wincent's message for what I said about this.

One minor issue (since you talk about programming stuff below) is that,
from my cursory survey of builtin-mv.c, a slight restructuring might be
required for this to work and for the solution to satisfy my coding
standards. This would be because you'd need to change the names of
individual cache entries as opposed to removing one and adding one. This
is a minor issue though, I'm sure I can figure out how to get it to work
somehow.

> Elsewhere in git we use the --cached command line option to mean
> "only make the change in the index". For example the git-apply
> --cached option. You could start a patch that uses --cached to
> trigger the new behavior you propose and see if people are interested
> in changing the default once the feature is working and available
> for experimentation.

>From a later email...
> But I was originally *way* wrong to propose --cached for this usage
> in git-mv. --cached means "apply *ONLY* to the index" and "do *NOT*
> touch the working tree". Here we want to touch the working tree
> in the sense of moving the file. So --cached is not the correct
> option name.

Hmm yeah, that did occur to me after I read your original message...

> --index is used in Git for places were we update *both* the index
> and the working directory (git-apply --index). So actually I should
> have suggested "git-mv --index".  Whoops.

Alright then, I don't know about that particular convention. If this
behavior can't be made default, git mv --index should activate it? I
there anything else that might be more descriptive?

> > I'm willing to look into what changes would need to be made to the
> > code for this change to happen; I'm not asking for someone to do
> > all the work for me. :)
> > 
> > So... Yeah. I'd like to know what people think about this before
> > I put a significant amount of effort into it. After all, we know
> > how lazy programmers are... :)
> 
> See builtin-mv.c around l.264-283. This is where we are removing
> the old names from the index (in memory) and inserting the new
> names. Instead of calling add_file_to_cache() you would want
> to use something like add_cacheinfo() in builtin-update-index.c,
> specifying the old sha1, ce_flags and ce_mode.

Might it be possible to simply get the struct cache_entry for the file
which we want to rename, change its name property (would this involve
xreallocing it?), and change the ce_namelen field of ce_flags?

In any case, I think the ce_flags would need to be changed to reflect
the new name length. Also, it seems that the old ce_mtime, ce_dev,
ce_ino, ce_uid, ce_gid, and ce_size could be used too... ce_ctime would
need to be updated...

> I'm sure Junio could probably give you a better starting point
> than I can, as he's more familiar with this sort of code, but that
> should still get you looking in the right direction and maybe get
> a working implementation together that you can share for discussion.

Yeah, I'd appreciate any help I can get. The people on #git were
invoking the "the code is the documentation" ideology. :)

So... Ping Junio...? I actually haven't seen any messages from him since
I subscribed to this list (I've only gotten about 300 messages so far,
but I'd expect to see a lot from him as he's the maintainer...). Is he
away at the moment or something?

Thanks,
	Ari
