From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase -i --root: simplify code
Date: Sun, 25 Jan 2009 21:54:10 -0800
Message-ID: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901260029480.14855@racer>
 <alpine.DEB.1.00.0901260031460.14855@racer>
 <200901260049.25563.trast@student.ethz.ch>
 <200901260053.06315.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 26 07:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRKb1-0006Dm-Hz
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 07:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbZAZFyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 00:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbZAZFyS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 00:54:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbZAZFyR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 00:54:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B4C21D4E5;
	Mon, 26 Jan 2009 00:54:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2F7091D4E2; Mon,
 26 Jan 2009 00:54:12 -0500 (EST)
In-Reply-To: <200901260053.06315.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon, 26 Jan 2009 00:53:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C3DD1DC2-EB6D-11DD-9F6B-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Rast <trast@student.ethz.ch> writes:

> Thomas Rast wrote:
>>           test ! -s "$DOTEST"/upstream && REBASE_ROOT=t
>
> Actually, I think that test never worked (and it's clearly my fault).
>
> The corresponding 'echo $UPSTREAM > "$DOTEST"/upstream' just expanded
> to 'echo > ...', resulting in a file containing a single newline, but
> never a zero-length file.  Duh.

Since you never use the value stored in "$DOTEST/upstream" for anything
else anyway, how about doing something like this instead?  It would make
the meaning of the file used as a state variable much clearer.

It may break hooks and outside scripts that look at $DOTEST/upstream.  I
didn't check.

The hunk in the middle is to protect you against an environment variable
UPSTREAM the user may have before starting "rebase -i".  There could be
other state variables you added in recent commit d911d14 (rebase -i: learn
to rebase root commit, 2009-01-02) that needs similar protection.  Please
check.

 git-rebase--interactive.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git c/git-rebase--interactive.sh w/git-rebase--interactive.sh
index 21ac20c..17cf0e5 100755
--- c/git-rebase--interactive.sh
+++ w/git-rebase--interactive.sh
@@ -456,7 +456,7 @@ get_saved_options () {
 	test -d "$REWRITTEN" && PRESERVE_MERGES=t
 	test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 	test -f "$DOTEST"/verbose && VERBOSE=t
-	test ! -s "$DOTEST"/upstream && REBASE_ROOT=t
+	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
 }
 
 while test $# != 0
@@ -585,6 +585,7 @@ first and then run 'git rebase --continue' again."
 			test -z "$ONTO" && ONTO=$UPSTREAM
 			shift
 		else
+			UPSTREAM=
 			UPSTREAM_ARG=--root
 			test -z "$ONTO" &&
 				die "You must specify --onto when using --root"
@@ -611,7 +612,12 @@ first and then run 'git rebase --continue' again."
 			echo "detached HEAD" > "$DOTEST"/head-name
 
 		echo $HEAD > "$DOTEST"/head
-		echo $UPSTREAM > "$DOTEST"/upstream
+		case "$REBASE_ROOT" in
+		'')
+			rm -f "$DOTEST"/rebase-root ;;
+		*)
+			: >"$DOTEST"/rebase-root ;;
+		esac
 		echo $ONTO > "$DOTEST"/onto
 		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
