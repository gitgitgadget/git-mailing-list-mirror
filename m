Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F523A3826
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552467; cv=none; b=nkDQyLFHp6ASirFX52z92/Opk8xdh6Ij7zCg/NY5eA1Fgyy1NNIkFNuNdU+PzGM7xwjrHEpC9nhVCpFc5r+T1PX3O+ajpN16S8tKk4/NYp5ZLGiuvjvWkUdnF3ybq82K6ndnlZIVWemUEWGDbV7a7/w7vkF6G9rMKTlxnrSDgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552467; c=relaxed/simple;
	bh=WX5RfaPFomNf/MfCz+RhZybj4k1fm8ni9IrFKSZUAJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUTxTbYD/RxrJpLJziZTIw/HXhTUnPoATsj+U8uVwYierEDUIYSxiT1zVGwlmxx7YZDfhWr5nDY512tnGIbwwVdl18+p3ZbRsR+6ashJMKI4zg8DcfmhKOLsL7/T9g3U5cbSwL2iEs/YkwodLV6Uw7jU6HS0QlBBgBsb0VFyd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RRs0wLNk; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RRs0wLNk"
Received: (qmail 155663 invoked by uid 106); 26 Mar 2026 19:14:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WX5RfaPFomNf/MfCz+RhZybj4k1fm8ni9IrFKSZUAJE=; b=RRs0wLNkIA2LOG6ayQntBkS6ZwvvIn5w3gM7EJPdgqig3GK6OXwAMboL65bQUZ644g7QZnGC3WfsHckU1xOrSE7lPs7O7/6UUCn9PCWLDG5G5A4BTcjtdAY9X3wwtKx5AHXPjhwCbWmowi6Kog07kwpNRgsxGP28/PkjZLDF0NJmgnEqQZ2XfKr8J7xjaiQmT5VpMX9w9l54+cF9toKiYY7xGH42sazNWu3ipRpxPFX8thmr8Cf13oQxqMS2b5qi2oZDOuINUIfPs4Np6zKm2RFBLXFhKN6ir7s5IcPd19yrE6O06JkvhdB7IA039w25duaaV7W+oBGk+l9cGj7OMA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 19:14:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 215905 invoked by uid 111); 26 Mar 2026 19:14:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 15:14:24 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 15:14:24 -0400
From: Jeff King <peff@peff.net>
To: Michael J Gruber <git@grubix.eu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 4/4] rev-parse: avoid writing to const string for parent marks
Message-ID: <20260326191424.GD415796@coredump.intra.peff.net>
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

The previous commit cleared up some const confusion in handling parent
marks in revision.c, but we have roughly the same code duplicated in
rev-parse. This one is much easier to fix, because the handling of the
shortened string is all done in one place, after detecting any marks
(but without shortening the string between marks).

  As a side note, I suspect this means that it behaves differently than
  the revision.c parser for weird stuff like "foo^!^@^-", but that is
  outside the scope of this patch.

While we are here, let's also rename the variable "dotdot", which is
totally misleading (and which we already fixed in revision.c long ago
via f632dedd8d (handle_revision_arg: stop using "dotdot" as a generic
pointer, 2017-05-19)).

Doing that here makes the diff a little messier, but it also lets the
compiler help us make sure we did not miss any stray mentions of the
variable while we are changing its semantics.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 5da9537113..218b5f34d6 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -326,46 +326,47 @@ static int try_difference(const char *arg)
 
 static int try_parent_shorthands(const char *arg)
 {
-	char *dotdot;
+	const char *mark;
 	struct object_id oid;
 	struct commit *commit;
 	struct commit_list *parents;
 	int parent_number;
 	int include_rev = 0;
 	int include_parents = 0;
 	int exclude_parent = 0;
+	char *to_free;
 
-	if ((dotdot = strstr(arg, "^!"))) {
+	if ((mark = strstr(arg, "^!"))) {
 		include_rev = 1;
-		if (dotdot[2])
+		if (mark[2])
 			return 0;
-	} else if ((dotdot = strstr(arg, "^@"))) {
+	} else if ((mark = strstr(arg, "^@"))) {
 		include_parents = 1;
-		if (dotdot[2])
+		if (mark[2])
 			return 0;
-	} else if ((dotdot = strstr(arg, "^-"))) {
+	} else if ((mark = strstr(arg, "^-"))) {
 		include_rev = 1;
 		exclude_parent = 1;
 
-		if (dotdot[2]) {
+		if (mark[2]) {
 			char *end;
-			exclude_parent = strtoul(dotdot + 2, &end, 10);
+			exclude_parent = strtoul(mark + 2, &end, 10);
 			if (*end != '\0' || !exclude_parent)
 				return 0;
 		}
 	} else
 		return 0;
 
-	*dotdot = 0;
+	arg = to_free = xmemdupz(arg, mark - arg);
 	if (repo_get_oid_committish(the_repository, arg, &oid) ||
 	    !(commit = lookup_commit_reference(the_repository, &oid))) {
-		*dotdot = '^';
+		free(to_free);
 		return 0;
 	}
 
 	if (exclude_parent &&
 	    exclude_parent > commit_list_count(commit->parents)) {
-		*dotdot = '^';
+		free(to_free);
 		return 0;
 	}
 
@@ -386,7 +387,7 @@ static int try_parent_shorthands(const char *arg)
 		free(name);
 	}
 
-	*dotdot = '^';
+	free(to_free);
 	return 1;
 }
 
-- 
2.53.0.1081.gf77a8b8145
