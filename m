From: Junio C Hamano <gitster@pobox.com>
Subject: t7004: do not create unneeded gpghome/gpg.conf when GPG is not used
Date: Tue, 18 Dec 2012 11:25:54 -0800
Message-ID: <7vk3sff9h9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 20:26:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl2nv-0000cC-Q5
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 20:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab2LRTZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 14:25:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab2LRTZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 14:25:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE249A31E;
	Tue, 18 Dec 2012 14:25:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	DSVMALfiyZjZGJzG9gGUsCvrtM=; b=g32avcuQQALft6/AEJxNERp1BaAFjdqMP
	RADPPWuW6YZKLt2Lgau0i5Tz9cTMa0o86sCzv+sshDcyk3lAYErqT0e3g5qsWbmL
	2aNgrk+axgEroz1FFHRlJeAJv6ggyexqo6L/dkRhCHieHtuxzpHrZnxukwDiYjt6
	NtujB2Eqi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=MRa
	tEc1tPdNWqD0gR24V0xBJ4tdsCNgVIHD7jU71ZOR6fv9tCYRp23t0epVSmMuWlz6
	u7bU8IR4udFORY2D2RsbKdsX9xu7bHM5/cv/O8nBhoC1Vep6Pmy+c7UyIYKrKZ2k
	ff20+Pc9EAQXdD3HhEjIlVZjfAqpy0eRyd/uOIpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAD5AA31D;
	Tue, 18 Dec 2012 14:25:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22F11A31C; Tue, 18 Dec 2012
 14:25:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEC3A0B2-4948-11E2-95C9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211778>

These tests themselves are properly protected by the GPG
prerequisite, but one of the set-up steps outside the
test_expect_success block unconditionally assumed that there is a
gpghome/ directory, which is not true if GPG is not being used.

It may be a good idea to move the whole set-up steps in the test but
that is a follow-up topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7004-tag.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git i/t/t7004-tag.sh w/t/t7004-tag.sh
index 5189446..f5a79b1 100755
--- i/t/t7004-tag.sh
+++ w/t/t7004-tag.sh
@@ -1066,12 +1066,12 @@ test_expect_success GPG \
 '
 
 # usage with rfc1991 signatures
-echo "rfc1991" > gpghome/gpg.conf
 get_tag_header rfc1991-signed-tag $commit commit $time >expect
 echo "RFC1991 signed tag" >>expect
 echo '-----BEGIN PGP MESSAGE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with rfc1991' '
+	echo "rfc1991" >gpghome/gpg.conf &&
 	git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
 	get_tag_msg rfc1991-signed-tag >actual &&
 	test_cmp expect actual
@@ -1085,6 +1085,7 @@ chmod +x fakeeditor
 
 test_expect_success GPG \
 	'reediting a signed tag body omits signature' '
+	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
 	test_cmp expect actual
@@ -1092,11 +1093,13 @@ test_expect_success GPG \
 
 test_expect_success GPG \
 	'verifying rfc1991 signature' '
+	echo "rfc1991" >gpghome/gpg.conf &&
 	git tag -v rfc1991-signed-tag
 '
 
 test_expect_success GPG \
 	'list tag with rfc1991 signature' '
+	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
 	git tag -l -n1 rfc1991-signed-tag >actual &&
 	test_cmp expect actual &&
