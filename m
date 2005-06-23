From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 19:28:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42BA18AF.2070406@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 04:21:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlHLa-00015A-3t
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 04:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVFWC1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 22:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVFWC1q
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 22:27:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261818AbVFWC0o (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 22:26:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N2QejA014462
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 19:26:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N2QdAs021089;
	Wed, 22 Jun 2005 19:26:40 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BA18AF.2070406@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
> The output isn't terribly helpful:

Yeah. The good news is that if something bad happens, it surely lets you 
know, and it's very verbose about that.

I should probably remove the "Fragment applied at offset xx" thing, it was 
basically a debugging message to make sure that I applied patch fragments 
correctly even if the line offset given in the patch was sligthly off..

> Outputting the following (stolen from 'git commit') would be far more 
> useful:
> 
>        modified: Documentation/networking/cxgb.txt
>        modified: drivers/net/chelsio/Makefile
>        deleted:  drivers/net/chelsio/ch_ethtool.h
>        modified: drivers/net/chelsio/common.h
>        modified: drivers/net/chelsio/cphy.h
>        modified: drivers/net/chelsio/cpl5_cmd.h
>        modified: drivers/net/chelsio/cxgb2.c
>        deleted:  drivers/net/chelsio/cxgb2.h
>        modified: drivers/net/chelsio/elmer0.h
>        modified: drivers/net/chelsio/espi.c
>        modified: drivers/net/chelsio/espi.h
>        modified: drivers/net/chelsio/gmac.h
>        modified: drivers/net/chelsio/mv88x201x.c
>        deleted:  drivers/net/chelsio/osdep.h
>        modified: drivers/net/chelsio/pm3393.c
>        modified: drivers/net/chelsio/regs.h
>        modified: drivers/net/chelsio/sge.c
>        modified: drivers/net/chelsio/sge.h
>        modified: drivers/net/chelsio/subr.c
>        modified: drivers/net/chelsio/suni1x10gexp_regs.h
>        deleted:  drivers/net/chelsio/tp.c
>        deleted:  drivers/net/chelsio/tp.h
>        modified: include/linux/pci_ids.h

How about this patch? Then you can say

	git-apply --stat --summary --apply --index /tmp/my.patch

and it will not only apply the patch, but also give a diffstat and a
summary or renames etc..

This also removes the "Fragment.." debugging message.

Btw, "--stat" and "--summary" normally turn off the "apply" flag, so 
"--apply" has to come _after_ the stat/summary thing, fwiw:

diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -860,7 +860,6 @@ static int find_offset(const char *buf, 
 		n = (i >> 1)+1;
 		if (i & 1)
 			n = -n;
-		fprintf(stderr, "Fragment applied at offset %d\n", n);
 		return try;
 	}
 
@@ -1434,6 +1433,10 @@ int main(int argc, char **argv)
 			check_index = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--apply")) {
+			apply = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--show-files")) {
 			show_files = 1;
 			continue;

> > Also, you can do
> > 
> > 	git commit <list-of-files-to-commit>
> > 
> > as a shorthand for
> > 
> > 	git-update-cache <list-of-files-to-commit>
> > 	git commit
> > 
> > which some people will probably find more natural.
> 
> It would be natural if it functioned like 'bk citool' ;-)
> 
> 	git commit --figure-out-for-me-what-files-changed
> 
> 'git diff' can do this, so it's certainly feasible.

Well, it _does_ do that. That's what the "git status" thing does, and look 
at the initial commit message comments that it prepares for you: it tells 
you which files are modified but haven't been marked for check-in etc.

But the thing is, you need to have a graphical tool for that. I don't want
to have some silly command line that asks for each modified file whether
you want to include that file in the commit or not.

So this is where "git" ends, and a nice user interface (written by 
somebody else than me) begins. Ie this is a cogito-like thing.

> > "git-whatchanged" is useful if you actually want to see what the commits 
> > _changed_, and then you often want to use the "-p" flag to see it as 
> > patches. Also, it's worth pointing out the fact that you can limit it to 
> > certain subdirectories (or individual files) etc, ie:
> > 
> > 	git-whatchanged -p drivers/net
> > 
> > since that is often what people want.
> > 
> > But if you just want the log, "git log" is faster and simpler and more 
> > correct.
> 
> I usually want just two things:
> 
> 1) browse the log
> 
> 2) list changes in local tree that are not in $remote_tree, a la
> 	bk changes -L ../linux-2.6
> 
> I agree that seeing the merge csets is useful, that is why [being 
> ignorant of 'git log'] I used git-changes-script.

For (1) "bk log" is good. For (2) you'll have to use your own script, or
just have the remote tree as a branch in the same tree, in which case you
can do

	git log remotebranch..mybranch

and it will do what you expect. In fact, since "HEAD" is the default 
branch for the final one, you can do

	git log remotebranch..

and you'll get the log of everything that is in your HEAD but it _not_ in 
the "remotebranch" branch.

Btw, if you have the remote as a branch in your own tree, you can also do

	gitk remotebranch..mybranch

which is a really nice way of graphically seeing "what is in 'mybranch' 
that is not in 'remotebranch'".

			Linus
