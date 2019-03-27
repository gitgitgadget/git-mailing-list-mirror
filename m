Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD3020248
	for <e@80x24.org>; Wed, 27 Mar 2019 21:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfC0VLP (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 17:11:15 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:45689 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC0VLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 17:11:15 -0400
Received: by mail-yw1-f74.google.com with SMTP id g140so25291715ywb.12
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lUU4z6j090yrSOl3RLbKI57YXd0C/FuE2HT9TFoihmo=;
        b=OBfolLlAr0ioBr06OavmH5FBbDQEKjgMn/ZRxvuLC7SbY/FnAlx8lwqnXPuwASyh7O
         eNdw7KgHMSASP8Rm4iLySW9pScDsDzsStrsg63ZPmWr38DnAF093zJbsBBPbf3NmM9kV
         8zllKlqkXxLMrLGXsXe84CLwIIAo8AvrSAW7XX8gqpDhz4M9h9P1w2vQE5q8DpDKzTmb
         QXq6FceXF3dyiDpp2+ZzkcZ94+3eiqmy0/+nyhqjdB5lPJW+sW3oGfZgalvj7YqGeLMa
         QFk7zSNed37EpXPP+gkiKvRh/3kZstijNVd7wGKsYLJYMb6M1JKrxDyIHPymb8HwJ5Om
         noXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lUU4z6j090yrSOl3RLbKI57YXd0C/FuE2HT9TFoihmo=;
        b=gBaBVSm5gPsrA3ByOAKLK3+rsn2uPuNZn7USzpOh3Wl8kuYG2JzyVF4baW0Xyc6bMh
         +nflZltM42l93bDGlMU49KkT2WInktm3T4Y0IsbxWtKYyzhJGn6v2vrRUt+PxUndM/U4
         /za1ZW+Hm4JbnH9Ue1bYsiFug8lOahJFkGoIVqgLPSQnmSzGefrKCNMHV8aH5J8ENut2
         sDWyjgooGtoGlel/ujZqaxB6xLSKT7gK4Qj+p7w/e+0RJDKkVJc6Kd4XmtuEiRQhrhfu
         HhidLSUyDZSlCmfTeazVaqj9dEW3rjyDpvoRujVGaxego02ZR7QH7Mrk3NCxUwyRLDxF
         exvg==
X-Gm-Message-State: APjAAAWEa5vHC33nTxNILfrhWEI1jULN7DgTpfGbid8ezYfhXsVFZMfN
        K8fP5mua9+tw+BzfaIrlpPSpJ0OafqNal3BY3LRZfyY0H5CJL5+GBIaU1vjDJt5z1EjZn8urQtH
        viI+RYg2HurQ1kZnzkGOpbvDXLpywvnHWsv0vrKsB6rPk+mXt2teh3QIuWbfWJ1RQySVNwlDj6c
        nh
X-Google-Smtp-Source: APXvYqx9TuUAz2pNJ3m0dnxK+U8jGdSmpxo+72zC/7tIwrRi3ftZE1L4pm3288ekL9SnkrfD/ts0dzx6GlYID/1lsE9d
X-Received: by 2002:a25:24c:: with SMTP id 73mr1606670ybc.15.1553721074308;
 Wed, 27 Mar 2019 14:11:14 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:11:10 -0700
Message-Id: <20190327211110.46327-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.197.gd478713db0
Subject: [PATCH] fetch-pack: binary search when storing wanted-refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In do_fetch_pack_v2(), the "sought" array is sorted by name, and it is
not subsequently reordered (within the function). Therefore,
receive_wanted_refs() can assume that "sought" is sorted, and can thus
use a binary search when storing wanted-refs retrieved from the server.

Replace the existing linear search with a binary search. This improves
performance significantly when mirror cloning a repository with more
than 1 million refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index e69993b2eb..e8266bd45a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1298,6 +1298,11 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 	}
 }
 
+static int cmp_name_ref(const void *name, const void *ref)
+{
+	return strcmp(name, (*(struct ref **)ref)->name);
+}
+
 static void receive_wanted_refs(struct packet_reader *reader,
 				struct ref **sought, int nr_sought)
 {
@@ -1305,20 +1310,16 @@ static void receive_wanted_refs(struct packet_reader *reader,
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		struct object_id oid;
 		const char *end;
-		int i;
+		struct ref **found;
 
 		if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
 			die(_("expected wanted-ref, got '%s'"), reader->line);
 
-		for (i = 0; i < nr_sought; i++) {
-			if (!strcmp(end, sought[i]->name)) {
-				oidcpy(&sought[i]->old_oid, &oid);
-				break;
-			}
-		}
-
-		if (i == nr_sought)
+		found = bsearch(end, sought, nr_sought, sizeof(*sought),
+				cmp_name_ref);
+		if (!found)
 			die(_("unexpected wanted-ref: '%s'"), reader->line);
+		oidcpy(&(*found)->old_oid, &oid);
 	}
 
 	if (reader->status != PACKET_READ_DELIM)
-- 
2.21.0.197.gd478713db0

