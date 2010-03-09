From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] show --first-parent/-m: do not default to --cc
Date: Tue,  9 Mar 2010 01:42:55 -0800
Message-ID: <1268127775-9998-4-git-send-email-gitster@pobox.com>
References: <1268127775-9998-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 13:30:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyXC-0001Do-P5
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab0CIJnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 04:43:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab0CIJnE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 04:43:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DA05A09CF
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 04:43:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fpLJ
	tjl7jhYSXmlSDfrpswkfbM4=; b=PBhY49PsYV+DqpQzsV2s7A/Vsc1ixQm1s4yE
	3u9FUwwzNrMM42rPwU6Z+w3cKOClNHIpMeOL4ZGNBhRdScM8dwwk3j0JjfQ+l+21
	KgxP7Yu5mI+aKr+Lx1WtvT+8MzhT1nAwCOqrB2u08nwmLcQ+gBCfGFaANLONMq+s
	zVyPp0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YrJ0ap
	LEBAGXJC0+91KntdIi7zg8ofWw1cqU5KTDzK2gRw7FJYVsfDLkWZxtZHTYqpdRPe
	KxB7ZEzgpiKF6ZvWiBCPUn6zCQYW7icQyK3Q9qOLRsEc2Jxf5lyNWWahUxyBl8iO
	Bu1Ch5NVvKZmo0fwgL2twEHXu8N1ViEIfqjMI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ABE2A09CE
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 04:43:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5FF2A09CD for
 <git@vger.kernel.org>; Tue,  9 Mar 2010 04:43:03 -0500 (EST)
X-Mailer: git-send-email 1.7.0.2.384.g015e
In-Reply-To: <1268127775-9998-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 28BBD9D0-2B60-11DF-A3A5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141807>

Given that "git show" always shows some diff and does not walk the history
by default, it is natural to expect "git show --first-parent" to show the
difference between the given commit and its first parent.  It also would
be natural, given that "--cc" is the default, "git show -m" to show
pairwise difference from each of the parents.

We however always defaulted to --cc and there was no way to turn it off.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-log.c                           |   12 +++-
 t/t4013-diff-various.sh                 |    2 +
 t/t4013/diff.show_--first-parent_master |   30 ++++++++++
 t/t4013/diff.show_-m_master             |   93 +++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 t/t4013/diff.show_--first-parent_master
 create mode 100644 t/t4013/diff.show_-m_master

diff --git a/builtin-log.c b/builtin-log.c
index ab5f60c..4dd6d2c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -329,6 +329,15 @@ static int show_tree_object(const unsigned char *sha1,
 
 static void show_rev_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
 {
+	if (rev->ignore_merges) {
+		/* There was no "-m" on the command line */
+		rev->ignore_merges = 0;
+		if (!rev->first_parent_only && !rev->combine_merges) {
+			/* No "--first-parent", "-c", nor "--cc" */
+			rev->combine_merges = 1;
+			rev->dense_combined_merges = 1;
+		}
+	}
 	if (!rev->diffopt.output_format)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
@@ -347,10 +356,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
-	rev.combine_merges = 1;
-	rev.dense_combined_merges = 1;
 	rev.always_show_header = 1;
-	rev.ignore_merges = 0;
 	rev.no_walk = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8dd93d9..dae6358 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -239,6 +239,8 @@ show --root initial
 show side
 show master
 show -c master
+show -m master
+show --first-parent master
 show --stat side
 show --stat --summary side
 show --patch-with-stat side
diff --git a/t/t4013/diff.show_--first-parent_master b/t/t4013/diff.show_--first-parent_master
new file mode 100644
index 0000000..3dcbe47
--- /dev/null
+++ b/t/t4013/diff.show_--first-parent_master
@@ -0,0 +1,30 @@
+$ git show --first-parent master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+diff --git a/dir/sub b/dir/sub
+index cead32e..992913c 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -4,3 +4,5 @@ C
+ D
+ E
+ F
++1
++2
+diff --git a/file0 b/file0
+index b414108..10a8a9f 100644
+--- a/file0
++++ b/file0
+@@ -4,3 +4,6 @@
+ 4
+ 5
+ 6
++A
++B
++C
+$
diff --git a/t/t4013/diff.show_-m_master b/t/t4013/diff.show_-m_master
new file mode 100644
index 0000000..4ea2ee4
--- /dev/null
+++ b/t/t4013/diff.show_-m_master
@@ -0,0 +1,93 @@
+$ git show -m master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+diff --git a/dir/sub b/dir/sub
+index cead32e..992913c 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -4,3 +4,5 @@ C
+ D
+ E
+ F
++1
++2
+diff --git a/file0 b/file0
+index b414108..10a8a9f 100644
+--- a/file0
++++ b/file0
+@@ -4,3 +4,6 @@
+ 4
+ 5
+ 6
++A
++B
++C
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+diff --git a/dir/sub b/dir/sub
+index 7289e35..992913c 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,4 +1,8 @@
+ A
+ B
++C
++D
++E
++F
+ 1
+ 2
+diff --git a/file0 b/file0
+index f4615da..10a8a9f 100644
+--- a/file0
++++ b/file0
+@@ -1,6 +1,9 @@
+ 1
+ 2
+ 3
++4
++5
++6
+ A
+ B
+ C
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+diff --git a/file3 b/file3
+deleted file mode 100644
+index 7289e35..0000000
+--- a/file3
++++ /dev/null
+@@ -1,4 +0,0 @@
+-A
+-B
+-1
+-2
+$
-- 
1.7.0.2.384.g015e
