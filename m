From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] rebase -p loses commits
Date: Mon, 16 May 2011 13:36:51 -0700
Message-ID: <7vfwoel6vw.fsf@alter.siamese.dyndns.org>
References: <20110516103354.GA23564@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 22:37:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM4XJ-0003bu-RJ
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 22:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab1EPUhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 16:37:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab1EPUg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 16:36:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EE4942EE;
	Mon, 16 May 2011 16:39:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h1/gqy0btJg8A5DA7etr0vIXgRM=; b=aFb0Ve
	P8x48lYkCFzAmR41SYPgwfW/TltUZ/WRxpPD/mTcGQfI7BAZOThYhoBCgzG+zCiu
	oqfr5dfQcaLZGZc0lDUC319MIM3+XWMvzoF11/s7bGnLcvKTVvRvhQVZNzJOPjKy
	2mlkmjBuVjiiUJ5Io00cP/qiHkdbYiv8/IzZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dGqDb2mZCeCnfXFT9Bc7nY/pZ9UY0LFF
	STRfCVsFi84BckPl7hRD5DPRKGzSCslPwOQ2BbBCK5EWMPECDD/N7svGRi8Vo3fv
	cPRQvoZOnyaD5e/2qnt2KG56YNjGJl3zD5qJavH6J9+pMV4NhTFHJYR2KaQxYYxA
	EYqYXeyfJrM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE90742EB;
	Mon, 16 May 2011 16:39:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C832542E9; Mon, 16 May 2011
 16:39:00 -0400 (EDT)
In-Reply-To: <20110516103354.GA23564@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 16 May 2011 06:33:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89906996-7FFC-11E0-B33F-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173756>

Jeff King <peff@peff.net> writes:

> I was trying to reproduce somebody's issue with a minimal test case, and
> I ran across this setup wherein "rebase -p" silently drops some commits:
>
>   commit() {
>     echo $1 >file && git add file && git commit -m $1
>   }
>
>   # repo with two branches, each with conflicting content
>   git init repo && cd repo &&
>   commit base &&
>   commit master &&
>   git checkout -b feature HEAD^ &&
>   commit feature &&
>
>   # now merge them, with some fake resolution
>   ! git merge master &&
>   commit resolved &&
>
>   # now try to "rebase -p" on top of master.
>   git rebase -p master

Hmm, I am confused.  You have this:

   F---*  feature
  /   /
 B---M    master

and you are at "*".  If it were to rebase to linearize,

    B---M---F' 

with F' that has the same the contents as '*', possibly autoresolved by
"am -3" and/or "rerere", should be what you would get.

But what does it mean to rebase that on top of master, preserving merges
in the first place? You are already on top of 'master' and '*' itself
should be what you should get, no?  IOW, shouldn't you already be
up-to-date?

> I'm totally unfamiliar with the preserve-merges code, and I won't have
> time to dig further until later today or tomorrow, so I thought I'd
> throw it out here and see if anybody has any clues.

I don't use preserve-merge rebase either, but at least when you are
strictly ahead of the target, nothing should happen, I think.

Perhaps this should be a good start?

 git-rebase.sh |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 7a54bfc..2be10d6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -466,10 +466,13 @@ require_clean_work_tree "rebase" "Please commit or stash them."
 # but this should be done only when upstream and onto are the same
 # and if this is not an interactive rebase.
 mb=$(git merge-base "$onto" "$orig_head")
-if test "$type" != interactive && test "$upstream" = "$onto" &&
-	test "$mb" = "$onto" &&
-	# linear history?
-	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
+if test "$upstream" = "$onto" && test "$mb" = "$onto" && {
+    {
+      test "$type" != interactive &&
+      # linear history?
+      ! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
+    } || test t,implied = "$preserve_merges,$interactive_rebase"
+  }
 then
 	if test -z "$force_rebase"
 	then
