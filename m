From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: point to 'git pull' and 'git push --force' in case
 of non-fast forward
Date: Thu, 06 Aug 2009 13:15:02 -0700
Message-ID: <7v7hxgk8c9.fsf@alter.siamese.dyndns.org>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:15:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ9N2-0003Yq-VC
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 22:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685AbZHFUPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 16:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756678AbZHFUPL
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 16:15:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbZHFUPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 16:15:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B379E1F899;
	Thu,  6 Aug 2009 16:15:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 56E071F898; Thu,  6 Aug 2009
 16:15:04 -0400 (EDT)
In-Reply-To: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu\,  6 Aug 2009 19\:32\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5EE7232-82C5-11DE-BF03-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125121>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> 'git push' failing because of non-fast forward is a very common situation,
> and a beginner does not necessarily understand "fast forward" immediately.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> That may be a bit verbose, but I think it's worth it.
> ...
> +		if (nonfastforward) {
> +			printf("Some branch push were rejected due to non-fast forward:\n");
> +			printf("Merge the remote changes (git pull) before pushing your's\n");
> +			printf("or use git push --force to discard the remote changes.\n");
> +		}

Although I think the patch identified the right place to make changes, I
am not sure about what the help message should say.

If the user lacks understanding of what a fast-forward is, I do not think
giving two choices that would produce vastly different results (because
they are applicable in vastly different situations) would help such a user
very much, as the understanding of the concept of fast-forward is a must
to correctly decide which one to use.

Unfortunately, I do not think we have a good description of fast-forward
in our documentation set.  The glossary defines what it is, git-push
manual page says by default only fast-forwards are accepted, and
user-manual says that we do not create a merge commit in a fast-forward
situation.  But nobody talks about _why_ a non-fast-forward update (either
push or fetch) is a bad idea clearly.

I wrote that in my upcoming book so we could refer to it in this error
message, but I suspect it may not help most people since it is in Japanese
;-)

Jokes aside, perhaps we could add "see git-push documentation for details"
to the above message of yours, and add something like this to the
documentation.

 Documentation/git-push.txt |   75 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2653388..c1ae82d 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -195,6 +195,81 @@ reason::
 	refs, no explanation is needed. For a failed ref, the reason for
 	failure is described.
 
+Note about fast-forwards
+------------------------
+
+When an update changes a branch (or more in general, a ref) that used to
+point at commit A to point at another commit B, it is called a
+fast-forward update if and only if B is a descendant of A.
+
+In a fast-forward update from A to B, the set of commits that the original
+commit A built on top of is a subset of the commits the new commit B
+builds on top of.  Hence, it does not lose any history.
+
+In contrast, a non-fast-forward update will lose history.  For example,
+suppose you and somebody else started at the same commit X, and you built
+a history leading to commit B while the other person built a history
+leading to commit A.  The history looks like this:
+
+----------------
+
+      B
+     /
+ ---X---A
+
+----------------
+
+Further suppose that the other person already pushed changes leading to A
+back to the original repository you two obtained the original commit X.
+
+The push done by the other person updated the branch that used to point at
+commit X to point at commit A.  It is a fast-forward.
+
+But if you try to push, you will attempt to update the branch (that
+now points at A) with commit B.  This does _not_ fast-forward.  If you did
+so, the changes introduced by commit A will be lost, because everybody
+will now start building on top of B.
+
+The command by default does not allow an update that is not a fast-forward
+to prevent such loss of history.
+
+If you do not want to lose your work (history from X to B) nor the work by
+the other person (history from X to A), you would need to first fetch the
+history from the repository, create a history that contains changes done
+by both parties, and push the result back.
+
+You can perform "git pull", resolve potential conflicts, and "git push"
+the result.  A "git pull" will create a merge commit C between commits A
+and B.
+
+----------------
+
+      B---C
+     /   /
+ ---X---A
+
+----------------
+
+Updating A with the resulting merge commit will fast-forward and your
+push will be accepted.
+
+Alternatively, you can rebase your change between X and B on top of A,
+with "git pull --rebase", and push the result back.  The rebase will
+create a new commit D that builds the change between X and B on top of
+A.
+
+----------------
+
+      B   D
+     /   /
+ ---X---A
+
+----------------
+
+Again, updating A with this commit will fast-forward and your push will be
+accepted.
+
+
 Examples
 --------
 
