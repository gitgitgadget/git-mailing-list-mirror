From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 18:43:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181836400.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
 <7vpsjecriu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
 <7vd5fecpyd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 03:43:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW1iy-000657-Rf
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 03:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDSBnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 21:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWDSBnH
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 21:43:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbWDSBnG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 21:43:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3J1h2tH029957
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 18:43:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3J1h0tk004567;
	Tue, 18 Apr 2006 18:43:01 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5fecpyd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18900>



On Tue, 18 Apr 2006, Junio C Hamano wrote:

> > 	git diff v0.99.6:git-commit-script git-commit.sh
> >
> > which parses as one SHA1 of a blob (put onto the rev.pending_objects 
> > list), and one filename (in the rev.prune_data array). We could decide to 
> > automatically do the "right thing" for that case too.
> 
> The "right thing" is ambiguous, I am afraid.
> 
> I think it would be natural to interpret the request as a diff
> between the blob from v0.99.6 and a random working tree file, 
> which may not even exist in the index.

Actually, it's not ambiguous. Just take the named file. If you want to 
diff it against HEAD:<named-file>, you should just say so.

Now, if you _really_ want to be difficult, there's a third option: to diff 
it against the named file as named in the index. "git diff" does have the 
"--cached" option that would make that case unambiguous too, of course.

Ie:

 (a) diff against the current HEAD:

	git diff v0.99.6:git-commit-script HEAD:git-commit.sh

 (b) diff against the current index contents for "git-commit.sh":

	git diff --cached v0.99.6:git-commit-script git-commit.sh

 (c) diff against a random file (which may not even be in the index):

	git diff v0.99.6:git-commit-script git-commit.sh

are all sensible operations, and unambiguous.

The only real downside is that the nice "a..b" syntax doesn't work for 
them, except fot the very first case. That syntax requires both sides to 
be SHA1 names (and while the "index" case could be a SHA1 name, we have no 
way to say so).

> Oh, another possibility is to act as if the user said
> 
> 	git diff v0.99.6:this :git-commit.sh
> 
> where "(empty):" would stand for "look up in the index, not in a
> tree".

That would possibly be a nice extension, yes. But I really did mean 
"random file, possibly not even in the index".

> Unfortunatly, I do not think this parses well:
> 
> 	git diff git-commit.sh v0.99.6:git-commit-script

Correct. As you point out, that would have to be done with -R.

			Linus
