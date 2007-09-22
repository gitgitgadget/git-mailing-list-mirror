From: "Steven Burns" <royalstream@hotmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sat, 22 Sep 2007 10:52:22 -0600
Message-ID: <fd3h7t$59b$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <fbr2iv$ugg$1@sea.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 18:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ8EV-0005CP-Bl
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 18:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbXIVQxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753684AbXIVQxW
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 12:53:22 -0400
Received: from main.gmane.org ([80.91.229.2]:58191 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbXIVQxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 12:53:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IZ8Dt-0001v6-E6
	for git@vger.kernel.org; Sat, 22 Sep 2007 16:52:53 +0000
Received: from 200.9.63.21 ([200.9.63.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 16:52:53 +0000
Received: from royalstream by 200.9.63.21 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 16:52:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.9.63.21
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.3138
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
X-RFC2646: Format=Flowed; Response
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 6.3 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.1 FORGED_HOTMAIL_RCVD2 hotmail.com 'From' address, but no 'Received:'
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58937>

Another reason GC is sometimes surprisingly faster is not only you end up 
allocating less times like you mention, but because some GC are compacting 
garbage collectors and that simplyfies allocations dramatically because 
allocating memory is just increasing a pointer. Compare that to the way most 
C++ heaps get implemented.
I don't know if that's the case with D's GC though.

I completely understand what you say about the strings and who owns it, I've 
ran into the same situation a hundred times, not only with strings but with 
vectors, matrixes, lists, etc.

After reading your post, I think I will have to revisit D sometime.
I read about it a few years ago and I got the impression some syntax 
decisions had been made to ease the writing of the compiler as opposed to 
favoring the end user/programmer, but it's been a while and maybe I was too 
quick to judge.

Steven


"Walter Bright" <boost@digitalmars.com> wrote in message 
news:fbr2iv$ugg$1@sea.gmane.org...
> Wincent Colaiuta wrote:
>> Git is all about speed, and C is the best choice for speed, especially in 
>> context of Git's workload.
>
> I can appreciate that. I originally got into writing compilers because my 
> game (Empire) ran too slowly and I thought the existing compilers could be 
> dramatically improved.
>
> And technically, yes, you can write code in C that is >= the speed of any 
> other language (other than asm). But practically, this isn't necessarily 
> so, for the following reasons:
>
> 1) You wind up having to implement the complex, dirty details of things 
> yourself. The consequences of this are:
>
>    a) you pick a simpler algorithm (which is likely less efficient - I run 
> across bubble sorts all the time in code)
>
>    b) once you implement, tune, and squeeze all the bugs out of those 
> complex, dirty details, you're reluctant to change it. You're reluctant to 
> try a different algorithm to see if it's faster. I've seen this effect a 
> lot in my own code. (I translated a large body of my own C++ code that I'd 
> spent months tuning to D, and quickly managed to get significantly more 
> speed out of it, because it was much simpler to try out different 
> algorithms/data structures.)
>
> 2) Garbage collection has an interesting and counterintuitive consequence. 
> If you compare n malloc/free's with n gcnew/collections, the malloc/free 
> will come out faster, and you conclude that gc is slow. But that misses 
> one huge speed advantage of gc - you can do FAR fewer allocations! For 
> example, I've done a lot of string manipulating programs in C. The basic 
> problem is keeping track of who owns each string. This is done by, when in 
> doubt, make a copy of the string.
>
> But if you have gc, you don't worry about who owns the string. You just 
> make another pointer to it. D takes this a step further with the concept 
> of array slicing, where one creates windows on existing arrays, or windows 
> on windows on windows, and no allocations are ever done. It's just pointer 
> fiddling.
>
> ------
> Walter Bright
> http://www.digitalmars.com  C, C++, D programming language compilers
> http://www.astoriaseminar.com  Extraordinary C++
> 
