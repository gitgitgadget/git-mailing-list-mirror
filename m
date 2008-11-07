From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Fri, 7 Nov 2008 20:39:57 +0100
Message-ID: <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth> <20081101220319.1116.50509.stgit@gandelf.nowhere.earth> <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 20:41:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyXD6-0006k7-St
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 20:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbYKGTkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 14:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbYKGTkW
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 14:40:22 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:42340 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbYKGTkV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 14:40:21 -0500
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 9C9A6B01C9;
	Fri,  7 Nov 2008 20:40:18 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 7EAD9B0143;
	Fri,  7 Nov 2008 20:40:18 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 6FABD1F06A; Fri,  7 Nov 2008 20:39:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100326>

On Thu, Nov 06, 2008 at 05:10:09PM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > Rename factorization tries to group together files moving from and to
> > identical directories - the most common case being directory renames.
> > We do that by first identifying groups of bulk-moved files, and then
> > hiding those of the individual renames which carry no other
> > information (further name change, or content changes).
> > This feature is activated by the new --factorize-renames diffcore
> > flag.
> 
> I have a mixed feeling about this one, primarily because I cannot
> visualize how a useful output should look like.  Unless you rename one
> directory to another without any content changes, you would have to say
> "this directory changed to that, and among the paths underneath them, this
> file have this content change in addition".

Right.  This is something I have already thought about, without taking
the time to finalize.  So let's have a try.

The direct transposition of the raw output of a dir rename with a
change would yield something like:

|diff --git a/ppc/ b/foo
|similarity index 100%
|rename from ppc/
|rename to foo/
|diff --git a/ppc/sha1.h b/foo/sha1.h
|--- ppc/sha1.h
|+++ foo/sha1.h
|...

This would have the usefulness I'm looking for, in that the content
modifications would not be "hidden" among a whole lot af individual
file rename hunks.

But if we want to make this more generally useful (eg. allow other
tools to apply such patches), we need to be careful.  A typical patch
file can usually be seen as a sequence of changes which can be applied
independently (at least in order).  It is obvious that this is not
true for the above output.  So we could also consider making this
patch output sequential with something like:

|diff --git a/ppc/ b/foo
|similarity index 100%
|rename from ppc/
|rename to foo/
|diff --git a/foo/sha1.h b/foo/sha1.h
|--- foo/sha1.h
|+++ foo/sha1.h
|...

However, such output would possibly be confusing, eg. when looking at
it from gitk and looking for commits which modify ppc/sha1.h.

A solution to this could be to add an annotation such as:

|diff --git a/ppc/ b/foo
|similarity index 100%
|rename from ppc/
|rename to foo/
|diff --git a/foo/sha1.h b/foo/sha1.h
|--- foo/sha1.h (previously ppc/sha1.h)
|+++ foo/sha1.h
|...

That would make the "git diff" format diverge a bit more from the
standard, but since a full-fledged git patch already cannot be used by
standard patch tools, it should not be a big issue - we should just be
careful about choosing a suitable format if we go that way.

But as we already change the patch format, we could also simply say
that we don't care about the patch being "litterally splittable", add
a "this is a non-splittable whole" note at the beginning of the patch
output, and go with the litteral solution shown as first example.

How do you feel wrt this ?


> A related feature that would benefit from something like your change
> without any downside/complication of output format issues is to boost
> rename similarity score of a path when its neighbouring paths are moved to
> the same location.

Yes, that could be triggered by distinct switches.

Doing this would be related to detecting "directory splits" (ie. when
some files are really not moved, or moved into several dirs instead of
being all moved to the same target dir).  We can start by detecting
dir-splits, then shift the scoring threshold and do another pass on
split dirs.
