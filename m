From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] topology tests: teach a helper to take abbreviated timestamps
Date: Fri, 21 Jun 2013 11:49:36 -0700
Message-ID: <1371840579-20161-3-git-send-email-gitster@pobox.com>
References: <1371840579-20161-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 20:49:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6PF-0002QS-GP
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423706Ab3FUStr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:49:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423388Ab3FUStq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:49:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDF7B2A0B8;
	Fri, 21 Jun 2013 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6LRF
	r3v16ENEkorPKn750zjoqz4=; b=U8TyK0oWzVIqP1PcsR+F0keeV3awLSDec7ra
	SXXJDOFc4LqA1LfzFQs9S8linzjf0pSLy6+q1YETHU2H1/7LHuuwgzMYa7k7GWt0
	9FCFqNzX5M8bgZC6vNvI4vk3VRDairHC7ZjUS5A93CewiJa8hLaABsHg1jvFHqsy
	r5A/Ve4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	RlWLOsKjYCrKUYoGtSelfvcjdIQZRI1Mqm6DWJzn1uJ7+dEBPGjZCh6LbuBwAPuT
	ubGVVhQ3UP/lNiuOh7MviW+wg88ld6WBJvmx0IwUCbIlAV81kXplwU/vUtWy98WZ
	zFwn5uqa/YSDFRqoZcEvhsCFsUtRY7yopXa+4/JWmUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D53E22A0B7;
	Fri, 21 Jun 2013 18:49:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E54202A0B4;
	Fri, 21 Jun 2013 18:49:44 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-691-gcbc83f4
In-Reply-To: <1371840579-20161-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 570C26F0-DAA3-11E2-B6EF-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228646>

The on_committer_date helper in t/lib-t6000 is used in t6002 and
t6003 with timestamps on a single day within a single minute
(i.e. 1971-08-16 00:00) and the tests repeat this over and over.

The actual value of the timestamp, however, does not matter very
much; only their relative ordering does.

Introduce another helper to expand only the suffix of the timestamp
to a full timestamp to make the lines shorter, and use it in this
helper.  Also, because all the commits in the test are made with
specific GIT_COMMITTER_DATE, stop unsetting it at the end of the
helper.

We'll be specifying the author timestamp to these test commits in a
later patch, which will be helped with this change.

Also remove a test that was commented-out from t6003; it used to
test a commit with the same parent listed twice, which was allowed
by mistake but was fixed long time ago.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-t6000.sh                 | 17 +++++++--
 t/t6002-rev-list-bisect.sh     | 84 +++++++++++++++++++++---------------------
 t/t6003-rev-list-topo-order.sh | 57 +++++++++++++---------------
 3 files changed, 81 insertions(+), 77 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index 102d567..e2c3615 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -64,13 +64,22 @@ commit_date () {
 	sed -n "s/^committer .*> \([0-9]*\) .*/\1/p"
 }
 
+# Assign the value of fake date to a variable, but
+# allow fairly common "1971-08-16 00:00" to be omittd
+assign_fake_date () {
+	case "$2" in
+	??:??:??)	eval "$1='1971-08-16 $2'" ;;
+	??:??)		eval "$1='1971-08-16 00:$2'" ;;
+	??)		eval "$1='1971-08-16 00:00:$2'" ;;
+	*)		eval "$1='$2'" ;;
+	esac
+}
+
 on_committer_date () {
-	_date=$1
-	shift 1
-	GIT_COMMITTER_DATE="$_date"
+	assign_fake_date GIT_COMMITTER_DATE "$1"
 	export GIT_COMMITTER_DATE
+	shift 1
 	"$@"
-	unset GIT_COMMITTER_DATE
 }
 
 # Execute a command and suppress any error output.
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index fb07536..43ad772 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -39,25 +39,25 @@ test_bisection_diff()
 date >path0
 git update-index --add path0
 save_tag tree git write-tree
