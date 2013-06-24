From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] t/t5528-push-default: generalize test_push_*
Date: Sun, 23 Jun 2013 21:33:06 -0700
Message-ID: <1372048388-16742-5-git-send-email-gitster@pobox.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 06:33:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqyTS-0004RX-Df
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 06:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab3FXEdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 00:33:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab3FXEdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 00:33:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FC6C265BF
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RlMl
	BSoX3co3IIjBJ5OqZuRRu8A=; b=M9i/C4f0KV/pkKK6rh4nwzORZ5dMclRB0BG+
	GB+YB74V3cqg/UAQoKGD/+8bTol1e9nIyjhN1+zAdvxBC8pPaVVmQhnpFehKZNla
	JMp4iNwocSxcRPw9HEzZ2QtYMKSpwlKft/JwPgqZhBHMpEhI9NjybLsxp5AuE3tT
	VFWhkww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vRd9vn
	7rYLDX02E4HArwotn89W9G3I4tS3XqIRWU8gSHKZqc0OPT22awoQxHrblj+Qt9rs
	5Bt0T+XSzxxo63JZ8jdyLqxGH/Hg2h6TAAF5f3ED02NqKitMzGluFYUCM50Y/Git
	3kt05ldXKoqXTfAkWmUvPStiAGH07gcJik520=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 149D1265BE
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 977B9265BB
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:17 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-721-g0a353d3
In-Reply-To: <1372048388-16742-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 310E9812-DC87-11E2-9E1A-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228773>

From: Ramkumar Ramachandra <artagnon@gmail.com>

The setup creates two bare repositories: repo1 and repo2, but
test_push_commit() hard-codes checking in repo1 for the actual output.
Generalize it and its caller, test_push_success(), to optionally accept
a third argument to specify the name of the repository to check for
actual output.  We will use this in the next patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5528-push-default.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 69ce6bf..db58e7f 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -15,17 +15,19 @@ test_expect_success 'setup bare remotes' '
 
 # $1 = local revision
 # $2 = remote revision (tested to be equal to the local one)
+# $3 = [optional] repo to check for actual output (repo1 by default)
 check_pushed_commit () {
 	git log -1 --format='%h %s' "$1" >expect &&
-	git --git-dir=repo1 log -1 --format='%h %s' "$2" >actual &&
+	git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&
 	test_cmp expect actual
 }
 
 # $1 = push.default value
 # $2 = expected target branch for the push
+# $3 = [optional] repo to check for actual output (repo1 by default)
 test_push_success () {
 	git -c push.default="$1" push &&
-	check_pushed_commit HEAD "$2"
+	check_pushed_commit HEAD "$2" "$3"
 }
 
 # $1 = push.default value
-- 
1.8.3.1-721-g0a353d3
