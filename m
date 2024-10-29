Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86347F9D6
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181051; cv=none; b=IFSJln9ahahPby6JnMZoSaY28KrklF+dZJg+kDqI4Je3rdtBjsJY5tNs70Mz8Q5pwYIVfQJFwgtjDFA0Rj1RjxTSJbroxC7hMMROiD0YV9BHL7zLZvXewG0v86OmMdZ9A5/jFSYhVo3gG/gBgk/ACNyV6GeDG5/lFTMEIO8Zjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181051; c=relaxed/simple;
	bh=tKckatXPax6eTc8X0z9CKzIRoPxTaMeFdVqd5GPZoeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr4RhAuzCtXxvdnWcDcuTesTfl7OsG2WsJCzQfgfY3zYKezhNLFBHu5E+sgpslGAHL8AJ/nsLY2W1GN+gyDPNIW5NsgWOSGO9O0sNLIug7GT0pTKPwWzzYLTsSwmShWqzB3oes9hXb3/Lqyzn7XxKxi9CuOivVAixCdG6esR5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I26T1njE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I26T1njE"
Received: (qmail 16838 invoked by uid 109); 29 Oct 2024 05:50:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tKckatXPax6eTc8X0z9CKzIRoPxTaMeFdVqd5GPZoeo=; b=I26T1njEQRHkXqYKZbY9NY0dKU+VXx4pAsV1qFbVzwN0zZdlvLzdFuLEB04Q6BSodQS4NxFL/eajcRpNhoLoLsW0iidGEIs+tuJw4Xt0LA7XBZfM9xfhSDlkENKPbCJKwpfTWs/kjlnZN2TQ0AsL1qswDQMZQ6nfVSOax9T7rN5RLkzzND6rg04FQnHvuTnTxqKm/io3qYwJmUKqgzsqwuVEW0KdYf1lxDhCVFx2ye+ycWxYBbLXRuYJRYQBK7Tz8iNbUVaRsSZE2qQuX+V6JTgviEykCGEWmwXyc43/RL2ZyElyz4PeYVUigUurZbEBLvkELR/jAR+lMdyJVvIXzg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Oct 2024 05:50:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30020 invoked by uid 111); 29 Oct 2024 05:50:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Oct 2024 01:50:40 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Oct 2024 01:50:39 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v2 4/8] packfile: pass down repository to `odb_pack_name`
Message-ID: <20241029055039.GA2886077@coredump.intra.peff.net>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <73ba9945a7b7ec69e4ea29116c473b88e5c2a916.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73ba9945a7b7ec69e4ea29116c473b88e5c2a916.1730122499.git.karthik.188@gmail.com>

On Mon, Oct 28, 2024 at 02:43:42PM +0100, Karthik Nayak wrote:

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index ffee7d3abd..f4892d7f37 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -806,7 +806,7 @@ static char *keep_pack(const char *curr_index_name)
>  	struct strbuf name = STRBUF_INIT;
>  	int keep_fd;
>  
> -	odb_pack_name(&name, pack_data->hash, "keep");
> +	odb_pack_name(the_repository, &name, pack_data->hash, "keep");

Why not pack_data->repo here? It's always going to be set to
the_repository in this program, but I think minimizing the number of
references to it still has value.

> @@ -814,11 +814,11 @@ static char *keep_pack(const char *curr_index_name)
>  	if (close(keep_fd))
>  		die_errno("failed to write keep file");
>  
> -	odb_pack_name(&name, pack_data->hash, "pack");
> +	odb_pack_name(the_repository, &name, pack_data->hash, "pack");
>  	if (finalize_object_file(pack_data->pack_name, name.buf))
>  		die("cannot store pack file");
>  
> -	odb_pack_name(&name, pack_data->hash, "idx");
> +	odb_pack_name(the_repository, &name, pack_data->hash, "idx");

Likewise in both of these spots.

