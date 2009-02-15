From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Sat, 14 Feb 2009 18:05:42 -0800
Message-ID: <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 03:08:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYWQU-0007on-FE
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 03:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbZBOCFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 21:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbZBOCFv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 21:05:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbZBOCFu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 21:05:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 824D099820;
	Sat, 14 Feb 2009 21:05:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2B4A39981F; Sat,
 14 Feb 2009 21:05:43 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 14 Feb 2009 23:52:42 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29C40050-FB05-11DD-B702-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109953>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> - update-ref does _not_ interpret @{-<n>} as the branch name (which I 
>   find okay, as update-ref is plumbing), but instead creates the file 
>   '.git/@{-<n>}' (which I think is a bug).

I do not think it make any sense for update-ref to expand @{-1} to the
name of the last branch, as you end up creating a not-a-ref ".git/next"
and not ".git/refs/heads/next".  It might be Ok to say that @{-1} expands
to refs/heads followed by the name of the last branch only for this
plumbing command, but such an inconsistency feels very wrong.

The particular plumbing command, following the example of recent loosening
the rule back to "HEAD is allowed to point outside refs/heads/", should be
allowed to create anything that passes check_ref_format(), and perhaps bit
more because we would need to allow ".git/HEAD".

> Now, show-branch indeed does not substitute the branch _name_, but 
> otherwise it works correctly, no?
> otherwise it works correctly, no?  And given the fact that show-branch 
> does not substitute "HEAD" with the current branch name, either,...

The tip commits come from get_sha1(), so obviously it would "work", but it
does not show what branch it talks about.  HEAD is shown only when the
user says HEAD (e.g. "git show-branch master HEAD") so I do not see much
similarity there.

The advertised new feature is that you can use the @{-1} syntax anywhere
you would use a branch name and it would work as if you typed the name of
the branch, so in that sense show-branch that shows @{-1} and does not
show the name of the branch is a bug.

It is the same thing for "git-merge @{-1}".  Sure, it would record a
correct tree in the resulting commit, but without the fix it would say
"Merge branch @{-1}" which is wrong and needs to be fixed.

And no, "update-ref @{-1}" should not create ".git/next" when you were on
'next' the last time.  When you say "update-ref next", you may have typed
the four characters and that may look the same as the name of a branch,
but obviously the argument to the command does not *mean* the name of a
branch, so it falls outside the "anywhere you would use a branch name"
rule.
