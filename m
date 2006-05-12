From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect failed me again
Date: Fri, 12 May 2006 07:55:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605120738190.3866@g5.osdl.org>
References: <20060512000249.71933599.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 12 16:56:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeZ3a-000186-Vh
	for gcvg-git@gmane.org; Fri, 12 May 2006 16:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWELOzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 10:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWELOzw
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 10:55:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932092AbWELOzv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 May 2006 10:55:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4CEtjtH011728
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 May 2006 07:55:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4CEtiVC016514;
	Fri, 12 May 2006 07:55:44 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060512000249.71933599.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19915>



On Fri, 12 May 2006, Andrew Morton wrote:
> 
> Trying to find a recently-merged box-killer in Len's tree:
> 
> bix:/usr/src/git26> cat .git/branches/git-acpi 
> git+ssh://master.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git#test
> 
> git-checkout git-acpi

Just for others: if you already have a Linux repo, this is the perfect 
time to do

	git clone --reference <old-linux-repo>
		git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6

to get that linux-acpi-2.6 repository.

And for Junio: good job on that "--reference" flag. I used to do a local 
clone and then force an update, this was much better.

> git-bisect reset
> git-bisect start
> git-bisect good ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
> git-bisect bad 9011bff4bdc0fef1f9a782d7415c306ee61826c9
> 
> And it led me to
> 
> bix:/usr/src/git26> git-bisect good
> 9011bff4bdc0fef1f9a782d7415c306ee61826c9 is first bad commit
> 
> which isn't a buggy patch.

Well, to see what's up, do "git bisect visualize". That tends to not only 
help bisect things (for when you want to pick a different bisection 
point), it's also a wonderfully visual tool to what the f*%& happens when 
something goes wrong.

Anyway, when I replay your log:

> bix:/usr/src/git26> cat .git/BISECT_LOG
> git-bisect start
> # good: [ff2fc3e9e3edb918b6c6b288485c6cb267bc865e] ACPI: EC acpi-ecdt-uid-hack
> git-bisect good ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
> # bad: [9011bff4bdc0fef1f9a782d7415c306ee61826c9] ACPI: delete newly added debugging macros in processor_perflib.c
> git-bisect bad 9011bff4bdc0fef1f9a782d7415c306ee61826c9
> # good: [c52851b60cc0aaaf974ff0e49989fb698220447d] P-state software coordination for speedstep-centrino
> git-bisect good c52851b60cc0aaaf974ff0e49989fb698220447d
> # good: [7e1f19e50371e1d148226b64c8edc77fec47fa5b] ACPI: UP build fix for bugzilla-5737
> git-bisect good 7e1f19e50371e1d148226b64c8edc77fec47fa5b

I definitely get the same "9011bff4bdc0fef1f9a782d7415c306ee61826c9 is 
first bad commit" result, and going along visually at every point makes it 
very very obvious that git-bisect is right.

(In fact, the _most_ visually obvious way to do it is to do this:

	git bisect reset
	git bisect start
	git bisect good ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
	git bisect bad 9011bff4bdc0fef1f9a782d7415c306ee61826c9
	git bisect visualize &
	git bisect good c52851b60cc0aaaf974ff0e49989fb698220447d
	.. go into the "file" menu, and select "re-read references" ..
	git-bisect good 7e1f19e50371e1d148226b64c8edc77fec47fa5b
	.. do "re-read references" again ..

and you'll see exactly what "git bisect" is doing).

You claimed that the previous commit (7e1f19..) was good, and that 
9011bff.. itself was bad). So if that was true, then it really _was_ that 
9011bff.. commit that caused it.

> What did I do wrong this time?

You did nothing wrong, unless your _testing_ was wrong, and one of your 
"git bisect good" entries should have been bad, or the other way around 
(you booted into the wrong kernel, so you thought something was ok when it 
wasn't).

Why are you so sure that git bisect gave the wrong answer? This is ACPI, 
after all. For all we know, subtle cache-effects could break it.

"git bisect" sadly won't help with bugs that show up due to some other 
subtle interaction..

Anyway, my first guess would be that you might have marked something good 
or bad that wasn't. How sure are you about that initial "git bisect bad" 
you did?

		Linus
