From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t0005: ksh93 portability workaround
Date: Tue, 31 May 2016 15:47:01 -0700
Message-ID: <xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 00:47:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7sRO-0003rd-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbcEaWrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 18:47:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751287AbcEaWrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:47:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 987161EF24;
	Tue, 31 May 2016 18:47:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	8PE2UVk0sq1pME9EdAgQDmkG3I=; b=PkgMb9ldVy5GT2sV8jkW0BrhAAqelGF2j
	IcQbB7+D6B9x7lHh1ljfFuk8Y4Jdqcm5Tjf+rMScdjqwV9YF9uVZAGxM4Oi5mMNn
	ys6m+rCRoWIUH44qIXhNS6XTOeY6iIjSaB+jabWwadbyiVjJMaEU0djrayTyuiH8
	HOuEeKB1+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=iaJ
	wT6m5jr6abcVD0+tQJcjKi57+9s8NnC9xZBVlGDtiple+m5Q1dLxxAUPmDb+X41v
	5ClLvysIbWXXcwFmpr5wIhyjfpFlPj/m07Sv2IfRjHPYHHpZ2krP0ww8UabJYe/a
	P96X961+jr0X982wB8adLIVfdhfBHxRX/VckGx20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 90CAB1EF23;
	Tue, 31 May 2016 18:47:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 159821EF22;
	Tue, 31 May 2016 18:47:03 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 97B73180-2781-11E6-B0CB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296026>

The test has two things ksh93 does not happy about:

 * It thinks "(( command1; command2 ) | command3)" is a perfectly
   sane way to write a pipeline.  ksh93, unlike other POSIX shells,
   does not like the two open parentheses next to each other for
   whatever reason it has.

 * It adds 256, unlike 128 that are used by other POSIX shells, to
   the signal number that caused the process to die when coming up
   with the exit status.

What is interesting is that we knew about the latter issue and had a
workaround in the test-sigchain test when verifying that SIGTERM
works OK, but we didn't have corresponding workaround for SIGPIPE.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0005-signals.sh | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index e7f27eb..12b4efb 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -9,6 +9,16 @@ two
 one
 EOF
 
+died_with_sigpipe () {
+	case "$1" in
+	141 | 269)
+		# POSIX w/ SIGPIPE=13 gives 141
+		# ksh w/ SIGPIPE=13 gives 269
+		true ;;
+	*)	false ;;
+	esac
+}
+
 test_expect_success 'sigchain works' '
 	{ test-sigchain >actual; ret=$?; } &&
 	case "$ret" in
@@ -40,13 +50,13 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
-	test "$OUT" -eq 141
+	OUT=$( ( (large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	died_with_sigpipe "$OUT"
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
-	test "$OUT" -eq 141
+	OUT=$( ( (trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	died_with_sigpipe "$OUT"
 '
 
 test_done
