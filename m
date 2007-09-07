From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 02:14:01 -0700
Organization: Digital Mars
Message-ID: <fbr4oi$5ko$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se>	<1189004090.20311.12.camel@hinata.boston.redhat.com>	<vpq642pkoln.fsf@bauges.imag.fr>	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>	<alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>	<fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz>	<fbr1a2$qm7$1@sea.gmane.org> <851wda7ufz.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 11:15:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITZvM-0007IY-Uy
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 11:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbXIGJOm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 05:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbXIGJOm
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 05:14:42 -0400
Received: from main.gmane.org ([80.91.229.2]:44172 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965008AbXIGJOl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 05:14:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITZur-0006wP-2n
	for git@vger.kernel.org; Fri, 07 Sep 2007 11:14:17 +0200
Received: from c-24-16-50-251.hsd1.mn.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 11:14:17 +0200
Received: from boost by c-24-16-50-251.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 11:14:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.mn.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <851wda7ufz.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58008>

David Kastrup wrote:
> Walter Bright <boost@digitalmars.com> writes:
> 
>> A canonical example is that of a loop. Consider a simple C loop over
>> an array:
>>
>> void foo(int array[10])
>> {
>>     for (int i = 0; i < 10; i++)
>>     {   int value = array[i];
>>         ... do something ...
>>     }
>> }
>>
>> It's simple, but it has a lot of problems:
>>
>> 1) i should be size_t, not int
> 
> Wrong.  size_t is for holding the size of memory objects in bytes, not
> in terms of indices.  For indices, the best variable is of the same
> type as the declared index maximum size, so here it is typeof(10),
> namely int.

The easiest way to show the error is consider the code being ported to a 
typical 64 bit C compiler. int's are still 32 bits, yet the array can be 
larger than 32 bits. You're right in that what we want to be able to do 
is typeof(array dimension), but there is no way to do that automatically 
in C, which is my point. If the array dimension changes, you have to 
carefully check to make sure every loop dependency on the type is 
updated, too.

size_t will always work, however, making it a better choice than int, at 
least for C.

>> 2) array is not checked for overflow
> 
> Why should it?

Because the 10 array dimension is not statically checked in C. I could 
pass it a pointer to 3 ints without the compiler complaining. This makes 
it a potential maintenance problem. Also, the maintenance programmer may 
change the array dimension in the function signature, but overlook 
changing it in the for loop. Again, a maintenance problem.


>> 3) 10 may not be the actual array dimension
> 
> Your point is?

Array buffer overflow errors are commonplace in C, because array 
dimensions are not automatically checked at either compile or run time. 
This is an expensive problem. Some C APIs try to deal with this by 
passing a second argument for arrays giving the dimension (snprintf, for 
example), but this tends to be sporadic, not conventional. It being 
extra work for the programmer inevitably means it doesn't get done.


>> 4) may be more efficient to step through the array with pointers,
>> rather than indices
> 
> No.  It is a beginners' and advanced users' mistake to think using
> pointers for access is a good idea.  Trivial optimizations are what a
> compiler is best at, not the user.  Using pointer manipulation will
> more often than not break loop unrolling, loop reversal, strength
> reduction and other things.

C compilers vary widely in the optimizations they'll do for simple 
loops. I see often enough attempts by programmers to take such matters 
into their own hands. I agree with you on that - and suggest the 
language should not tempt the user to do such optimizations.

>> 5) type of array may change, but the type of value may not get
>> updated
> 
> Huh?

Let's say our fearless maintenance programmer decides to make it an 
array of longs, not an array of ints. He overlooks changing the type of 
value in the loop. Suddenly, things subtly break because of overflows. 
Or maybe he changed the int to an unsigned, now the divides in the loop 
give different answers. Etc. There really isn't any compiler/language 
help in finding these kinds of problems.


>> 6) crashes if array is NULL
> 
> Certainly.  Your point being?

I consider an array that is NULL to have no members, so instead of 
crashing the loop should execute 0 times.


>> 7) only works with arrays and pointers
> 
> Since there are only arrays and pointers in C, not really a restriction.

C has structs, too, as well as more complicated user defined 
collections. Essentially, you cannot (simply) write generic algorithms 
in C, because you cannot (simply) generically express iteration. Of 
course, you can still express anything in C if you're willing to work 
hard enough to get it. Me, I'm too lazy <g>. It's like why I can't play 
chess - everytime I try to play it instead I think about writing a 
program to do the hard work for me.


>> As a programmer, I'm specifying exactly what I want to happen without
>> much extra puffery. It's less typing, simpler, and more resistant to
>> bugs.
>>
>> 1) correct loop index type is selected based on the type of array
>> 2) arrays carry with them their dimension, so foreach is guaranteed to
>> step through the loop the correct number of times
>> 3) implementation decides if pointers will do a better job than
>> indices, based on the compilation target
>> 4) type of value is inferred automatically from the type of array, so
>> no worries if the type changes
>> 5) Null arrays have 0 length, so no crashing
>> 6) works with any collection type
> 
> Most of those are toy concerns.  They prevent problems that don't
> actually occur much in practice.

I beg to differ - buffer overflow bugs are common and expensive. The 
nice thing about the D loop is it is LESS typing than the C one - you 
get the extra robustness for free.

Let's look at the code gen for the inner loop for C:

L8:             push    [EBX*4][ESI]
                 call    near ptr _bar
                 inc     EBX
                 add     ESP,4
                 cmp     EBX,0Ah
                 jb      L8

and for D:

LE:            mov     EAX,[EBX]
                call    near ptr _D4test3barFiZv
                add     EBX,4
                cmp     EBX,ESI
                jb      LE

I think you can see that performance isn't an impediment.
