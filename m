From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] work around an obnoxious bash "safety feature" on OpenBSD
Date: Tue, 26 Jan 2010 16:29:30 -0800
Message-ID: <7veilcxudx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 01:29:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZvmy-00021f-LC
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 01:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab0A0A3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 19:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676Ab0A0A3j
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 19:29:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab0A0A3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 19:29:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69AB0946FB;
	Tue, 26 Jan 2010 19:29:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Ai0q
	qVOxbeRp2U82rEw2oDldTfU=; b=TyDvNjMYvDmSHrKGBdqPHhk2cNPsyZ2HZ4rM
	YHcM+EH5WsLeNprzX/QIVEBSRK6eidIMjsMCPddlNKGGJz5mfiSGNRghqiPFTPWb
	kyomsoTkrb5Y2G3C7p8bxDrBUFc13LpjmoIzBwf051szm7Y4YAREGoKW1Irum2iE
	ibjv/uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=j1n
	9Uc3eMH1xZ1RhF/cPzhEOAUIhjjV55PcBtSBfX4haypBn6mu88P1Q8jBtHPFmh2F
	31usyhEd3zotGfyUNh7QWcwIPJMYcQhEEZiB7hWoClZp2iOW6B4kMqfKQRbFdwGA
	hLowRaCfxBdQSEaiehzM2bJ6rXwsycNRaCFI/KE8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56843946FA;
	Tue, 26 Jan 2010 19:29:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1E35946F9; Tue, 26 Jan
 2010 19:29:31 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A6A4F48-0ADB-11DF-9ADB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138092>

Bash (4.0.24) on OpenBSD 4.6 refuses to run this snippet:

    $ cat gomi.sh
    #!/bin/sh
    one="/var/tmp/1 1"
    rm -f /var/tmp/1 "/var/tmp/1 1"
    echo hello >$one
    $ sh gomi.sh; ls /var/tmp/1*
    /var/tmp/1 1
    $ bash gomi.sh; ls /var/tmp/1*
    gomi.sh: line 4: $one: ambiguous redirect
    ls: /var/tmp/1*: No such file or directory

Every competent shell programmer knows that a <$word in redirection is not
subject to field splitting (POSIX.1 "2.7 Redirection" explicitly lists the
kind of expansion performed: "... the word that follows the redirection
operator shall be subjected to ...", and "Field Splitting" is not among
them).

Some clueless folks apparently decided that users need to be protected in
the name of "security", however.

Output from "git grep -e '> *\$' -- '*.sh'" indicates that rebase-i
suffers from this bogus "safety".  Work it around by surrounding the
variable reference with a dq pair.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I don't regularly run OpenBSD and build test on the platform only
   occasionally.  People who _do_ care about the platform perhaps need to
   run the testsuite to find and help fixing other possible issues.

   You will trigger this the path to your git work tree has whitespace
   in it, e.g. t3404.

 git-rebase--interactive.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 19a608c..cecaa1d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -368,7 +368,8 @@ nth_string () {
 }
 
 update_squash_messages () {
-	if test -f "$SQUASH_MSG"; then
+	if test -f "$SQUASH_MSG"
+	then
 		mv "$SQUASH_MSG" "$SQUASH_MSG".bak || exit
 		COUNT=$(($(sed -n \
 			-e "1s/^# This is a combination of \(.*\) commits\./\1/p" \
@@ -378,7 +379,7 @@ update_squash_messages () {
 			sed -e 1d -e '2,/^./{
 				/^$/d
 			}' <"$SQUASH_MSG".bak
-		} >$SQUASH_MSG
+		} >"$SQUASH_MSG"
 	else
 		commit_message HEAD > "$FIXUP_MSG" || die "Cannot write $FIXUP_MSG"
 		COUNT=2
@@ -387,7 +388,7 @@ update_squash_messages () {
 			echo "# The first commit's message is:"
 			echo
 			cat "$FIXUP_MSG"
-		} >$SQUASH_MSG
+		} >"$SQUASH_MSG"
 	fi
 	case $1 in
 	squash)
@@ -403,7 +404,7 @@ update_squash_messages () {
 		echo
 		commit_message $2 | sed -e 's/^/#	/'
 		;;
-	esac >>$SQUASH_MSG
+	esac >>"$SQUASH_MSG"
 }
 
 peek_next_command () {



    
