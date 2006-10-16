From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 08:47:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
References: <87slhopcws.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 17:48:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZUgp-0003wf-Cd
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 17:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWJPPrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 11:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWJPPrj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 11:47:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161004AbWJPPri (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 11:47:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GFlWaX003594
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 08:47:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9GFlVXE017752;
	Mon, 16 Oct 2006 08:47:31 -0700
To: Jim Meyering <jim@meyering.net>,
	Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <87slhopcws.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-0.474 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28964>


Davide? I'm quoting the whole report, because I suspect you don't follow 
the git lists, and this is all original libxdiff code.

Jim: the annotation failure _may_ just be due to a "valid" diff change 
(there is not always a unique correct answer for a diff, and so two 
different diff algorithms can validly give two different answers, which 
will also mean that git-annotate/blame would give different explanations). 

But it could certainly also be that you just broke the diffs entirely, so 
I would like to wait for Davide to comment on your diff before Junio 
should apply it. 

Others may be intimately familiar with the diff algorithms too, of course. 
It just scares me personally ;)

		Linus

On Mon, 16 Oct 2006, Jim Meyering wrote:
>
> [using very latest code, built an hour ago:
>  git version 1.4.3.rc3.gb32db-dirty ]
> 
> I found that git-diff-tree is *very* slow when processing files with
> many changes.  The offending example involves comparing the configure
> file from coreutils-6.3 with that from the latest coreutils development
> sources.  Both are over 50k lines long, and the diff -u output is almost
> 50k-lines long, divided into ~700 hunks.
> 
>   http://meyering.net/code/git-perf/configure.gz
>   http://meyering.net/code/git-perf/configure-curr.gz
> 
> Comparing them with "diff -u" takes about 0.3s.
> Putting them in a git repo (uncompressed, and with the same name,
> of course) and comparing with git-diff-tree takes over a minute.
> That's 200 times slower.
> 
> I traced the problem to xdiff/xprepare.c's xdl_cleanup_records function.
> Each of its two doubly-nested loops ends up running the inner-loop
> code more than 2 *billion* times.
> 
> That seems to be due to the two typos fixed by this patch:
> With this patch, my "git-diff-tree --no-commit-id -r -p 2c2172"
> command completes in just 2 seconds.
> 
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 1be7b31..e5438a9 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -381,7 +381,7 @@ static int xdl_cleanup_records(xdfile_t
>  		hav = (*recs)->ha;
>  		rhi = (long) XDL_HASHLONG(hav, xdf2->hbits);
>  		for (nm = 0, rec = xdf2->rhash[rhi]; rec; rec = rec->next)
> -			if (rec->ha == hav && ++nm == mlim)
> +			if (rec->ha == hav || ++nm == mlim)
>  				break;
>  		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
>  	}
> @@ -392,7 +392,7 @@ static int xdl_cleanup_records(xdfile_t
>  		hav = (*recs)->ha;
>  		rhi = (long) XDL_HASHLONG(hav, xdf1->hbits);
>  		for (nm = 0, rec = xdf1->rhash[rhi]; rec; rec = rec->next)
> -			if (rec->ha == hav && ++nm == mlim)
> +			if (rec->ha == hav || ++nm == mlim)
>  				break;
>  		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
>  	}
> 
> However, that change causes the t800*.sh (14,16,18) annotate/blame
> tests to fail, so take it with a grain of salt.
> 
> I.e., running one of them manually gave this:
> 
>     $ sh t8001-annotate.sh --immediate --verbose
>     * expecting success: check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1
>     Author A (expected 2, attributed 2) good
>     Author B1 (expected 2, attributed 1) bad
>     Author A U Thor (expected 1, attributed 2) bad
>     Author B2 (expected 1, attributed 1) good
>     Author B (expected 1, attributed 1) good
>     * FAIL 14: Two lines blamed on A, one on B, two on B1, one on B2, one on A U Thor
>             check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1
>     [Exit 1]
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
