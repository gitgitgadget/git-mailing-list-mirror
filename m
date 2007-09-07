From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 01:15:06 -0700
Organization: Digital Mars
Message-ID: <fbr1a2$qm7$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se>	<1189004090.20311.12.camel@hinata.boston.redhat.com>	<vpq642pkoln.fsf@bauges.imag.fr>	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>	<alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>	<fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 10:15:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITZ08-00016J-Ue
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 10:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbXIGIPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 04:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbXIGIPe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 04:15:34 -0400
Received: from main.gmane.org ([80.91.229.2]:47821 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964937AbXIGIPd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 04:15:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITYzf-0000mH-VK
	for git@vger.kernel.org; Fri, 07 Sep 2007 10:15:11 +0200
Received: from c-24-16-50-251.hsd1.wa.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 10:15:11 +0200
Received: from boost by c-24-16-50-251.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 10:15:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <85k5r27wkv.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58003>

David Kastrup wrote:
> Walter Bright <boost@digitalmars.com> writes:
>> The D programming language is a different take than C++ has on growing
>> C. I'm curious what your thoughts on that are (D has garbage
>> collection, while still retaining the ability to directly manage
>> memory). Can you enumerate what you feel are the important concepts?
> 
> A design is perfect not when there is no longer anything you can add
> to it, but if there is no longer anything you can take away.

I like to phrase that a slightly different way: anyone can make 
something complicated, but it takes genius to make something simple.

A very big goal for D is to make what should be simple code, simple. It 
turns out that what's simple for a computer is complex for a human. So 
to design a language that is simple for programmers is (unfortunately) a 
rather complex problem. Or perhaps I'm just not smart enough <g>.

A canonical example is that of a loop. Consider a simple C loop over an 
array:

void foo(int array[10])
{
     for (int i = 0; i < 10; i++)
     {   int value = array[i];
         ... do something ...
     }
}

It's simple, but it has a lot of problems:

1) i should be size_t, not int
2) array is not checked for overflow
3) 10 may not be the actual array dimension
4) may be more efficient to step through the array with pointers, rather 
than indices
5) type of array may change, but the type of value may not get updated
6) crashes if array is NULL
7) only works with arrays and pointers

Since this thread is talking about C++, let's look at the C++ version:

void foo(std::vector<int> array)
{
   for (std::vector<int>::const_iterator
        i = array.begin();
        i != array.end();
        i++)
   {
     int value = *i;
     ... do something ...
   }
}

It has fewer latent bugs, but still:

1) type of array may change, but the type of value may not get updated
2) too darned much typing
3) it's more complicated, not simpler

Frankly, I don't want to write loops that way. I want to write them like 
this:

void foo(int[] array)
{
   foreach (value; array)
   {
     ... do something ...
   }
}

As a programmer, I'm specifying exactly what I want to happen without 
much extra puffery. It's less typing, simpler, and more resistant to bugs.

1) correct loop index type is selected based on the type of array
2) arrays carry with them their dimension, so foreach is guaranteed to 
step through the loop the correct number of times
3) implementation decides if pointers will do a better job than indices, 
based on the compilation target
4) type of value is inferred automatically from the type of array, so no 
worries if the type changes
5) Null arrays have 0 length, so no crashing
6) works with any collection type

[This example is extracted from a presentation I've made.]

------
Walter Bright
http://www.digitalmars.com  C, C++, D programming language compilers
http://www.astoriaseminar.com  Extraordinary C++
