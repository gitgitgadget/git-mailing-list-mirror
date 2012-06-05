From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Feeding an annotated but unsigned tag to "git merge"
Date: Tue,  5 Jun 2012 12:58:30 -0700
Message-ID: <1338926312-4239-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 21:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbzto-0001V9-S8
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 21:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab2FET6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 15:58:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab2FET6f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 15:58:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6593C9FCA
	for <git@vger.kernel.org>; Tue,  5 Jun 2012 15:58:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=uwkQ9fV1KSV9i6rEkoeALPJuTyQ
	=; b=H80of1HLZLyq0E2Ghqd3hyNPBy70jEUN2venyiwGaSU2jMRKS+kqLwiKgLt
	C8qOdBzQEaFVtFD8Alq/jqX9O93lPd+t50spj/iFh5hO9uuDLOIM6tfu+KcFyEh8
	HjwT0iWWxguPNMXpN6SI+7EKfaE+Q2ciT9dJLUHVOeKSXM3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=OfCZTCgwsc0q/45oDHDZKah+7otHg
	S+aBuf0rjSHCeqkTGjNmwvdMf5sHZpNwwmdffmHg/uvx3r7U5VCWGS5G59VAGT4W
	4WwqQgce0k6YB4JGnn6G5k3aHlYJCd+bXpFccX1M+o0AXud/gWXuKr6CWos6Bi5J
	0ggtyPhV3gey3E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D1129FC9
	for <git@vger.kernel.org>; Tue,  5 Jun 2012 15:58:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD8F89FC8 for
 <git@vger.kernel.org>; Tue,  5 Jun 2012 15:58:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
X-Pobox-Relay-ID: D4AE2860-AF48-11E1-8149-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199284>

When you give an annotated but unsigned tag to "git merge", if the
tagged commit does not fast-forward, we create a merge commit and
the tagged commit (not the tag itself) becomes one of the parents of
the resulting merge commit. The merge commit log contains the
message from the annotated tag.

When the tagged commit is a descendant of the current HEAD, however,
we used to simply fast-forward such a merge (losing the content of
the annotated tag).

Post 1.7.9, we no longer do so.  These three create a merge commit
for an annotated tag "anno" that points at a commit that is a
descendant of the HEAD:

        $ git merge anno
        $ git merge --ff anno
        $ git merge --no-ff anno

You can force fast-forwarding with:

        $ git merge anno^0

but you obvously cannot record the contents of the annotated tag, as
there is no new commit to record it.

The "--ff" option has always meant "allow fast-forward", i.e. "if
the merge can be fast-forwarded, do so without creating a new merge
commit", and without any of the "ff"-related options, the command
defaults to allow fast-forwarding.  "--no-ff" is "I always want a
new merge commit made", and "--ff-only" is "fail the command if it
cannot be fast-forwarded".  In effect, in the post 1.7.9 world, we
consider that an annotated tag is what you cannot fast-forward to.

The above definition was loosened slightly with b5c9f1c (merge: do
not create a signed tag merge under --ff-only option, 2012-02-05).
"--ff-only" is taught to consider an annotated or signed tag that
points at a commit that can be fast-forwarded as what you can
fast-forward to, so that a user following along without adding
anything can do this:

	$ git checkout v3.2.0
	$ git pull --ff-only v3.3.0

without creating an extra merge commit.

This two-patch series further loosens the definition by considering
that an annotated but unsigned tag can be fast-forwarded as long as
it points at a commit that can be fast-forwarded to.  So

        $ git merge anno
        $ git merge --ff anno

will now fast-forward (note that this will *not* happen for signed
tags).

I find this change somewhat iffy myself, as we are encouraging
people to lose information (i.e. the contents of the annotated tag
is no longer recorded in the history) and some may see it as a
regression in the post 1.7.10 world because of that.

But since I've written it already, I thought it might be worth
showing it to the list for discussion, if only to publicly reject
the idea ;-).

Junio C Hamano (2):
  merge: separte the logic to check for a signed tag
  merge: allow fast-forwarding to an annotated but unsigned tag

 builtin/merge.c  | 26 ++++++++++++++++++++++----
 t/t7600-merge.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 4 deletions(-)

-- 
1.7.11.rc1.37.g09843ac
