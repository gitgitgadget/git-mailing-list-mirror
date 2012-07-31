From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] rebase -i: handle fixup of root commit correctly
Date: Tue, 31 Jul 2012 12:19:39 +0100
Message-ID: <20120731111938.GD19416@arachsys.com>
References: <20120724121703.GG26014@arachsys.com>
 <5017A1E4.1070800@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 13:19:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwAUR-0003dl-Md
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 13:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab2GaLTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 07:19:46 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:44772 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab2GaLTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 07:19:45 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SwAUK-00030d-DA; Tue, 31 Jul 2012 12:19:44 +0100
Content-Disposition: inline
In-Reply-To: <5017A1E4.1070800@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202644>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 24.07.2012 14:17, schrieb Chris Webb:
> >diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> >index bef7bc0..0d2056f 100644
> >--- a/git-rebase--interactive.sh
> >+++ b/git-rebase--interactive.sh
> >@@ -493,25 +493,28 @@ do_next () {
> >  		author_script_content=$(get_author_ident_from_commit HEAD)
> >  		echo "$author_script_content" >"$author_script"
> >  		eval "$author_script_content"
> >-		output git reset --soft HEAD^
> >-		pick_one -n $sha1 || die_failed_squash $sha1 "$rest"
> >+		if ! pick_one -n $sha1
> >+		then
> >+			git rev-parse --verify HEAD >"$amend"
> >+			die_failed_squash $sha1 "$rest"
> >+		fi
> >  		case "$(peek_next_command)" in
> >  		squash|s|fixup|f)
> >  			# This is an intermediate commit; its message will only be
> >  			# used in case of trouble.  So use the long version:
> >-			do_with_author output git commit --no-verify -F "$squash_msg" ||
> >+			do_with_author output git commit --amend --no-verify -F "$squash_msg" ||
> >  				die_failed_squash $sha1 "$rest"
> 
> This new sequence looks *VERY* suspicious. It makes a HUGE
> difference in what is left behind if the cherry-pick fails. Did you
> think about what happens when the cherry-pick fails in a
> squash+squash+fixup+fixup sequence (or any combination thereof) and
> then the rebase is continued (after a manual resolution)?

I had to deal with the case where there's a conflict while picking the
squash/fixup, and we have to ensure we commit --amend in rebase --continue.
This is why I've written

  git rev-parse --verify HEAD >"$amend"

in the above, to use the pre-existing support for amending the HEAD commit
in rebase --continue. (We test for this fixup-conflict case in various ways
in t3404 and not doing an amend there would result in double commits and
spectacular test breakage.)

Is this the issue you mean here, or is it something more subtle which I'm
not properly following?

If we have a conflict in the middle of a chain of fixup/squashes, as far as
I can see, we have a HEAD with all the previous successful fixups applied,
conflict markers for the current failed pick, and when the conflict has been
resolved, git rebase --continue will commit --amend the resolution and
continue? Isn't that the correct behaviour here?

Cheers,

Chris.
