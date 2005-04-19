From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: naive question
Date: Tue, 19 Apr 2005 11:27:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191117570.19286@ppc970.osdl.org>
References: <16997.222.917219.386956@cargo.ozlabs.ibm.com>
 <20050419171534.GH12757@pasky.ji.cz> <Pine.LNX.4.58.0504191036560.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 20:23:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNxM8-0004fP-7Z
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 20:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVDSSZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 14:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVDSSZy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 14:25:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:32472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261516AbVDSSZl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 14:25:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JIPbs4002621
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 11:25:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JIPaFU023290;
	Tue, 19 Apr 2005 11:25:37 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.58.0504191036560.19286@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Linus Torvalds wrote:
> 
> The real expense right now of a merge is that we always forget all the
> stat information when we do a merge (since it does a read-tree). I have a
> cunning way to fix that, though, which is to make "read-tree -m" read in
> the old index state like it used to, and then at the end just throw it
> away except for the stat information.

Ok, done. That was really the plan all along, it just got dropped in the 
excitement of trying to get the dang thing to _work_ in the first place ;)

The current version only does

	read-tree -m <orig> <branch1> <branch2>

which now reads the old stat cache information, and then applies that to 
the end result of any trivial merges in case the merge result matches the 
old file stats. It really boils down to this littel gem;

            /*
             * See if we can re-use the old CE directly?
             * That way we get the uptodate stat info.
             */
            if (path_matches(result, old) && same(result, old))
                    *result = *old;


and it seems to work fine.

HOWEVER, I'll also make it do the same for a "single-tree merge":

	read-tree -m <newtree>

so that you can basically say "read a new tree, and merge the stat 
information from the current cache".  That means that if you do a
"read-tree -m <newtree>" followed by a "checkout-cache -f -a", the 
checkout-cache only checks out the stuff that really changed.

You'll still need to do an "update-cache --refresh" for the actual new
stuff. We could make "checkout-cache" update the cache too, but I really
do prefer a "checkout-cache only reads the index, never changes it"  
world-view. It's nice to be able to have a read-only git tree.

Final note: just doing a plain "read-tree <newtree>" will still throw all
the stat info away, and you'll have to refresh it all...

		Linus
