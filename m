From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: proper lazy reachability
Date: Sat, 4 Jun 2005 08:42:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506040837190.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
 <17052.21846.816147.370354@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org>
 <Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org> <7vekbigo8q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 17:37:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeaiS-0003WO-FZ
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 17:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFDPk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 11:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFDPk4
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 11:40:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:45753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbVFDPkr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 11:40:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j54FegjA016556
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Jun 2005 08:40:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j54Fef3C026351;
	Sat, 4 Jun 2005 08:40:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekbigo8q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 4 Jun 2005, Junio C Hamano wrote:
>
> Linus, what do you think rev-list should do given HEADs from two
> forks, like this?
> 
>     JC          git-rev-list JC LT ????
>      |
>      |  LT
>      |   |
>       \ /
>        |
>        |
>        |

Ahh. Ok, I'll fix it. Indeed, I think it should give everything up to the 
merge base.

> Current "proper lazy reachability" version, btw, does something
> very unexpected for my use pattern.  If you have more than one
> commits between the fork point and LT HEAD in the above picture,
> everything from the beginning of time to JC is given, or
> something silly like that.

Yes. The whole thing is written to literally expect to see the "stop here" 
thing, and that's when it starts poisoning the well.

Does this fix it for you (untested, of course)?

		Linus
---
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -160,6 +160,8 @@ int main(int argc, char **argv)
 		end = lookup_commit_reference(sha1[1]);
 		if (!end || parse_commit(end) < 0)
 			die("bad ending commit object");
+		end->object.flags |= UNINTERESTING;
+		commit_list_insert(end, &list);
 	}
 
 	commit_list_insert(commit, &list);
