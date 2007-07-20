From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Fri, 20 Jul 2007 10:41:53 +0200
Message-ID: <86hcnzxy9a.fsf@lola.quinscape.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <85d4yqz24s.fsf@lola.goethe.zz> <7vhco28aoq.fsf@assigned-by-dhcp.cox.net> <200707201029.10358.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 10:42:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBo3w-0001GG-Ct
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 10:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbXGTImJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 04:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbXGTImI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 04:42:08 -0400
Received: from main.gmane.org ([80.91.229.2]:60064 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbXGTImG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 04:42:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBo3n-0008Jj-NL
	for git@vger.kernel.org; Fri, 20 Jul 2007 10:42:03 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 10:42:03 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 10:42:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:rYq5JEzIyy7ebL2G5X9X5DQpv4E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53071>

Johan Herland <johan@herland.net> writes:

> On Wednesday 18 July 2007, Junio C Hamano wrote:
>> Didn't I say I do not have an objection for somebody who wants
>> to track empty directories, already?  I probably would not do
>> that myself but I do not see a reason to forbid it, either.
>> 
>> The right approach to take probably would be to allow entries of
>> mode 040000 in the index.  Traditionally, we allowed only 100644
>> (blobs as regular files) and 120000 (blobs as symlinks).  We
>> recently added 160000 (commit from outer space, aka subproject).
>> 
>> And we do that for all directories, not just empty ones.  So if
>> you have fileA, empty/, sub/fileB tracked, your index would
>> probably have these four entries, immediately after read-tree
>> of an existing tree object:
>
> Sorry for jumping in late...

It could have given you a chance to read up on what has already been
discussed.

> Why do you want to add _all_ directories, and not just the ones we
> want to explicitly track (independent of whether they're empty or
> not).

Because the problematic cases are more often than not the _implicit_
cases.  Do you check a directory tree for empty directories before you
archive it?  In order to archive every empty directory explicitly?

If you did that, you could equally maintain a script that manually
does mkdir/rmdir.

> Basically, add a "--dir" flag to git-add, git-rm and friends, to
> tell them you're acting on the directory itself (rather than its
> (recursive) contents). "git-add --dir foo" will add the "040000
> 123abc... 0 foo" to the index/tree whether or not foo is an empty
> directory. "git-rm --dir foo" will remove that entry (or fail if it
> doesn't exist), but _not_ the contents of foo.

There is nothing wrong with implementing something like this in
_addition_ to treating directory entries implicitly.  For example, ls
has an option -d which does just that, and even git-ls-files has an
option --directory.  Heck, I even have

rm --help
Usage: rm [OPTION]... FILE...
Remove (unlink) the FILE(s).

  -d, --directory       unlink FILE, even if it is a non-empty directory
                          (super-user only; this works only if your system
                           supports `unlink' for nonempty directories)
[...]

which works on just the directory and not on the contents.

So a --directory option for appropriate commands would be natural for
_explicit_ manipulation of such entries.

But the important, the _really_ important thing are the implicit
behaviors.  If I have to hassle with every directory myself, I don't
need a content tracking system.

The --directory stuff, in contrast, are things nice to have when the
framework is in place (and may be even necessary for some direct
manual maintenance tasks), but they don't really concern the
framework.

-- 
David Kastrup
