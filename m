From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How can I merge some files rather than all files modified on one
  branch to my branch?
Date: Mon, 02 Mar 2009 02:04:35 -0800
Message-ID: <7v1vtgnsuk.fsf@gitster.siamese.dyndns.org>
References: <856bfe0e0903020119y68188a39m90c683949220b2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 11:06:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le52N-0002CJ-Kt
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 11:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552AbZCBKEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 05:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756311AbZCBKEr
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 05:04:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbZCBKEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 05:04:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 310B42251;
	Mon,  2 Mar 2009 05:04:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5CAE72250; Mon, 
 2 Mar 2009 05:04:40 -0500 (EST)
In-Reply-To: <856bfe0e0903020119y68188a39m90c683949220b2f@mail.gmail.com>
 (Emily Ren's message of "Mon, 2 Mar 2009 17:19:05 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D2AA05A-0711-11DE-884D-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111925>

Emily Ren <lingyan.ren@gmail.com> writes:

> I want to merge some files rather than all files modified on one
> branch to my branch, how can I do?

In general, you do not want to, simply because the result is not really a
merge.

You are rejecting one of the two primary advantages git brings over other
traditional systems: merge tracking [*1*]..

But if you really wanted to, here is how.

Suppose you are on branch A, and if you merged branch B in a natural way
it would bring in changes to file1 and file2.  But you do not want any
change to file2.  You can do this:

 (1) Start from a clean state.  No uncommitted changes (if you have some,
     stash them away first).  Merge the branch the usual way:

     $ git merge B

 (2) (1) may get conflicts in file1 and/or file2.  Resolve the conflicts
     only in the file(s) you are interested in (in this example file1).
     Ignore conflicts in files you do not want to get changed in this
     merge.  And then conclude the merge with:

     $  git commit -a

     This step is necessary only if (1) does not cleanly merge; otherwise
     it would have created a merge commit already.

 (3) You did not want changes to certain paths (in this example, file2) in
     the "merge", but we recorded such change in the previous step, so you
     amend it.  At this point HEAD is the merge you created, and HEAD^ is
     before you started the merge.  You want the contents of file2 before
     the merge happened, i.e. from HEAD^:

     $ git checkout HEAD^ file2
     $ git commit --amend

The result would record a "merge" that ignores what B did to file2.

The reason you do not want to do this is because git tracks merges.

Suppose you have this topology:

             A---M
            /   /
    ---o---C---B

A is where you were before this "merge", B is the other branch, and M is
the result of the "merge".

Now, suppose branch B later improves on what it has done, and now what the
branch has is satisfactory for your needs.  There is no reason you would
not want to have any of its improvements.  You try to merge again.

             A---M-----------?
            /   /           /
    ---o---C---B---D---E---F

Because you declared (when you made the "merge" at M) that anything B did
to file2 was unwanted to your branch, git remembers that declaration.  The
information is used when computing the merge between M and F.  That is
what merge tracking is.

Perhaps changes to file2 when you inspected B were not good enough, but
with improvements made in D, E and/or F it may now be perfect.  But you
are denying to take this whole sequence of changes, and the merge you
would create between M and F will have only what D/E/F did to file2;
it won't contain what B did.  That makes the sequence of changes B-D-E-F
did to file2 incomplete and inconsistent.

If you are lucky, it will result in huge conflicts and you will notice the
situation.  But if you are not lucky, it may merge cleanly, but because
D/E/F builds on top of what B did, which possibly was half-baked back
then, for the merge result to work as well as F does, you need to have
what B did.  But you won't have it, because you already rejected it at M.

Two advises are:

 (1) To avoid problems in future merges, do not record the result as a
     "merge". You want to cherry-pick partially; in other words, you would
     want to record this topology when you create this "merge" (which is
     not a merge):

             A---M
            /
    ---o---C---B

    with the same tree as you would have recorded in the first picture.
    For that, I think you could run "git merge --squash B" in step (1) in
    the main part of this message.

 (2) More importantly, your wish to take only one but not the other part
     of B is a strong indication that the branch B is doing too many
     things, either in a single commit or either on a single branch or
     both. Separate these distinct bits into different topic branches so
     that each individual bits can be independently merged to other
     branches.

[Footnote]

*1* The other advantage is distributedness, which is "separation between
the act of committing and the act of publishing".
