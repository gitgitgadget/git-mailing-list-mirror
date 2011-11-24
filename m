From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] bulk-checkin: honor pack.packsizelimit
Date: Wed, 23 Nov 2011 21:18:58 -0800
Message-ID: <7vhb1u9jy5.fsf_-_@alter.siamese.dyndns.org>
References: <1319846051-462-1-git-send-email-gitster@pobox.com>
 <1321600317-30546-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 06:19:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTRiM-0002uZ-0H
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 06:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791Ab1KXFTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 00:19:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab1KXFTB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 00:19:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EA8B6B90;
	Thu, 24 Nov 2011 00:19:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yyvbXdZjNp2RiqIVOhB9tdkB7tM=; b=PPLhT/
	rbusy6zklgqdBg0zODoUKIc9VMRaflldeih0x3OP/g+nT00/ids67aBBmtYOlH3c
	6JziKKOOmeQpY8tOXMeciEDyU7NpFrJWSMW+s+kPVo/Umghfe8NFOn86ixg/IUW7
	W04k63dDWNT+oU3q0EXEH0Wm3Orogfx5zpbzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WF6xTn9ycP5F/0vp8eMOPB7/LAnbM+Cm
	ZEV+2HWHX2b6hV1646fI5W5x2q+mZ/7YLfBlNOaQYzH9WgSoEGKNFHUwvX8JIWbJ
	7JCvyYx91wI9W7kqZrDZkHTJWoofDibfWiGn9uzMVxozcFeQINBkbgDdDq4EyC8R
	I4ECsEvpQco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 469136B8F;
	Thu, 24 Nov 2011 00:19:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 493096B8D; Thu, 24 Nov 2011
 00:19:00 -0500 (EST)
In-Reply-To: <1321600317-30546-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Thu, 17 Nov 2011 23:11:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D10F29A6-165B-11E1-8FBD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185888>

The bulk-checkin interface is designed to throw multiple blobs into a
single output packfile during the lifetime of a single process by
"plugging" the output. The direct streaming of the data to a packfile
however is primarily meant as a way to deal with large blobs better, and
it is possible that we end up with a single humongous packfile that is
awkward to handle.

Pay attention to the pack.packsizelimit configuration the same way as
the pack-object does, and make sure we close a packfile and switch to a
new one before busting the size limit.

We allow the limit to be busted if a single object is too large to be
contained in a pack that is smaller than the limit on its own, as there is
no way to store such an object otherwise; the same is already done in
pack-objects.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c |    6 +-----
 bulk-checkin.c         |   35 ++++++++++++++++++++++++++++++-----
 cache.h                |    1 +
 config.c               |    4 ++++
 environment.c          |    1 +
 5 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b458b6d..dde913e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -76,7 +76,7 @@ static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
 static int progress = 1;
 static int window = 10;
-static unsigned long pack_size_limit, pack_size_limit_cfg;
+static unsigned long pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
@@ -2009,10 +2009,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			    pack_idx_opts.version);
 		return 0;
 	}
-	if (!strcmp(k, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(k, v);
-		return 0;
-	}
 	return git_default_config(k, v, cb);
 }
 
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 60178ef..2adc67b 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -73,10 +73,13 @@ static int already_written(struct bulk_checkin_state *state, unsigned char sha1[
 	return 0;
 }
 
-static void deflate_to_pack(struct bulk_checkin_state *state,
-			    unsigned char sha1[],
-			    int fd, size_t size, enum object_type type,
-			    const char *path, unsigned flags)
+#define DEFLATE_TO_PACK_OK 0
+#define DEFLATE_TO_PACK_TOOBIG 1
+
+static int deflate_to_pack(struct bulk_checkin_state *state,
+			   unsigned char sha1[],
+			   int fd, size_t size, enum object_type type,
+			   const char *path, unsigned flags)
 {
 	unsigned char obuf[16384];
 	unsigned hdrlen;
@@ -149,6 +152,13 @@ static void deflate_to_pack(struct bulk_checkin_state *state,
 			sha1file_truncate(state->f, &checkpoint);
 			state->offset = checkpoint.offset;
 			free(idx);
+		} else if (state->nr_written &&
+			   pack_size_limit_cfg &&
+			   pack_size_limit_cfg < state->offset) {
+			sha1file_truncate(state->f, &checkpoint);
+			state->offset = checkpoint.offset;
+			free(idx);
+			return DEFLATE_TO_PACK_TOOBIG;
 		} else {
 			hashcpy(idx->sha1, sha1);
 			ALLOC_GROW(state->written,
@@ -156,12 +166,17 @@ static void deflate_to_pack(struct bulk_checkin_state *state,
 			state->written[state->nr_written++] = idx;
 		}
 	}
+	return DEFLATE_TO_PACK_OK;
 }
 
 int index_bulk_checkin(unsigned char *sha1,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
+	off_t seekback;
+	int status;
+
+again:
 	if (!state.f && (flags & HASH_WRITE_OBJECT)) {
 		state.f = create_tmp_packfile(&state.pack_tmp_name);
 		reset_pack_idx_option(&state.pack_idx_opts);
@@ -171,7 +186,17 @@ int index_bulk_checkin(unsigned char *sha1,
 			die_errno("unable to write pack header");
 	}
 
-	deflate_to_pack(&state, sha1, fd, size, type, path, flags);
+	seekback = lseek(fd, 0, SEEK_CUR);
+	if (seekback == (off_t) -1)
+		return error("cannot seek");
+	status = deflate_to_pack(&state, sha1, fd, size, type, path, flags);
+	if (status == DEFLATE_TO_PACK_TOOBIG) {
+		finish_bulk_checkin(&state);
+		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
+			return error("cannot seek back");
+		goto again;
+	}
+
 	if (!state.plugged)
 		finish_bulk_checkin(&state);
 	return 0;
diff --git a/cache.h b/cache.h
index 2e6ad36..b158d3e 100644
--- a/cache.h
+++ b/cache.h
@@ -598,6 +598,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
+extern unsigned long pack_size_limit_cfg;
 extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
diff --git a/config.c b/config.c
index edf9914..c736802 100644
--- a/config.c
+++ b/config.c
@@ -797,6 +797,10 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		return 0;
 	}
 
+	if (!strcmp(var, "pack.packsizelimit")) {
+		pack_size_limit_cfg = git_config_ulong(var, value);
+		return 0;
+	}
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 0bee6a7..31e4284 100644
--- a/environment.c
+++ b/environment.c
@@ -60,6 +60,7 @@ char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 struct startup_info *startup_info;
+unsigned long pack_size_limit_cfg;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
-- 
1.7.8.rc3.208.g1edbd
