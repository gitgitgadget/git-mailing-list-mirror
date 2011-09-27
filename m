From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] grep: --untracked and --exclude tests
Date: Tue, 27 Sep 2011 15:22:33 -0700
Message-ID: <7voby5wrpy.fsf_-_@alter.siamese.dyndns.org>
References: <2f376e61802a1a38c67698d5ec263d1807b1fcee.1316110876.git.bert.wesarg@googlemail.com> <7b3551dd84a2bfec78c8db1d14dd2d0e6dda35f6.1316110876.git.bert.wesarg@googlemail.com> <7vmxe5pp4n.fsf@alter.siamese.dyndns.org> <CAKPyHN2ewwLf6am3VQr_z4c3_Q5=saeLcZtuY-fEtUGr-41rKQ@mail.gmail.com> <7vty7xwrsf.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 00:22:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8g31-00026h-TM
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 00:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab1I0WWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 18:22:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab1I0WWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 18:22:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33E9F5554;
	Tue, 27 Sep 2011 18:22:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JsUufOqVgIspBIJL6q4VpXiVOAY=; b=WlSjTR
	QBP6kBN9bDjwqj02ZgQO13f8IqEXauyIHJFAdK4V8RaeSWvJku0hMk18DusWjPxH
	+p53p9LjEkUsm6YiuEDXy3KwLzbVfgLfjqq9Ks3QD0M+Tr+xOOkp5yw8cg0XR8E+
	XiTEewXGqMqtDuQceidIvL1LfnBJfIjd6ghjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jo4tkZRINywy7IRdMnskJ+DD24nU4OWp
	Nd6RCM0Svbp1ods+oGEncbr/aBwhWZsFywp6sPjq44txl9AD0IuLzE6PKEIL4LzI
	vhy694AOHO3YEwE6Xg/1lIEf/RvXjNgdq/OIPLVv4T5J4Q9xG03qnkI69oOLoT/i
	GcyiGZHt0MA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 287B45553;
	Tue, 27 Sep 2011 18:22:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6291B5551; Tue, 27 Sep 2011
 18:22:35 -0400 (EDT)
In-Reply-To: <7vty7xwrsf.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 27 Sep 2011 15:21:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 335AF478-E957-11E0-A8BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182272>

Test various combinations of these options and --no-index.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7002-grep.sh |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 918d33f..2cbbdcc 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -455,6 +455,23 @@ test_expect_success 'outside of git repository' '
 		test_must_fail git grep o &&
 		git grep --no-index o >../../actual.sub &&
 		test_cmp ../../expect.sub ../../actual.sub
+	) &&
+
+	echo ".*o*" >non/git/.gitignore &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git grep o &&
+		git grep --no-index --exclude o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+
+		{
+			echo ".gitignore:.*o*"
+			cat ../expect.full
+		} >../expect.with.ignored &&
+		git grep --no-index --no-exclude o >../actual.full &&
+		test_cmp ../expect.with.ignored ../actual.full
 	)
 '
 
@@ -465,9 +482,12 @@ test_expect_success 'inside git repository but with --no-index' '
 	echo world >is/git/sub/file2 &&
 	echo ".*o*" >is/git/.gitignore &&
 	{
-		echo ".gitignore:.*o*" &&
 		echo file1:hello &&
 		echo sub/file2:world
+	} >is/expect.unignored &&
+	{
+		echo ".gitignore:.*o*" &&
+		cat is/expect.unignored
 	} >is/expect.full &&
 	: >is/expect.empty &&
 	echo file2:world >is/expect.sub
@@ -476,12 +496,24 @@ test_expect_success 'inside git repository but with --no-index' '
 		git init &&
 		test_must_fail git grep o >../actual.full &&
 		test_cmp ../expect.empty ../actual.full &&
+
+		git grep --untracked o >../actual.unignored &&
+		test_cmp ../expect.unignored ../actual.unignored &&
+
 		git grep --no-index o >../actual.full &&
 		test_cmp ../expect.full ../actual.full &&
+
+		git grep --no-index --exclude o >../actual.unignored &&
+		test_cmp ../expect.unignored ../actual.unignored &&
+
 		cd sub &&
 		test_must_fail git grep o >../../actual.sub &&
 		test_cmp ../../expect.empty ../../actual.sub &&
+
 		git grep --no-index o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub &&
+
+		git grep --untracked o >../../actual.sub &&
 		test_cmp ../../expect.sub ../../actual.sub
 	)
 '
-- 
1.7.7.rc3.4.g8d714
