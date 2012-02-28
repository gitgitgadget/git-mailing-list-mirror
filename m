From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] test: "am -3" can accept non-standard -p<num>
Date: Tue, 28 Feb 2012 15:24:55 -0800
Message-ID: <1330471495-12013-3-git-send-email-gitster@pobox.com>
References: <1330471495-12013-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 00:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2WQC-0002JW-Me
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 00:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965719Ab2B1XZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 18:25:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965522Ab2B1XZB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 18:25:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DECC37A1F
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 18:25:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Q5u+
	nWudt/Auej/hXawPJod4k5g=; b=NeT3gATI+7cP/eGC1wwffkMLcq904qKoI35g
	pL8XYbH/STjStVLItQg7ZKhFoGHF1paAHpJtevKw8O3gQDQEQ8jgKWhe28F2WynL
	dzY0E8E07o7nt8nOsGFZbfVu01Z6Fetb1XV09DsmEzA/nCnY1VoqPbpEkpkuyZY1
	07a9+Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QV+VOr
	RxBqopzl5ZeCs4GsBBQjcPRhpscc9dW/KwxMDcCEHONtjFJ8WJtRojqNga1mYznU
	O/+pmj5QJXq93CTN0piC5Z/V/MMXOMTolohLlFXTe15k1TLGlJWMEPE0hR+vVYP2
	Dg1bOZzBi0ulsAXCSnBkz3huoCsHi0LUItG7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0887A1E
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 18:25:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C6957A1D for
 <git@vger.kernel.org>; Tue, 28 Feb 2012 18:25:00 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.344.g3e8c86
In-Reply-To: <1330471495-12013-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6F123320-6263-11E1-A910-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191793>

This adds a test for the previous one to make sure that "am -3 -p0" can
read patches created with the --no-prefix option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4150-am.sh |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index d7d9ccc..e1d381c 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -123,6 +123,7 @@ test_expect_success setup '
 	git commit -m "added another file" &&
 
 	git format-patch --stdout master >lorem-move.patch &&
+	git format-patch --no-prefix --stdout master >lorem-zero.patch &&
 
 	git checkout -b rename &&
 	git mv file renamed &&
@@ -276,6 +277,20 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 	git diff --exit-code lorem
 '
 
+test_expect_success 'am -3 -p0 can read --no-prefix patch' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout -b lorem3 master2 &&
+	sed -n -e "3,\$p" msg >file &&
+	head -n 9 msg >>file &&
+	git add file &&
+	test_tick &&
+	git commit -m "copied stuff" &&
+	git am -3 -p0 lorem-zero.patch &&
+	! test -d .git/rebase-apply &&
+	git diff --exit-code lorem
+'
+
 test_expect_success 'am can rename a file' '
 	grep "^rename from" rename.patch &&
 	rm -fr .git/rebase-apply &&
-- 
1.7.9.2.344.g3e8c86
