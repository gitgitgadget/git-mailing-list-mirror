Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284D812
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451611; cv=none; b=lRNgIxru1dJhkPbrQi1Izg3U3exUWN5x1uX8c5DMPVZ2hXAeullItC3cam/LQ0wLH1pcwY+lB4l/PUjVN52bEluLVRCuZobok6ZclB5pBZ8k8u6/KhFElzC6lDVrvCv53laYCGdt2bxi+/ubOuMDeDLDgqSKHHm7B40o1V/omW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451611; c=relaxed/simple;
	bh=WBpHAygscHfE50QgOD73xaOZMJa4Ks3/K8YNPNb4Ijw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8YwAryHkhtYQisNInB9+/LLbxtnsVS6WGCO8qXYQwagTf0dLdLHm5JD/OgSgL3K7b2gtB2U5/onJecf/Zm1onqDq9OecZNmXsongfFVxtncjOtIJs9rr0NdkRDUI15an3nWIH0RL4eGcB8FAzjYjeWOYUYOW9pjyIHndSM5jXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7286 invoked by uid 109); 7 Apr 2024 01:00:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:00:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11225 invoked by uid 111); 7 Apr 2024 01:00:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:00:11 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:00:08 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 02/11] config: add git_config_pathname_dup()
Message-ID: <20240407010008.GB868358@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

The git_config_pathname() function suffers the same potential leak issue
as git_config_string(), since it is basically the same thing but with
the added twist of interpolating the path rather than just duplicating
the value.

Let's provide a similar "dup()" variant to help call sites transition to
using the leak-free variant.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 11 +++++++++++
 config.h |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/config.c b/config.c
index 2194fb078a..a0aa45abd5 100644
--- a/config.c
+++ b/config.c
@@ -1364,6 +1364,17 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_pathname_dup(char **dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	free(*dest);
+	*dest = interpolate_path(value, 0);
+	if (!*dest)
+		die(_("failed to expand user dir in: '%s'"), value);
+	return 0;
+}
+
 int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *value)
 {
 	if (!value)
diff --git a/config.h b/config.h
index cdffc14ccf..fed21d3144 100644
--- a/config.h
+++ b/config.h
@@ -300,6 +300,13 @@ int git_config_string_dup(char **, const char *, const char *);
  */
 int git_config_pathname(const char **, const char *, const char *);
 
+/**
+ * Like git_config_pathname(), but frees any previously-allocated
+ * string at the destination pointer, avoiding a leak when a
+ * config variable is seen multiple times.
+ */
+int git_config_pathname_dup(char **, const char *, const char *);
+
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
 int git_config_set_in_file_gently(const char *, const char *, const char *, const char *);
-- 
2.44.0.872.g288abe5b5b

