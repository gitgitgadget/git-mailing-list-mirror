Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6D143739
	for <git@vger.kernel.org>; Thu, 30 May 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051524; cv=none; b=KAXH37Xk5ZMKhf1/L91d9PSVui8PG2/xDVHko9ory9J5cJERB0zbMnZRHGZgeuGCd0dYFGIbfOnVZGkCZJl0Q33u0h6J27iYis+Mhd9jp93MuYmJ4k02uV2KWByXGhKPrYPB9yfzxx8jQKBgVwBn7O7hqHarW5J8In/SbYVwd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051524; c=relaxed/simple;
	bh=FCPomW+MLc5IfG/su35hexOZjGheWoiq1pI83NjxyM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4awqYtpm1XH7PNpFZGV+Z3w9oeHp/Ug5sAJ9ipPAfB22q/GgR6vWB3BKrXrdqGRtGc0+IgbNdVmEPf2e9XOM4r5dAkLULf1uP4w4JRzgUX5dDYKpq1ht1twJJ7sPezoRAbmfSooAaoEEwHLO1rTUipB+NL0LaU5bDHZ5Vq9oto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16808 invoked by uid 109); 30 May 2024 06:45:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 06:45:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27681 invoked by uid 111); 30 May 2024 06:45:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 02:45:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 02:45:21 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 4/5] mv: factor out empty src_dir removal
Message-ID: <20240530064521.GD1949704@coredump.intra.peff.net>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530063857.GA1942535@coredump.intra.peff.net>

This pulls the loop added by b6f51e3db9 (mv: cleanup empty
WORKING_DIRECTORY, 2022-08-09) into a sub-function. That reduces clutter
in cmd_mv() and makes it easier to see that the lifetime of the
a_src_dir strbuf is limited to this code (and thus its cleanup doesn't
need to go after the "out" label).

Another option would be to just declare the strbuf inside the loop,
since it is only used there. But this refactor retains the existing
property that we can reuse the allocated buffer for each iteration of
the loop. That optimization is probably overkill, but I think the
sub-function is more readable anyway, and then keeping the optimization
is basically free.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mv.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 852b4e92c1..01725e4a20 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -156,6 +156,28 @@ static int empty_dir_has_sparse_contents(const char *name)
 	return ret;
 }
 
+static void remove_empty_src_dirs(const char **src_dir, size_t src_dir_nr)
+{
+	size_t i;
+	struct strbuf a_src_dir = STRBUF_INIT;
+
+	for (i = 0; i < src_dir_nr; i++) {
+		int dummy;
+		strbuf_addstr(&a_src_dir, src_dir[i]);
+		/*
+		 * if entries under a_src_dir are all moved away,
+		 * recursively remove a_src_dir to cleanup
+		 */
+		if (index_range_of_same_dir(a_src_dir.buf, a_src_dir.len,
+					    &dummy, &dummy) < 1) {
+			remove_dir_recursively(&a_src_dir, 0);
+		}
+		strbuf_reset(&a_src_dir);
+	}
+
+	strbuf_release(&a_src_dir);
+}
+
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
@@ -177,7 +199,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	char *dst_w_slash = NULL;
 	const char **src_dir = NULL;
 	int src_dir_nr = 0, src_dir_alloc = 0;
-	struct strbuf a_src_dir = STRBUF_INIT;
 	enum update_mode *modes, dst_mode = 0;
 	struct stat st, dest_st;
 	struct string_list src_for_dst = STRING_LIST_INIT_DUP;
@@ -538,24 +559,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	/*
-	 * cleanup the empty src_dirs
-	 */
-	for (i = 0; i < src_dir_nr; i++) {
-		int dummy;
-		strbuf_addstr(&a_src_dir, src_dir[i]);
-		/*
-		 * if entries under a_src_dir are all moved away,
-		 * recursively remove a_src_dir to cleanup
-		 */
-		if (index_range_of_same_dir(a_src_dir.buf, a_src_dir.len,
-					    &dummy, &dummy) < 1) {
-			remove_dir_recursively(&a_src_dir, 0);
-		}
-		strbuf_reset(&a_src_dir);
-	}
-
-	strbuf_release(&a_src_dir);
+	remove_empty_src_dirs(src_dir, src_dir_nr);
 
 	if (dirty_paths.nr)
 		advise_on_moving_dirty_path(&dirty_paths);
-- 
2.45.1.692.gbe047d9c60