>  	if (finalize_object_file(curr_index_name, name.buf))
>  		die("cannot store index file");
>  	free((void *)curr_index_name);
> @@ -832,7 +832,7 @@ static void unkeep_all_packs(void)
>  
>  	for (k = 0; k < pack_id; k++) {
>  		struct packed_git *p = all_packs[k];
> -		odb_pack_name(&name, p->hash, "keep");
> +		odb_pack_name(p->repo, &name, p->hash, "keep");

This one does use p->repo. Good.

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index be2f99625e..eaefb41761 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1479,7 +1479,7 @@ static void write_special_file(const char *suffix, const char *msg,
>  	if (pack_name)
>  		filename = derive_filename(pack_name, "pack", suffix, &name_buf);
>  	else
> -		filename = odb_pack_name(&name_buf, hash, suffix);
> +		filename = odb_pack_name(the_repository, &name_buf, hash, suffix);
>  
>  	fd = odb_pack_keep(filename);
>  	if (fd < 0) {
> @@ -1507,7 +1507,7 @@ static void rename_tmp_packfile(const char **final_name,
>  {
>  	if (!*final_name || strcmp(*final_name, curr_name)) {
>  		if (!*final_name)
> -			*final_name = odb_pack_name(name, hash, ext);
> +			*final_name = odb_pack_name(the_repository, name, hash, ext);

These two don't have a packed_git, so they use their own repo. Makes
sense.

> -int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
> +int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo) {
>  	int i; int i_still_use_this = 0; struct pack_list *min = NULL, *red, *pl;
>  	struct llist *ignore;
>  	struct strbuf idx_name = STRBUF_INIT;
> @@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
>  	pl = red = pack_list_difference(local_packs, min);
>  	while (pl) {
>  		printf("%s\n%s\n",
> -		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
> +		       odb_pack_name(repo, &idx_name, pl->pack->hash, "idx"),
>  		       pl->pack->pack_name);
>  		pl = pl->next;
>  	}

This one is using the "repo" variable passed to the main function. That
seems a little sketchy to me philosophically, though, because these
packs all came from a call to get_all_packs(the_repository). I think
the two will always be the same, but it feels like we should be using
pl->pack->repo here for consistency.

> diff --git a/http.c b/http.c
> index 7e5be05207..50d8811cea 100644
> --- a/http.c
> +++ b/http.c
> @@ -2579,7 +2579,7 @@ struct http_pack_request *new_direct_http_pack_request(
>  
>  	preq->url = url;
>  
> -	odb_pack_name(&preq->tmpfile, packed_git_hash, "pack");
> +	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
>  	strbuf_addstr(&preq->tmpfile, ".temp");
>  	preq->packfile = fopen(preq->tmpfile.buf, "a");
>  	if (!preq->packfile) {

This one really ought to be using the packed_git we set up for the
matching idx file, but we won't have passed it through. And it's not
worth heavy refactoring just to get access to it, IMHO.


Earlier I mentioned that another helper could simplify many of these
sites a little. What I meant was this (on top of what's in your series):

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9056447bd0..976cb1d77b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -806,19 +806,19 @@ static char *keep_pack(const char *curr_index_name)
 	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	odb_pack_name(the_repository, &name, pack_data->hash, "keep");
+	pack_hashfile(pack_data, &name, "keep");
 	keep_fd = odb_pack_keep(name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
 	if (close(keep_fd))
 		die_errno("failed to write keep file");
 
-	odb_pack_name(the_repository, &name, pack_data->hash, "pack");
+	pack_hashfile(pack_data, &name, "pack");
 	if (finalize_object_file(pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
-	odb_pack_name(the_repository, &name, pack_data->hash, "idx");
+	pack_hashfile(pack_data, &name, "idx");
 	if (finalize_object_file(curr_index_name, name.buf))
 		die("cannot store index file");
 	free((void *)curr_index_name);
@@ -832,7 +832,7 @@ static void unkeep_all_packs(void)
 
 	for (k = 0; k < pack_id; k++) {
 		struct packed_git *p = all_packs[k];
-		odb_pack_name(p->repo, &name, p->hash, "keep");
+		pack_hashfile(p, &name, "keep");
 		unlink_or_warn(name.buf);
 	}
 	strbuf_release(&name);
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 7d6c47ffd9..d3b5e7e112 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       odb_pack_name(repo, &idx_name, pl->pack->hash, "idx"),
+		       pack_hashfile(pl->pack, &idx_name, "idx"),
 		       pl->pack->pack_name);
 		pl = pl->next;
G 	}
diff --git a/packfile.c b/packfile.c
index cfbfcdc2b8..d81a62eb84 100644
--- a/packfile.c
+++ b/packfile.c
@@ -46,6 +46,11 @@ char *odb_pack_name(struct repository *repo, struct strbuf *buf,
 	return buf->buf;
 }
 
+char *pack_hashfile(struct packed_git *p, struct strbuf *out, const char *ext)
+{
+	return odb_pack_name(p->repo, out, p->hash, ext);
+}
+
 static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
diff --git a/packfile.h b/packfile.h
index 3409aef35d..43c19d7bba 100644
--- a/packfile.h
+++ b/packfile.h
@@ -32,6 +32,9 @@ struct pack_entry {
 char *odb_pack_name(struct repository *repo, struct strbuf *buf,
 		    const unsigned char *hash, const char *ext);
 
+/* Like odb_pack_name(), but pull repo and hash from existing packed_git. */
+char *pack_hashfile(struct packed_git *p, struct strbuf *out, const char *ext);
+
 /*
  * Return the basename of the packfile, omitting any containing directory
  * (e.g., "pack-1234abcd[...].pack").


While coming up with the name, though, I had some second thoughts. The
interface implies that its the way you should derive a pack-related
filename from a packed_git. But it really is mis-designed for that
purpose! The packed_git struct has "foo.pack" or similar in its
pack_name field, and the correct way to derive the .idx, .bitmap, .keep,
etc, is by string substitution. While we do tend to name packs
pack-$hash.pack, most of the code will happily work on
"some-arbitrary-name.pack". And that's why we have so few
odb_pack_name() calls in the first place.

IMHO the ones in fast-import should probably be doing that suffix
replacement instead (and probably we should have a decent helper to
facilitate that; you can grep for strip_suffix.*pack to see places that
could potentially use it).

All that said, I don't think it's worth derailing your series to deal
with that cleanup. That can come later if we want. And if we do that,
then the pack_hashfile() I suggested above would have no callers,
because it's the wrong approach.

I do think it's probably worth changing your series to use the
packed_git repo pointers we already have available, though (i.e., the
cases I pointed out inline above).

-Peff
