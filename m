From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Tue, 08 Mar 2016 15:36:26 -0800
Message-ID: <xmqqegbkk0ed.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
	<56DEC4B4.2000902@web.de> <56DED770.4050603@drmicha.warpmail.net>
	<20160308143556.GA10153@sigill.intra.peff.net>
	<xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, Anders Kaseorg <andersk@mit.edu>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 00:36:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adRB4-0006qc-1B
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 00:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbcCHXga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 18:36:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750888AbcCHXg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 18:36:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDD454B004;
	Tue,  8 Mar 2016 18:36:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mbQTtX0Laix9i+nBCwW6z9ZS7mg=; b=iY5w87
	prsuoq5xG7Zusnde6529/NE53hoNIbd3Whd7HIR6a4RSm935STlbskVbUdWRdBbq
	A42CeiymZ76MjtpzYimSOO647BaTMYrd/9OWo8m9XStHUdG6rI7SP6HJP9KGGiIs
	/ZvnpEFTxUX9DH/OlSVX0kyGOuf+m2jKrC3/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w0uovryF/Qal5XMVnNX34OlmKDDhkUpe
	8L6zw0qoDNLV9QwbHUyzMFcEkoU1xmu9c/KFPiL3j/BuT02D8z7EIxFkVQ6tzKsI
	eHuCZF81defnARzNnHjX84yklb+UJzr3gbhybo8f57Reik0eIsl4mx1/1MHuj4Ve
	5zBVlXfsC+Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4CBD4B002;
	Tue,  8 Mar 2016 18:36:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E3D24B001;
	Tue,  8 Mar 2016 18:36:27 -0500 (EST)
In-Reply-To: <xmqqio0wk151.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 08 Mar 2016 15:20:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 93C2F84E-E586-11E5-8BF3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288460>

Subject: rebase-i: clarify "is this commit relevant" test

While I was checking all the call sites of sane_grep and sane_egrep,
I noticed this one is somewhat strangely written.  The lines in the
file sane_grep works on all begin with 40-hex object name, so there
is no real risk of confusing "test $(...) = ''" by finding something
that begins with a dash, but using the status from sane_grep makes
it a lot clearer what is going on.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * By the way, if we are going to take that @@SANE_TEXT_GREP@@
   patch, we'd need to add $(SANE_TEXT_GREP) to SCRIPT_DEFINES
   in Makefile to force git-sh-setup to be regenerated when its
   setting changes.

 git-rebase--interactive.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c0cfe88..4cde685 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1233,7 +1233,8 @@ then
 	git rev-list $revisions |
 	while read rev
 	do
-		if test -f "$rewritten"/$rev && test "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
+		if test -f "$rewritten"/$rev &&
+		   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
 		then
 			# Use -f2 because if rev-list is telling us this commit is
 			# not worthwhile, we don't want to track its multiple heads,
