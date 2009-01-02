From: david@lang.hm
Subject: Re: how to track the history of a line in a file
Date: Fri, 2 Jan 2009 14:43:37 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901021439080.21567@asgard.lang.hm>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm> <20090102212655.GA24082@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 02 22:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIrn1-0002jZ-L5
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 22:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758517AbZABVlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756943AbZABVlV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:41:21 -0500
Received: from mail.lang.hm ([64.81.33.126]:42931 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528AbZABVlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:41:21 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n02LfF3N022890;
	Fri, 2 Jan 2009 13:41:15 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090102212655.GA24082@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104418>

On Fri, 2 Jan 2009, Jeff King wrote:

> On Fri, Jan 02, 2009 at 02:13:32PM -0800, david@lang.hm wrote:
>
>> I have a need to setup a repository where I'm storing config files, and I
>> need to be able to search the history of a particular line, not just when
>> the last edit of the line was (which is what I see from git blame)
>
> As you figured out, the "manual" way is to just keep reblaming from the
> parent of each blame. Recent versions of "git gui blame" have a "reblame
> from parent" option in the context menu which makes this a lot less
> painful.

unfortunantly I am needing to do this from the command line.

>> 57f8f7b6 (Linus Torvalds 2008-10-23 20:06:52 -0700 3) SUBLEVEL = 28
>>
>> what I would want it to show would be a list of the commits that have
>> changed this line.
>
> The tricky thing here is what is "this line"? Using the line number
> isn't right, since it will change based on other content coming in and
> out of the file. You can keep drilling down by reblaming parent commits,
> but remember that each time you do that you are manually looking at the
> content and saying "Oh, this is the line I am still interested in." So I
> a script would have to correlate the old version and new version of the
> line and realize how to follow the "interesting" thing.
>
> In your case, I think you want to see any commit in Makefile which
> changed a line with SUBLEVEL in it. Which is maybe easiest done as:
>
>  git log -z -p Makefile |
>    perl -0ne 'print if /\n[+-]SUBLEVEL/' |
>    tr '\0' '\n'
>
> and is pretty fast. But obviously we're leveraging some content-specific
> knowledge about what's in the Makefile.

using the line number shouldn't be _that_ hard becouse git knows what 
lines came and went from the file, so it can calculate the new line number 
(and does with the -M option)

In my case I would consider 'the same line' to be any lines in the diff 
that were taken out when this line was put in

so in the usual case (for me) of

-oldline
+newline

it's a 1-1 correspondence

if it's instead
-oldline1
-oldline2
+newline1
+newline2

I can't know for sure which oldline corresponds to the newline, but the 
odds are very good that they are related, so if I widen the search to 
cover each of the lines I am probably good.

David Lang
