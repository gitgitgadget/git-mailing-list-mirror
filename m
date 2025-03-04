Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602A1F4735
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071305; cv=none; b=V8otQTxabbbS/oNCFsctJ9Oh5xJd+RSUWJ8aMgSFIlChCQolC3LFnm2O24GHgWmuzNYB29hR8UD9s+/TMGv9gEX8OqogJ/LVUnC3J8eouZ264SWYmDTSO7P6b8KBsBLFDgTf9eQtfWwWACk9Gmaq8kB2AXPbmB7DkMn6IkkrN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071305; c=relaxed/simple;
	bh=TgcLnlidUPmpo6lvcwH/d9j30hXzALJpcAt3skSH2IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZKa9RVgSexYFrsJ0WM/9G29KVDMPE4mteaV86w7UmICsfKpHJgkhuE+gl6I8vFWrxA7GR6OpTmC/5l8UCtH1GllwQ6MB0DQv/x4WsCt90WuFayi5tnG9k3dyplH2ppoKGq+2/jFjBLBFCWac2arTjyL8EvWhbtPby1t6okopdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ey6aCp6t; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ey6aCp6t"
Received: (qmail 9193 invoked by uid 109); 4 Mar 2025 06:55:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TgcLnlidUPmpo6lvcwH/d9j30hXzALJpcAt3skSH2IU=; b=Ey6aCp6t6Ru10P2769g7Em6oGTM1u2usD2C6fo4dGgpAR83hx7sgEkBHDeT75MMJH8M00nb0LwaqsPSc3jmv/3OV+FgYTIfDPDYViF/IEqAb9SBfV9e++wLfvF8X+YTgwTjJ9KLEU1yVDZbNKE7MUyXI2dcqTclbB3hvpGNEWWYHokzblTO4OZAb8H+C3z5EhcbmtHXLluLbv98InGX4gQDmY3QdPBqLY+bjc1JL5sY4sxDU6sjEH4wHA0fGpoVj14sxC34BKGZssNvY4l6uGSHHv+i01tjV40eKrbPlhXN5Z319R+N6WOWN1gCL39WwQFe7nI4zgSK9ecoTIT6Vxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 06:55:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22314 invoked by uid 111); 4 Mar 2025 06:55:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 01:55:01 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 01:55:01 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] unpack_loose_header(): avoid numeric comparison of
 zlib status
Message-ID: <20250304065501.GB1283901@coredump.intra.peff.net>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225063056.GF1293961@coredump.intra.peff.net>
 <Z8EEGd4Q+Py3Ym0l@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8EEGd4Q+Py3Ym0l@nand.local>

On Thu, Feb 27, 2025 at 07:32:25PM -0500, Taylor Blau wrote:

> On Tue, Feb 25, 2025 at 01:30:56AM -0500, Jeff King wrote:
> > diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> > index e493600aff..86a2825473 100755
> > --- a/t/t1006-cat-file.sh
> > +++ b/t/t1006-cat-file.sh
> > @@ -951,6 +951,8 @@ test_expect_success 'object reading handles zlib dictionary' - <<\EOT
> >  	printf '\170\273\017\112\003\143' >$objpath &&
> >
> >  	test_must_fail git cat-file blob $blob 2>err &&
> > +	test_grep ! 'too long' err &&
> > +	test_grep 'error: unable to unpack' err &&
> >  	test_grep 'error: inflate: needs dictionary' err
> >  EOT
> 
> All looking good here, too.
> 
> I think the test_grep is hiding what is a fairly unpleasant error
> message that says the same thing a few times from different points in
> the call-stack. But that isn't anything new from this series, and I'm
> content to let it be a problem for another day ;-).

Yeah, we get one set of errors when we ask for the type to find out if
we need to peel a tag (it's not a tag, it's OBJ_ERR ;) ). And then
again we ask if it's a blob to try streaming. It's still OBJ_ERR. And
then we fall back to the non-streaming case.

We should probably check for errors earlier. And also avoid asking for
the type twice when we didn't peel a tag, which is just stupidly
inefficient.

Perhaps something like this (untested):

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9de1016acd..e1dbbfeb43 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -236,7 +236,13 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 		if (exp_type_id == OBJ_BLOB) {
 			struct object_id blob_oid;
-			if (oid_object_info(the_repository, &oid, NULL) == OBJ_TAG) {
+			enum object_type found_type = oid_object_info(the_repository,
+								      &oid, NULL);
+
+			if (found_type < 0)
+				die(_("unable to read %s"), oid_to_hex(&oid));
+
+			if (found_type == OBJ_TAG) {
 				char *buffer = repo_read_object_file(the_repository,
 								     &oid,
 								     &type,
@@ -251,10 +257,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 						      &hash_algos[oid.algo]))
 					die("%s not a valid tag", oid_to_hex(&oid));
 				free(buffer);
+				found_type = type;
 			} else
 				oidcpy(&blob_oid, &oid);
 
-			if (oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB) {
+			if (found_type == OBJ_BLOB) {
 				ret = stream_blob(&blob_oid);
 				goto cleanup;
 			}

But yes, this is all way out of scope for this series, and is true of
any corruption.

-Peff
