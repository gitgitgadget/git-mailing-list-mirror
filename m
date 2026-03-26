Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057334CFDE
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551887; cv=none; b=lfkRoYecQGAfWD9/KmelP6CpsbyAP6UjjEItnT4vSHV54VMBuicXdOv1jrFbm3wnpKEdQegKpFrF0LJr3mzpHp/mwIunhjeMaquW30LX71wgf/WV6W577izuO7qRKkNmIl/u1FAvO1s7fuD7YIVJJJ8jVqeQpUVw3Hm0Zq4nTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551887; c=relaxed/simple;
	bh=sJvs23Vt9c00gsLWIShM7QCHBfu/qvqHYdnVLKssiEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WErxNf/tvkoV9uTuHU3gWGMZOIXZeHlA1kniAHFUQcmwQrLFZgYhF1FbtjsCWjOrdUaujxFVLHW1S0YNHpmbVLNwEiqSg0sHiYOpTZcjgvEtXBsLiNrWi9VWdwCMU18Y+HpBYkcnIyd6g8Lc3sZKMRvKi0eCZ3mB/izAWRET4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QmMKBkrU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QmMKBkrU"
Received: (qmail 155555 invoked by uid 106); 26 Mar 2026 19:04:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sJvs23Vt9c00gsLWIShM7QCHBfu/qvqHYdnVLKssiEU=; b=QmMKBkrUDywsBkmlF2kBe7Noy8wiso5YeIJ4ri766QxYTbXBefz4PlRpOq6zU9hGNSvylWK4GWuWgmrNYuP4Xurz7bYJ4vNDQflkReKqZJMAgz2ajTXxLwEAbz1IhhNEuzbNqU7/pqhmV+D0niDP1qIBUXSu9qybFF3IV9ZB1GkcyW9foLq6tuNXJMYx0LYc2EAbGaZykL5k/vkiYaPq/wQJ1HEsrwmNAONgJf+ApseoXyh4ulJW3rJnQR8nAxQDzOErmlzibp8R5wRfOZ4AMCTzo2Sn811bA/yqfGCWC7Su8t5EktZCbqKd9fTn0fXg/uo/YizI020zRzVO9tY/Ww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 19:04:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 215740 invoked by uid 111); 26 Mar 2026 19:04:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 15:04:44 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 15:04:44 -0400
From: Jeff King <peff@peff.net>
To: Michael J Gruber <git@grubix.eu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 1/4] revision: make handle_dotdot() interface less confusing
Message-ID: <20260326190444.GA415796@coredump.intra.peff.net>
References: <20260326190243.GA412983@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326190243.GA412983@coredump.intra.peff.net>

There are two very subtle bits to the way we parse ".." (and "...")
range operators:

 1. In handle_dotdot_1(), we assume that the incoming arguments "dotdot"
    and "arg" are part of the same string, with the first digit of the
    range-operator blanked to a NUL. Then when we want the full name
    (e.g., to report an error), we replace the NUL with a dot to restore
    the original string.

 2. In handle_dotdot(), we take in a const string, but then we modify it
    by overwriting the range operator with a NUL. This has worked OK in
    practice since we tend to pass in buffers that are actually
    writeable (including argv), but segfaults with something like:

      handle_revision_arg("..HEAD", &revs, 0, 0);

    On top of that, building with recent versions of glibc causes the
    compiler to complain, because it notices when we use strchr() or
    strstr() to launder away constness (basically detecting the
    possibility of the segfault above via the type system).

Instead of munging the buffer, let's instead make a temporary copy of
the left-hand side of the range operator. That avoids any const
violations, and lets us pass around the parsed elements independently:
the left-hand side, the right-hand side, the number of dots (via the
"symmetric" flag), and the original full string for error messages.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/revision.c b/revision.c
index 31808e3df0..f61262436f 100644
--- a/revision.c
+++ b/revision.c
@@ -2038,41 +2038,32 @@ static void prepare_show_merge(struct rev_info *revs)
 	free(prune);
 }
 
-static int dotdot_missing(const char *arg, char *dotdot,
+static int dotdot_missing(const char *full_name,
 			  struct rev_info *revs, int symmetric)
 {
 	if (revs->ignore_missing)
 		return 0;
-	/* de-munge so we report the full argument */
-	*dotdot = '.';
 	die(symmetric
 	    ? "Invalid symmetric difference expression %s"
-	    : "Invalid revision range %s", arg);
+	    : "Invalid revision range %s", full_name);
 }
 
-static int handle_dotdot_1(const char *arg, char *dotdot,
+static int handle_dotdot_1(const char *a_name, const char *b_name,
+			   const char *full_name, int symmetric,
 			   struct rev_info *revs, int flags,
 			   int cant_be_filename,
 			   struct object_context *a_oc,
 			   struct object_context *b_oc)
 {
-	const char *a_name, *b_name;
 	struct object_id a_oid, b_oid;
 	struct object *a_obj, *b_obj;
 	unsigned int a_flags, b_flags;
-	int symmetric = 0;
 	unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
 	unsigned int oc_flags = GET_OID_COMMITTISH | GET_OID_RECORD_PATH;
 
-	a_name = arg;
 	if (!*a_name)
 		a_name = "HEAD";
 
-	b_name = dotdot + 2;
-	if (*b_name == '.') {
-		symmetric = 1;
-		b_name++;
-	}
 	if (!*b_name)
 		b_name = "HEAD";
 
@@ -2081,15 +2072,13 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		return -1;
 
 	if (!cant_be_filename) {
-		*dotdot = '.';
-		verify_non_filename(revs->prefix, arg);
-		*dotdot = '\0';
+		verify_non_filename(revs->prefix, full_name);
 	}
 
 	a_obj = parse_object(revs->repo, &a_oid);
 	b_obj = parse_object(revs->repo, &b_oid);
 	if (!a_obj || !b_obj)
-		return dotdot_missing(arg, dotdot, revs, symmetric);
+		return dotdot_missing(full_name, revs, symmetric);
 
 	if (!symmetric) {
 		/* just A..B */
@@ -2103,7 +2092,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		a = lookup_commit_reference(revs->repo, &a_obj->oid);
 		b = lookup_commit_reference(revs->repo, &b_obj->oid);
 		if (!a || !b)
-			return dotdot_missing(arg, dotdot, revs, symmetric);
+			return dotdot_missing(full_name, revs, symmetric);
 
 		if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0) {
 			commit_list_free(exclude);
@@ -2132,16 +2121,23 @@ static int handle_dotdot(const char *arg,
 			 int cant_be_filename)
 {
 	struct object_context a_oc = {0}, b_oc = {0};
-	char *dotdot = strstr(arg, "..");
+	const char *dotdot = strstr(arg, "..");
+	char *tmp;
+	int symmetric = 0;
 	int ret;
 
 	if (!dotdot)
 		return -1;
 
-	*dotdot = '\0';
-	ret = handle_dotdot_1(arg, dotdot, revs, flags, cant_be_filename,
-			      &a_oc, &b_oc);
-	*dotdot = '.';
+	tmp = xmemdupz(arg, dotdot - arg);
+	dotdot += 2;
+	if (*dotdot == '.') {
+		symmetric = 1;
+		dotdot++;
+	}
+	ret = handle_dotdot_1(tmp, dotdot, arg, symmetric, revs, flags,
+			      cant_be_filename, &a_oc, &b_oc);
+	free(tmp);
 
 	object_context_release(&a_oc);
 	object_context_release(&b_oc);
-- 
2.53.0.1081.gf77a8b8145

