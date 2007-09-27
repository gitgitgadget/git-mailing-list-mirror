From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] quiltimport: Skip non-existent patches
Date: Thu, 27 Sep 2007 15:02:11 -0700
Message-ID: <7vejgjsr6k.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be>
	<1190925059-5233-1-git-send-email-dbn.lists@gmail.com>
	<loom.20070927T203413-499@post.gmane.org>
	<7v1wcju93a.fsf@gitster.siamese.dyndns.org>
	<91705d080709271445k62f2867am99114eb0e98fc408@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dan Nicholson" <dbn.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib1RB-0006Bv-0g
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 00:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029AbXI0WCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 18:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756948AbXI0WCS
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 18:02:18 -0400
Received: from rune.pobox.com ([208.210.124.79]:34738 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755652AbXI0WCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 18:02:17 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id C068C13D3B6;
	Thu, 27 Sep 2007 18:02:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F8E113A9E7;
	Thu, 27 Sep 2007 18:02:35 -0400 (EDT)
In-Reply-To: <91705d080709271445k62f2867am99114eb0e98fc408@mail.gmail.com>
	(Dan Nicholson's message of "Thu, 27 Sep 2007 14:45:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59341>

"Dan Nicholson" <dbn.lists@gmail.com> writes:

> When you run the command `quilt series', it just lists what's in the
> series file (minus any comments). And when you run `quilt push' with a
> non-existent patch, it says "Patch foo.patch does not exist; applied
> empty patch"
>
> So, I think the consistent thing to do is what's in my patch: just
> skip the patch with a message to the user. Maybe the message can be
> tailored to match quilt's output. Actually, it would be best to also
> skip on empty files since quiltimport will bomb in that case as well.

Thanks for your helpful explanation.  So perhaps we can do this
on top of yours to be safer and more consistent.

---

 git-quiltimport.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 880c81d..627e023 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -79,8 +79,8 @@ for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
 	git mailinfo "$tmp_msg" "$tmp_patch" \
 		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
 	test -s "$tmp_patch" || {
-		echo "Patch is empty.  Was it split wrong?"
-		exit 1
+		echo "Patch is empty. Skipping."
+		continue
 	}
 
 	# Parse the author information
