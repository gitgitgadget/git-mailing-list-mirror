From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Mon, 2 Apr 2012 19:09:45 -0500
Message-ID: <20120403000945.GA15075@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
 <2148933.pnpYo0xMAP@flomedio>
 <2487557.B8qfnaixh3@flomedio>
 <4F7A258C.5000200@pileofstuff.org>
 <20120402222958.GD13969@burratino>
 <4F7A3450.7000302@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner@student.tugraz.at>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 02:10:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SErKC-00016T-Fd
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 02:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab2DCAKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 20:10:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44965 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab2DCAKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 20:10:06 -0400
Received: by iagz16 with SMTP id z16so4802870iag.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6A2Oz9dZS9fcfsULTWMhT+W91VwrVKYBjNzUXBE6mTw=;
        b=sPBSWixAVKL+14VAotJM7Y37luEc+AEliymU2/HFmuCZVzfHdFVklt0MyqqhAHZQNz
         WUYtW5/NBah5GM30+cR/uk2IYTxQXeBgSLK3MJaHVWM+nJJFx+ND/cA+pjSzWvrqV/cC
         ugxpMHVm5x/jZLYbyWx3i+0jHKkb6jwnIinmt1+pKLkT9VflWssIBUv7C7DXdwYkHWg7
         nwoGAH4eaaDefWOvLoKjAfleD8MMgITm+VSIvlAUFnVZekcoKh/DpgqkUP5F6uz2jTbN
         7FfzzA+zCXOnK/9whRZwEJRO4v9vn9otNQd007+ZkY/zGfG9OF8ZXu/FEzQ9Dehh1XYX
         fCAw==
Received: by 10.50.89.233 with SMTP id br9mr7218902igb.48.1333411804032;
        Mon, 02 Apr 2012 17:10:04 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id en8sm9788985igc.7.2012.04.02.17.10.02
        (version=SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 17:10:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7A3450.7000302@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194581>

Andrew Sayers wrote:

> Sorry, that wasn't clear.  I meant commands that just expose a single
> primitive bit of functionality (like git-commit-tree) instead of those
> that present an abstract interface to the whole git machinery (like
> git-fast-import).

Ok.  I think you are misunderstanding the purpose of fast-import[1] but
it doesn't take away from what you're saying.

> I agree it's possible to use fast-import for this problem, but it seems
> like it's redundant after svn-fe has already loaded everything into git.

Right, I missed your point here before.  The fundamental question is
not about what commands to use but about the order of operations.

1. In one scheme, first you import the whole tree without splitting it
   into branches, with a tool like svn-fe.  Afterwards, you
   postprocess the resulting repository with tools like "git
   filter-branch --subdirectory-filter".  The result of the import can
   depend on all revisions --- you can say, in rev 1, "I'm not sure
   whether this new directory is a branch; let me see how it develops
   by rev 1000 to decide how to process it".

2. In another scheme, you only import the subset of the repository
   you are interested in.  This is what git-svn does, for example.
   This requires the branch discovery to happen at the same time as
   the import, because otherwise there is no way to tell what subset
   of the repository you are actually interested in.

3. Lastly, in yet another scheme, you import the whole tree and it is
   split into branches on the fly.  The advantages relative to (1) are:

   - impatient people can peek at the partial result of the import as
     it happens

   - the result of importing rev n is guaranteed to depend only on
     revs <= n, so different people importing at different times will
     get the same commits (assuming nobody is rewriting early history
     behind the scenes) and it is obvious how to support incremental
     importants to expand a repository with all revs <= n to a
     repository with all revs <= 2n

   However, if splitting branches only can happen during the initial
   import, that makes it harder to tweak the configuration and try
   again to see what changes.

The relevant technical difference is that in the naive implementation
of scheme (2) you can make use of arbitrary information available over
svn protocol, in naive scheme (3) you can only use information that
makes it into the fast-import stream, and in naive scheme (1) you can
only use information that makes it into the actual git repository.  So
to use scheme (1) you need to make sure svn-fe stores all interesting
data in a visible way, including copyfrom info (which is not a bad
idea anyway).

[...]
> The point I was making in IRC was that (so far as I understand)
> fast-import doesn't let you pass trees around in this way, but instead
> requires you to transmit the contents of all the changed files.

fast-import's "ls" command allows exactly what you are talking about,
and svn-fe uses it to copy subtrees from earlier revs into later ones
when it receives an "svn cp" command.

See [2] for some work that preexists that.

Did I understand correctly?
Jonathan

[1] By acting as a single process that takes a stream of commands it
really is able to do something that no other plumbing command can do.
[2] http://thread.gmane.org/gmane.comp.version-control.git/158375
