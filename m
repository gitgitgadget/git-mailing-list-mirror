From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] topology tests: teach a helper to set author dates as well
Date: Fri, 21 Jun 2013 11:49:38 -0700
Message-ID: <1371840579-20161-5-git-send-email-gitster@pobox.com>
References: <1371840579-20161-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 20:50:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6PG-0002QS-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945923Ab3FUSt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:49:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423388Ab3FUStu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:49:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B742A0D4;
	Fri, 21 Jun 2013 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KCJu
	W/dWTv3CoDaCzt8WIiqcOok=; b=q3yxVjuJbKV0Gj888lW2LiwkcG/dpugnVm6N
	4WxnVWT5vmew9LuCw//lRQhHJ5x4btInx1y34tCyfTRNNRZrG5SNnStL6AlSn5cW
	QBxfGkBnalEp253eI3lP8MfJKdVRA7ETo5yOh1AYlk4KEdhDgF24e/vJkYCfPgWR
	459n70M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	mQzdtCEua19od5D7bm/5bvyyqSduXRpyLAUHvLxYcIEm5KBl4Cbnc1j4F2gDwHYu
	moGhKNCXmysBkdZ4LIEKmYooP94vpmM339f/K2Wbiwvc7ewyO2mK8Y0TjpRNtOck
	v/ZBcEbDADATynPyf+0xeZVFtqMFZprSptFm1V9iv78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEAF62A0D3;
	Fri, 21 Jun 2013 18:49:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C0372A0CE;
	Fri, 21 Jun 2013 18:49:49 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-691-gcbc83f4
In-Reply-To: <1371840579-20161-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5993660E-DAA3-11E2-8CAE-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228647>

Introduce on_dates helper that is similar to on_committer_date but
also sets the author date, not just the committer date.

At this step, just set the same timestamp to the author date as the
committer date, as no test looks at author date yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-t6000.sh                 |  8 +++++++
 t/t6003-rev-list-topo-order.sh | 52 +++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index e2c3615..4ffd901 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -82,6 +82,14 @@ on_committer_date () {
 	"$@"
 }
 
+on_dates () {
+	assign_fake_date GIT_COMMITTER_DATE "$1"
+	assign_fake_date GIT_AUTHOR_DATE "$2"
+	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+	shift 2
+	"$@"
+}
+
 # Execute a command and suppress any error output.
 hide_error () {
 	"$@" 2>/dev/null
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 0e3b7e1..77bf2ca 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -16,32 +16,32 @@ list_duplicates()
 date >path0
 git update-index --add path0
 save_tag tree git write-tree
-on_committer_date "00:00" hide_error save_tag root unique_commit root tree
-on_committer_date "00:01" save_tag l0 unique_commit l0 tree -p root
-on_committer_date "00:02" save_tag l1 unique_commit l1 tree -p l0
-on_committer_date "00:03" save_tag l2 unique_commit l2 tree -p l1
-on_committer_date "00:04" save_tag a0 unique_commit a0 tree -p l2
-on_committer_date "00:05" save_tag a1 unique_commit a1 tree -p a0
-on_committer_date "00:06" save_tag b1 unique_commit b1 tree -p a0
-on_committer_date "00:07" save_tag c1 unique_commit c1 tree -p b1
-on_committer_date "00:08" as_author foobar@example.com save_tag b2 unique_commit b2 tree -p b1
-on_committer_date "00:09" save_tag b3 unique_commit b3 tree -p b2
-on_committer_date "00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
-on_committer_date "00:11" save_tag c3 unique_commit c3 tree -p c2
-on_committer_date "00:12" save_tag a2 unique_commit a2 tree -p a1
-on_committer_date "00:13" save_tag a3 unique_commit a3 tree -p a2
-on_committer_date "00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
-on_committer_date "00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
-on_committer_date "00:16" save_tag l3 unique_commit l3 tree -p a4
-on_committer_date "00:17" save_tag l4 unique_commit l4 tree -p l3
-on_committer_date "00:18" save_tag l5 unique_commit l5 tree -p l4
-on_committer_date "00:19" save_tag m1 unique_commit m1 tree -p a4 -p c3
-on_committer_date "00:20" save_tag m2 unique_commit m2 tree -p c3 -p a4
-on_committer_date "00:21" hide_error save_tag alt_root unique_commit alt_root tree
-on_committer_date "00:22" save_tag r0 unique_commit r0 tree -p alt_root
-on_committer_date "00:23" save_tag r1 unique_commit r1 tree -p r0
-on_committer_date "00:24" save_tag l5r1 unique_commit l5r1 tree -p l5 -p r1
-on_committer_date "00:25" save_tag r1l5 unique_commit r1l5 tree -p r1 -p l5
+on_dates "00:00" "00:00" hide_error save_tag root unique_commit root tree
+on_dates "00:01" "00:01" save_tag l0 unique_commit l0 tree -p root
+on_dates "00:02" "00:02" save_tag l1 unique_commit l1 tree -p l0
+on_dates "00:03" "00:03" save_tag l2 unique_commit l2 tree -p l1
+on_dates "00:04" "00:04" save_tag a0 unique_commit a0 tree -p l2
+on_dates "00:05" "00:05" save_tag a1 unique_commit a1 tree -p a0
+on_dates "00:06" "00:06" save_tag b1 unique_commit b1 tree -p a0
+on_dates "00:07" "00:07" save_tag c1 unique_commit c1 tree -p b1
+on_dates "00:08" "00:08" as_author foobar@example.com save_tag b2 unique_commit b2 tree -p b1
+on_dates "00:09" "00:09" save_tag b3 unique_commit b3 tree -p b2
+on_dates "00:10" "00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
+on_dates "00:11" "00:11" save_tag c3 unique_commit c3 tree -p c2
+on_dates "00:12" "00:12" save_tag a2 unique_commit a2 tree -p a1
+on_dates "00:13" "00:13" save_tag a3 unique_commit a3 tree -p a2
+on_dates "00:14" "00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
+on_dates "00:15" "00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
+on_dates "00:16" "00:16" save_tag l3 unique_commit l3 tree -p a4
+on_dates "00:17" "00:17" save_tag l4 unique_commit l4 tree -p l3
+on_dates "00:18" "00:18" save_tag l5 unique_commit l5 tree -p l4
+on_dates "00:19" "00:19" save_tag m1 unique_commit m1 tree -p a4 -p c3
+on_dates "00:20" "00:20" save_tag m2 unique_commit m2 tree -p c3 -p a4
+on_dates "00:21" "00:21" hide_error save_tag alt_root unique_commit alt_root tree
+on_dates "00:22" "00:22" save_tag r0 unique_commit r0 tree -p alt_root
+on_dates "00:23" "00:23" save_tag r1 unique_commit r1 tree -p r0
+on_dates "00:24" "00:24" save_tag l5r1 unique_commit l5r1 tree -p l5 -p r1
+on_dates "00:25" "00:25" save_tag r1l5 unique_commit r1l5 tree -p r1 -p l5
 
 
 hide_error save_tag e1 as_author e@example.com unique_commit e1 tree
-- 
1.8.3.1-682-g924db96
