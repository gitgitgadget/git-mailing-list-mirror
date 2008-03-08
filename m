From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Make "git remote rm <remote>" remove file
 refs/remotes/<remote>/HEAD
Date: Fri, 07 Mar 2008 17:45:46 -0800
Message-ID: <7vskz2yomt.fsf@gitster.siamese.dyndns.org>
References: <200803051338.44938.tlikonen@iki.fi>
 <1204923732-29141-1-git-send-email-tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat Mar 08 02:46:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXo9H-0004Ed-Nt
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 02:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501AbYCHBqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 20:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757389AbYCHBqB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 20:46:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756958AbYCHBqA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 20:46:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 064961C71;
	Fri,  7 Mar 2008 20:45:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 20CCF1C70; Fri,  7 Mar 2008 20:45:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76537>

Teemu Likonen <tlikonen@iki.fi> writes:

> The command "git remote rm <remote>" used to leave the
> refs/remotes/<remote>/HEAD file lying in the directory. This usually
> happens when user has cloned a remote repository and later decided to
> remove the default "origin" with "git remote rm origin". The result is
> that several git commans display the error message
>
>   error: refs/remotes/origin/HEAD points nowhere!
>
> This patch makes "git remote rm" remove the HEAD file if it exists.
>
> Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
> ---
>
> I have never written or even read any perl code before this (I'm not really
> a programmer) but I managed to come up with this. This seems to work well. If
> more error checking or something is needed, I guess somebody else has to do it;
> my skills aren't quite enough. :)
>
> Any comments?

Hmm.  The loop grabs everything under refs/remotes/$that_remote/ and runs
"update-ref -d" on them.

I somehow had an impression that --no-deref option to update-ref was
invented to allow operating on the symbolic ref itself, instead of
operating on the ref it points at, but it does not seem to work.

I think "update-ref -d" should remove the ref without dereferencing
anyway.  How about not doing your patch at all (you would need to manually
remove the symref in "prune" codepath as well), and instead doing this?

I do not know how this reacts when the tracked HEAD points at a ref that
lexicographically sorts earlier, say branch "A".

-- >8 --
delete_ref(): when symref is given, delete it, not the underlying ref.

Removing the underlying ref without touching the symref does not make any
sense.  An alternative would be to remove the symref _and_ the underlying
ref, but this should do for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index c979fb1..e7c0c38 100644
--- a/refs.c
+++ b/refs.c
@@ -887,7 +887,7 @@ int delete_ref(const char *refname, const unsigned char *sha1)
 	struct ref_lock *lock;
 	int err, i, ret = 0, flag = 0;
 
-	lock = lock_ref_sha1_basic(refname, sha1, 0, &flag);
+	lock = lock_ref_sha1_basic(refname, sha1, REF_NODEREF, &flag);
 	if (!lock)
 		return 1;
 	if (!(flag & REF_ISPACKED)) {
