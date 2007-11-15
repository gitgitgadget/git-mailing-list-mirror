From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Bisect reset: remove bisect refs that may have been packed.
Date: Thu, 15 Nov 2007 00:18:47 -0800
Message-ID: <7vwssj6hw8.fsf@gitster.siamese.dyndns.org>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZwP-0001cU-LD
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbXKOIS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbXKOIS4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:18:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54655 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbXKOISz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:18:55 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3EEBB2EF;
	Thu, 15 Nov 2007 03:19:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id AF12894DC2;
	Thu, 15 Nov 2007 03:19:12 -0500 (EST)
In-Reply-To: <20071115081807.06fe092b.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 15 Nov 2007 08:18:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65084>

Christian Couder <chriscool@tuxfamily.org> writes:

> If refs were ever packed in the middle of bisection, the bisect
> refs were not removed from the "packed-refs" file.
>
> This patch fixes this problem by using "git update-ref -d $ref $hash"
> in "bisect_clean_state".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Thanks.  Just a few nits.

On top of your patch...

 - You forgot to remove one "removal of filesystem refs";
 - for-each-ref takes more than one patterns.

 git-bisect.sh |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 584906f..21ed02f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -350,17 +350,12 @@ bisect_reset() {
 }
 
 bisect_clean_state() {
-	rm -fr "$GIT_DIR/refs/bisect"
-
 	# There may be some refs packed during bisection.
-	git for-each-ref --format='%(refname) %(objectname)' \
-		"refs/bisect/*" | while read ref hash
+	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* refs/heads/bisect |
+	while read ref hash
 	do
 		git update-ref -d $ref $hash
 	done
-
-	hash=$(git show-ref --hash refs/heads/bisect)
-	test -n "$hash" && git update-ref -d refs/heads/bisect $hash
 	rm -f "$GIT_DIR/BISECT_LOG"
 	rm -f "$GIT_DIR/BISECT_NAMES"
 	rm -f "$GIT_DIR/BISECT_RUN"
