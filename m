From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 3 Jul 2006 20:21:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>
References: <1151949764.4723.51.camel@neko.keithp.com> 
 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <1151973438.4723.70.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 04 05:21:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxbTx-0004pa-JH
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 05:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWGDDVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 23:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWGDDVh
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 23:21:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751302AbWGDDVg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 23:21:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k643LVnW013515
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 20:21:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k643LUbF014455;
	Mon, 3 Jul 2006 20:21:30 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1151973438.4723.70.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23241>



On Mon, 3 Jul 2006, Keith Packard wrote:
> On Mon, 2006-07-03 at 16:14 -0700, Linus Torvalds wrote:
> > 
> > Well, you could use multiple branches in the same repository, even if they 
> > are totally unrealated. That would allow you to fetch them all in one go.
> 
> I'd like to avoid this; the hope is that most people won't ever need to
> look at most repositories; it would be somewhat like having glibc in the
> same repo as the kernel...

Sure, understood. I'm just saying that if you want to fetch in one go, 
it's one possibility.

However, your setup has something else seriously wrong.

> Yeah, I tried with the git protocol and it's a few seconds faster (about
> 14 seconds instead of 17). Ick.

That's -still- about 13 seconds too much.

> I think it might have something to do with the number of heads we're
> tracking.

It really shouldn't matter. You get all the heads in one go with a single 
connection, so if 32 heads takes 32 times longer, there's something wrong.

> > Also, one thing to try is to just do
> > 
> > 	strace -Ttt git-peek-remote ...
> 
> That's plenty fast, 0.410 seconds, with nothing ugly in the strace.

Ok, a "git fetch" really shouldn't take any longer than a single 
connection. However, the fact that you have 32 heads, and it takes pretty 
close to _exactly_ 32 times 0.410 seconds (32*0.410s = 13.1s) makes me 
suspect that "git fetch" is just broken and fetches one branch at a time. 

Which would be just stupid.

But look as I might, I see only that one "git-fetch-pack" in git-fetch.sh 
that should trigger. Once. Not 32 times. But your timings sure sound like 
it's doing a _lot_ more than it should.

Junio, any ideas?

Keithp, can you try this trivial patch? It _should_ say something like

	Fetching
	refs/heads/master
	refs/heads/...
	refs/heads/...
	...
	refs/heads/... from git://..../...

and more importantly, it should say so only once.

And then it should leave a "fetch.trace" file in your working directory, 
which should show where that _one_ thing spends its time.

		Linus

----
diff --git a/git-fetch.sh b/git-fetch.sh
index 48818f8..4739202 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -339,6 +339,8 @@ fetch_main () {
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
       (
+	  echo "Fetching $rref from $remote" >&2
+	  strace -o fetch.trace -Ttt \
 	  git-fetch-pack $exec $keep --thin "$remote" $rref || echo failed "$remote"
       ) |
       while read sha1 remote_name
