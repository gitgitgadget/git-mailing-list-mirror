From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 12:23:16 -0700
Organization: Digital Mars
Message-ID: <fbs8es$1cd$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <fbr2iv$ugg$1@sea.gmane.org> <46E11CE1.4030209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 21:23:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITjQP-0000Af-64
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 21:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509AbXIGTXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 15:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbXIGTXY
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 15:23:24 -0400
Received: from main.gmane.org ([80.91.229.2]:48739 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850AbXIGTXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 15:23:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITjQD-0006RM-UZ
	for git@vger.kernel.org; Fri, 07 Sep 2007 21:23:17 +0200
Received: from c-24-16-50-251.hsd1.mn.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 21:23:17 +0200
Received: from boost by c-24-16-50-251.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 21:23:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.mn.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46E11CE1.4030209@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58058>

Andreas Ericsson wrote:
> Walter Bright wrote:
>> 1) You wind up having to implement the complex, dirty details of 
>> things yourself. The consequences of this are:
>>
>>    a) you pick a simpler algorithm (which is likely less efficient - I 
>> run across bubble sorts all the time in code)
>>
>>    b) once you implement, tune, and squeeze all the bugs out of those 
>> complex, dirty details, you're reluctant to change it. You're 
>> reluctant to try a different algorithm to see if it's faster. I've 
>> seen this effect a lot in my own code. (I translated a large body of 
>> my own C++ code that I'd spent months tuning to D, and quickly managed 
>> to get significantly more speed out of it, because it was much simpler 
>> to try out different algorithms/data structures.)
>>
> 
> I haven't seen this in the development of git, although to be fair, you
> didn't mention the number of developers that were simultaneously working
> on your project.

On my project, one. But I've seen this problem repeatedly in other 
projects that had multiple developers. For example, I used to use 
version 1 of an assembler. It was itself written entirely in assembler. 
It ran *incredibly* slowly on large asm files. But it was written in 
assembler, which is very fast, so how could that be?

Turns out, the symbol table used internally was a linear one. A linear 
symbol table is easy to implement, but doesn't scale well at all. A 
linear symbol table was implemented because it was just harder to do 
more advanced symbol table algorithms in assembler. In this case, a 
higher level language re-implementation made the assembler much faster, 
even though that implementation was SLOWER in every detail. It was 
faster overall, because it was easier to develop faster algorithms.


> If it was you alone, I can imagine you were reluctant to
> change it just to see if something is faster.

My point was that when I reimplemented it in D, the cost of changing the 
algorithms got much lower, so I was much more tempted to muck around 
trying out different ones. The result was I found faster ones.


> Opensource projects with many contributors (git, linux) work differently,
> since one or a few among the plethora of authors will almost always be
> a true expert at the problem being solved.

That is a nice advantage. I don't think many projects can rely on having 
the best in the business working on them, though <g>.


> The point is that, given enough developers, *someone* is bound to
> find an algorithm that works so well that it's no longer worth
> investing time to even discuss if anything else would work better,
> either because it moves the performance bottleneck to somewhere else
> (where further speedups would no longer produce humanly measurable
> improvements), or because the action seems instantanous to the user
> (further improvements simply aren't worth it, because no valuable
> resource will be saved from it).

Sure, but I suggest that few projects reach this maxima. Case in point: 
ld, the gnu linker. It's terribly slow. To see how slow it is, compare 
it to optlink (the 15 years old one that comes with D for Windows). So I 
don't believe there is anything inherent about linking that should make 
ld so slow. There's some huge leverage possible in speeding up ld 
(spreading out that saved time among all the gnu developers).

So while git may have reached a maxima in performance, I don't think 
this principle is applicable in general, even for very widely used open 
source projects that would profit greatly from improved performance.

------
Walter Bright
http://www.digitalmars.com  C, C++, D programming language compilers
http://www.astoriaseminar.com  Extraordinary C++
