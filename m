From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-am: don't ignore --keep (-k) option
Date: Wed, 25 Nov 2009 09:13:08 +0100
Message-ID: <87638zm38r.fsf_-_@meyering.net>
References: <874ookp4u8.fsf@meyering.net>
	<7vmy2b76ji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 09:13:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDD0A-0002xJ-D9
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 09:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758323AbZKYINL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 03:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbZKYINL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 03:13:11 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:32847 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbZKYINK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 03:13:10 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D9FAE8180E2
	for <git@vger.kernel.org>; Wed, 25 Nov 2009 09:13:11 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 02965818104
	for <git@vger.kernel.org>; Wed, 25 Nov 2009 09:13:08 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 6C1F6213EE; Wed, 25 Nov 2009 09:13:08 +0100 (CET)
In-Reply-To: <7vmy2b76ji.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 24 Nov 2009 17:10:57 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133617>

Junio C Hamano wrote:
> Jim Meyering <meyering@redhat.com> writes:
>> Before this change, a [...] prefix would be removed only as long as
>> its length did not exceed 2/3 of the subject length.  Now, when the
>> bracketed quantity starts with PATCH, it is removed unconditionally.
>> Otherwise, the existing behavior remains unchanged.
>
> Thanks, I think this is a good idea in general, but have two comments.
>
>  - I am not sure how this should play with 17635fc (mailinfo: -b option
>    keeps [bracketed] strings that is not a [PATCH] marker, 2009-07-15).

Ah ha!  I see you've already scratched this itch,
and more thoroughly, to boot.  Also, I prefer your
removal of the hard-to-describe 2/3 threshold.

>  - Regardless of interaction with 17635fc, Things like [RFC PATCH]
>    [SECURITY PATCH] might want a similar treatment.

As your patch does.

I started looking at git-am.sh and spotted what appears to be a typo.
There is only that one use of $keep_subject, so its value currently
comes from the environment.

>From 02f7e6433b5db8b18a4cccf58c302159c2f54fa5 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Wed, 25 Nov 2009 09:10:46 +0100
Subject: [PATCH] git-am: don't ignore --keep (-k) option

Fix typo in variable name: s/keep_subject/keep/.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 151512a..f353e73 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -578,7 +578,7 @@ do
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
 		else
 			SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
-			case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
+			case "$keep" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac

 			(printf '%s\n\n' "$SUBJECT"; cat "$dotest/msg") |
 				git stripspace > "$dotest/msg-clean"
--
1.6.6.rc0.236.ge0b94
