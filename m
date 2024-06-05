Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A71190486
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581802; cv=none; b=J5xNP7hcnK9XP4U5NMFeHnh3KN6vrZndx2xO+boecl8uOVjgexH6iPYwU0liqPSAZZUOgaGgF22+4t3u431E0nqHIFtzyY71GiIpvL0yDsQn9j6tFeOuGmhp8oC2ULqjIiuFstd/9VwiCRWJk/tRFVDZi6zgS+8bgb3o+zzPN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581802; c=relaxed/simple;
	bh=xkWiLskl/PB+TP8BdmbQGxUecdVeezt8+TdmpjtBpnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvWf5tgEv47DvixxCsENSZMrDJRx8RZL/RMyR6jaXVxD7/dSdIBKtzujT9kY/nJQJ81GpoTD8qN9FrsTsoW80c9vNy47KrLkni27u9ueuTtJu30X0TO3Rn4HXJNq0ZftVnZj7ELUCL31sWGT6uR7nI9BceqoXDgWZSmqJrOW+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26047 invoked by uid 109); 5 Jun 2024 10:03:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 10:03:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28550 invoked by uid 111); 5 Jun 2024 10:03:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 06:03:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 06:03:18 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
Message-ID: <20240605100318.GA3436391@coredump.intra.peff.net>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>

On Mon, Jun 03, 2024 at 11:31:00AM +0200, Patrick Steinhardt wrote:

> +int repo_migrate_ref_storage_format(struct repository *repo,
> +				    enum ref_storage_format format,
> +				    unsigned int flags,
> +				    struct strbuf *errbuf)
> +{
> [...]
> +	new_gitdir = mkdtemp(xstrdup(buf.buf));
> +	if (!new_gitdir) {
> +		strbuf_addf(errbuf, "cannot create migration directory: %s",
> +			    strerror(errno));
> +		ret = -1;
> +		goto done;
> +	}

Coverity complains here of a leak of the xstrdup(). The return from
mkdtemp() should generally point to the same buffer we passed in, but if
it sees an error it will return NULL and the new heap buffer will be
lost.

Probably unlikely, but since you are on a leak-checking kick, I thought
I'd mention it. ;)

Since you have a writable strbuf already, maybe:

  new_gitdir = mkdtemp(buf.buf);
  if (!new_gitdir)
	...
  new_gitdir = strbuf_detach(&buf, NULL); /* same pointer, but now we own it */

Or since "buf" is not used for anything else, we could just leave it
attached to the strbuf. And probably give it a better name. Maybe:

diff --git a/refs.c b/refs.c
index 166b6f269e..9a6655abee 100644
--- a/refs.c
+++ b/refs.c
@@ -2726,10 +2726,9 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 {
 	struct ref_store *old_refs = NULL, *new_refs = NULL;
 	struct ref_transaction *transaction = NULL;
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf new_gitdir = STRBUF_INIT;
 	struct migration_data data;
 	size_t reflog_count = 0;
-	char *new_gitdir = NULL;
 	int did_migrate_refs = 0;
 	int ret;
 
@@ -2787,16 +2786,15 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 *
 	 *   6. Change the repository format to the new ref format.
 	 */
-	strbuf_addf(&buf, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
-	new_gitdir = mkdtemp(xstrdup(buf.buf));
-	if (!new_gitdir) {
+	strbuf_addf(&new_gitdir, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
+	if (!mkdtemp(new_gitdir.buf)) {
 		strbuf_addf(errbuf, "cannot create migration directory: %s",
 			    strerror(errno));
 		ret = -1;
 		goto done;
 	}
 
-	new_refs = ref_store_init(repo, format, new_gitdir,
+	new_refs = ref_store_init(repo, format, new_gitdir.buf,
 				  REF_STORE_ALL_CAPS);
 	ret = ref_store_create_on_disk(new_refs, 0, errbuf);
 	if (ret < 0)
@@ -2841,7 +2839,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 
 	if (flags & REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN) {
 		printf(_("Finished dry-run migration of refs, "
-			 "the result can be found at '%s'\n"), new_gitdir);
+			 "the result can be found at '%s'\n"), new_gitdir.buf);
 		ret = 0;
 		goto done;
 	}
@@ -2862,13 +2860,13 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
-	ret = move_files(new_gitdir, old_refs->gitdir, errbuf);
+	ret = move_files(new_gitdir.buf, old_refs->gitdir, errbuf);
 	if (ret < 0)
 		goto done;
 
-	if (rmdir(new_gitdir) < 0)
+	if (rmdir(new_gitdir.buf) < 0)
 		warning_errno(_("could not remove temporary migration directory '%s'"),
-			      new_gitdir);
+			      new_gitdir.buf);
 
 	/*
 	 * We have migrated the repository, so we now need to adjust the
@@ -2888,13 +2886,12 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret && did_migrate_refs) {
 		strbuf_complete(errbuf, '\n');
 		strbuf_addf(errbuf, _("migrated refs can be found at '%s'"),
-			    new_gitdir);
+			    new_gitdir.buf);
 	}
 
 	if (ret && new_refs)
 		ref_store_release(new_refs);
 	ref_transaction_free(transaction);
-	strbuf_release(&buf);
-	free(new_gitdir);
+	strbuf_release(&new_gitdir);
 	return ret;
 }
