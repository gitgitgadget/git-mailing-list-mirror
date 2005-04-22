From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Gnu-arch-users] Re: [GNU-arch-dev] [ANNOUNCEMENT] /Arch/ embraces
 `git'
Date: Fri, 22 Apr 2005 09:13:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504220844390.2344@ppc970.osdl.org>
References: <200504202304.QAA17069@emf.net> <1114069758.5886.9.camel@perun.redhat.usu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tom Lord <lord@emf.net>, gnu-arch-users@gnu.org,
	gnu-arch-dev@lists.seyza.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 18:09:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP0hM-0001W6-Nh
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 18:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVDVQMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 12:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVDVQMj
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 12:12:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:24521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262048AbVDVQM2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 12:12:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MGBss4014200
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 09:11:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MGBoEn031806;
	Fri, 22 Apr 2005 09:11:51 -0700
To: Tomas Mraz <t8m@centrum.cz>
In-Reply-To: <1114069758.5886.9.camel@perun.redhat.usu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Apr 2005, Tomas Mraz wrote:
> 
> However you're right that the original structure proposed by Linus is
> too flat.

You're wrong. 

The thing is, having 256 sybdirectories already eats one _megabyte_ of 
diskspace on common filessystems. If you expand that to be either deeper 
(ie subdirectories within subdirectories), or use more than 8 bits for the 
first level, you'll be using much more.

A megabyte of diskspace is peanuts for a project like Linux, but I think
it matters for small projects. I want git to work reasonably even for
really trivial stuff. 

For example, if you just expand the fan-out to use 12 bits instead of 8, 
you're now using 16MB of diskspace just for the directory structure, even 
for a trivially small project. I just think that sucks.

Secondly, any sane OS (and filesystem) will look up flat directories 
_faster_ than deep directories. Peter Anvid did the testing: a _totally_ 
flat directory is actually the best-performing one. 

I just don't want to go there, because while it's ok to have tens of
thousands of files in one subdirectory, I don't think it's ok to have
hundreds of thousands of files. The 8-bit initial fan-out is very much a
middle ground: we waste some space (and some time) doing it, but it does
make the really horrible case largely go away.

Trust me, the design of git didn't just come out of my *ss. Unlike pretty
much apparently any other SCM engineer in the history of mankind (judging
by the performance crap that is out there), I actually know what performs
well, and I can calculate how much space we waste, and I actually _did_ do
so, and chose a reasonably intelligent middle ground.

You can bicker about the details (should it be 9 bits? should we pack the
names more densely? should we use another algorithm for compression? why
does it bother to use ASCII headers?), but please realize that those are
_details_. And even then, they are details where I bet that I have
selected pretty reasonable initial values.

So my choices may not be optimal, but they are "reasonable across a wide
variety of different parameters". And that includes project size,
filesystem implementation, disk wastage etc etc.

The only "extreme" choice I actually made was to go with the highest
compression level of zlib. I think I made the right choice there too: it
wastes CPU-time, but it's still pretty cheap(*) and keeps getting cheaper.  
And we have a much higher read-to-write ratio that most other systems
have.

(*) I'll also argue that one reason even "-9" is cheap is actually that
most of the files we compress are small. All the metadata files are really
quite small, and most source-files tend to be just a few kB in size too -
I personally believe that _big_ files tend to be things that really change
quite seldom (things with big tables like firmware files etc). And for a
small file, it doesn't actually matter that much, the compression window
just can't grow too much.

So people say that "gzip -9" is expensive, but it's really expensive only
for large files. Try it out, it's just a personal pet theory of mine. But
realize that I _do_ generally think things through. I don't just cobble
together random things. There's a real _reason_ why git runs like a bat
out of hell. It was _designed_.

			Linus