-on_committer_date "1971-08-16 00:00:00" hide_error save_tag root unique_commit root tree
-on_committer_date "1971-08-16 00:00:01" save_tag l0 unique_commit l0 tree -p root
-on_committer_date "1971-08-16 00:00:02" save_tag l1 unique_commit l1 tree -p l0
-on_committer_date "1971-08-16 00:00:03" save_tag l2 unique_commit l2 tree -p l1
-on_committer_date "1971-08-16 00:00:04" save_tag a0 unique_commit a0 tree -p l2
-on_committer_date "1971-08-16 00:00:05" save_tag a1 unique_commit a1 tree -p a0
-on_committer_date "1971-08-16 00:00:06" save_tag b1 unique_commit b1 tree -p a0
-on_committer_date "1971-08-16 00:00:07" save_tag c1 unique_commit c1 tree -p b1
-on_committer_date "1971-08-16 00:00:08" save_tag b2 unique_commit b2 tree -p b1
-on_committer_date "1971-08-16 00:00:09" save_tag b3 unique_commit b2 tree -p b2
-on_committer_date "1971-08-16 00:00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
-on_committer_date "1971-08-16 00:00:11" save_tag c3 unique_commit c3 tree -p c2
-on_committer_date "1971-08-16 00:00:12" save_tag a2 unique_commit a2 tree -p a1
-on_committer_date "1971-08-16 00:00:13" save_tag a3 unique_commit a3 tree -p a2
-on_committer_date "1971-08-16 00:00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
-on_committer_date "1971-08-16 00:00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
-on_committer_date "1971-08-16 00:00:16" save_tag l3 unique_commit l3 tree -p a4
-on_committer_date "1971-08-16 00:00:17" save_tag l4 unique_commit l4 tree -p l3
-on_committer_date "1971-08-16 00:00:18" save_tag l5 unique_commit l5 tree -p l4
+on_committer_date "00:00" hide_error save_tag root unique_commit root tree
+on_committer_date "00:01" save_tag l0 unique_commit l0 tree -p root
+on_committer_date "00:02" save_tag l1 unique_commit l1 tree -p l0
+on_committer_date "00:03" save_tag l2 unique_commit l2 tree -p l1
+on_committer_date "00:04" save_tag a0 unique_commit a0 tree -p l2
+on_committer_date "00:05" save_tag a1 unique_commit a1 tree -p a0
+on_committer_date "00:06" save_tag b1 unique_commit b1 tree -p a0
+on_committer_date "00:07" save_tag c1 unique_commit c1 tree -p b1
+on_committer_date "00:08" save_tag b2 unique_commit b2 tree -p b1
+on_committer_date "00:09" save_tag b3 unique_commit b2 tree -p b2
+on_committer_date "00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
+on_committer_date "00:11" save_tag c3 unique_commit c3 tree -p c2
+on_committer_date "00:12" save_tag a2 unique_commit a2 tree -p a1
+on_committer_date "00:13" save_tag a3 unique_commit a3 tree -p a2
+on_committer_date "00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
+on_committer_date "00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
+on_committer_date "00:16" save_tag l3 unique_commit l3 tree -p a4
+on_committer_date "00:17" save_tag l4 unique_commit l4 tree -p l3
+on_committer_date "00:18" save_tag l5 unique_commit l5 tree -p l4
 git update-ref HEAD $(tag l5)
 
 
@@ -90,29 +90,29 @@ git update-ref HEAD $(tag l5)
 #     F
 
 
