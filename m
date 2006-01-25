From: Junio C Hamano <junkio@cox.net>
Subject: Re: Caching directories
Date: Tue, 24 Jan 2006 21:52:21 -0800
Message-ID: <7vvew8zwfe.fsf@assigned-by-dhcp.cox.net>
References: <1138076423.15105.36.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 06:53:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1daW-0007yd-8U
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 06:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWAYFw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 00:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWAYFw1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 00:52:27 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4301 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751031AbWAYFw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 00:52:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125054951.NLHD17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 00:49:51 -0500
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15117>

Pavel Roskin <proski@gnu.org> writes:

> Maybe it's time to start caching directories in git?  I mean,
> directories corresponding to tree objects could have their stats
> recorded in the cache.  This would allow to distinguish between tracked
> and untracked directories without scanning them recursively.

I do not understand the above logic.  

Given a directory path, finding out if the directory has
something tracked in it is an O(log n) operation in the current
index that does not "cache directory".  Your message implies
that you feel we could use the index file to list "untracked
directories" without recursively scanning the directory tree,
but to me, the only way to do that is to record a new directory
in the index file every time somebody (either Makefile or the
user) creates a junk directory.  That does not make much sense
to me, so I am probably misreading what you really meant.

I've been meaning to explore the possibility of recording 0{40}
SHA1 in the index file to mean "I do not want to place anything
on this path when I write the index out to a tree yet, but keep
an eye on the path in the working tree for me".

You can consider this as an "intent to add"; for example, with
such an index file, you could do something like this:

	$ git update-index --intent-to-add foo

This would record 0^{40} SHA1 with the 0 mode in the index at
"foo".  Then:

        $ git diff-files -p
        diff --git a/foo b/foo
        new file mode 100644
        index 0000000..6690023
        --- /dev/null
        +++ b/foo
        @@ -0,0 +1,24 @@
        +...
        +....
        ...

The index has heard about it, but does not actually have it, so
it reports an addition.  Since we currently do not have such,
after a "git add", the index not just has heard about it, but
actually has it, and as a consequence, there is no way to get
"new file" out of diff-files.

	$ git diff-index --cached HEAD ;# nothing

The index has heard about it, but does not have it.  If the HEAD
commit did not have it, diff-index --cached would report
nothing.

        $ git diff-index HEAD
        diff --git a/foo b/foo
        new file mode 100644
        index 0000000..6690023
        --- /dev/null
        +++ b/foo
        @@ -0,0 +1,24 @@
        +...
        +....
        ...

The index has heard about it, and without --cached it uses the
working tree file, so if HEAD did not have it you would see "new
file" out of diff-index.  If the comparison were with a tree
that has "foo" in it, diff-index using an index that does not
have "foo" would not say anything in the current system, but
with "intent to add", it would say "Oh, your index knows about
it so let me look in the working tree; ah, you have something
there.  Let me compare it with the version in the tree in
question".

One interesting thing the "intent to add" entries would do is
this:

        $ git diff-files --abbrev foo
        :000000 100644 0000... 0000...

Note that two "0^{40}" mean quite different things.  The one on
the LHS means "we've heard about it but we do not have it".  On
the other hand, the one on the RHS means "we do not cache the
SHA1 --- go look at the working tree file".

We might want to represent the existence of a tree that does not
have anything under using 0^{40} as well.  Or it might be better
kept out of the main index entries list, and become extra data
just like we have been discussing how to store "bind" entries in
the "Subprojects" thread.  I dunno.

I have no idea what 'clean' does, so would not comment on that
part of your message.
