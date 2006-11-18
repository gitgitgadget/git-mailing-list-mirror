X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sat, 18 Nov 2006 11:04:20 -0800
Message-ID: <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	<7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	<20061118184345.GO7201@pasky.or.cz>
	<e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 19:04:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	(Marco Costalba's message of "Sat, 18 Nov 2006 19:47:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31792>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlVUI-00033Z-3U for gcvg-git@gmane.org; Sat, 18 Nov
 2006 20:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756383AbWKRTEX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 14:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756389AbWKRTEW
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 14:04:22 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34529 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1756383AbWKRTEW
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 14:04:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118190421.QJDU4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 14:04:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oK3t1V00J1kojtg0000000; Sat, 18 Nov 2006
 14:03:53 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 11/18/06, Petr Baudis <pasky@suse.cz> wrote:
>> On Sat, Nov 18, 2006 at 07:38:11PM CET, Junio C Hamano wrote:
>> >
>> > I think the question is why you would want to run peek-remote.
>> > Do you use the ^{} peeled-onion information and if so how and
>> > why?
>>..
> Yes. It is. From a list like
>
>> > > d9b0f913ce0508fcc83e642e0241f373428368e5        refs/tags/v1.4.3
>> > > e0b0830726286287744cc9e1a629a534bbe75452        refs/tags/v1.4.3^{}
>> > > 4314f5982d2aac08001a977fc0b1b611e858e025        refs/tags/v1.4.3-rc1
>> > > 1965efb1599f59b8e3380335d1fa395e2008a30b        refs/tags/v1.4.3-rc1^{}
>>
> qgit (but also gitk FWIK) extracts
>
> e0b0830726286287744cc9e1a629a534bbe75452
> 1965efb1599f59b8e3380335d1fa395e2008a30b
>
> Stores in a quick look-up container and then checks against loaded
> commits to, as Pasky says, attach the nice green markers to tags.

Two answers.

A quick one that is to the point to solve "your" problem.

	show-ref -d

Not a quick one but that may lead to solution of a similar issue
for wider audiences is...

I wonder how fast update-server-info is under the same condition
with your earlier timing.

I am not suggesting you to use update-server-info.  The reason I
am wondering about it are:

 (1) traditionally, "peek-remote ." has been the only way to get
     to that information, so you have every right to keep doing
     so;

 (2) however, even with presense of packed-refs, upload-pack
     that is invoked by peek-remote needs to consult unpacked
     refs first and then fall back to packed-refs, and only
     using the ^{} information "cached" in packed-refs file and
     computing ^{} itself when dealing with unpacked refs means
     more code, which we need to assess the pros-and-cons.

 (3) another inefficiency of using "peek-remote ." is that it
     spawns another process in the "remote" repo and talks with
     it.

So storing this information making upload-pack to reuse it when
it can might make things go faster for other applications but
first I wanted to know how much overhead is incurred in the
extra upload-pack process, and time update-server-info needs to
prepare the info in .git/info/refs would be a way to get a rough
estimate for that (you subtract that from "peek-remote ." time).


