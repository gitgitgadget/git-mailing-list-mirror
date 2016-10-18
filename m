Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FF120988
	for <e@80x24.org>; Tue, 18 Oct 2016 19:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756192AbcJRTnA (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 15:43:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61959 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754177AbcJRTm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 15:42:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA85548BFB;
        Tue, 18 Oct 2016 15:42:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=a
        fkN4mRDbZmMm7jhsSQNXmjk+tQ=; b=E0DIDAR5cGziNs5m6Pe7kgBq1jVVsAwhL
        E+20wDo/HFwK61QJ9Oyqv1fPbGrrTR1EAmLYUw1lN4/1q+J8vaXuUXSrU6hDVIJH
        Ytt+1GhNYKA+X+vniWSfjMfTidnFsDUzO4y+BuqwW8DneBGno7aY8+DoCOBUkeo0
        v9Hpi/uM9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=pw04EK/owAx6HFLjGTrEnNw26KQY1EjQBHtYJ29GG6fRG/txZOEUputH
        Zrgh7b3dHNgkTMMtHr5vNc6qXHm6gVHUQbft4X+qR1Rk2oM+W8IsWfU+BvUtatqM
        cWqgvnPxblJisyJAqNS/SS+qZdJu3p+QeSlvo28WquxIM402tlg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A184848BFA;
        Tue, 18 Oct 2016 15:42:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 256D348BF9;
        Tue, 18 Oct 2016 15:42:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] sha1_name: remove ONELINE_SEEN bit
Date:   Tue, 18 Oct 2016 12:42:55 -0700
Message-ID: <xmqqd1ixphog.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11A8A08A-956B-11E6-8F7F-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

28a4d94044 ("object name: introduce ':/<oneline prefix>' notation",
2007-02-24) started using its own bit from object->flags to mark
commits used while parsing the ":/token" extended SHA-1 syntax to
name a commit temporarily, and this was kept even when f7bff00314
("sha1_name.c: fix parsing of ":/token" syntax", 2010-08-02) found
and fixed a bug in its implementation.

The use of that flag bit, however, is limited to a single function,
get_sha1_oneline(), which first sets it for the commits sitting at
the tips of refs, uses the bit to avoid duplicate traversal while
walking the history, and then cleans the bit from all commits it
walked.

Which is exactly what the general-purpose TMP_MARK bit meant to be
used for isolated case was invented for.  Replace ONELINE_SEEN with
TMP_MARK and retire the former.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.h    |  1 -
 sha1_name.c | 10 ++++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/object.h b/object.h
index f8b644263f..f8e218eccd 100644
--- a/object.h
+++ b/object.h
@@ -37,7 +37,6 @@ struct object_array {
  * bundle.c:                               16
  * http-push.c:                            16-----19
  * commit.c:                               16-----19
- * sha1_name.c:                                     20
  */
 #define FLAG_BITS  27
 
diff --git a/sha1_name.c b/sha1_name.c
index ca7ddd6f2c..fa0e6701a3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "dir.h"
+#include "revision.h"
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
@@ -855,9 +856,6 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
  * For future extension, all other sequences beginning with ':/!' are reserved.
  */
 
-/* Remember to update object flag allocation in object.h */
-#define ONELINE_SEEN (1u<<20)
-
 static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
@@ -899,7 +897,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 		return -1;
 
 	for (l = list; l; l = l->next) {
-		l->item->object.flags |= ONELINE_SEEN;
+		l->item->object.flags |= TMP_MARK;
 		commit_list_insert(l->item, &backup);
 	}
 	while (list) {
@@ -907,7 +905,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 		struct commit *commit;
 		int matches;
 
-		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
+		commit = pop_most_recent_commit(&list, TMP_MARK);
 		if (!parse_object(commit->object.oid.hash))
 			continue;
 		buf = get_commit_buffer(commit, NULL);
@@ -924,7 +922,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 	regfree(&regex);
 	free_commit_list(list);
 	for (l = backup; l; l = l->next)
-		clear_commit_marks(l->item, ONELINE_SEEN);
+		clear_commit_marks(l->item, TMP_MARK);
 	free_commit_list(backup);
 	return found ? 0 : -1;
 }
