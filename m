From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect is magical
Date: Tue, 10 Jan 2006 11:42:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101131540.4939@g5.osdl.org>
References: <dpuoqf$3rp$1@sea.gmane.org> <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org>
 <dq11c6$g15$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 20:43:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwPOV-000764-Az
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 20:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWAJTm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 14:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWAJTm4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 14:42:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932308AbWAJTm4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 14:42:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0AJgrDZ029185
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 11:42:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0AJgpud010867;
	Tue, 10 Jan 2006 11:42:52 -0800
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dq11c6$g15$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14440>



On Tue, 10 Jan 2006, walt wrote:
> 
> Yesterday (while reading the bisect HOWTO) I did a git-revert on the
> 'bad' commit, which indeed fixed my bug.  But this caused a problem
> this morning when I did my daily 'cg-update' for the kernel.
> 
> I got a merge conflict (of course) because of yesterday's git-revert.

Well, it's not "of course". It might have merged fine, and to some degree 
you were just unlukcy that it created a conflict with new development), 
but yes, it will now always be a _merge_ rather than a fast-forward, as 
your tree was now different from my historical tree.

> My question (I think) is:  exactly what did I change when I did the
> git-revert?

You can think of a "git revert" as being just a "apply the reverse of that 
one diff, and commit it". So a "git revert" really just add a _new_ 
commit, it never _removes_ anything.

(That's fundamental: in a distributed system you can't undo history).

Now, strictly speaking "git revert" actually does something much smarter 
than just apply the diff in reverse - which means that it works better if 
other things have changed in that area - but if you think of it as the 
"commit the diff in reverse" case, you'll be thinking the right way.

>  I notice in retrospect that (in refs/heads) master is
> no longer identical to origin.  I think (but I'm not certain) that
> the two used to be the same.  (For example, in my 'git' repository
> the 'master' and 'origin' files are identical.)

Exactly.

Do a "git-whatchanged -p", and you'll see what your "git revert" did.

> Did the git-revert change my local kernel repository permanently?

Yes.

You can _undo_ the revert, so it's not permanent in that sense. Just do

	git reset --hard origin

and your "master" branch will be forced back to the state that "origin" 
was in.

> Did the merge-conflict prevent today's cg-update from updating my
> local repository with your commits from the last 24 hours?  Or is
> the merge conflict only with my currently checked-out-and-modified
> copy of the repository?

I'm not sure. It could be either, you don't tell what the conflict message 
is.

If the conflict message is

	Entry 'xyzzy' not uptodate. Cannot merge.

that means that no merge was even tried, because you had dirty contents in 
your tree, and the merge simply won't touch it. You need to commit the 
dirty state and let the merge try to auto-merge it, or you need to undo 
it so that your tree is clean.

If the conflict message is something like

	CONFLICT (content): merge conflict in xyzzy

that means that the merge _was_ done, but there was a content conflict 
that you need to fix up by hand and finish the merge.

> Is it clear to you why I'm confused? :o)  Most of my muddle is
> because I don't know the definitions of some important words, I
> suspect.

Hey, keep the questions coming. And if something starts making sense, I 
suspect that Junio would be very happy with additions to the Documentation 
subdirectory to try to help others... Hint, hint.

		Linus
