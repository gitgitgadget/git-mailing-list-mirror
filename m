From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: {RFC/PATCH] micro-optimize get_sha1_hex()
Date: Sat, 9 Sep 2006 17:53:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609091741420.27779@g5.osdl.org>
References: <7vzmd8vh6q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609091639110.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 02:53:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMDa5-00082V-11
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 02:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWIJAxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 20:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWIJAxU
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 20:53:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965061AbWIJAxT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 20:53:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8A0rEnW024209
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Sep 2006 17:53:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8A0rELE025397;
	Sat, 9 Sep 2006 17:53:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0609091639110.27779@g5.osdl.org>
X-Spam-Status: No, hits=-0.521 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26777>



On Sat, 9 Sep 2006, Linus Torvalds wrote:
>
> I _suspect_ that you profiled using "gprof" and the "-pg" flag to 
> the compiler?

Btw, in the absense of oprofile (which is very useful, and has the 
advantage that you can run many programs multiple times and get a 
"combined data" output from it all), what you can do (and which is more 
reliable) is:

 - the "minor pagefault" count that /usr/bin/time prints out is very 
   useful. It gives a pretty much direct view into what the total memory 
   use of the program was over its lifetime, in a way that very few other 
   things do.

 - using "gprof" to try to find _potential_ hotspots, but then not 
   trusting the profiling numbers at all for actual improvement, but 
   simply recompiling (witout profiling) and timing it for real after any 
   change. The real timings will almost certainly not match what you 
   thought you'd get from profiling, but now they'll be real numbers.

 - using "-pg" to link in the profiling code, BUT ONLY AT THE FINAL LINK 
   TIME! This will give you the "% time" and "cumulative seconds" part, 
   but it will mean that you will _not_ get the call-graph, because now 
   the actual code generation is not affected, and the compiler won't be 
   inserting all the call-graph-generation code. 

Note that the last use makes gprof much more accurate, but it also means 
that it won't _work_ very well for things that are fast. You usually have 
a 1/100th of a second profiling setup, so anything that is less than a 
second won't have much of a profile. So this only works for longer-running 
things.

		Linus
