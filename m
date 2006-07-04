From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 3 Jul 2006 22:36:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607032213030.12404@g5.osdl.org>
References: <1151949764.4723.51.camel@neko.keithp.com> 
 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>  <1151973438.4723.70.camel@neko.keithp.com>
  <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>  <1151985747.4723.102.camel@neko.keithp.com>
  <Pine.LNX.4.64.0607032115340.12404@g5.osdl.org> <1151989503.4723.126.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 07:36:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxdaA-0005Jw-EV
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 07:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWGDFgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 01:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWGDFgT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 01:36:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751075AbWGDFgS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 01:36:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k645aFnW020305
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 22:36:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k645aFex018715;
	Mon, 3 Jul 2006 22:36:15 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1151989503.4723.126.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23251>



On Mon, 3 Jul 2006, Keith Packard wrote:
> 
> 5 Start:                             21:59:01.584648000
> 66 After args:                       21:59:01.605987000
> 248 fetch_main() start:              21:59:02.408559000
> 339 fetch_main() before fetch-pack:  21:59:03.293228000
> 387 fetch_main() done:               21:59:04.784388000
> 422 After tag following:             21:59:05.311439000
> 438 All done:                        21:59:05.315338000
> 
> fetch-pack itself took 0.421 seconds (measured with time(1)).
> 
> Looks like the bulk of the time here is caused by simple shell
> processing overhead, some of which scales with the number of heads and
> tags to track.

Ahh.. Do you have tons of tags at the other end?

Looking closer, I suspect a big part of it is that

	git-ls-remote $upload_pack --tags "$remote" |
	sed -ne 's|^\([0-9a-f]*\)[      ]\(refs/tags/.*\)^{}$|\1 \2|p' |
	while read sha1 name
	do
		..
	done

loop.

With a lot of tags, the shell overhead there can indeed be pretty 
disgusting. And I was wrong - I thought it would do that git-ls-remote 
only if the first time around we noticed that we would need to, but we do 
actually do it all the time that we're fetching any new branches. 

The sad part is that we really already got the list once, we just never 
saved it away (ie "git-fetch-pack" actually _knows_ what the tags at the 
other end are, and also knows which tags we already have, so if we made 
git-fetch-pack just create that list and save it off, all the overhead 
would just go away).

And yes, the shell script loops are really really simple, but some of them 
are actually quadratic in the number of refs (O(local*remote)). If this 
was a C program, we'd never even care, but with shell, the thing is slow 
enough that having even a modest amount of tags and refs is going to just 
make it waste a lot of time in shell scripting.

We already do a lot of the infrastructure for "git fetch" in C - the 
remotes parsing etc is all things that "git fetch" used to share with "git 
push", but "git push" has been a builtin C program for a while now. I 
suspect we should just do the same to "git fetch", which would make all 
these issues just totally go away.

			Linus
