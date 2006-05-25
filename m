From: Junio C Hamano <junkio@cox.net>
Subject: Re: file name case-sensitivity issues
Date: Thu, 25 May 2006 11:17:48 -0700
Message-ID: <7vac96ufxv.fsf@assigned-by-dhcp.cox.net>
References: <20060523210615.GB5869@steel.home>
	<7v7j4c4af3.fsf@assigned-by-dhcp.cox.net>
	<20060525154735.GA6119@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 20:17:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjKPB-0002hq-0K
	for gcvg-git@gmane.org; Thu, 25 May 2006 20:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWEYSRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 14:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWEYSRu
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 14:17:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12792 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030319AbWEYSRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 14:17:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525181748.WJAX19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 14:17:48 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060525154735.GA6119@steel.home> (Alex Riesen's message of
	"Thu, 25 May 2006 17:47:35 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20752>

fork0@t-online.de (Alex Riesen) writes:

> ... Besides, how about when you
> don't _know_, like when cloning onto an usb-stick mounted with
> auto-detection? Will the files with case-different names just
> overwrite each other?

You _do_ realize that example is bogus, don't you?  At least I
hope you did after you sent it.

You are cloning a project that has mixed cases (say foo and FOO)
onto a case challenged filesystem but unfortunately you did not
know the filesystem was case challenged in advance.  So after
the cloning, your checkout results in only one file either foo
or FOO but not both, because you cannot have two files whose
names are different only in case on such a filesystem.

Tough.

There are some other problems on case challenged filesystems
that we _could_ solve but we probably don't right now.  You
could concentrate on fixing those, instead of talking about
unfixable.


There are probably 2 kinds of case-challenged-ness.  On non
case-challenged filesystems, if I say "rm -f foo Foo; echo >foo;
echo >Foo", "ls" says "foo Foo".  On case-challenged systems,
one of the following would happen:

 * "ls" says "foo".  If I swap the order of the "echo", it says
   "Foo".  The filesystem does record the case but does not
   allow two names with only case difference.

 * "ls" says ef oh oh in a case different from either "foo" nor
   "Foo".  Or it says "foo" but if I swap the order of the
   "echo", it still says "foo".  The filesystem does not record
   the case, and does not allow two names with only case
   difference.  readdir() may do some heuristics such as
   lowercasing the name, but the point is the returned string is
   unrealiable.

I have git installed on a Cygwin on NTFS at work, and I think it
is in the former category.  git seems to work as expected,
modulo that you obviously cannot have two files "foo" and "Foo"
in your git-managed project.  Probably a patch to delete "Foo"
and create "foo" (to make your project friendlier to Windows)
and a merge to do the same would work well, though I haven't
tried.

What breaks on filesystems in the latter category?  I suspect
not many.

update-index records the names given by the user (I am assuming
that at least the shell is case sensitive), uses that name to
stat() and open() to update and/or refresh the cache entry, so
that codepath should be OK.  Anything that goes from index to
find names and then goes to the filesystem with those names
(diff family, checkout-index and read-tree -u) should be fine.

ls-files -o/-i would have a hard time, since they need to work
with strings read from readdir(), as you found out.  That means
"git add" and "git clean" may not work.

I do not think of anything else that is affected by readdir()
breakage offhand; the core is doing pretty fine as it is (I do
not consider ls-files -o/-i a core -- that is more Porcelainish
part of the whole package).

I honestly think that on Windows people would not even want to
use the core Porcelainish nor even Cogito.  The would want a
native Window-ish UI that drives the core.  I do not think such
a program would internally call "git add" nor read from
"ls-files -o/-i".  It would instead do its own Folder hierarchy
traversal, and use "update-index --add --remove" to implement
its own "git add/rm" UI, and read from "ls-files" (not -o nor
-i) so that it can show tracked and untracked files differently
in its Explorer view.

So in that sense, I think ls-files -o/-i issue is quite low
priority.  It does not matter on sane filesystems, and in the
place where it matters the most, the desired solution does not
involve ls-files -o/-i working well there.

Having said that, I think you _could_ have a repository
configuration that says "this repository sits on a case
challenged filesystem", and update ls-files to munge what it
gets from readdir() by comparing them against what you have in
the index.  If your readdir() gives "foo" when you have "FOO" in
the index on such a filesystem, you do not say that "foo" is an
untracked file -- you just say you found "FOO" as you expected.
