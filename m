From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] contrib/subtree bugfix: Can't `add` annotated tag
Date: Tue, 13 May 2014 12:34:13 -0700
Message-ID: <xmqqa9alo4lm.fsf@gitster.dls.corp.google.com>
References: <1399954138-2807-1-git-send-email-nod.helm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Cagle <kcagle@micron.com>
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 21:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkIT3-0005XR-Rm
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 21:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbaEMTeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 15:34:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63945 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbaEMTeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 15:34:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8682718FCD;
	Tue, 13 May 2014 15:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tdWWzsv+nXVfs/7hoO+VQG1Z/Ys=; b=JU+Sif
	V7oj8H9heVjMr/jayG8dnInBqIJ6T4a1eqWB5sK/+dQIh4mV5PnCbxeasi0L7zYE
	LP9KPJd1NJ+ImAISz+xyjmgtSIk7qcd4BW5loHVUyc4JgZGqE6hLhExV81crGH5H
	ABcP3jWXnrzx/1JcwERWX1yxs1hkaBe8HAwD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EDoj3fAQIxa3dTQ3IUy0G9h1asp9anhb
	dtBzByAtrVSL86z9iJpwCIvRp1Q2X1DucNI08/kZNjMY3fScCjzW92s4RwlHRP3B
	kbXscuDcbKnA6MgwHkpQhwlaI/YAr3XHw1oeecSSltEo+pZxrhFuQVvguAYSF1Q4
	+aJe/ZQNOrY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BBDA18FCC;
	Tue, 13 May 2014 15:34:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC20118FC0;
	Tue, 13 May 2014 15:34:14 -0400 (EDT)
In-Reply-To: <1399954138-2807-1-git-send-email-nod.helm@gmail.com> (James
	Denholm's message of "Tue, 13 May 2014 14:08:58 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 91233C06-DAD5-11E3-8770-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248809>

James Denholm <nod.helm@gmail.com> writes:

> cmd_add_commit() is passed FETCH_HEAD by cmd_add_repository, which is
> then rev-parsed into an object ID. However, if the user is fetching a
> tag rather than a branch HEAD, such as by executing:
>
> $ git subtree add -P oldGit https://github.com/git/git.git tags/v1.8.0
>
> The object ID is a tag and is never peeled, and the git commit-tree call
> (line 561) slaps us in the face because it doesn't handle tag IDs.
>
> Because peeling a committish ID doesn't do anything if it's already a
> commit, fix by peeling[1] the object ID before assigning it to $rev, as
> per the patch.
>
> [*1*]: Via peel_committish(), from git:git-sh-setup.sh, pre-existing
> dependency of git-subtree.
>
> Reported-by: Kevin Cagle <kcagle@micron.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: James Denholm <nod.helm@gmail.com>
> ---
> I felt that defining revp would be a little more self-documenting than
> using $rev^0.

That is a good decision, but as long as we are attempting to peel,
don't we want to stop the damage when it does not peel to a commit?

I'll tentatively queue this.  Thanks.

-- >8 --
From: James Denholm <nod.helm@gmail.com>
Date: Tue, 13 May 2014 14:08:58 +1000
Subject: [PATCH] contrib/subtree: allow adding an annotated tag

cmd_add_commit() is passed FETCH_HEAD by cmd_add_repository, which
is then rev-parsed into an object name.  However, if the user is
fetching a tag rather than a branch HEAD, such as by executing:

  $ git subtree add -P oldGit https://github.com/git/git.git tags/v1.8.0

the object name refers to a tag and is never peeled, and the git
commit-tree call (line 561) slaps us in the face because it doesn't
peel tags to commits.

Because peeling a committish doesn't do anything if it's already a
commit, fix by peeling the object name before assigning it to $rev,
using peel_committish() from git:git-sh-setup.sh, a pre-existing
dependency of git-subtree.

Reported-by: Kevin Cagle <kcagle@micron.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: James Denholm <nod.helm@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/subtree/git-subtree.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index db925ca..fa1a583 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -558,8 +558,9 @@ cmd_add_commit()
 		commit=$(add_squashed_msg "$rev" "$dir" |
 			 git commit-tree $tree $headp -p "$rev") || exit $?
 	else
+		revp=$(peel_committish "$rev") &&
 		commit=$(add_msg "$dir" "$headrev" "$rev" |
-			 git commit-tree $tree $headp -p "$rev") || exit $?
+			 git commit-tree $tree $headp -p "$revp") || exit $?
 	fi
 	git reset "$commit" || exit $?
 	
-- 
2.0.0-rc3-404-gb0be553
