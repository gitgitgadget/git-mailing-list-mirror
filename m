Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4733EB03
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054400; cv=none; b=Q1BeYGhglh/v9kM189Brq6a020IgGvC7QImKlQsJsi4MCjx7Z0iHTGQSADYpsZv8YZX9IL8GpZemm5DOBmTjBnfgMOPucA58nHk1Lf184fMVnbtM0dxmHv8Q+7ijLUv3gocGvAV+nINSSyCpyt96VJ6ubtqba6n9A7/26NDoNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054400; c=relaxed/simple;
	bh=yTD3xZiLhXOs2gCdbsJgbf1E6Kq/FOo0ODPWmgGuNE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzNLoPRQtZUx7M1fH4non8bH9Eod0d14Li/FHFrB50LnNcywMSqcDQvzNGb07nkoIE12jL9zLWgy8dF83fCp9DtYtFF2pXxvlX6Vnd6OOLyEy7KHOC16R+OLgcbPF+kHvJQlKe45/FElT+9B3SVn6mdGWkuHN7mOkocOUajV9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZVGF0C02; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZVGF0C02"
Received: (qmail 102505 invoked by uid 109); 16 Sep 2025 20:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yTD3xZiLhXOs2gCdbsJgbf1E6Kq/FOo0ODPWmgGuNE8=; b=ZVGF0C028bF+3iIqFemvurcbP7vO4D4uCinEkcCjUoFX54Vvt/qR3XClH7ipKwikQPBj121bYTlAM83vJXY7YRDGUFha01LV8MmSp7pK+f3KyIxnfzgenk67ZLY0OOzMaSmQYESAo+Pfxq/cpKT3Je6llp52sxv337W36zYONcGhVTr/ayidZjNp7jT5bmtJPTmAcpP9oLBEaEUuxiqdUEi/CvmZ3jicAHQZ4PZPxZsLytihPpbdngK3ZSykdPyxkkXPz1SdtXWMYPqiBn1QSPenBIZ5Gh7mExACzlz/g93eg1nvKBPhOZHOAUznjkPQiHXhWxOP3Z2Hd1OvTZP1wQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:26:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166308 invoked by uid 111); 16 Sep 2025 20:26:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:26:37 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:26:37 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 12/13] config: store want_color() result in a separate bool
Message-ID: <20250916202637.GL612873@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

The "git config --get-colorbool foo.bar" command not only digs in the
config to find the value of foo.bar, it evaluates the result using
want_color() to check the tty-ness of stdout.

But it stores the bool result of want_color() in the same git_colorbool
that we found in the config. This works in practice because the
git_colorbool enum is a superset of the bool values. But it is an oddity
from a type system perspective.

Let's instead store the result in a separate bool and use that.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 9e4e4eb2f1..2348a99dd4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -598,6 +598,7 @@ static int get_colorbool(const struct config_location_options *opts,
 		.get_diff_color_found = GIT_COLOR_UNKNOWN,
 		.get_color_ui_found = GIT_COLOR_UNKNOWN,
 	};
+	bool result;
 
 	config_with_options(git_get_colorbool_config, &data,
 			    &opts->source, the_repository,
@@ -614,13 +615,13 @@ static int get_colorbool(const struct config_location_options *opts,
 		/* default value if none found in config */
 		data.get_colorbool_found = GIT_COLOR_AUTO;
 
-	data.get_colorbool_found = want_color(data.get_colorbool_found);
+	result = want_color(data.get_colorbool_found);
 
 	if (print) {
-		printf("%s\n", data.get_colorbool_found ? "true" : "false");
+		printf("%s\n", result ? "true" : "false");
 		return 0;
 	} else
-		return data.get_colorbool_found ? 0 : 1;
+		return result ? 0 : 1;
 }
 
 static void check_write(const struct git_config_source *source)
-- 
2.51.0.527.g34bc42dacd

