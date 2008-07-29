From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: q: git-fetch a tad slow?
Date: Mon, 28 Jul 2008 22:50:14 -0700
Message-ID: <20080729055014.GE11947@spearce.org>
References: <20080728160138.GA12777@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:51:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNi7c-0003SC-6C
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733AbYG2FuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756431AbYG2FuR
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:50:17 -0400
Received: from george.spearce.org ([209.20.77.23]:50941 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbYG2FuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:50:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CA1A1383A5; Tue, 29 Jul 2008 05:50:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080728160138.GA12777@elte.hu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90582>

Ingo Molnar <mingo@elte.hu> wrote:
> 
> Setup/background: distributed kernel testing cluster, [...]
> 
> Problem: i noticed that git-fetch is a tad slow:
> 
>   titan:~/tip> time git-fetch
>   real    0m2.372s
> 
> There are hundreds of branches, so i thought fetching a single branch 
> alone would improve things:
> 
>   titan:~/tip> time git-fetch origin master
>   real    0m0.942s
>
> But that's still slow - so i use a (lame) ad-hoc script instead:
> 
>   titan:~/tip> time tip-fetch
>   real    0m0.246s

OK, yes, when there are _many_ branches like that limiting fetch
to a narrow focus of only the branch(es) you must have can make it
go much faster.  Part of the problem is we loop over the branches
many times, and those are O(N) loops (N=number of branches).  We
could do better, but we don't.

One reason why your tip-fetch runs so much better is because we don't
have to enumerate the hundreds of advertised branches offered up by
the remote peer to find the one you want to fetch.  Your tip-fetch
is reading only that one ref file (.git/refs/heads/master) and
that's pretty much it.

In contrast git-upload-pack on the server side must open and read
_all_ ref files under .git/refs/ and send them to the client, who
then has to loop over them at least twice before it can decide if
a match exists.  That's a lot more data to shove down over SSH.
Granted its only 42 bytes + refname per ref, but its still more.

Those O(N) loops I referred to earlier can explain why for hundreds
of branches it gets ugly.  That turns into an O(N^2) matching
algorithm.  Not pretty.  A simple hash would solve a lot of that,
changing the first time from 0m2.372s to much closer to the scond
time of 0m0.942s.

Neither of which can compete with your tip-fetch.

Have you tried using git-pack-refs to pack the branches on the
remote repository?

If you update all of the branches, run `git pack-refs --all --prune`,
then allow the testing clients to start fetching it may go much
quicker.  The pack-refs moves all of the individual ref files into
the single .git/packed-refs file, reducing the number of files we
need to open and read to service a single fetch client.

I wonder if git-pack-refs + fetching only a single branch will get
you closer to the tip-fetch time.

Also, I wonder if you really need to fetch over SSH.  Doing a
fetch over git:// is much quicker, as there is no SSH session
setup overheads.

-- 
Shawn.
