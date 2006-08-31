From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Problematic git pack
Date: Thu, 31 Aug 2006 10:45:12 +0200
Organization: ARCES - =?ISO-8859-15?Q?Universit=E0_di_Bologna?=
Message-ID: <44F6A198.4040902@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 31 10:46:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIiBO-0005k8-OW
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 10:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWHaIpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWHaIpv
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 04:45:51 -0400
Received: from arces.unibo.it ([137.204.143.6]:58796 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S1750964AbWHaIpu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 04:45:50 -0400
Received: from [192.168.143.223] (mars-fw.arces.unibo.it [137.204.143.2])
	(authenticated bits=0)
	by arces.unibo.it (8.13.7/8.13.7) with ESMTP id k7V8wtd7012163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 31 Aug 2006 10:59:27 +0200
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_50,USER_IN_WHITELIST 
	autolearn=unavailable version=3.1.3-gr0
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on 
	mail.arces.unibo.it
X-Virus-Scanned: ClamAV 0.88.4/1778/Thu Aug 31 09:34:18 2006 on arces.unibo.it
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26245>

What can I say... I had never seen before such an action at such a rapid 
pace following the indication of a potential problem.
Thanks Linus and Junio and everybody who might have contributed.
>   Junio could then generate a new pack with the one corrupted object 
>   fixed, which obviously meant that all the deltas now worked too.
>   
Excellent news...
>   This is my (probably final) analysis of the resulting differences.. ]
>
> On Wed, 30 Aug 2006, Junio C Hamano wrote:
> > 
> > Ok, I was going to attach the resurrected pack that should
> > contain everything your corrupt pack had, but it is a bit too
> > large, so I'll place it here [*1*].  Drop me a note when you
> > retrieved it, so that I can remove it.
>   
Junio, can you please send me privately details about [*1*] so I can 
retrieve the pack also?

I also have another question... (maybe it was answered in some previous 
thread on this list, in this case a pointer would be enough).
Now I am going to have the fixed archive and also a new archive, which I 
restarted from the latest working copy I had of my project.
Is there any way to automatically do real "surgery" to attach one to the 
other and get a single archive with all the history?
Obviously, if I try to change a commit object to modify its parents, its 
signature changes, so I need to modify its childs and so on, is this 
correct?
Alternatively I belive that grafts should be a way to go... I had never 
used them before, do all git tools support them? Particularly do they 
get pushed and pulled correctly?
> So the _real_ difference is literally just the one byte at offset 0151000 
> (decimal 53760) which in the fixed pack is 0x96, and in the corrupt pack 
> it is 0x94. That's a single-bit difference (bit #1 has been cleared).
>
>   
So, possibly, the alpha particle theory could be the plausible one in 
the end...
> Now, that makes me feel happy on one level, because it's almost certainly 
> a hardware problem - subtle memory corruption, or disk corruption that 
> happened when either reading or writing the image. Sergio may not be that 
> happy about it, of course.
>   
The bad thing is that I don't know which of my two machines (the laptop 
or the desktop) caused the issue!

> Finally, this also points out that the corrupted packs _can_ be fixed, but 
> I think Sergio was a bit lucky (to offset all the bad luck). Sergio still 
> had access to the original file that had had its object corrupted. 
Actually, this could possibly be a not so rare case... In my tree I had 
the development of some LaTeX documents and packages (code like, the 
really "precious" files) and a few binary objects (images and openoffice 
files mainly, by far less precious).
Since the binary objects were so much overwhelming in size with regard 
to the text ones, assuming a single error the probability of having it 
in a non-code object was much larger than that of having it in a 
precious code object. Also commit and tree objects should be much 
smaller than data objects.
This assumption is the reason which initally pushed me to ask help to 
try to unpack at least all the correct objects (one of my first 
questions was: does git unpack-objects die on the first error or is 
there a way to convince it to simply skip the wrong object (or the delta 
against a wrong object)...
If git unpack-objects can gain an option like --continue-on-errors and 
if checkout/reset can also get an option to do the same (i.e. in a tree 
with missing objects, checkout all that can be found), I believe that 
one is at a good point already...
Finally, having a command to create an object out of a single file 
(contrary of git cat-file) could help re-creating the missing objects...
> And it 
> took a fair amount of work, and some git hacking by somebody who really 
> understood git (Junio).
>
> Maybe we'll end up having some of that effort being useful and checked in, 
> and we'll eventually have more infrastructure for fixing these things, but 
> I suspect that in most cases, even a _single_ bit of corruption will 
> generally result in so much havoc that nobody should depend on that. It's 
> a lot better to have backups.
>
> 			Linus
