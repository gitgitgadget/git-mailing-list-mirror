From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] difftool --dir-diff: always use identical working
 tree file
Date: Tue, 28 May 2013 20:08:29 +0100
Message-ID: <20130528190829.GB17475@serenity.lan>
References: <20130526154429.GK27005@serenity.lan>
 <1369668697-1016-1-git-send-email-nitoyon@gmail.com>
 <7vbo7v0yju.fsf@alter.siamese.dyndns.org>
 <20130528181525.GA17475@serenity.lan>
 <7v7gij0w6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kenichi Saita <nitoyon@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 28 21:08:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhPGF-00060E-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 21:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab3E1TIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 15:08:39 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:52638 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495Ab3E1TIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 15:08:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 85237CDA5E5;
	Tue, 28 May 2013 20:08:38 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbYfRW97hiaB; Tue, 28 May 2013 20:08:37 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1B12ACDA5AF;
	Tue, 28 May 2013 20:08:31 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v7gij0w6z.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225681>

On Tue, May 28, 2013 at 11:57:08AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Yeah, the commit message is still quite focused on the end effect of
> > copying files back.  But that's not what's being changed here.
> >
> > In my suggested commit message I tried to make it clear that we're
> > changing when we decide to copy a file across to the temporary tree.
> > This has the beneficial (side-)effect of changing the set of files we
> > consider for copying back into the working tree after the diff tool has
> > been run.
> 
> I actually think the effect of copying files back _is_ the primary
> motivation of this change, and stressing that end effect is a much
> better description.  After all, if the working tree files do not
> have any difference from the RHS of the comparison, copying from the
> working tree and stuffing the $rsha1 to the RHS temporary index and
> running "checkout -f" should produce identical temporary directory
> for the user to start viewing.
> 
> The _only_ difference in behaviour before and after this patch that
> matters to the end user is if that path is in @working_tree, which
> is returned to @worktree of dir_diff sub to be later copied back,
> no?  I would view this change as a mere means, an implementation
> detail, to achieve that end of stuffing more paths in the @worktree
> array.

I agree with this, but like you I found it confusing that the patch
touched code seemingly unrelated to copying files back.  I went toward
describing the patch more literally and giving the motivation in the
final paragraph.  Your message below is better, but I think it needs to
say that the set of files considered for copying back is the set that is
copied across to begin with.

> Perhaps
> 
> 	difftool --dir-diff: allow changing any clean working tree file
> 
> 	The temporary directory prepared by "difftool --dir-diff" to
> 	show the result of a change can be modified by the user via
> 	the tree diff program, and we try hard not to lose changes
> 	to them after tree diff program returns to us.
> 
>         However, the set of files to be copied back is computed
> 	differently between --symlinks and --no-symlinks modes.  The
> 	former checks all paths that start out as identical to the
> 	working tree file, while the latter checks paths that
> 	already had a local modification in the working tree,
> 	allowing changes made in the tree diff program to paths that
> 	did not have any local change to be lost.
> 
> or something.  This invites a few questions, though.
> 
>  - By allowing these files in the temporary directory to be
>    modified, aren't we making the user's life harder by forcing them
>    to handle "working tree file was already modified, made different
>    changes in the temporary directory, now these changes need to be
>    consolidated" case?
> 
>  - When comparing two revisions, e.g. "--dir-diff HEAD^^ HEAD^",
>    that checks out (via $rsha1 to "checkout -f" codepath) a blob
>    that does not match what is in the working tree of HEAD to the
>    temporary directory, we still allow modifications to the copy in
>    the temporary directory, but what can the user do with these
>    changes that are _not_ based on HEAD, short of checking out HEAD^
>    and apply the difference first?
> 
> I still cannot shake this nagging feeling that giving a writable
> temporary directory might have been a mistake in the first place.
> Perhaps it may be a better design to make the ones that the user
> shouldn't touch (or will lead to the above confusion) read-only,
> while the ones that match the working tree read-write?

My ideal scenario would be that we only allow users to edit files when
they are comparing against the working tree, but that would require
git-difftool to fully understand all git-diff options since it just
passes through any it doesn't recognise.  I don't think there's an easy
way to do that, which leaves us with this confusing situation.
