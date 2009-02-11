From: Sam Vilain <sam@vilain.net>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Wed, 11 Feb 2009 18:05:47 +1300
Message-ID: <49925CAB.505@vilain.net>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <200902100158.46884.bss@iguanasuicide.net> <20090210131600.GD17305@coredump.intra.peff.net> <200902101958.21284.bss@iguanasuicide.net> <alpine.LFD.2.00.0902101825360.3590@localhost.localdomain> <49924642.6000609@vilain.net> <alpine.LFD.2.00.0902101953170.3590@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 06:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX7Ju-0005jb-CQ
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 06:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbZBKFGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 00:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbZBKFGB
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 00:06:01 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:55352 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbZBKFGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 00:06:00 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 08A1F21D662; Wed, 11 Feb 2009 18:05:52 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	PLING_QUERY autolearn=no version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id B6DF721C2DB;
	Wed, 11 Feb 2009 18:05:47 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.2.00.0902101953170.3590@localhost.localdomain>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109373>

Linus Torvalds wrote:
>> The only case where it hurts is when you want to merge. Nothing else
>> should care. So, if a merge of these note trees sees two different trie
>> sizes then it can convert the shorter one to the longer length first,
>> and then try the merge again. So you get the pain, but only once. And
>> when a project decides that its split is too small, it can split then
>> and it should "silently" spread out to others.
>>     
>
> But what's the advantage of the added complexity?
>
> The non-fixed trie only helps for the case that doesn't matter - just a 
> few annotations. If you have a thousand annotations or less, you _really_ 
> don't care. Whatever you do will be fine.
>
> So the whole thing only matters once you have tens of thousands of 
> entries, and then you do want to have fan-out. No?
>   

Yeah. I see your point and you may be right, that a 12/28 split hurts
no-one, if we take this to the benchmarks. There's certainly savings in
terms of total object count for the small users by using a smaller split.

I just already wrote the code to handle an arbitrary split for the
features written so far[1]. If *I* can write it, in C, it means it must
not be that complicated ;-)

So it comes down to how complicated things are when merging happens. If
12 is fixed in stone this is simple, because there are no chances for
discrepancies. But refs/notes/commits still needs special treatment to
be fetched, because it is not under refs/heads/* and you wouldn't
normally have a working tree to resolve conflicts.

So I think probably the most productive thing to do is for me to write
the code to handle the merge as I described above, once the code to
handle pulling in - and merging - notes at 'git fetch' time is written.
Then we can see whether it's that much of a complication.

To bench this we need the current builtin-log implementation to be
re-written to be lazy. Which means we can't put it in the next release
unless someone writes that. However my proposal means that we can
release as we are and not care, and let some code - which I hope I have
shown isn't *that* complicated, really - deal with it in a later
release, and not break backwards compatibility.

Sam.

1. see message <1233455960.17688.122.camel@maia.lan>
