From: "Steven Burns" <royalstream@hotmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 20 Sep 2007 08:06:03 -0600
Message-ID: <fctuo4$t93$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com> <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org> <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com> <20070907061554.GB30161@thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 16:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYMft-0006yy-R1
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 16:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbXITOGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 10:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbXITOGa
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 10:06:30 -0400
Received: from main.gmane.org ([80.91.229.2]:36390 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865AbXITOG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 10:06:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IYMfZ-000400-H2
	for git@vger.kernel.org; Thu, 20 Sep 2007 16:06:17 +0200
Received: from 200.9.63.21 ([200.9.63.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 16:06:17 +0200
Received: from royalstream by 200.9.63.21 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 16:06:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.9.63.21
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.3138
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58781>

> a = b + "/share/" + c + serial_num;
>
> where you can have absolutely no idea how many memory allocations are
> done, due to type coercions, overloaded operators

You are assuming (incorrectly) everybody will use dumb string classes like 
that.

It is very possible to create a string class that instead of allocating all
those strings simply concatenates tiny temporary objects and performs one
single operation in the end. Not to mention those temporaries are optimized
away by any decent compiler and you end up with code that runs at the same
speed as your C code.
I've done it, many other programmers have. As a reference, I'd like to
mention Matthew Wilson's chapter on efficient string concatenation in his
book "Imperfect C++". He uses expression templates (that's the technique I
just described) and gets impressive results.

With that said, your point is valid. 90% of C++ programmers will use string
classes that are very inefficient for concatenation, starting with
std::string which I hate for that reason (and many other reasons, e.g. you 
have to
resort to Boost for mundane things like trimming)

Steven Burns

"Theodore Tso" <tytso@mit.edu> wrote in message 
news:20070907061554.GB30161@thunk.org...
> On Thu, Sep 06, 2007 at 08:09:23PM -0700, Dmitry Kakurin wrote:
>> > Total BS. The string/memory management is not at all relevant. Look at 
>> > the
>> > code (I bet you didn't). This isn't the important, or complex part.
>>
>> Not only have I looked at the code, I've also debugged it quite a bit.
>> Granted most of my problems had to do with handling paths on Windows
>> (i.e. string manipulations).
>
> I consider string manipulation to be one of the places where C++ is a
> total disaster.  It's way to easy for idiots to do something like this:
>
> a = b + "/share/" + c + serial_num;
>
> where you can have absolutely no idea how many memory allocations are
> done, due to type coercions, overloaded operators (good God, you can
> overload the comma operator in C++!!!), and then when something like
> that ends up in an inner loop, the result is a disaster from a
> performance point of view, and it's not even obvious *why*!
>
>> My goal is to *use* Git. When something does not work *for me* I want
>> to be able to fix it (and contribute the fix) in *shortest time
>> possible* and with *minimal efforts*. As for me it's a diversion from
>> my main activities.
>
> Yes, and if you contribute something the shortest time possible, and
> it ends up being crap, who gets to rewrite it and fix it?  I've seen
> too many C++ programs which get this kind of crap added, and it's not
> noticed right away (because C++ is really good at hiding such
> performance killers so they are not visible), and then later on, it's
> even harder to find the performance problems and fix them.
>
>> Now, I realize that I'm a very infrequent contributor to Git, but I
>> want my opinion to be heard.
>
> And if git were written in C++, it's precisely the infrequent
> contributors (who are in a hurry, who only care about the quick hack
> to get them going, and not about the long-term maintainability and
> performance of the package) that are be in the position to do the
> most damage...
>
> - Ted 
