From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possible regression in git-rev-list --header
Date: Tue, 2 Jan 2007 22:32:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701022219050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
 <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7iw9jftv.fsf@assigned-by-dhcp.cox.net> <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net> <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 22:32:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1rFL-0003l1-OQ
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbXABVc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754979AbXABVc2
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:32:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:46058 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754976AbXABVc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:32:27 -0500
Received: (qmail invoked by alias); 02 Jan 2007 21:32:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 02 Jan 2007 22:32:25 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35821>

Hi,

On Sun, 31 Dec 2006, Junio C Hamano wrote:

> "Marco Costalba" <mcostalba@gmail.com> writes:
> 
> > On 12/31/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> Further, if you rely on parsing being super-fast, why not just parse
> >> _only_ the header information that you actually need? The header still
> >> consists of
> >>
> >>         - exactly one "tree",
> >>         - an arbitrary amount of "parent" lines,
> >>         - exactly one "author", and
> >>         - exactly one "committer" line
> >>
> >> After that may come optional headers,
> 
> They are more like 'other' headers.

I should have been more clear: optional for the committer.

> > If you intorduce the concept of an 'optional header part' you
> > logically and naturally _may_ also introduce the concept of disabling
> > the display of _that_ optional header, or better, to keep back
> > compatibility...
> 
> While I am somewhat sympathetic, and am willing to apologize for
> trying to advance the i18n support without enough advance
> warning, I think you already know what you are saying does not
> make much sense in the larger picture and as the longer term
> solution.

Besides, when you say

> The problem with your proposed algorithm is that you don't have _one_ 
> commit but a sequence of commits to parse, so when you have parsed until 
> the committer line you must need to know where the next commit starts, 
> IOW you have to find the next '\0', that's what I was trying to expose 
> in my previous e-mail postscriptum.

I don't get _at all_ what could be a problem _with_ the encoding header 
that is no problem _without_ it. I assume you want to tell me something 
more than that you do not want to change your code? If so, I missed it.

>  * When the output encoding conversion is done successfully, the
>    current tip of master drops "encoding" header from the
>    output, [...]

Earlier, I said that I do not feel strongly about that issue.

But now I do.

If you drop the "encoding" header from the commit buffer, just because you 
reencoded it to whatever encoding happens to be the one the caller just 
asked for, you are _not_ interpreting the data, but _changing_ it.

That is not what git is about, IMHO. It would be a completely different 
thing if the caller had a way to ask for _specific_ headers, and asks to 
be left alone with all the other cruft. But the caller does not even have 
the chance to say that, let alone ask specifically _for_ it.

The encoding header bears information, just like the tree header or the 
committer header. I find it highly irritating that I am shielded from it. 
The encoding header has _nothing_ to do with the encoding that the output 
is being encoded with, but _all_ with how the commit message was encoded 
_by the committer_.

> The reason we did the latter, by the way, does not have anything
> to do with helping broken parsers.  We drop the header after
> re-coding the log message into an encoding specified by the user
> (which is presumably different from what the commit was
> originally recorded in) because the encoding recorded on
> "encoding" header would not match the re-coded log message
> anymore.

By the same reasoning, you'd have to rewrite the committer line to reflect 
the current GIT_COMMITTER_IDENT, or hide it. If you want to convince me, 
you have to try harder.

And Marco has to fix the header parsing anyway.

So, please, Junio, can you rethink that decision?

Ciao,
Dscho
