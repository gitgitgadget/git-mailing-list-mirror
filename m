From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sat, 16 Feb 2008 20:20:55 +0000
Message-ID: <20080216202055.GA30146@hashpling.org>
References: <20080216185349.GA29177@hashpling.org> <7vzlu07jn9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 21:21:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQTXf-0001Z3-LF
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 21:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbYBPUVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 15:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755096AbYBPUVJ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 15:21:09 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:57204 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbYBPUVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 15:21:07 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1JQTWx-0003TK-GT; Sat, 16 Feb 2008 20:21:03 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1GKKuRb030579;
	Sat, 16 Feb 2008 20:20:56 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1GKKtp0030578;
	Sat, 16 Feb 2008 20:20:55 GMT
Content-Disposition: inline
In-Reply-To: <7vzlu07jn9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 59135ce8717f664bdb4f178abd27d2f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74075>

On Sat, Feb 16, 2008 at 12:04:26PM -0800, Junio C Hamano wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
> > It follows filter-branch's 'eval a user shell snippet' philosophy to
> > provide the flexibility and here in lies an ugliness. It exposes
> > git-mergetool.sh's private variables to the user script. The variables
> > are BASE, REMOTE, LOCAL and path.
> >
> > My feeling is that we should give this consistent and documented
> > names, perhaps GIT_BASE, GIT_REMOTE, GIT_LOCAL, GIT_MERGED or similar.
> 
> I like the general idea and you are right that the external
> interface should not expose the variable names the current
> implementation happens to use.  I do not think it is necessary
> to rename them to GIT_BASE etc., but I do think we need to list
> the repertoire of variables that can be expected to be usable by
> custom script in any future version of mergetool (even after it
> is rewritten in C).  Anybody who uses a variable that is not in
> the documented set that the current implementation uses can be
> broken ;-).

OK, I'm fine with this, although I think we should use something other
than path (in lower case) for the output.  Either MERGED, RESULT or
OUTPUT, say, I've no strong preferences.

> Also perhaps we would want to spawn the eval in a subprocess to
> make it clear that the custom script cannot affect the caller's
> variables.

Sub-shell, good plan.

> > Also, does anyone know of any reason why the temporary files should
> > not be cleaned up after an unsuccessful merge?
> 
> I do not use mergetool myself, but presumably it would be to
> make the manual inspection easier.

I don't use it a lot (yet) either, but I think that this sort of
change well help git get wider acceptance in the "but does it work
with my favourite 3-way merge tool" community.

As far as it goes, though, I find that if I fire up a merge tool and
it looks complex, I quite often want to abort and look at the easy
files first.  The .BASE/.LOCAL/.REMOTE files don't contain anything
that isn't in the index anyway (the merge tool certainly should be
updating them with intermediate state).

It's a separate issue to the main thrust of this patch, though.

> > +mergetool.<tool>.keepBackup::
> 
--- snip ---

> Shouldn't the handling of back-up files be the same across
> backends?
> 
> If the answer is yes, it makes mergetool.<tool>.keepBackup
> configuration a quite bogus variable, as it is not something you
> would configure per backend.
> 
> In the existing code, I see kdiff3 arm calls remove_backup while
> tkdiff arm and others call save_backup, which seems quite
> inconsistent.  Perhaps mergetool needs a command line option
> (and perhaps a single configuration variable independent from
> which backend is used) to tell what to do about them after a
> conflicting merge is resolved and/or resolution is aborted.

Yes, I think that you're right. I couldn't work out why kdiff3 was
special, but I took the safe/wrong path of assuming that it should be
configurable per backend. I think that it might be something that
should be configurable, but the variable should probably me
mergetool.keepBackup and the patch should be separate from this one.

Charles.
