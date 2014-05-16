From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] request-pull: resurrect for-linus -> tags/for-linus DWIM
Date: Fri, 16 May 2014 10:57:50 -0700
Message-ID: <1400263070-15312-1-git-send-email-gitster@pobox.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 20:25:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlMpH-0002Nv-O9
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757714AbaEPSZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 14:25:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51436 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbaEPSZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 14:25:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 238D619CA1;
	Fri, 16 May 2014 14:25:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=XUSp8MHu7CLzILSjnO0NhkIBFe0
	=; b=GsJHSWGPDxXw2rn/S38kjyfu3Bv8C8B9N1RJFOyKkzzGxfFYfTUCXAXT+aL
	+Z3oi3y/OnJCuaZaPpaPYnrnCnz9AYZX/93DNK3BGNKFn1cs0Cpar+1ykZfcjI4a
	x6MzMjXPl0IREagV/gufNsTFZQxzTN/0v0rt0OSN7nBNKBR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=SIdW6zGzXRw3UtNipJn7R
	5Qwm+DlAGRGXFmktWF5x/XSP+APzMXImSfXEPlIQNmFeqMADlUoN0dTw7jnf91LB
	w7S8sUaUUEGTT0jJFzhdvXQcIbiHnXksyMyUZNyA2/2hjZkq43FnDdMWDwi4t09g
	+Hg4yBozyBnjsziSilYd8c=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19A9919CA0;
	Fri, 16 May 2014 14:25:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0D033189F9;
	Fri, 16 May 2014 13:57:51 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc3-434-g1ba2fe8
X-Pobox-Relay-ID: 99878A5A-DD23-11E3-A0DB-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249404>

Older versions of Git before v1.7.10 did not DWIM

    $ git pull $URL for-linus

to the tag "tags/for-linus" and the users were required to say

    $ git pull $URL tags/for-linus

instead.  Because newer versions of Git works either way,
request-pull used to show tags/for-linus when asked

    $ git request-pull origin/master $URL for-linus

The recent updates broke this and in the output we see "for-linus"
without the "tags/" prefix.

As v1.7.10 is more than 2 years old, this should matter very little
in practice, but resurrecting it is very simple.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I _think_ the fix, without breaking the spirit of Linus's "I do
   not want the thing DWIM based on what the remote end has"
   original, would be as simple as this patch.  We can queue it as a
   regression fix and do another round of -rc4 if those who depend
   on request-pull heavily feel strongly about it.

 git-request-pull.sh     | 6 ++++++
 t/t5150-request-pull.sh | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index b67513a..d6648b2 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -118,6 +118,12 @@ then
 	status=1
 fi
 
+# Special case: turn "for_linus" to "tags/for_linus" when it is correct
+if test "$ref" = "refs/tags/$pretty_remote"
+then
+	pretty_remote=tags/$pretty_remote
+fi
+
 url=$(git ls-remote --get-url "$url")
 
 git show -s --format='The following changes since commit %H:
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 75d6b38..93e2c65 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -223,7 +223,13 @@ test_expect_success 'pull request format' '
 		git request-pull initial "$downstream_url" tags/full:refs/tags/full
 	) >request &&
 	sed -nf fuzz.sed <request >request.fuzzy &&
-	test_i18ncmp expect request.fuzzy
+	test_i18ncmp expect request.fuzzy &&
+
+	(
+		cd local &&
+		git request-pull initial "$downstream_url" full
+	) >request &&
+	grep ' tags/full$'
 '
 
 test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
-- 
2.0.0-rc3-434-g1ba2fe8
