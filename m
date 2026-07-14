Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF73DEFE3
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011584; cv=none; b=SDxosmuITn4laomMrDNC/jEV7245b8T3uOjVsdEVZA7LbTbtD0Qbe1GWHgfROc2IM6VKlqbZdZthdvTLg/LcaJwdMHTQf13R9uaB0W28km/KqtejQ7v0uWV8fsidVlWHaqDyVnjSvGNMQrZjnv0N+Y2vV8qlX7TfnL/srkaE0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011584; c=relaxed/simple;
	bh=jQ9gvzBiSDutHuSEIhruk3Xy4UovhOlGeAMJHiUBXUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnpn/Vvd2CZIR6veQenkGcQW3NMLxOawN3hZsGfNywOM+8EiAAAOehSCnTZ/98wqvvwP9CHDgwaZaVa4pS95NJlxF6H+8TfCwrFVXl6SDaeIWNVwOrKIDUmsXpjCKUlLrpN9q3B0bHTKN75niiU0nNw4MHJZ8Mt7zVcBtVQHXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ifnhRYyY; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ifnhRYyY"
Received: (qmail 21438 invoked by uid 106); 14 Jul 2026 06:46:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jQ9gvzBiSDutHuSEIhruk3Xy4UovhOlGeAMJHiUBXUM=; b=ifnhRYyYx5hroFUHh2c91e5jcfdzTED3X1QMHBLDX8nBcxXxe6Cs3UApauvpPA3RvmySswdimKj7u2ieqzMZEnSYQ6HSa1A0xT7vlk/7nA649naN6NR1OhiupprmSIUeLxl93hWidgpx3ryujCUs9TBo4NjZTJ7C7E0HFi3UDeXYxe4WBUIr9DRqJxwHi8+C5g1wC5BWn2RO6jiUW5z4jvKNGFw3kxlEM//XSgri90MNnVM4gLVYUevnYCqADhaYJAMIDQmr3ee9JbXFqfs2j7j8SBfs0wvzYyOwNbEwc6LEG6xmYTxSlWioHHhfl3/0dkzQ51ohpLfo4NIvWIS9bQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 06:46:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 42479 invoked by uid 111); 14 Jul 2026 06:46:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 02:46:23 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 02:46:19 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
Message-ID: <20260714064619.GC2516582@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVn-QmK3K91_tkH@com-76773>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alVn-QmK3K91_tkH@com-76773>

On Mon, Jul 13, 2026 at 03:34:33PM -0700, Ted Nyman wrote:

> The path is derived from the advertised pack hash. Two processes
> fetching the same pack into a shared object database therefore open the
> same file for append. Their writes can corrupt the temporary pack. If
> one process arrives after the other has completed the download, it may
> instead try to resume at EOF, which some HTTP servers reject with 416.

Yuck. In theory they're writing the same thing, but I think the source
of the corruption is append mode. Two concurrent writers will keep
auto-seeking to the end of the file, rather than keeping their own file
pointers. There's no way to ask for O_APPEND without O_TRUNC via stdio,
but we can drop down a level like this:

