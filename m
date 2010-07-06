From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] rebase-i: do not get fooled by a log message ending with
 backslash
Date: Mon,  5 Jul 2010 23:27:11 -0700
Message-ID: <1278397631-20658-3-git-send-email-gitster@pobox.com>
References: <1278397631-20658-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 08:27:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW1cp-0003GP-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 08:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0GFG1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 02:27:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab0GFG1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 02:27:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5154C0277
	for <git@vger.kernel.org>; Tue,  6 Jul 2010 02:27:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FBP6
	TTZHjEmItMvxUCNwTZQ+Kpk=; b=A2z8bTrRaaK+47Di2PK2GCXseJpVt66Ap6cO
	olQZgRKKadnKpdGn+tUDq/KCXwyKrAe5baEvzd7kmiQYok4aR2L8dbHnIcTeP1eu
	bdvhik5e/GQbvJ4PYiIpP8PN5omdBhJfo/bt6h2X7zjjJ7U1KBaqY8ontfNfa0IO
	pl64IFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=OBCS4q
	gd6U7HpJMBTWRZmQ6O/ZjiPXbUfAn2iGYM/gKHd8e5Z0WNZB7RTQFzM7zItlLMVe
	VlHtHfdDAjYZKbaiEaUeTVv4voWpEAFUVn9FQ2sb7GMw5V2kWLV311ar36xn02Dw
	orHT3FOtGOc5F3QeeMsg+WGkJQzanTTjQNd34=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2837C0275
	for <git@vger.kernel.org>; Tue,  6 Jul 2010 02:27:17 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 115ECC0274 for
 <git@vger.kernel.org>; Tue,  6 Jul 2010 02:27:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.209.g3868f
In-Reply-To: <1278397631-20658-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 863C7B0E-88C7-11DF-8F43-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150328>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh    |   10 +++++-----
 t/t3404-rebase-interactive.sh |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ed57552..31e6860 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -450,7 +450,7 @@ record_in_rewritten() {
 
 do_next () {
 	rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" || exit
-	read command sha1 rest < "$TODO"
+	read -r command sha1 rest < "$TODO"
 	case "$command" in
 	'#'*|''|noop)
 		mark_action_done
@@ -591,7 +591,7 @@ do_rest () {
 # skip picking commits whose parents are unchanged
 skip_unnecessary_picks () {
 	fd=3
-	while read command sha1 rest
+	while read -r command sha1 rest
 	do
 		# fd=3 means we skip the command
 		case "$fd,$command,$(git rev-parse --verify --quiet $sha1^)" in
@@ -644,13 +644,13 @@ rearrange_squash () {
 	test -s "$1.sq" || return
 
 	used=
-	while read pick sha1 message
+	while read -r pick sha1 message
 	do
 		case " $used" in
 		*" $sha1 "*) continue ;;
 		esac
 		echo "$pick $sha1 $message"
-		while read squash action msg
+		while read -r squash action msg
 		do
 			case "$message" in
 			"$msg"*)
@@ -891,7 +891,7 @@ first and then run 'git rebase --continue' again."
 			--abbrev=7 --reverse --left-right --topo-order \
 			$REVISIONS | \
 			sed -n "s/^>//p" |
-		while read shortsha1 rest
+		while read -r shortsha1 rest
 		do
 			if test t != "$PRESERVE_MERGES"
 			then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ee9a1b2..47ca88f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -630,4 +630,22 @@ test_expect_success 'always cherry-pick with --no-ff' '
 	test_cmp empty out
 '
 
+test_expect_success 'set up commits with funny messages' '
+	git checkout -b funny A &&
+	echo >>file1 &&
+	test_tick &&
+	git commit -a -m "end with slash\\" &&
+	echo >>file1 &&
+	test_tick &&
+	git commit -a -m "another commit"
+'
+
+test_expect_success 'rebase-i history with funny messages' '
+	git rev-list A..funny >expect &&
+	test_tick &&
+	FAKE_LINES="1 2" git rebase -i A &&
+	git rev-list A.. >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.2.rc1.209.g3868f
