Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B73207
	for <git@vger.kernel.org>; Thu, 30 May 2024 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051602; cv=none; b=nsJC/Vf3X14H1SpegIOtZwfRCr+NBiQeOAIwEDX8JlSUvAFMUQB0puAaFhAWELNJO212Irscws/1QedRDC/aqIztpJ+uWUxl7aGZu9pJb9UWQ+y2FzQPiyhQ56EWy++Gf81a+qBNjQ96/JlkYe64/Pio76ft7hYv30SwAUlVZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051602; c=relaxed/simple;
	bh=QlauurVVKhlzavNDT07ujeSfoI0lDelrQLMrA8N1BiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLzDWedxXB0tpepq4pZgiI52k4xCnfZ87PPI42lZwo31LbYeuCP2Nv3waSCd2O7l4fDl+CT43vp4zrg8mqwYvnW88uGHxla/ehgm/M8f9fRcLJRlk2WlKczKFGWoRedwCW5yaJsTMydUs3kaneMjQv75fxSgsNGFwulex2fbMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16825 invoked by uid 109); 30 May 2024 06:46:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 06:46:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27689 invoked by uid 111); 30 May 2024 06:46:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 02:46:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 02:46:38 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 5/5] mv: replace src_dir with a strvec
Message-ID: <20240530064638.GE1949704@coredump.intra.peff.net>
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

We manually manage the src_dir array with ALLOC_GROW. Using a strvec is
a little more ergonomic, and makes the memory ownership more clear. It
does mean that we copy the strings (which were otherwise just pointers
into the "sources" strvec), but using the same rationale as 9fcd9e4e72
(builtin/mv duplicate string list memory, 2024-05-27), it's just not
enough to be worth worrying about here.

As a bonus, this gets rid of some "int"s used for allocation management
(though in practice these were limited to command-line sizes and thus
not overflowable).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 01725e4a20..6c69033c5f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -197,8 +197,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct strvec submodule_gitfiles_to_free = STRVEC_INIT;
 	const char **submodule_gitfiles;
 	char *dst_w_slash = NULL;
-	const char **src_dir = NULL;
-	int src_dir_nr = 0, src_dir_alloc = 0;
+	struct strvec src_dir = STRVEC_INIT;
 	enum update_mode *modes, dst_mode = 0;
 	struct stat st, dest_st;
 	struct string_list src_for_dst = STRING_LIST_INIT_DUP;
@@ -344,8 +343,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			/* last - first >= 1 */
 			modes[i] |= WORKING_DIRECTORY;
 
-			ALLOC_GROW(src_dir, src_dir_nr + 1, src_dir_alloc);
-			src_dir[src_dir_nr++] = src;
+			strvec_push(&src_dir, src);
 
 			n = argc + last - first;
 			REALLOC_ARRAY(modes, n);
@@ -559,7 +557,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	remove_empty_src_dirs(src_dir, src_dir_nr);
+	remove_empty_src_dirs(src_dir.v, src_dir.nr);
 
 	if (dirty_paths.nr)
 		advise_on_moving_dirty_path(&dirty_paths);
@@ -574,7 +572,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	ret = 0;
 
 out:
-	free(src_dir);
+	strvec_clear(&src_dir);
 	free(dst_w_slash);
 	string_list_clear(&src_for_dst, 0);
 	string_list_clear(&dirty_paths, 0);
-- 
2.45.1.692.gbe047d9c60
