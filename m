From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Wed, 26 Dec 2007 11:36:25 -0800
Message-ID: <7v4pe5nt8m.fsf@gitster.siamese.dyndns.org>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
	<8763yof9lg.fsf@gollum.intra.norang.ca>
	<Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<20071225044202.GO14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 26 20:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7c3t-0004KL-OY
	for gcvg-git-2@gmane.org; Wed, 26 Dec 2007 20:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbXLZTgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 14:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbXLZTgk
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 14:36:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbXLZTgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 14:36:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 64CF6236B;
	Wed, 26 Dec 2007 14:36:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B03742369;
	Wed, 26 Dec 2007 14:36:32 -0500 (EST)
In-Reply-To: <20071225044202.GO14735@spearce.org> (Shawn O. Pearce's message
	of "Mon, 24 Dec 2007 23:42:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69244>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> There is nothing that requires that a commit object end with an LF.
> So tools that make this assumption (that there is a trailing LF)
> while processing the body of a commit message are quite simply
> broken.
> ...
> IMHO git-gui is producing valid commit messages, and always does
> so with no trailing LF, and any tool that is assuming a trailing
> LF is always present is broken.

I would not go that far, even though I would agree that the
consumers of existing commits should be lenient and the creators
of new commits should be strict.

Now, "strict" and "lenient" are both relative to some yardstick,
but relative to what?  I would say that the UI layer of "git the
SCM" is about helping humans create commit messages for human
consumption, even though the low-level commit objects are
equipped to record any binary blob (including NUL byte).

As UI layer programs, I think "git commit" and "git rebase -i"
can and should be stricter than allowing "arbitrary binary
blobs".  Namely, they should make sure what they produce are
good text messages (and a good text message ends with a LF ---
prepare a file with an incomplete line, run "cat file" from
interactive shell on it, and see your prompt tucked at the end
before arguing otherwise).

So how about doing something like this?

---
 git-rebase--interactive.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 090c3e5..d0d83c3 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -215,15 +215,17 @@ make_squash_message () {
 		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
 			< "$SQUASH_MSG" | tail -n 1)+1))
 		echo "# This is a combination of $COUNT commits."
-		sed -n "2,\$p" < "$SQUASH_MSG"
+		sed -e 1d -e '2,/^./{
+			/^$/d
+		}' <"$SQUASH_MSG"
 	else
 		COUNT=2
 		echo "# This is a combination of two commits."
 		echo "# The first commit's message is:"
 		echo
 		git cat-file commit HEAD | sed -e '1,/^$/d'
-		echo
 	fi
+	echo
 	echo "# This is the $(nth_string $COUNT) commit message:"
 	echo
 	git cat-file commit $1 | sed -e '1,/^$/d'
