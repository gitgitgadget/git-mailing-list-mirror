From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 18:16:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
 <7vpsjecriu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 03:16:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW1Iy-0003D2-Ja
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 03:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWDSBQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 21:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDSBQT
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 21:16:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16809 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750780AbWDSBQT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 21:16:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3J1GDtH029201
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 18:16:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3J1GBBL002628;
	Tue, 18 Apr 2006 18:16:11 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsjecriu.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18896>



On Tue, 18 Apr 2006, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > 	git diff v0.99.6:git-commit-script..v1.3.0:git-commit.sh
> 
> This is interesting.
> 
> Yet to be born "internal diff".  Should I start one, or are you
> already hacking on it?

I'm not working on it, but I might get back to it if nobody else beats me 
to it.

Probably not in the next few days, though, so if you feel the urge, please 
do look into it.

Anyway, the above syntax would actually work even with the current 
external diff, because with my suggested patch we get:

  git-rev-parse v0.99.6:git-commit-script..v1.3.0:git-commit.sh

resulting in

	01c73bdd08e075d650e58664650bcd7fe1cd1551
	^a2455b0f8ff1582248b0678b9c85b2f064d972c4

(which are just the SHA1's for the object), and then the external diff 
will just see that it's two commits, so it decides to just feed them 
directly into git-diff-tree.

So if we added the test for "are the objects two commits" to git-diff-tree 
and diffed them directly, it would all "just work".

But you're certainly correct in stating that it would be _cleaner_ to do 
it with a internal "git diff" command. Everything should be perfectly set 
up by just calling the regular "setup_revisions()", and looking at the 
"rev.pending_objects" list.

Now, the thing that an internal "git diff" could do better is to notice 
when it gets _one_ blob revision, and one filename, ie we could do

	git diff v0.99.6:git-commit-script git-commit.sh

which parses as one SHA1 of a blob (put onto the rev.pending_objects 
list), and one filename (in the rev.prune_data array). We could decide to 
automatically do the "right thing" for that case too.

		Linus
