From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 21/25] apply: --build-fake-ancestor expects blobs
Date: Tue,  3 Jul 2012 14:37:11 -0700
Message-ID: <1341351435-31011-22-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAns-0005gY-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928Ab2GCVi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756579Ab2GCVh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C18FE8696
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KXCr
	0qgbvR6vxs5Wo8PYJ5uvDKw=; b=EuPzBmC5RVikwjOfnEUxz22OaXn0dpyaHdCY
	0X+/8YTuAyZfSfhPJrXqMEs4Y5O17kVfFICpAWuhA9AQWHagJi3S/Cc9ujCmcI4h
	sipCsy5UUd1qdcZ4l4bY4/UL8AX8wZN7ECGzN8mxkEaIIgPyw0WSlRgPvxwwKE7b
	GCeHNgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fxHV+Z
	Qv+wp+ahoKstpfyGsF4pDN4abcmg7HAP0mGRPZWuydPtzWHIw6BERL1CUr9hOaZa
	3Qz4jW2aWoNSSzB3R3rBZm5RQKQuPx7aiyacHr7cMWZhb5XqLBYlnAq0AV3GkxY3
	iSs7zzv37i4zzlJ4vdLnwtcl1MsE17AoT+0ic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8BE68695
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4551C8694 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5B54CCA6-C557-11E1-B83E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200957>

The "index" line read from the patch to reconstruct a partial
preimage tree records the object names of blob objects.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c                     | 2 +-
 t/t1512-rev-parse-disambiguation.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c24dc54..8b2db1d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3203,7 +3203,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 		name = patch->old_name ? patch->old_name : patch->new_name;
 		if (0 < patch->is_new)
 			continue;
-		else if (get_sha1(patch->old_sha1_prefix, sha1))
+		else if (get_sha1_blob(patch->old_sha1_prefix, sha1))
 			/* git diff has no index line for mode/type changes */
 			if (!patch->lines_added && !patch->lines_deleted) {
 				if (get_current_sha1(patch->old_name, sha1))
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 4851a5f..87270c9 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -53,7 +53,7 @@ test_expect_success 'disambiguate tree-ish' '
 	git rev-parse --verify 11021982:bz01t33
 '
 
-test_expect_failure 'disambiguate blob' '
+test_expect_success 'disambiguate blob' '
 	sed -e "s/|$//" >patch <<-EOF &&
 	diff --git a/frotz b/frotz
 	index 11021982..11021982 100644
-- 
1.7.11.1.229.g706c98f
