From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Darcs-git pulling from the Linux repo: a Linux VM
	question
Date: Wed, 27 Apr 2005 08:31:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504270823480.18901@ppc970.osdl.org>
References: <7i7jionz5q.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Wed Apr 27 17:26:01 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQoOp-0006zY-9L
	for gcvdd-darcs-devel@m.gmane.org; Wed, 27 Apr 2005 17:24:27 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DQoTu-0000rH-HW; Wed, 27 Apr 2005 11:29:42 -0400
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by abridgegame.org with esmtp (Exim 4.50) id 1DQoTs-0000mz-MM
	for darcs-devel@darcs.net; Wed, 27 Apr 2005 11:29:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RFTcs4015825
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 08:29:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RFTbuJ020057;
	Wed, 27 Apr 2005 08:29:38 -0700
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7i7jionz5q.fsf@lanthane.pps.jussieu.fr>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net



On Wed, 27 Apr 2005, Juliusz Chroboczek wrote:
> 
> So yes, in the longer term we need to fix Darcs.  For now, does anyone
> know how I can tune the Linux VM to get a 720 MB process to run
> reliably in 640 MB of main memory?

I really think you're screwed. The only way you have even a _chance_ of
getting it to work well is that if you have very nice access patterns to
that 720MB, but my guess is that that simply isn't the case. You probably
read most of it in once (and write out changes once, but I hope you at
least notice the case of "nothing changed" so that probably is the smaller
of your problems), and the fact is, you're going to have absolutely
_horrible_ access patterns, since you'll end up not just with a 720MB
process that doesn't have much locality, you'll end up with another 720MB
that you needed to have in the page cache for the IO.

The only way I can see to fix it short-term is to try to use "mmap()"  
instead of "read()" to read the file data, and then try to avoid touching
the mapping unless you _have_ to. In other words: if you actually need to
_compare_ the data (which obviously reads from the mapping), you're
screwed.

Using mmap() will at least mean that the system can re-use the page cache 
pages, though, so it should improve memory pressure a bit.

> So what was it you said about self-tuning VM systems?

The kernel tries to tune itself in the sense that it automatically 
allocates the memory to user processes vs caching (page cache, directory 
caching etc) and tunes itself quite well that way.

But there's no way to tune for crappy access patterns and working sets
bigger than the amount of RAM. Sorry. You really need to fix darcs.

You _really_ shouldn't read in files that you don't absolutely need.  
That's really the biggest point of git: using the sha1 for naming the
objects is really all about "descrive the contents using 20 bytes instead
of by reading the contents". Because reading the content _will_ be
expensive. Even if you have 2GB of memory and you can keep it all cached,
it will be horribly expensive.

		Linus
