From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit ending in \ breaks rebase commitlog parsing
Date: Mon, 05 Jul 2010 22:57:51 -0700
Message-ID: <7vfwzx5ezk.fsf@alter.siamese.dyndns.org>
References: <AANLkTim8BGaTvaBFdNDeQp26hwMCztScZFoIHI00DjkD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joshua ben Jore <twists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 07:58:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW1AV-0000K2-JD
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 07:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab0GFF6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 01:58:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0GFF57 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 01:57:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 528D1C1FA8;
	Tue,  6 Jul 2010 01:57:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tKzs3fKsp2thUbIhWppnNDEutfc=; b=dsJVFo
	/UJ5yngxMGE16tktMU4xHOcJi0iA9AK3otZCbeJx9e4piTyrzjVcmNytHXV9kUpY
	znoTXKMDH+kZTwOxmgWqSOhwzH56UbKmPF6NTL6nA0ChpGkjJLQokdqY32dM+Zgc
	ld8bpgWK2k0Bes3wl8Dd641aHLl5wsl8p8Qr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yc94ZRmKg7T8q1+CrAFMuTLzI2g9Gt00
	GrOcSS0jlaBCRFsRu2d9AgYqHcBIENlt90hw4SEcxQ69iWCXFszbyvPZ3nXoOxT7
	kisQaGeKIMZ6CuSt3C2WqnieEoaEJniDfN0M/lz7Jv0IZhWlhlf5eVBV0H4UP2Rf
	Xg0kP9rtNbo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 241E3C1FA7;
	Tue,  6 Jul 2010 01:57:56 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D0BDC1FA3; Tue,  6 Jul
 2010 01:57:53 -0400 (EDT)
In-Reply-To: <AANLkTim8BGaTvaBFdNDeQp26hwMCztScZFoIHI00DjkD@mail.gmail.com>
 (Joshua ben Jore's message of "Mon\, 5 Jul 2010 13\:24\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6C49F73E-88C3-11DF-A2C5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150322>

Joshua ben Jore <twists@gmail.com> writes:

> ... The
> pick list just *drops* the commit, perhaps because some layer thinks
> the commit message is empty?

The problem is that we use "read" in shell to read these insn in the todo
list line by line, but a backslash at the end of line acts as a line
continuation signal.  POSIX compliant shells are supposed to understand
"read -r", so perhaps something like this may help.


 git-rebase--interactive.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

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
