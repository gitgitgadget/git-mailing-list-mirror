From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 16 May 2006 19:20:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 17 04:20:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgBeU-0004gf-7e
	for gcvg-git@gmane.org; Wed, 17 May 2006 04:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWEQCUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 22:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWEQCUj
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 22:20:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751120AbWEQCUi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 22:20:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4H2KVtH030577
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 19:20:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4H2KU3f031854;
	Tue, 16 May 2006 19:20:31 -0700
To: Stefan Pfetzing <stefan.pfetzing@gmail.com>
In-Reply-To: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20155>


[ Junio - see the "grep" issue ]

On Wed, 17 May 2006, Stefan Pfetzing wrote:
> 
> So there are 2 possible solutions to get git working on Solaris.
> 
> 1.  fix every single shellscript automatically during the build phase
> 2.  setup a dir which contains symlinks to the "right" binaries and
> put that dir into PATH.

If the biggest issue is git depending on some GNU extensions, I'd really 
suggest
 (a) install all the normal GNU binaries, and put them in the path before 
     git just to get it working (and don't try to change git at all)
 (b) help send in patches that just remove the dependency entirely.

I've been - on and off - trying to libify most of the core git sources, so 
that the shell scripts can be re-written to be just plain C. Most of the 
time it's not actually even a huge amount of work, it's just somewhat 
boring.

Writing them as C usually gets rid of any dependencies on any GNU tools, 
and hopefully even cygwin. For example, we got rid of one "xargs -0" in 
the development branch pretty recently, thanks to making "git grep" a 
built-in.

Of course, I don't think anybody tried the new "git grep" on Solaris, and 
I think the solaris "grep" lacks the "-H" flag, for example. But that 
should be easy to fix (for example, replace the use of "--" and "-H" with 
putting a "/dev/null" as the first filename).

I don't think it's worth it trying to add some compatibility layer for the 
shell-scripts. We really do want to get rid of them, and the more people 
that help, the merrier.

In many ways, the libification effort isn't even needed. It's perfectly ok 
to turn a stupid shell-script (and they really all _are_ pretty stupid) 
into a builtin-cmd.c C file that just does something really easy like a 
"fork + execve()" translation of the original shell script.

The complete libification will take some time, and in the meantime, a few 
silly C files that hard-code the shell logic is probably much preferable 
to using the shell and all the problems that involves (like the whole 
problem with quoting arguments - just _gone_ when you do it as a execve() 
in a simple C program).

So anybody can help with this. If you know shell (and the git 
shell-scripts aren't even _advanced_ shell), and know some basic C, you're 
all set to do a trivial conversion from one to the other. And when the 
libification gets further, your conversion will probably help that (ie 
maybe libificaiton isn't complete, but a _part_ of the thing can be 
written to use the library interfaces instead of spawning an external 
program).

There aren't _that_ many shell programs, and a lot of them are really 
really trivial (ie they parse the arguments, and then do just a couple of 
external git commands).

			Linus
