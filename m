From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 3/4] t7800: modernize tests
Date: Fri, 22 Mar 2013 11:53:52 +0000
Message-ID: <20130322115352.GI2283@serenity.lan>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com>
 <1361419428-22410-2-git-send-email-davvid@gmail.com>
 <1361419428-22410-3-git-send-email-davvid@gmail.com>
 <514985FB.8080806@viscovery.net>
 <CAJDDKr4O-OU57j0f7F2E2_4EvtCTE1gFP5uLv+fvD6VcpPiifg@mail.gmail.com>
 <514AB9A5.3050601@viscovery.net>
 <514C04AA.6030305@viscovery.net>
 <20130322100030.GH2283@serenity.lan>
 <514C3D13.5010301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 22 12:54:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ0YM-00078f-9b
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 12:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088Ab3CVLyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 07:54:06 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:42231 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825Ab3CVLyF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 07:54:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C9031606518;
	Fri, 22 Mar 2013 11:54:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yFiDWSeVgyZP; Fri, 22 Mar 2013 11:54:03 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 7CC61198002;
	Fri, 22 Mar 2013 11:53:54 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <514C3D13.5010301@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218793>

On Fri, Mar 22, 2013 at 12:14:27PM +0100, Johannes Sixt wrote:
> Am 3/22/2013 11:00, schrieb John Keeping:
> > On Fri, Mar 22, 2013 at 08:13:46AM +0100, Johannes Sixt wrote:
> >> Am 3/21/2013 8:41, schrieb Johannes Sixt:
> >>> Am 3/20/2013 23:59, schrieb David Aguilar:
> >>>> I started digging in and the @worktree_files (aka @worktree above)
> >>>> is populated from the output of "git diff --raw ...".
> >>>>
> >>>> Seeing the "output" filename in "diff --raw" implies that one of the
> >>>> tests added "output" to the index somehow.  I do not see that
> >>>> happening anywhere, though, so I do not know how it would end up in
> >>>> the @worktree array if it is not reported by "diff --raw".
> >>>>
> >>>>
> >>>> My current understanding of how it could possibly be open twice:
> >>>>
> >>>> 1. via the >output redirect
> >>>> 2. via the copy() perl code which is fed by @worktree
> >>>>
> >>>> So I'm confused.  Why would we get different results on Windows?
> >>>
> >>> I tracked down the difference between Windows and Linux, and it is...
> >>>
> >>> 	for my $file (@worktree) {
> >>> 		next if $symlinks && -l "$b/$file";
> >>>
> >>> ... this line in sub dir_diff. On Linux, we take the short-cut, but on
> >>> Windows we proceed through the rest of the loop,
> >>
> >> And that is likely by design. From the docs:
> >>
> >> --symlinks
> >> --no-symlinks
> >>
> >>     git difftool's default behavior is create symlinks to the working
> >>     tree when run in --dir-diff mode.
> >>
> >>     Specifying `--no-symlinks` instructs 'git difftool' to create
> >>     copies instead.  `--no-symlinks` is the default on Windows.
> >>
> >> And indeed, we have this initialization:
> >>
> >> 	my %opts = (
> >> 		...
> >> 		symlinks => $^O ne 'cygwin' &&
> >> 				$^O ne 'MSWin32' && $^O ne 'msys',
> >> 		...
> >> 	);
> >>
> >> Can the --dir-diff tests case pass on Cygwin when neither --symlinks nor
> >> --no-symlinks is passed?
> >>
> >> Perhaps the right solution is this:
> > 
> > We already have tests that explicitly pass '--symlinks'.  I wonder if it
> > would be better to change "output" to ".git/output", which should avoid
> > the problem by moving the output file out of the working tree.
> 
> The point of using --symlinks is not to test the effect of the option, but
> to test the same thing on Unix and on Cygwin, because the latter uses
> --no-symlinks by default. Therefore, I think that this sketch is the right
> thing to do.

So shouldn't we be running all of the tests with both --symlinks and
--no-symlinks (except those which explicitly check that these options do
the right thing)?

> But the real problem seems to be that "output" should not be among the
> files treated in the cited pieces of code (unless I'm wrong, of course; I
> know next to nothing about git-difftool). It should not matter where the
> file lives. Just add --no-symlinks to the difftool invocation of test
> "difftool -d" and watch it fail on Linux, too.

I fired up strace and it looks like difftool sees it as a working tree
file (i.e. the working tree content matches the RHS of the diff) in the
output of "git diff --raw --no-abbrev -z branch" and copies it over to
the temporary directories.  Then when difftool completes it copies back
the working tree files from there.

When the file is copied to the temporary directory, the diff command
hasn't yet run so "output" is empty.  When it's copied back it is after
the "ls" has run and so we overwrite the output of the command with the
original empty file.

So sticking the output file under .git does solve this issue since it
then is not treated as a working tree file.

Whether the current behaviour of difftool is entirely sensible is a
different question.  I think we should at the very least by refusing to
overwrite working tree files that have been modified since they were
copied to the temporary directory

If I ever end up on a system using --no-symlinks I can see myself being
bitten by this by editing the original working tree file while
inspecting the diff in a separate window.  I suspect this is just as
common a workflow as people editing the file in their diff tool and
wanting the changes copied back to the working tree.


John
