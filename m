From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: git stash takes excessively long when many untracked files
 present
Date: Thu, 15 Aug 2013 11:07:36 -0700
Message-ID: <20130815180736.GA4093@jtriplet-mobl1>
References: <20130810214453.GA5719@jtriplet-mobl1>
 <loom.20130813T120243-481@post.gmane.org>
 <7v7gfpy0wy.fsf@alter.siamese.dyndns.org>
 <1fc732a7-6b63-4d75-960f-0b1c6cf9c70e@email.android.com>
 <7vmwolwk94.fsf@alter.siamese.dyndns.org>
 <7v61v9w9dy.fsf@alter.siamese.dyndns.org>
 <7vr4durgd4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anders Darander <anders.darander@gmail.com>,
	Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 20:07:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA1xg-0007Ue-Bp
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 20:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759113Ab3HOSHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 14:07:48 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44609 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758276Ab3HOSHr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 14:07:47 -0400
Received: from mfilter14-d.gandi.net (mfilter14-d.gandi.net [217.70.178.142])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id B2CEFA80BF;
	Thu, 15 Aug 2013 20:07:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter14-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter14-d.gandi.net (mfilter14-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id w7MUedB6CmlG; Thu, 15 Aug 2013 20:07:42 +0200 (CEST)
X-Originating-IP: 173.246.103.110
Received: from jtriplet-mobl1 (joshtriplett.org [173.246.103.110])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AEABCA80C4;
	Thu, 15 Aug 2013 20:07:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr4durgd4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232357>

On Thu, Aug 15, 2013 at 10:52:39AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > In any case, this is a regression introduced in 'master' since the
> > last release, and the attempted fix was for an issue that has long
> > been with us, so I'll revert a7365313 (git stash: avoid data loss
> > when "git stash save" kills a directory, 2013-06-28) soon.  For
> > today's -rc3, I'm already deep into the integration cycle, so it is
> > too late to do the revert it and then redo everything.
> >
> > Then we will plan to re-apply the patch once "ls-files --killed"
> > gets fixed not to waste too much cycles needlessly, after the coming
> > release.
> 
> I've already reverted the problematic patch to "git stash" and it
> will not be part of the upcoming release.

Thanks!

> Here is a quick attempt to see if we can do better in "ls-files -k".
> 
> We have an existing test t3010.3 that tries all the combinations of
> directory turning into a regular file, symlink, etc. and vice versa,
> and it seems to pass.  The test has a directory path6 in the working
> tree without any paths in it in the index, and the added bypass code
> seems to correctly trigger and prevents us from digging into that
> directory, so this patch may be sufficient to improve "ls-files -k".
> 
> By the way, regarding the reverted commit, I do not think it is
> enough to ask "ls-files -k" to see if the state recorded in the
> current index is sufficient.  Imagine your HEAD records "path" as a
> file and then you did this:
> 
>     $ git reset --hard ;# "path" is now a regular file
>     $ mv path path.bak
>     $ mkdir path
>     $ mv path.bak path/file
>     $ git add -A ;# "path/file" in the index and in the working tree
>     $ >path/cruft ;# "path/cruft" in the working tree
> 
> Then call "save_stash" without saving untracked.  The resulting
> stash will save the contents of "path/file" but "path/cruft" is not
> recorded anywhere, and then we would need to bring the state in the
> working tree and the index back to the state recorded in HEAD, hence
> "path" needs to be turned back to a directory.
> 
> But "ls-files -k" is asked to check with the index, which has the
> path as a directory, so this case is missed.

Since git stash resets to the state in HEAD, whatever --killed check it
does needs to check against HEAD, yes.  It still doesn't need to check
any path that doesn't exist in HEAD, though; it makes more sense to
drive this from the list of files in HEAD rather than from the list of
files in the working directory, even with a filter applied to the latter
to prune bits not in HEAD.

> So instead of
> 
> 	test -n "$(git ls-files --killed | head -n 1)"
> 
> in Pasky's patch, which probably is a right thing to do if you are
> running "git stash save --keep-index", you would need something like
> this if you are not running with "--keep-index":
> 
> 	test -n "$(
>         	GIT_INDEX_FILE=tmp_index
>                 export GIT_INDEX_FILE
>                 git read-tree HEAD
>                 git ls-files -k
> 	)"
> 
> in order to make sure that the result of going back to the state in
> the HEAD will not clobber leftover "path/cruft".

Sure, that works.  However, wouldn't it make sense to just directly let
git ls-files output to the screen, then test its return value (after
adding some ls-files option to set the return value)?  Since ls-files
--killed will have no output if git stash can proceed, and since git
stash should show the list of files that'd be killed before it fails,
using the output directly makes sense.

- Josh Triplett
