From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 08:21:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 25 17:21:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYPMA-0006LC-H6
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 17:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWDYPVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 11:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWDYPVf
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 11:21:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932258AbWDYPVf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 11:21:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PFLNtH010591
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 08:21:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PFLMGX027024;
	Tue, 25 Apr 2006 08:21:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19149>



On Tue, 25 Apr 2006, Junio C Hamano wrote:
> 
> How about an ability to "attach" arbitrary objects to commit
> objects?  The commit object would look like:
> 
>     tree 0aaa3fecff73ab428999cb9156f8abc075516abe
>     parent 5a6a8c0e012137a3f0059be40ec7b2f4aa614355
>     parent e1cbc46d12a0524fd5e710cbfaf3f178fc3da504
>     related a0e7d36193b96f552073558acf5fcc1f10528917 key
>     related 0032d548db56eac9ea09b4ba05843365f6325b85 cherrypick

This would at the face of it seem a bit better, but the fact is, it's not.

Without _semantics_ for the different cases, it's just random crud.

What does any of the fields _mean_ to git? In particular, if you cannot 
come up with an _exact_ definition of what they mean for fsck, pull, push, 
and any other random thing (how to show them for logging? How do they 
affect merge bases?), then it's still just random free-form text, and it 
should go into the random free-form section.

> The semantics I would attach to these "related" links are as
> follows:
> 
>  * To the "core" level git, they do not mean anything other than
>    "you must to have these objects, and objects reachable from
>    them, if you are going to have this commit and claim your
>    repository is without missing objects".

Ok, a real semantic meaning. However:

THAT IS COMPLETELY USELESS.

It sure isn't useful for cherry-picking, which so far is one of the only 
"real examples" of where this would actually be used. 

It isn't useful for much anything else either, because you really have two 
cases:

 - the "related" commit is an indirect parent _anyway_ (for things like 
   "revert", this would obviously be the case, since it doesn't generally 
   make a lot of sense to revert something that has never touched your 
   history). In this case, the git semantics end up being NULL, and you 
   just have another relationship that doesn't actually add any new 
   information to the tree.

 - the "related" commit is not actually in the set of _real_ parenthood at 
   all, and actually points to a different branch (or possibly even 
   different project).

   This case I'd sure as hell hate to have for the kernel, at least. I 
   would have to add crap to my workflow to make sure that people do _not_ 
   have these kinds of linkages that link in random parts of their project 
   that doesn't actually have anything to do with the history I'm pulling.

Those are the only two possible cases. Either it's an indirect parent, or 
it isn't. Neither one makes any sense: the first one is a no-op from your 
semantic definition, and the second one is just crazy and you'll just find 
that people have to protect themselves from other developers doing 
something crazy by mistake.

I want the git objects to have clear and unambiguous semantics. I want 
people to be able to explain exactly what the fields _mean_. No "this 
random field could be used this random way" crud, please.

			Linus
