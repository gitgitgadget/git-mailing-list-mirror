From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] t1450: add tests for NUL in headers of commits and tags
Date: Thu, 19 Nov 2015 17:20:14 +0100
Message-ID: <564DF6BE.6020609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 19 17:20:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzRx4-0003M3-Hd
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 17:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbbKSQUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 11:20:46 -0500
Received: from mout.web.de ([212.227.15.4]:61054 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994AbbKSQUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 11:20:44 -0500
Received: from [192.168.178.36] ([79.253.140.34]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LetUF-1aidTL1v3f-00qmJo; Thu, 19 Nov 2015 17:20:24
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Provags-ID: V03:K0:KZ4SzfeLXQxVfSDn4mnMpgOWWljeJyYm1Y0Adbs9GFNawWaSxBR
 WeoLHq+y6m8vq5TRG0TkAkcfsNxCaxvBwYJO2vbk0IJFKu6wGjLhAtEVFz+USJfuHHqUUG/
 qI0muj4G5hK3FnuXtRsL+28EBejGD8E0nuBKl9I+SGEX0Z1uTQDX7Mjy4vxQTVZ5E5kTAUT
 pCUPYe+NNC28u94eNSNCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8FI0hz7dwmA=:LhOs48poqJImkRfHmDvuOo
 FqhRzfI4gefUPWnPyLOjY/kygPS6xDR9Wo6pXzocZ9k3zJJRoppv3DdxbdkaHGRNNq65cPNOp
 hYWIwByoYDjwI1jskqECbuG4pC1FOXN+4Qd2DhgxxUsP4yHMPjobv9tWy3EoelziTRNEV9xqk
 8CbL/+EPa4IXZB4WQhPy6WZDn5qg7GG9bZN7ha08HzhIWE60VsaZVUwFqBTWkNjr9cTFTB3Qs
 Zz/LA5YIgYPgGnML8DwnevcOxzX47CUcV1SZfRSQy0JG5bUB9V8eUzKUK9G9uSzBcYK9uWgtv
 eUkh7yGRkZU003O1FhXDc57bSfoKVfDjKym69W6EbbFI5CnzTzVBes006X4POV6rakpZLSj2p
 VrwJTazbQ7K0IWhD//rfmuU68v2vJVKE3eLt6r3I4t9oyEKYVcOK2UkLs78DNqJhJOA/S+93/
 4gY1ef3u5LSV/TrP2FA/fVJiKSnJwY42VfjTBarUAVqQ6V0UGXLts9bVs6h2/HfkG8sGv1av8
 SN2LWvYuLxGUo+q25S0YqbmQXlngbvja1+hKfF/emwP9ACc5VTBJgt0pGHJttzRzUYSbOEHDC
 izUpVCKPzcEnpFl8WoDeY60UQqbuTXmyJ5qzkAodgqoXG6rIXa+T+/bnn7uZwzku5WzFRR3WK
 VGuzHbUWz0o6UHSi12PdGFOK8wv00ZSSmVCh0kVjMhl15LZ4tuPYYFH9eMMUtMQK/PCcJiSWK
 fRJgA1lFneFeJueWG5i+wqEWoa9NGrtfTrQs7iA2RaqF25ncncCHZNTZQc3yrel9XvY35fHg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281481>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t1450-fsck.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index dc09797..6c96953 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -176,6 +176,18 @@ test_expect_success 'integer overflow in timestamps is reported' '
 	grep "error in commit $new.*integer overflow" out
 '
 
+test_expect_success 'commit with NUL in header' '
+	git cat-file commit HEAD >basis &&
+	sed "s/author ./author Q/" <basis | q_to_nul >commit-NUL-header &&
+	new=$(git hash-object -t commit -w --stdin <commit-NUL-header) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	test_must_fail git fsck 2>out &&
+	cat out &&
+	grep "error in commit $new.*unterminated header: NUL at offset" out
+'
+
 test_expect_success 'malformatted tree object' '
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_when_finished "remove_object \$T" &&
@@ -276,6 +288,26 @@ test_expect_success 'tag with bad tagger' '
 	grep "error in tag .*: invalid author/committer" out
 '
 
+test_expect_failure 'tag with NUL in header' '
+	sha=$(git rev-parse HEAD) &&
+	q_to_nul >tag-NUL-header <<-EOF &&
+	object $sha
+	type commit
+	tag contains-Q-in-header
+	tagger T A Gger <tagger@example.com> 1234567890 -0000
+
+	This is an invalid tag.
+	EOF
+
+	tag=$(git hash-object --literally -t tag -w --stdin <tag-NUL-header) &&
+	test_when_finished "remove_object $tag" &&
+	echo $tag >.git/refs/tags/wrong &&
+	test_when_finished "git update-ref -d refs/tags/wrong" &&
+	test_must_fail git fsck --tags 2>out &&
+	cat out &&
+	grep "error in tag $tag.*unterminated header: NUL at offset" out
+'
+
 test_expect_success 'cleaned up' '
 	git fsck >actual 2>&1 &&
 	test_cmp empty actual
-- 
2.6.3
