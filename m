From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: naive question
Date: Tue, 19 Apr 2005 10:41:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191036560.19286@ppc970.osdl.org>
References: <16997.222.917219.386956@cargo.ozlabs.ibm.com>
 <20050419171534.GH12757@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:36:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwdH-00061f-RT
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVDSRjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVDSRjg
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:39:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:30924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261433AbVDSRj3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 13:39:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JHdNs4031279
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 10:39:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JHdLao021025;
	Tue, 19 Apr 2005 10:39:22 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419171534.GH12757@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Petr Baudis wrote:
> 
> I'd actually prefer, if:
> 
> (i) checkout-cache simply wouldn't touch files whose stat matches with
> what is in the cache; it updates the cache with the stat informations
> of touched files

Run "update-cache --refresh" _before_ doing the "checkout-cache", and that 
is exactly what will happen.

But yes, if you want to make checkout-cache update the stat info (Ingo 
wanted to do that too), it should be possible. The end result is a 
combination of "update-cache" and "checkout-cache", though: you'll 
effectively need to both (just in one pass).

With the current setup, you have to do

	update-cache --refresh
	checkout-cache -f -a
	update-cache --refresh

which is admittedly fairly inefficient.

The real expense right now of a merge is that we always forget all the
stat information when we do a merge (since it does a read-tree). I have a
cunning way to fix that, though, which is to make "read-tree -m" read in
the old index state like it used to, and then at the end just throw it
away except for the stat information.

		Linus
