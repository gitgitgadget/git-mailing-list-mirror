Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5B210EC
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923945; cv=none; b=pWb/quPYk/UeM/GEko5gvr4MuStDwAENcM19fMRCDBbbTE6ckXelfHbXBwFHUGor+b+ph0mYCtwFdWhwFWHr5Pk0X+EQXv7YHO42Y6jUTBoXEWKR5LYaYg5GqN1x7cTu7UGMzUMeqFCeJIysk7VMO6ikW917wk5/x72pbIBpGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923945; c=relaxed/simple;
	bh=3IKYQ4rDaj1foKll4xoRe0xu68VP9pZIhvafL9CNWFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCCiDBpTQbudmGt+nDvfcyNvPDMWXbRgMHl5ecKt0fFim9Hi/zUMx+LLjbLryzQTGIB8BMG0zm84snIy9hYW6JS2rqzSSeylyfqxyMjU5C+DsANHGYk5RkdAyFQjh6Gl/l1hznxSZsPbUXZSsxP3TaOOuJVJgU6JbdE/9F5sdzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32252 invoked by uid 109); 9 Sep 2024 23:19:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:19:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24975 invoked by uid 111); 9 Sep 2024 23:19:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:19:02 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:19:02 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 7/9] ref-filter: fix leak with %(describe) arguments
Message-ID: <20240909231902.GG921834@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909230758.GA921697@coredump.intra.peff.net>

When we parse a %(describe) placeholder, we stuff its arguments into a
strvec, which is then detached into the used_atom struct. But later,
when ref_array_clear() frees the atom, we never free the memory.

To solve this, we just need to add the appropriate free() calls. But
it's a little awkward, since we have to free each element of the array,
in addition to the array itself. Instead, let's store the actual strvec,
which lets us do a simple strvec_clear().

This clears up one case that LSan finds in t6300, but there are more.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 54c5079dde..370cc5b44a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -233,7 +233,7 @@ static struct used_atom {
 			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
-		const char **describe_args;
+		struct strvec describe_args;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -693,7 +693,7 @@ static int describe_atom_parser(struct ref_format *format UNUSED,
 				struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
-	struct strvec args = STRVEC_INIT;
+	strvec_init(&atom->u.describe_args);
 
 	for (;;) {
 		int found = 0;
@@ -702,13 +702,12 @@ static int describe_atom_parser(struct ref_format *format UNUSED,
 		if (!arg || !*arg)
 			break;
 
-		found = describe_atom_option_parser(&args, &arg, err);
+		found = describe_atom_option_parser(&atom->u.describe_args, &arg, err);
 		if (found < 0)
 			return found;
 		if (!found)
 			return err_bad_arg(err, "describe", bad_arg);
 	}
-	atom->u.describe_args = strvec_detach(&args);
 	return 0;
 }
 
@@ -1941,7 +1940,7 @@ static void grab_describe_values(struct atom_value *val, int deref,
 
 		cmd.git_cmd = 1;
 		strvec_push(&cmd.args, "describe");
-		strvec_pushv(&cmd.args, atom->u.describe_args);
+		strvec_pushv(&cmd.args, atom->u.describe_args.v);
 		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
 		if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
 			error(_("failed to run 'describe'"));
@@ -3004,6 +3003,8 @@ void ref_array_clear(struct ref_array *array)
 		struct used_atom *atom = &used_atom[i];
 		if (atom->atom_type == ATOM_HEAD)
 			free(atom->u.head);
+		else if (atom->atom_type == ATOM_DESCRIBE)
+			strvec_clear(&atom->u.describe_args);
 		else if (atom->atom_type == ATOM_TRAILERS ||
 			 (atom->atom_type == ATOM_CONTENTS &&
 			  atom->u.contents.option == C_TRAILERS)) {
-- 
2.46.0.867.gf99b2b8e0f

