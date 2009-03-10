From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6] Make git-clone respect branch.autosetuprebase
Date: Tue, 10 Mar 2009 01:16:15 -0700
Message-ID: <7vab7tbxo0.fsf@gitster.siamese.dyndns.org>
References: <1236655610-14236-1-git-send-email-pknotz@sandia.gov>
 <1236659098-14400-1-git-send-email-pknotz@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Pat Notz" <pknotz@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Mar 10 09:18:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgxA0-0001c0-Iq
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbZCJIQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 04:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbZCJIQb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 04:16:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbZCJIQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 04:16:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FC9CA0F31;
	Tue, 10 Mar 2009 04:16:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4EAF3A0F30; Tue,
 10 Mar 2009 04:16:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF007894-0D4B-11DE-B5C3-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112791>

"Pat Notz" <pknotz@sandia.gov> writes:

> This version fixes the verbose output to be more human friendly.  Before,
> the branch being tracked was printed as 'refs/heads/frotz' regardless of
> wether that was a local or remote branch.  Now, a local branch is just
> printed as 'frotz' and a remote branch is printed as 'origin/frotz'

Since I've already queued the previous round in 'next', I took the liberty
of making this into an incremental.

I do not think what you did is really correct.  For clone, because we do
not create anything but the default "refs/remotes/<origin>/<branch>"
layout, always stripping out the first 11 bytes "refs/heads/" happens to
give a more intuitive result.  But the helper function is shared with a
more general "git branch --track" that lets you mark the new branch to
track almost anything.  For example, the version from v1.6.0 gives you
these:

    $ git branch --track maint-1.6.0 v1.6.0
    Branch maint-1.6.0 set up to track local branch refs/tags/v1.6.0
    $ git branch --track frotz master
    Branch frotz set up to track local branch refs/heads/master

Arguably, the former should say "track local ref refs/tags/v1.6.0" (or the
command should not even let you "track" a tag, which is supposed to be
immutable), and the latter would be helped by stripping "refs/heads/".
But the point is that stripping first 11 bytes unconditionally would be
wrong if you happen to start tracking a tag whose name is a single byte.

Also I do not think ("%s/%s", origin, remote+11) is correct in general.
You could very well configure your tracking to:

	[remote "origin"]
	fetch = refs/heads/*:refs/remotes/upstream/*

and I think the variable "remote" here refer to the name the ref is known
as in the remote repository, not the name we use to keep a copy of.  IOW,
when we say "Branch frotz tracks remote 'master'", we should say "the
branch known as 'master' at the remote site, no matter what name we happen
to call its copy locally somewhere under our refs/remotes".

In that sense, both the version I queued and the original are lacking
a critical piece of information: which remote we are talking about.

In any case, here is your patch, made into an incremental.  I'll send out
an alternative fix in a separate message.

 branch.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index d20fb04..d586843 100644
--- a/branch.c
+++ b/branch.c
@@ -65,12 +65,18 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 		git_config_set(key.buf, "true");
 	}
 
-	if (flag & BRANCH_CONFIG_VERBOSE)
+	if (flag & BRANCH_CONFIG_VERBOSE) {
+		strbuf_reset(&key);
+		if (origin)
+			strbuf_addf(&key, "%s/%s", origin, remote+11);
+		else
+			strbuf_addf(&key, "%s", remote+11);
 		printf("Branch %s set up to track %s branch %s %s.\n",
 		       local,
 		       origin ? "remote" : "local",
-		       remote,
+		       key.buf,
 		       rebasing ? "by rebasing" : "by merging");
+	}
 	strbuf_release(&key);
 }
 