-on_committer_date "1971-08-16 00:00:00" hide_error save_tag F unique_commit F tree
-on_committer_date "1971-08-16 00:00:01" save_tag e8 unique_commit e8 tree -p F
-on_committer_date "1971-08-16 00:00:02" save_tag e7 unique_commit e7 tree -p e8
-on_committer_date "1971-08-16 00:00:03" save_tag e6 unique_commit e6 tree -p e7
-on_committer_date "1971-08-16 00:00:04" save_tag e5 unique_commit e5 tree -p e6
-on_committer_date "1971-08-16 00:00:05" save_tag f4 unique_commit f4 tree -p F
-on_committer_date "1971-08-16 00:00:06" save_tag f3 unique_commit f3 tree -p f4
-on_committer_date "1971-08-16 00:00:07" save_tag f2 unique_commit f2 tree -p f3
-on_committer_date "1971-08-16 00:00:08" save_tag f1 unique_commit f1 tree -p f2
-on_committer_date "1971-08-16 00:00:09" save_tag e4 unique_commit e4 tree -p e5
-on_committer_date "1971-08-16 00:00:10" save_tag e3 unique_commit e3 tree -p e4
-on_committer_date "1971-08-16 00:00:11" save_tag e2 unique_commit e2 tree -p e3
-on_committer_date "1971-08-16 00:00:12" save_tag e1 unique_commit e1 tree -p e2
-on_committer_date "1971-08-16 00:00:13" save_tag E unique_commit E tree -p e1 -p f1
-
-on_committer_date "1971-08-16 00:00:00" hide_error save_tag U unique_commit U tree
-on_committer_date "1971-08-16 00:00:01" save_tag u0 unique_commit u0 tree -p U
-on_committer_date "1971-08-16 00:00:01" save_tag u1 unique_commit u1 tree -p u0
-on_committer_date "1971-08-16 00:00:02" save_tag u2 unique_commit u2 tree -p u0
-on_committer_date "1971-08-16 00:00:03" save_tag u3 unique_commit u3 tree -p u0
-on_committer_date "1971-08-16 00:00:04" save_tag u4 unique_commit u4 tree -p u0
-on_committer_date "1971-08-16 00:00:05" save_tag u5 unique_commit u5 tree -p u0
-on_committer_date "1971-08-16 00:00:06" save_tag V unique_commit V tree -p u1 -p u2 -p u3 -p u4 -p u5
+on_committer_date "00:00" hide_error save_tag F unique_commit F tree
+on_committer_date "00:01" save_tag e8 unique_commit e8 tree -p F
+on_committer_date "00:02" save_tag e7 unique_commit e7 tree -p e8
+on_committer_date "00:03" save_tag e6 unique_commit e6 tree -p e7
+on_committer_date "00:04" save_tag e5 unique_commit e5 tree -p e6
+on_committer_date "00:05" save_tag f4 unique_commit f4 tree -p F
+on_committer_date "00:06" save_tag f3 unique_commit f3 tree -p f4
+on_committer_date "00:07" save_tag f2 unique_commit f2 tree -p f3
+on_committer_date "00:08" save_tag f1 unique_commit f1 tree -p f2
+on_committer_date "00:09" save_tag e4 unique_commit e4 tree -p e5
+on_committer_date "00:10" save_tag e3 unique_commit e3 tree -p e4
+on_committer_date "00:11" save_tag e2 unique_commit e2 tree -p e3
+on_committer_date "00:12" save_tag e1 unique_commit e1 tree -p e2
+on_committer_date "00:13" save_tag E unique_commit E tree -p e1 -p f1
+
+on_committer_date "00:00" hide_error save_tag U unique_commit U tree
+on_committer_date "00:01" save_tag u0 unique_commit u0 tree -p U
+on_committer_date "00:01" save_tag u1 unique_commit u1 tree -p u0
+on_committer_date "00:02" save_tag u2 unique_commit u2 tree -p u0
+on_committer_date "00:03" save_tag u3 unique_commit u3 tree -p u0
+on_committer_date "00:04" save_tag u4 unique_commit u4 tree -p u0
+on_committer_date "00:05" save_tag u5 unique_commit u5 tree -p u0
+on_committer_date "00:06" save_tag V unique_commit V tree -p u1 -p u2 -p u3 -p u4 -p u5
 
 test_sequence()
 {
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index e4c52b0..bb66b8b 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -16,39 +16,34 @@ list_duplicates()
 date >path0
 git update-index --add path0
 save_tag tree git write-tree
-on_committer_date "1971-08-16 00:00:00" hide_error save_tag root unique_commit root tree
-on_committer_date "1971-08-16 00:00:01" save_tag l0 unique_commit l0 tree -p root
-on_committer_date "1971-08-16 00:00:02" save_tag l1 unique_commit l1 tree -p l0
-on_committer_date "1971-08-16 00:00:03" save_tag l2 unique_commit l2 tree -p l1
-on_committer_date "1971-08-16 00:00:04" save_tag a0 unique_commit a0 tree -p l2
-on_committer_date "1971-08-16 00:00:05" save_tag a1 unique_commit a1 tree -p a0
-on_committer_date "1971-08-16 00:00:06" save_tag b1 unique_commit b1 tree -p a0
-on_committer_date "1971-08-16 00:00:07" save_tag c1 unique_commit c1 tree -p b1
-on_committer_date "1971-08-16 00:00:08" as_author foobar@example.com save_tag b2 unique_commit b2 tree -p b1
-on_committer_date "1971-08-16 00:00:09" save_tag b3 unique_commit b3 tree -p b2
-on_committer_date "1971-08-16 00:00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
-on_committer_date "1971-08-16 00:00:11" save_tag c3 unique_commit c3 tree -p c2
-on_committer_date "1971-08-16 00:00:12" save_tag a2 unique_commit a2 tree -p a1
-on_committer_date "1971-08-16 00:00:13" save_tag a3 unique_commit a3 tree -p a2
-on_committer_date "1971-08-16 00:00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
-on_committer_date "1971-08-16 00:00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
-on_committer_date "1971-08-16 00:00:16" save_tag l3 unique_commit l3 tree -p a4
-on_committer_date "1971-08-16 00:00:17" save_tag l4 unique_commit l4 tree -p l3
-on_committer_date "1971-08-16 00:00:18" save_tag l5 unique_commit l5 tree -p l4
-on_committer_date "1971-08-16 00:00:19" save_tag m1 unique_commit m1 tree -p a4 -p c3
-on_committer_date "1971-08-16 00:00:20" save_tag m2 unique_commit m2 tree -p c3 -p a4
-on_committer_date "1971-08-16 00:00:21" hide_error save_tag alt_root unique_commit alt_root tree
-on_committer_date "1971-08-16 00:00:22" save_tag r0 unique_commit r0 tree -p alt_root
-on_committer_date "1971-08-16 00:00:23" save_tag r1 unique_commit r1 tree -p r0
-on_committer_date "1971-08-16 00:00:24" save_tag l5r1 unique_commit l5r1 tree -p l5 -p r1
-on_committer_date "1971-08-16 00:00:25" save_tag r1l5 unique_commit r1l5 tree -p r1 -p l5
+on_committer_date "00:00" hide_error save_tag root unique_commit root tree
+on_committer_date "00:01" save_tag l0 unique_commit l0 tree -p root
+on_committer_date "00:02" save_tag l1 unique_commit l1 tree -p l0
+on_committer_date "00:03" save_tag l2 unique_commit l2 tree -p l1
+on_committer_date "00:04" save_tag a0 unique_commit a0 tree -p l2
+on_committer_date "00:05" save_tag a1 unique_commit a1 tree -p a0
+on_committer_date "00:06" save_tag b1 unique_commit b1 tree -p a0
+on_committer_date "00:07" save_tag c1 unique_commit c1 tree -p b1
+on_committer_date "00:08" as_author foobar@example.com save_tag b2 unique_commit b2 tree -p b1
+on_committer_date "00:09" save_tag b3 unique_commit b3 tree -p b2
+on_committer_date "00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
+on_committer_date "00:11" save_tag c3 unique_commit c3 tree -p c2
+on_committer_date "00:12" save_tag a2 unique_commit a2 tree -p a1
+on_committer_date "00:13" save_tag a3 unique_commit a3 tree -p a2
+on_committer_date "00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
+on_committer_date "00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
+on_committer_date "00:16" save_tag l3 unique_commit l3 tree -p a4
+on_committer_date "00:17" save_tag l4 unique_commit l4 tree -p l3
+on_committer_date "00:18" save_tag l5 unique_commit l5 tree -p l4
+on_committer_date "00:19" save_tag m1 unique_commit m1 tree -p a4 -p c3
+on_committer_date "00:20" save_tag m2 unique_commit m2 tree -p c3 -p a4
+on_committer_date "00:21" hide_error save_tag alt_root unique_commit alt_root tree
+on_committer_date "00:22" save_tag r0 unique_commit r0 tree -p alt_root
+on_committer_date "00:23" save_tag r1 unique_commit r1 tree -p r0
+on_committer_date "00:24" save_tag l5r1 unique_commit l5r1 tree -p l5 -p r1
+on_committer_date "00:25" save_tag r1l5 unique_commit r1l5 tree -p r1 -p l5
 
 
-#
-# note: as of 20/6, it isn't possible to create duplicate parents, so this
-# can't be tested.
-#
-#on_committer_date "1971-08-16 00:00:20" save_tag m3 unique_commit m3 tree -p c3 -p a4 -p c3
 hide_error save_tag e1 as_author e@example.com unique_commit e1 tree
 save_tag e2 as_author e@example.com unique_commit e2 tree -p e1
 save_tag f1 as_author f@example.com unique_commit f1 tree -p e1
-- 
1.8.3.1-682-g924db96
