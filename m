Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29142A8F
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215273; cv=none; b=ZDTcRtEZLIybJfkUfYIleY+qgZNfY9uGGqdPxb1hjJqpsL/UbJNYtBHZsbOBztYqvS21HyqhtVEuJR8qc+zRRieE/LVkpVQirg/w2T6QsY4tz46wp5yEVV5HQYXF0C65YZ8q22BFgOcH85eXH2OEvqyjrBkxf3+7/id/uYv8xWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215273; c=relaxed/simple;
	bh=0vEa0m7VoJnlHdwofMDX++IpiaG83CEMI3ZspuG3htE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLHx+nMgnBX49+nB6nzr9m2Bb00Hq0Y2GOHDEJbBQX9g4kqsDnEf9eOXApgK1iWzCx1z0IHIEUwOkxJaUnuaTABpPCwgeC0zITsxBuYbQY5W8j1krxXLiBz2q8Ul6jaiVu8HwdueFmeta58jNnYTGjbxabkZok96My5zbyNtcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15525 invoked by uid 109); 24 Sep 2024 22:01:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:01:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18696 invoked by uid 111); 24 Sep 2024 22:01:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:01:10 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:01:09 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 14/28] http: fix leak of http_object_request struct
Message-ID: <20240924220109.GN1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

The new_http_object_request() function allocates a struct on the heap,
along with some fields inside the struct. But the matching function to
clean it up, release_http_object_request(), only frees the interior
fields without freeing the struct itself, causing a leak.

The related http_pack_request new/release pair gets this right, and at
first glance we should be able to do the same thing and just add a
single free() call. But there's a catch.

These http_object_request structs are typically embedded in the
object_request struct of http-walker.c. And when we clean up that parent
struct, it sanity-checks the embedded struct to make sure we are not
leaking descriptors. Which means a use-after-free if we simply free()
the embedded struct.

I have no idea how valuable that sanity-check is, or whether it can
simply be deleted. This all goes back to 5424bc557f (http*: add helper
methods for fetching objects (loose), 2009-06-06). But the obvious way
to make it all work is to be sure we set the pointer to NULL after
freeing it (and our freeing process closes the descriptor, so we know
there is no leak).

To make sure we do that consistently, we'll switch the pointer we take
in release_http_object_request() to a pointer-to-pointer, and we'll set
it to NULL ourselves. And then the compiler can help us find each caller
which needs to be updated.

Most cases will just pass "&obj_req->req", which will obviously do the
right thing. In a few cases, like http-push's finish_request(), we are
working with a copy of the pointer, so we don't NULL the original. But
it's OK because the next step is to free the struct containing the
original pointer anyway.

This lets us mark t5551 as leak-free. Ironically this is the "smart"
http test, and the leak here only affects dumb http. But there's a
single dumb-http invocation in there. The full dumb tests are in t5550,
which still has some more leaks.

This also makes t5559 leak-free, as it's just an HTTP/2 variant of
t5551. But we don't need to mark it as such, since it inherits the flag
from t5551.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c                 |  4 ++--
 http-walker.c               |  8 ++++----
 http.c                      | 11 ++++++++---
 http.h                      |  4 ++--
 t/t5551-http-fetch-smart.sh |  1 +
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7315a694aa..7196ffa525 100644
--- a/http-push.c
+++ b/http-push.c
@@ -275,7 +275,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	if (!start_active_slot(slot)) {
 		fprintf(stderr, "Unable to start GET request\n");
 		repo->can_update_info_refs = 0;
-		release_http_object_request(obj_req);
+		release_http_object_request(&obj_req);
 		release_request(request);
 	}
 }
@@ -580,7 +580,7 @@ static void finish_request(struct transfer_request *request)
 
 		/* Try fetching packed if necessary */
 		if (request->obj->flags & LOCAL) {
-			release_http_object_request(obj_req);
+			release_http_object_request(&obj_req);
 			release_request(request);
 		} else
 			start_fetch_packed(request);
diff --git a/http-walker.c b/http-walker.c
index e417a7f51c..9c1e5c37e6 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -74,7 +74,7 @@ static void start_object_request(struct object_request *obj_req)
 	obj_req->state = ACTIVE;
 	if (!start_active_slot(slot)) {
 		obj_req->state = ABORTED;
-		release_http_object_request(req);
+		release_http_object_request(&req);
 		return;
 	}
 }
@@ -110,7 +110,7 @@ static void process_object_response(void *callback_data)
 		if (obj_req->repo->next) {
 			obj_req->repo =
 				obj_req->repo->next;
-			release_http_object_request(obj_req->req);
+			release_http_object_request(&obj_req->req);
 			start_object_request(obj_req);
 			return;
 		}
@@ -495,7 +495,7 @@ static int fetch_object(struct walker *walker, unsigned char *hash)
 
 	if (repo_has_object_file(the_repository, &obj_req->oid)) {
 		if (obj_req->req)
-			abort_http_object_request(obj_req->req);
+			abort_http_object_request(&obj_req->req);
 		abort_object_request(obj_req);
 		return 0;
 	}
@@ -543,7 +543,7 @@ static int fetch_object(struct walker *walker, unsigned char *hash)
 		strbuf_release(&buf);
 	}
 
-	release_http_object_request(req);
+	release_http_object_request(&obj_req->req);
 	release_object_request(obj_req);
 	return ret;
 }
diff --git a/http.c b/http.c
index cc136408c0..d0242ffb50 100644
--- a/http.c
+++ b/http.c
@@ -2816,15 +2816,17 @@ int finish_http_object_request(struct http_object_request *freq)
 	return freq->rename;
 }
 
-void abort_http_object_request(struct http_object_request *freq)
+void abort_http_object_request(struct http_object_request **freq_p)
 {
+	struct http_object_request *freq = *freq_p;
 	unlink_or_warn(freq->tmpfile.buf);
 
-	release_http_object_request(freq);
+	release_http_object_request(freq_p);
 }
 
-void release_http_object_request(struct http_object_request *freq)
+void release_http_object_request(struct http_object_request **freq_p)
 {
+	struct http_object_request *freq = *freq_p;
 	if (freq->localfile != -1) {
 		close(freq->localfile);
 		freq->localfile = -1;
@@ -2838,4 +2840,7 @@ void release_http_object_request(struct http_object_request *freq)
 	}
 	curl_slist_free_all(freq->headers);
 	strbuf_release(&freq->tmpfile);
+
+	free(freq);
+	*freq_p = NULL;
 }
diff --git a/http.h b/http.h
index a516ca4a9a..46e334c2c2 100644
--- a/http.h
+++ b/http.h
@@ -240,8 +240,8 @@ struct http_object_request *new_http_object_request(
 	const char *base_url, const struct object_id *oid);
 void process_http_object_request(struct http_object_request *freq);
 int finish_http_object_request(struct http_object_request *freq);
-void abort_http_object_request(struct http_object_request *freq);
-void release_http_object_request(struct http_object_request *freq);
+void abort_http_object_request(struct http_object_request **freq);
+void release_http_object_request(struct http_object_request **freq);
 
 /*
  * Instead of using environment variables to determine if curl tracing happens,
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 7b5ab0eae1..e36dfde17e 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -5,6 +5,7 @@ test_description="test smart fetching over http via http-backend ($HTTP_PROTO)"
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 test "$HTTP_PROTO" = "HTTP/2" && enable_http2
-- 
2.46.2.1011.gf1f9323e02

