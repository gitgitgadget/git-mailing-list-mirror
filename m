From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Version of dirdiff to display diffs between git trees
Date: Fri, 6 May 2005 12:07:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505061200060.2233@ppc970.osdl.org>
References: <17019.28326.351036.268948@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0505060916320.2233@ppc970.osdl.org> <m3d5s4jieh.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 20:59:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU82b-00032c-Cb
	for gcvg-git@gmane.org; Fri, 06 May 2005 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVEFTFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEFTFo
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 15:05:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:47328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261268AbVEFTFf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 15:05:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46J5RU3018093
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 12:05:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46J5QRW024723;
	Fri, 6 May 2005 12:05:26 -0700
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m3d5s4jieh.fsf@defiant.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, Krzysztof Halasa wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > 	cat .git/ORIG_HEAD > .git/HEAD
> > 	git-read-tree -m HEAD
> > 	git-checkout-cache -f -a
> > 	git-update-cache --refresh
> >
> > and you're back to your original head (the above is basically "unpull").
> 
> So, is "git-read-tree -m HEAD" actually equivalent to "git-read-tree HEAD"
> and does it simply write complete index (ignoring the old one)
> corresponding to given HEAD?

Yes, "git-read-tree -m HEAD" is 100% equivalent to the version without
"-m" except: that it reads the old index file, and picks up the file stat
information from there if the name/SHA1 pair matches.

This has two implications:

 - "git-read-tree -m HEAD" is a lot better than the non "-m" version, 
   since it means that if most of the files are unchanged between the new
   and the old tree, _most_ of the index is still up-to-date.

   You still need to do "git-update-cache --refresh" to make sure the 
   index is fully up-to-date, but now the refresh has to do a _lot_ less.

 - If your old index file has crap in it, it won't work. If you have a 
   corrupt index file, you can't use "-m". And in particular, if the merge 
   _failed_ and you have unmerged entries in your index file, you can't
   use "-m" (I might change that, and let the single-merge case just 
   ignore unmerged entries).

So the rule is: normally you probably want to use "-m", but if you want to
start from a totally clean slate because something went wrong, you should
skip the "-m" which then does the "reset the whole index" without the
merge of the old index information.

(Also, if the new tree you're reading is totally different from the old 
one, or you don't have anything checked out, you're better off without the 
"-m", since it will just add overhead for no gain).

			Linus
