From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 23/23] t5541: test push --signed to smart HTTP server
Date: Mon, 15 Sep 2014 15:24:24 -0700
Message-ID: <1410819864-22967-24-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:25:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeiC-0006b0-07
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbaIOWZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:25:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61187 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbaIOWZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:25:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 898143B1E1;
	Mon, 15 Sep 2014 18:25:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=45X2
	M4NSdMfGySpAFTCX4S6r2/c=; b=fhNukc9k46D19CJ1+mEhVTmvWp/5O2RcYW7T
	wXIGR1stCf6mZzTwXo6KJvU7YuTQDXiV2KNMFzDekKaGyVCG50QvhY0pHjeCZ6EH
	9GVHA3I8OrIpMsKNYvhCtVNQ0hHNfubXJtKTPmJPmrJlBGy7kRYBPZ04tbMChCn4
	ZFlqNGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FfHF07
	AvrgYTrAWtAdQE+JheXbs+XdpVYEnW9bkXCParexL74LXIKW7Ub3tsx3PLGHffJj
	kiBKkhwsmIqFvT10+QZttNrY5Mj8cBQLH2zFv4NWgdbUdhdWJDU90ED09cUvUuZb
	AUWbjCUvnOV3BhRuBYoTW6beILK6bKnN48iBM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 814463B1E0;
	Mon, 15 Sep 2014 18:25:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0DB813B1DF;
	Mon, 15 Sep 2014 18:25:11 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 28831A9A-3D27-11E4-8CF9-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257105>

Currently it seems that somewhere in the transport option setting
chain the "--signed" bit gets lost and this does not pass.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5541-http-push-smart.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 73af16f..3915f67 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -14,6 +14,7 @@ fi
 ROOT_PATH="$PWD"
 . "$TEST_DIRECTORY"/lib-httpd.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
 start_httpd
 
 test_expect_success 'setup remote repository' '
@@ -323,5 +324,43 @@ test_expect_success 'push into half-auth-complete requires password' '
 	test_cmp expect actual
 '
 
+test_expect_failure GPG 'push with post-receive to inspect certificate' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+		mkdir -p hooks &&
+		write_script hooks/post-receive <<-\EOF &&
+		# discard the update list
+		cat >/dev/null
+		# record the push certificate
+		if test -n "${GIT_PUSH_CERT-}"
+		then
+			git cat-file blob $GIT_PUSH_CERT >../push-cert
+		fi &&
+		env >../env &&
+		cat >../push-cert-status <<E_O_F
+		SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
+		KEY=${GIT_PUSH_CERT_KEY-nokey}
+		STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
+		NONCE=${GIT_PUSH_CERT_NONCE-nononce}
+		E_O_F
+		EOF
+
+		git config receive.certnonceseed sekrit
+	) &&
+	cd "$ROOT_PATH/test_repo_clone" &&
+	test_commit cert-test &&
+	git push --signed "$HTTPD_URL/smart/test_repo.git" &&
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH" &&
+		cat <<-\EOF &&
+		SIGNER=C O Mitter <committer@example.com>
+		KEY=13B6F51ECDDE430D
+		STATUS=G
+		EOF
+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" push-cert
+	) >expect &&
+	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH/push-cert-status"
+'
+
 stop_httpd
 test_done
-- 
2.1.0-410-gd72dacd
