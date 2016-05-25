From: Eric Wong <e@80x24.org>
Subject: [RFC] fast-import: invalidate pack_id references after loosening
Date: Wed, 25 May 2016 22:54:02 +0000
Message-ID: <20160525225402.GB18894@dcvr.yhbt.net>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
 <20160513103621.GA12329@dcvr.yhbt.net>
 <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
 <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
 <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
 <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
 <20160517121330.GA7346@sigill.intra.peff.net>
 <20160525224907.GA18894@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu May 26 00:54:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hgp-0003gd-5n
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbcEYWyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:54:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42666 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829AbcEYWyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:54:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84A31FCC6;
	Wed, 25 May 2016 22:54:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160525224907.GA18894@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295610>

When loosening a pack, the current pack_id gets reused when
checkpointing and the import does not terminate.  This causes
problems after checkpointing as the object table, branch, and
tag lists still contains pre-checkpoint references to the
recycled pack_id.

Merely clearing the object_table as suggested by Jeff King in
http://mid.gmane.org/20160517121330.GA7346@sigill.intra.peff.net
is insufficient as the marks set still contains references
to object entries.

Wrong pack_id references branch and tags lists do not cause
errors, but can lead to misleading crash reports and core dumps,
so they are also invalidated.

Signed-off-by: Eric Wong <e@80x24.org>
---
 I started writing a standalone test case; but testing with
 original failing cases would be greatly appreciated.

 Still learning my way around the fast-import code...
 Thanks.

 fast-import.c                       | 31 +++++++++++++++++++-
 t/t9302-fast-import-unpack-limit.sh | 57 +++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 0e8bc6a..b9db4b6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -597,6 +597,33 @@ static struct object_entry *insert_object(unsigned char *sha1)
 	return e;
 }
 
+static void invalidate_pack_id(unsigned int id)
+{
+	unsigned int h;
+	unsigned long lu;
+	struct tag *t;
+
+	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
+		struct object_entry *e;
+
+		for (e = object_table[h]; e; e = e->next)
+			if (e->pack_id == id)
+				e->pack_id = MAX_PACK_ID;
+	}
+
+	for (lu = 0; lu < branch_table_sz; lu++) {
+		struct branch *b;
+
+		for (b = branch_table[lu]; b; b = b->table_next_branch)
+			if (b->pack_id == id)
+				b->pack_id = MAX_PACK_ID;
+	}
+
+	for (t = first_tag; t; t = t->next_tag)
+		if (t->pack_id == id)
+			t->pack_id = MAX_PACK_ID;
+}
+
 static unsigned int hc_str(const char *s, size_t len)
 {
 	unsigned int r = 0;
@@ -993,8 +1020,10 @@ static void end_packfile(void)
 				    cur_pack_sha1, pack_size);
 
 		if (object_count <= unpack_limit) {
-			if (!loosen_small_pack(pack_data))
+			if (!loosen_small_pack(pack_data)) {
+				invalidate_pack_id(pack_id);
 				goto discard_pack;
+			}
 		}
 
 		close(pack_data->pack_fd);
diff --git a/t/t9302-fast-import-unpack-limit.sh b/t/t9302-fast-import-unpack-limit.sh
index 0f686d2..a04de14 100755
--- a/t/t9302-fast-import-unpack-limit.sh
+++ b/t/t9302-fast-import-unpack-limit.sh
@@ -45,4 +45,61 @@ test_expect_success 'bigger packs are preserved' '
 	test $(find .git/objects/pack -type f | wc -l) -eq 2
 '
 
+test_expect_success 'lookups after checkpoint works' '
+	hello_id=$(echo hello | git hash-object --stdin -t blob) &&
+	id="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
+	before=$(git rev-parse refs/heads/master^0) &&
+	(
+		cat <<-INPUT_END &&
+		blob
+		mark :1
+		data 6
+		hello
+
+		commit refs/heads/master
+		mark :2
+		committer $id
+		data <<COMMIT
+		checkpoint after this
+		COMMIT
+		from refs/heads/master^0
+		M 100644 :1 hello
+
+		# pre-checkpoint
+		cat-blob :1
+		cat-blob $hello_id
+		checkpoint
+		# post-checkpoint
+		cat-blob :1
+		cat-blob $hello_id
+		INPUT_END
+
+		n=0 &&
+		from=$before &&
+		while test x"$from" = x"$before"
+		do
+			if test $n -gt 30
+			then
+				echo >&2 "checkpoint did not update branch"
+				exit 1
+			else
+				n=$(($n + 1))
+			fi &&
+			sleep 1 &&
+			from=$(git rev-parse refs/heads/master^0)
+		done &&
+		cat <<-INPUT_END &&
+		commit refs/heads/master
+		committer $id
+		data <<COMMIT
+		make sure from "unpacked sha1 reference" works, too
+		COMMIT
+		from $from
+		INPUT_END
+		echo done
+	) | git -c fastimport.unpackLimit=100 fast-import --done &&
+	test $(find .git/objects/?? -type f | wc -l) -eq 6 &&
+	test $(find .git/objects/pack -type f | wc -l) -eq 2
+'
+
 test_done
