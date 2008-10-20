From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase-i-p: only list commits that require rewriting in
 todo
Date: Mon, 20 Oct 2008 16:36:38 -0700
Message-ID: <7vej2a3kl5.fsf@gitster.siamese.dyndns.org>
References: <cover.1224055978.git.stephen@exigencecorp.com>
 <0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com> <20081020115003.GA11309@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Haberman <stephen@exigencecorp.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 01:54:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks4K0-0003Og-Q4
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 01:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYJTXgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 19:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYJTXgs
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 19:36:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYJTXgr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 19:36:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E7FE8D520;
	Mon, 20 Oct 2008 19:36:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 24B778D51F; Mon, 20 Oct 2008 19:36:39 -0400 (EDT)
In-Reply-To: <20081020115003.GA11309@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 20 Oct 2008 07:50:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F56DC554-9EFF-11DD-AA40-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98744>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 15, 2008 at 02:44:38AM -0500, Stephen Haberman wrote:
>
>> +					cat "$TODO" | grep -v "${rev:0:7}" > "${TODO}2" ; mv "${TODO}2" "$TODO"
>
> Substring expansion (like ${rev:0:7}) is not portable. At least it
> doesn't work on FreeBSD /bin/sh, and "it's not even in POSIX", I
> believe.

True.

I do not remember the individual patches in the series, but I have to say
that the script at the tip of the topic is, eh, less than ideal.

Here is a small untested patch to fix a few issues I spotted while reading
it for two minutes.

 * Why filter output from "rev-list --left-right A...B" and look for the
   ones that begin with ">"?  Wouldn't "rev-list A..B" give that?

 * The abbreviated SHA-1 are made with "rev-list --abbrev=7" into $TODO in
   an earlier invocation, and it can be more than 7 letters to avoid
   ambiguity.  Not just that "${r:0:7} is not even in POSIX", but use of
   it here is actively wrong.

 * There is no point in catting a single file and piping it into grep.


 git-rebase--interactive.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git i/git-rebase--interactive.sh w/git-rebase--interactive.sh
index 848fbe7..a563dea 100755
--- i/git-rebase--interactive.sh
+++ w/git-rebase--interactive.sh
@@ -635,8 +635,8 @@ first and then run 'git rebase --continue' again."
 				sed -n "s/^>//p" > "$DOTEST"/not-cherry-picks
 			# Now all commits and note which ones are missing in
 			# not-cherry-picks and hence being dropped
-			git rev-list $UPSTREAM...$HEAD --left-right | \
-				sed -n "s/^>//p" | while read rev
+			git rev-list $UPSTREAM..$HEAD |
+			while read rev
 			do
 				if test -f "$REWRITTEN"/$rev -a "$(grep "$rev" "$DOTEST"/not-cherry-picks)" = ""
 				then
@@ -645,7 +645,8 @@ first and then run 'git rebase --continue' again."
 					# just the history of its first-parent for others that will
 					# be rebasing on top of it
 					git rev-list --parents -1 $rev | cut -d' ' -f2 > "$DROPPED"/$rev
-					cat "$TODO" | grep -v "${rev:0:7}" > "${TODO}2" ; mv "${TODO}2" "$TODO"
+					short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
+					grep -v "^[a-z][a-z]* $short" <"$TODO" > "${TODO}2" ; mv "${TODO}2" "$TODO"
 					rm "$REWRITTEN"/$rev
 				fi
 			done
