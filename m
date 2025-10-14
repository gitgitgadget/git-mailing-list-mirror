Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D841448D5
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400698; cv=none; b=Rl5BzlUtqB6tRg0HPqMRjNie2LaGJ5K1Nsrt56bNwjjREpGs0T4P+90Oj2VO+ZCpHssEf1O5a6dtN2n+6xVKnlKbSjbnSO9fuUPJ5Ty5ceiQBRhLe9QtWfX86do2dr7zr5NV5p6oflEwCtl6O8Z/i+MyGhFYq018qGxGjk21O8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400698; c=relaxed/simple;
	bh=kpBgYQ9dPReIK07qaJdFfoByuoXH9DHx6YmJJLVtqF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsVRKVjfnH7KcwveH8QsQfGXCv/0bbD/T0azObEayQhwygiIaLIG1LP6CX3UJFe7W6I70V4gZGCZanIQC/vX2Vu0IjOIpYMPM1uZcY0IXu+MFVmcf8OluyBIyEn1uscnVPfeApHSzaLV/JDWA2unGIHhCIZeaIKa555wca3U18A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MlESf3iJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MlESf3iJ"
Received: (qmail 211884 invoked by uid 109); 14 Oct 2025 00:11:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kpBgYQ9dPReIK07qaJdFfoByuoXH9DHx6YmJJLVtqF0=; b=MlESf3iJzKcXmNAsVH9fLWNiH5W/JgDnSK5Yhb4BC0ZVWwFIpoImBsIfUe66LHfA/aiWsAG0uE93ghN/HbgV5yB0dXCHARsDvezPcFB0dq41Jd5njmde7p3jOErhA+To71jnMRO7/q+Q7pQ07pLMkts+G+G/ODUJ34pqDUcWkLIlZZCvCoyMO8cn63GiKXpHe599UE2cQyB5uBroUW9mJ7dxpG8u6Sa0j0MParGgeG5p/FLNO7Pr2Csd3CGCBdFk7uugnhpVhXVx8zEekXxtWeijFvAWwLZctfsCqeM6bf+LlVMto7oWVsYn3k1ZbgpBD25FN0UAcuVv0W62C3VezA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Oct 2025 00:11:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 341741 invoked by uid 111); 14 Oct 2025 00:11:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Oct 2025 20:11:28 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Oct 2025 20:11:28 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] builtin/cat-file.c: simplify calling
 `report_object_status()`
Message-ID: <20251014001128.GB1507@coredump.intra.peff.net>
References: <9236fa6e654a59337266430a2a8807da21210cd4.1760392502.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9236fa6e654a59337266430a2a8807da21210cd4.1760392502.git.me@ttaylorr.com>

On Mon, Oct 13, 2025 at 05:56:01PM -0400, Taylor Blau wrote:

> That commit does so by calling report_object_status() and passing in
> "oid_to_hex(&data->oid)" for the "obj_name" parameter. This is
> unnecessary, however, since report_object_status() will do the same
> automatically if given a NULL "obj_name" argument.

Yeah, looking at the code, this should obviously be a noop change, and I
think it simplifies things a little.

It is interesting that "oid" is not used in report_object_status()
except for this fallback. Which kind of makes me wonder if we could
ditch it completely, and just pass int oid_to_hex() unconditionally
here. But it's hard to say if other code paths might end up with a NULL
obj_name somehow (e.g., in an error path).

...poking at it...

Ah, indeed. The patch below does fail one test in t5313 with a corrupted
pack. So not worth pursuing that further simplification.

Your patch looks good to me. :)

-Peff

-- >8 --
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ee6715fa52..19625b5a64 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -455,11 +455,9 @@ static void print_default_format(struct strbuf *scratch, struct expand_data *dat
 
 static void report_object_status(struct batch_options *opt,
 				 const char *obj_name,
-				 const struct object_id *oid,
 				 const char *status)
 {
-	printf("%s %s%c", obj_name ? obj_name : oid_to_hex(oid),
-	       status, opt->output_delim);
+	printf("%s %s%c", obj_name, status, opt->output_delim);
 	fflush(stdout);
 }
 
@@ -495,9 +493,9 @@ static void batch_object_write(const char *obj_name,
 							    OBJECT_INFO_LOOKUP_REPLACE);
 		if (ret < 0) {
 			if (data->mode == S_IFGITLINK)
-				report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "submodule");
+				report_object_status(opt, oid_to_hex(&data->oid), "submodule");
 			else
-				report_object_status(opt, obj_name, &data->oid, "missing");
+				report_object_status(opt, obj_name, "missing");
 			return;
 		}
 
@@ -507,25 +505,22 @@ static void batch_object_write(const char *obj_name,
 		case LOFC_BLOB_NONE:
 			if (data->type == OBJ_BLOB) {
 				if (!opt->all_objects)
-					report_object_status(opt, obj_name,
-							     &data->oid, "excluded");
+					report_object_status(opt, obj_name, "excluded");
 				return;
 			}
 			break;
 		case LOFC_BLOB_LIMIT:
 			if (data->type == OBJ_BLOB &&
 			    data->size >= opt->objects_filter.blob_limit_value) {
 				if (!opt->all_objects)
-					report_object_status(opt, obj_name,
-							     &data->oid, "excluded");
+					report_object_status(opt, obj_name, "excluded");
 				return;
 			}
 			break;
 		case LOFC_OBJECT_TYPE:
 			if (data->type != opt->objects_filter.object_type) {
 				if (!opt->all_objects)
-					report_object_status(opt, obj_name,
-							     &data->oid, "excluded");
+					report_object_status(opt, obj_name, "excluded");
 				return;
 			}
 			break;
@@ -581,10 +576,10 @@ static void batch_one_object(const char *obj_name,
 	if (result != FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
-			report_object_status(opt, obj_name, &data->oid, "missing");
+			report_object_status(opt, obj_name, "missing");
 			break;
 		case SHORT_NAME_AMBIGUOUS:
-			report_object_status(opt, obj_name, &data->oid, "ambiguous");
+			report_object_status(opt, obj_name, "ambiguous");
 			break;
 		case DANGLING_SYMLINK:
 			printf("dangling %"PRIuMAX"%c%s%c",