diff --git a/http.c b/http.c
index b4e7b8d00b..d7362c99a2 100644
--- a/http.c
+++ b/http.c
@@ -2740,6 +2740,7 @@ struct http_pack_request *new_direct_http_pack_request(
 {
 	off_t prev_posn = 0;
 	struct http_pack_request *preq;
+	int fd;
 
 	CALLOC_ARRAY(preq, 1);
 	strbuf_init(&preq->tmpfile, 0);
@@ -2748,12 +2749,13 @@ struct http_pack_request *new_direct_http_pack_request(
 
 	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
 	strbuf_addstr(&preq->tmpfile, ".temp");
-	preq->packfile = fopen(preq->tmpfile.buf, "a");
-	if (!preq->packfile) {
+	fd = open(preq->tmpfile.buf, O_WRONLY|O_CREAT, 0666);
+	if (fd < 0) {
 		error("Unable to open local file %s for pack",
 		      preq->tmpfile.buf);
 		goto abort;
 	}
+	preq->packfile = xfdopen(fd, "w");
 
 	preq->slot = get_active_slot();
 	preq->headers = object_request_headers();

That patch (with no other code changes) passes your test.

I suspect it could cause us to racily send an http range of "N-" to the
server, where N is the total number of bytes in the file (because we
don't know how many bytes there are supposed to be). I don't know if
that would cause an HTTP 416 or not. I think possibly not, and the 416
you saw (and that I see when running the test without any code changes)
might be from sending a range that starts _past_ N. We end up with a
too-long when both processes are appending.

I can't say I love the overall notion of "two processes are writing the
same data, it will probably be fine!". There might be portability
issues, and I'm not sure what would happen if we ever did get
conflicting data. If we're just feeding this to "index-pack --stdin"
we'd at least notice the problem (rather than quietly corrupting the
indexed file!).

So I'm offering this as a point for further discussion, and not
necessarily a counter-proposal. ;)

> Use the tempfile API to give direct packfile URI downloads unique
> temporary files. Keep the deterministic path for ordinary dumb HTTP
> pack requests, which use it to resume a partial download left by an
> earlier invocation.
> 
> This means that a packfile URI download cannot be resumed by a later
> invocation. A retry starts with an empty temporary file instead.

Arguably losing the ability to retry is a regression. In general, I
think we should prefer correctness to efficiency. But I wonder if this
is a case where the user might want to make the choice to say "I am not
going to fetch two packfiles at once; please enable resumable fetches".
Especially because one of the selling points of packfile URIs is that
they are resumable.

One other thought on resumable transfers: if we are not going to resume
the transfer, then why spool the pack to disk at all? In other words,
why not just send it straight to "index-pack --stdin". That fixes your
concurrency issue (because it uses its own tempfiles behind the scene),
but has two other big advantages:

  1. It halves the number of disk writes, and lowers the peak disk usage
     (with the current code, there is a moment where both the tempfile
     and the indexed pack are present on disk).

  2. It pipelines the data processing. The current code bottlenecks on
     the network while the CPU sits idle, and then bottlenecks on the
     CPU once we have the whole file. We could be doing useful CPU work
     during the network transfer, just like a regular pack code does.


So I'm not quite sold on losing the ability to resume entirely. And in
cases where we do lose it, I think it opens up other improvements.

But I'll reader over the rest of the patch with the notion that this is
the direction we want to go in.

> diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
> index 2200f073c4..533bf381c4 100644
> --- a/Documentation/git-http-fetch.adoc
> +++ b/Documentation/git-http-fetch.adoc
> @@ -48,9 +48,8 @@ commit-id::
>  	line (which is not expected in
>  	this case), 'git http-fetch' fetches the packfile directly at the given
>  	URL and uses index-pack to generate corresponding .idx and .keep files.
> -	The hash is used to determine the name of the temporary file and is
> -	arbitrary. The output of index-pack is printed to stdout. Requires
> -	--index-pack-args.
> +	The hash is arbitrary. The output of index-pack is printed to stdout.
> +	Requires --index-pack-args.

Do we even need to provide a hash anymore? After your patch I don't
think we even use it. It might be worth keeping around, though, as it
would be a unique key for de-duping or resuming, if we ever did
implement those on top.

>  void release_http_pack_request(struct http_pack_request *preq)
>  {
> -	if (preq->packfile) {
> +	if (preq->tempfile) {
> +		delete_tempfile(&preq->tempfile);
> +		preq->packfile = NULL;
> +	} else if (preq->packfile) {
>  		fclose(preq->packfile);
>  		preq->packfile = NULL;
>  	}

OK. I think this is correct, though see my comments elsewhere in the
thread.

> @@ -2688,7 +2691,10 @@ int finish_http_pack_request(struct http_pack_request *preq)
>  	int tmpfile_fd;
>  	int ret = 0;
>  
> -	fclose(preq->packfile);
> +	if (preq->tempfile)
> +		close_tempfile_gently(preq->tempfile);
> +	else
> +		fclose(preq->packfile);
>  	preq->packfile = NULL;

OK, and this is correct because preq->packfile is just an alias for
preq->tempfile.fp when the tempfile is valid. The NULL assignment is
important here so that the release() function doesn't double-free.

> -struct http_pack_request *new_http_pack_request(
> -	const unsigned char *packed_git_hash, const char *base_url) {
> -
> -	struct strbuf buf = STRBUF_INIT;
> -
> -	end_url_with_slash(&buf, base_url);
> -	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
> -		hash_to_hex(packed_git_hash));
> -	return new_direct_http_pack_request(packed_git_hash,
> -					    strbuf_detach(&buf, NULL));
> -}

This hunk puzzled me at first, but it's because we used to just be a
wrapper for the "direct" variant, and now the two will share a single
static helper. That might have been a little more clear as a preparatory
patch, but OK.

> +	if (resumable) {
> +		odb_pack_name(the_repository, &preq->tmpfile,
> +			      packed_git_hash, "pack");
> +		strbuf_addstr(&preq->tmpfile, ".temp");
> +		preq->packfile = fopen(preq->tmpfile.buf, "a");
> +	} else {
> +		strbuf_addf(&preq->tmpfile, "%s/pack/tmp_pack_XXXXXX",
> +			    repo_get_object_directory(the_repository));
> +		preq->tempfile = mks_tempfile_m(preq->tmpfile.buf, 0444);
> +		if (preq->tempfile) {
> +			strbuf_reset(&preq->tmpfile);
> +			strbuf_addstr(&preq->tmpfile,
> +				      get_tempfile_path(preq->tempfile));
> +			preq->packfile = fdopen_tempfile(preq->tempfile, "w");
> +		}
> +	}
>  	if (!preq->packfile) {
>  		error("Unable to open local file %s for pack",
>  		      preq->tmpfile.buf);

OK, and this is the meat of the change. We usually use odb_mkstemp() for
tmp_pack_* files, but that annoyingly doesn't give you a tempfile
struct. So setting up your own filename and using mks_tempfile_m() makes
sense here.

The error path is a little funny, but we catch it in the context when
preq->packfile is NULL. Good.

> @@ -2766,8 +2776,9 @@ struct http_pack_request *new_direct_http_pack_request(
>  	 * If there is data present from a previous transfer attempt,
>  	 * resume where it left off
>  	 */
> -	prev_posn = ftello(preq->packfile);
> -	if (prev_posn>0) {
> +	if (resumable)
> +		prev_posn = ftello(preq->packfile);
> +	if (prev_posn > 0) {

I think this is not technically necessary, as ftello() would just return
"0" for our newly-created file. But it does make the intent clear.

> @@ -2779,12 +2790,28 @@ struct http_pack_request *new_direct_http_pack_request(
>  	return preq;
>  
>  abort:
> -	strbuf_release(&preq->tmpfile);
> -	free(preq->url);
> -	free(preq);
> +	release_http_pack_request(preq);
>  	return NULL;
>  }

OK, now we have potentially more to free, so we rely on the release
function. That could cause problems if we jump to this abort label when
the struct isn't fully initialized. I think it is OK, though. We zero
the whole thing, so the extra fields that the release() function
considers will just be ignored.

> diff --git a/http.h b/http.h
> index 729c51904d..2c900779f5 100644
> --- a/http.h
> +++ b/http.h
> @@ -224,6 +224,7 @@ struct http_pack_request {
>  
>  	FILE *packfile;
>  	struct strbuf tmpfile;
> +	struct tempfile *tempfile;
>  	struct active_request_slot *slot;
>  	struct curl_slist *headers;

Yuck, now we have "tempfile" and "tmpfile" with two different types and
totally different semantics (and even when "tempfile" is in use,
"tmpfile" is still meaningful!).

Can we even just call the second one non_resumable_tempfile or
something? It's a mouthful, but it makes it less likely to confuse the
two.

> +	# Hold the first download before it is indexed, so that the second
> +	# download installs the pack first.
> +	{
> +		(
> +			if ! PATH="$TRASH_DIRECTORY:$PATH" \
> +			GIT_TEST_WAIT_READY="$TRASH_DIRECTORY/first-ready" \
> +			GIT_TEST_WAIT_CONTINUE="$TRASH_DIRECTORY/first-continue" \
> +			git -C packfileclient-concurrent http-fetch \
> +				--packfile="$packhash" \
> +				--index-pack-arg=wait-index-pack \
> +				--index-pack-arg=--stdin \
> +				--index-pack-arg=--keep \
> +				"$HTTPD_URL/dumb/repo_pack.git/$p" >first.out
> +			then
> +				echo failed >"$TRASH_DIRECTORY/first-ready" &&
> +				exit 1
> +			fi
> +		) &
> +		first_pid=$!
> +	} &&

OK. I wonder if it would be simpler and a more robust test if rather
than writing the correct bytes (and then waiting), the first process
just wrote total garbage. Then we'd be sure the other process is not
reading it, because it would definitely corrupt their input.

I dunno. This is a more realistic scenario, so in that sense maybe it is
more interesting.

> +	test_when_finished "
> +		echo continue >&9
> +		wait $first_pid 2>/dev/null || :
> +		exec 8>&-
> +		exec 9>&-
> +		rm -f first-ready first-continue git-wait-index-pack
> +	" &&
> [...]

The rest of the fifo handling looks plausibly correct. This is a tricky
area and it's common to introduce funky races, but I didn't see anything
wrong, and it passed a few dozen rounds of --stress.

> @@ -313,7 +381,9 @@ test_expect_success 'http-fetch --packfile with corrupt pack' '
>  	git init packfileclient &&
>  	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git && ls objects/pack/pack-*.pack) &&
>  	test_must_fail git -C packfileclient http-fetch --packfile \
> -		"$HTTPD_URL"/dumb/repo_bad1.git/$p
> +		"$HTTPD_URL"/dumb/repo_bad1.git/$p &&
> +	find packfileclient/.git/objects/pack -name "tmp_pack_*" -print >tmpfiles &&
> +	test_must_be_empty tmpfiles
>  '

OK, so here we just detect that we cleaned up after ourselves. Makes
sense.

-Peff
