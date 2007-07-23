From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Mon, 23 Jul 2007 08:05:02 +0200
Message-ID: <85ps2jeju9.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<200707221406.25541.jnareb@gmail.com> <857iosmto0.fsf@lola.goethe.zz>
	<200707222226.30788.jnareb@gmail.com> <85644cf3mf.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICr2e-0003vm-2p
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 08:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbXGWGFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 02:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbXGWGFH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 02:05:07 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:56020 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754387AbXGWGFF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 02:05:05 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 150912C866B;
	Mon, 23 Jul 2007 08:05:04 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id F1B455BD63;
	Mon, 23 Jul 2007 08:05:03 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-065.pools.arcor-ip.net [84.61.13.65])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id C32353425E7;
	Mon, 23 Jul 2007 08:05:03 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 202DD1D1E182; Mon, 23 Jul 2007 08:05:02 +0200 (CEST)
In-Reply-To: <85644cf3mf.fsf@lola.goethe.zz> (David Kastrup's message of "Mon\, 23 Jul 2007 00\:57\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3740/Mon Jul 23 05:50:50 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53394>

David Kastrup <dak@gnu.org> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> I think it would be best implemented by repository config, e.g.

I got sidetracked here: the gitignore stuff has in the dirmod scheme
actually no code or concept overlap with the actual scheme, so it can
be considered a distraction for now and its implementation and
discussion tabled.  It has one disadvantage: in order to get
_recursive_ behavior in one tree, one needs to use the "." pattern in
the .gitignore file of the respective directory, and having a
.gitignore file in that directory sort of defeats the idea of not
having .gitignore directories around...  Of course, a single
.gitignore file is better than ones one has to distribute through the
tree.

>> core.dirManagement or something like that, which could be set to
>>  1. "autoremove" or something like that, which gives old behavior
>>     of untracking directory if it doesn't have any tracked files
>>     in it, and removing directory if it doesn't have any files
>>     in it.
>
> That's actually not _tracking_ a directory at all, but rather
> maintaining an independent directory in the parallel repository
> universe.  No information specific to directories passes the index.

Note: that was merely a comment on semantics, not on the matter.

>>  2. "noremove" or something like that, which changes the behaviour
>>     to _never_ untrack directory automatically. This can be done
>>     without any changes to 'tree' object nor index. It could be useful
>>     for git-svn repositories.
>
> I don't see how this could occur.  Automatic _untracking_ would happen
> when one untracks (aka removes) a parent directory.  But one would not
> do this while keeping the child.

Correction: if there was a --directory option and one used it for
git-rm (or no -r was given, so just one directory level was effected),
one _could_ untrack stuff on the git side accidentally.  And for
something like git-svn, this might be a bad idea.  So there is
conceivably a market for an option that never untracks a non-empty
tree.

>>  3. "marked" or something like that, for which you have to explicitely
>>     mark directories which are not to be removed when empty.
>
> Equivalent to 1 in my scheme.

At least if scheme 1 does not forbid some _explicit_ way of saying
"track this and I really mean it".

>>  4. "recursive" or something like that, which would automatically mark
>>     as "sticky" all subdirectories added in a "sticky" repository.
>
> If they are covered by the add and not just implied by childs.  That is,
> git-add a/b
> will not make "a" sticky while
> git-add a
> will make a/b sticky.

Addition: I was thinking so much of my implementation and its
semantics that I did not consider one possibility that you might mean
here:

When adding a/b, always also add a (and the whole hierarchy above it)
automatically as sticky.  Namely disallow unsticky directories in the
repository at all.  That would mean that

  git-add a/b;git-commit -m x;git-rm a/b;git-commit -m x

might not be a noop if a was not in the repository previously: it
would cause a to stay around sticky until removed.  With all other
schemes, however, it would cause a to be removed "on behalf of the
user" even if the user intended it to stay around.

Indeed, this scheme might by far be the easiest to understand.  Having
no autoremoval at all in levels higher than the deleted level is
something that people might easily understand: delayed removal just
does not happen anymore, and git never deletes a directory unless told
to.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
