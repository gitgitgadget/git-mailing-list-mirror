From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 01:36:56 -0700
Organization: Digital Mars
Message-ID: <fbr2iv$ugg$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 10:37:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITZL6-0006OZ-M3
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 10:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbXIGIhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 04:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbXIGIhN
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 04:37:13 -0400
Received: from main.gmane.org ([80.91.229.2]:60152 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964953AbXIGIhL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 04:37:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITZKn-00037b-AL
	for git@vger.kernel.org; Fri, 07 Sep 2007 10:37:01 +0200
Received: from c-24-16-50-251.hsd1.mn.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 10:37:01 +0200
Received: from boost by c-24-16-50-251.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 10:37:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.mn.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58005>

Wincent Colaiuta wrote:
> Git is all about speed, and C is the best 
> choice for speed, especially in context of Git's workload.

I can appreciate that. I originally got into writing compilers because 
my game (Empire) ran too slowly and I thought the existing compilers 
could be dramatically improved.

And technically, yes, you can write code in C that is >= the speed of 
any other language (other than asm). But practically, this isn't 
necessarily so, for the following reasons:

1) You wind up having to implement the complex, dirty details of things 
yourself. The consequences of this are:

    a) you pick a simpler algorithm (which is likely less efficient - I 
run across bubble sorts all the time in code)

    b) once you implement, tune, and squeeze all the bugs out of those 
complex, dirty details, you're reluctant to change it. You're reluctant 
to try a different algorithm to see if it's faster. I've seen this 
effect a lot in my own code. (I translated a large body of my own C++ 
code that I'd spent months tuning to D, and quickly managed to get 
significantly more speed out of it, because it was much simpler to try 
out different algorithms/data structures.)

2) Garbage collection has an interesting and counterintuitive 
consequence. If you compare n malloc/free's with n gcnew/collections, 
the malloc/free will come out faster, and you conclude that gc is slow. 
But that misses one huge speed advantage of gc - you can do FAR fewer 
allocations! For example, I've done a lot of string manipulating 
programs in C. The basic problem is keeping track of who owns each 
string. This is done by, when in doubt, make a copy of the string.

But if you have gc, you don't worry about who owns the string. You just 
make another pointer to it. D takes this a step further with the concept 
of array slicing, where one creates windows on existing arrays, or 
windows on windows on windows, and no allocations are ever done. It's 
just pointer fiddling.

------
Walter Bright
http://www.digitalmars.com  C, C++, D programming language compilers
http://www.astoriaseminar.com  Extraordinary C++
