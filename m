Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A9312815
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551929; cv=none; b=Fk9lTv3cIpjgPoJPTD2MTp7tD7BG/9xIka2BoizCaNm0f9JtPxIyQMq6eWmz7ASTbzx12GTcJJofuoiEHfvvUb+9xt5vBAncMLZUKXLh+gLiVTqHkJDcVE3aYrR2Gdk7Xm0zUQkcUljO0Mftl54JbMR3zDWdIIJtp1Ysr3R6QIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551929; c=relaxed/simple;
	bh=MmdM4lNlcCTql7fNFxdERYEL/oiBKKLUaVTg/c6O5DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0TQ3LNv3NFthmbbS677C7KMN6tFOQsAvDVEefD1+wpNom1EifwORUmVKt678Hjzostm79bHi+Q1edf4rW+qCWNhGelvxocf3ZBPLSYiss5zKU2DDGOCSf0u0rZ2j03fFptmq4T9h8K1WdcqsPrQu9RtmZUvcHv2AVZE51vvfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RWBUrM/Q; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RWBUrM/Q"
Received: (qmail 155566 invoked by uid 106); 26 Mar 2026 19:05:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MmdM4lNlcCTql7fNFxdERYEL/oiBKKLUaVTg/c6O5DU=; b=RWBUrM/QpzrNCA5ymnXdLSPKnWK6hbLD3pjM4aqcmHfaexIbwcXDwucziolqXIAaY/ciDP2NYSxJIjdQo1arc/+E1LhBam0xF5Ha6ojVwht6w50A/kqBAoF+4jWvvZy3CfwYPoqFBruDLe8xZLtZxqPFiOiFVcivIwq9qqkdfExNDXcIcHQpwNJNSma/jwbYrm56EHZx4CEr8BtIX3p1liSfdC/QelvsreqUTXKd2e/zQDztTSwJ+LoTQHL1yYURXd8aXqWEhNrS+Yrbw13GhQg7sBCvHRVAogEoXzUc5+LtOlvSZ/54dIno/Ue3VJPoc6VofrJxFnv3sN3arDMtQg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 19:05:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 215779 invoked by uid 111); 26 Mar 2026 19:05:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 15:05:26 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 15:05:25 -0400
From: Jeff King <peff@peff.net>
To: Michael J Gruber <git@grubix.eu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 2/4] rev-parse: simplify dotdot parsing
Message-ID: <20260326190525.GB415796@coredump.intra.peff.net>
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

The previous commit simplified the way that revision.c parses ".." and
"..." range operators. But there's roughly similar code in rev-parse.
This is less likely to trigger a segfault, as there is no library
function which we'd pass a string literal to, but it still causes the
compiler to complain about laundering away constness via strstr().

Let's give it the same treatment, copying the left-hand side of the
range operator into its own string.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 01a62800e8..5da9537113 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -267,21 +267,20 @@ static int show_file(const char *arg, int output_prefix)
 
 static int try_difference(const char *arg)
 {
-	char *dotdot;
+	const char *dotdot;
 	struct object_id start_oid;
 	struct object_id end_oid;
 	const char *end;
 	const char *start;
+	char *to_free;
 	int symmetric;
 	static const char head_by_default[] = "HEAD";
 
 	if (!(dotdot = strstr(arg, "..")))
 		return 0;
+	start = to_free = xmemdupz(arg, dotdot - arg);
 	end = dotdot + 2;
-	start = arg;
 	symmetric = (*end == '.');
-
-	*dotdot = 0;
 	end += symmetric;
 
 	if (!*end)
@@ -295,7 +294,7 @@ static int try_difference(const char *arg)
 		 * Just ".."?  That is not a range but the
 		 * pathspec for the parent directory.
 		 */
-		*dotdot = '.';
+		free(to_free);
 		return 0;
 	}
 
@@ -308,7 +307,7 @@ static int try_difference(const char *arg)
 			a = lookup_commit_reference(the_repository, &start_oid);
 			b = lookup_commit_reference(the_repository, &end_oid);
 			if (!a || !b) {
-				*dotdot = '.';
+				free(to_free);
 				return 0;
 			}
 			if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0)
@@ -318,10 +317,10 @@ static int try_difference(const char *arg)
 				show_rev(REVERSED, &commit->object.oid, NULL);
 			}
 		}
-		*dotdot = '.';
+		free(to_free);
 		return 1;
 	}
-	*dotdot = '.';
+	free(to_free);
 	return 0;
 }
 
-- 
2.53.0.1081.gf77a8b8145

