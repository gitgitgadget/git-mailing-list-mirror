Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA0DC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1602720723
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 13:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgC1Nbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:31:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:54416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726045AbgC1Nbg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 09:31:36 -0400
Received: (qmail 24006 invoked by uid 109); 28 Mar 2020 13:31:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 13:31:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1274 invoked by uid 111); 28 Mar 2020 13:41:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 09:41:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 09:31:34 -0400
From:   Jeff King <peff@peff.net>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v3 1/1] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200328133134.GA1196665@coredump.intra.peff.net>
References: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
 <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
 <20200328131553.GA643242@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328131553.GA643242@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 09:15:53AM -0400, Jeff King wrote:

> > I said I would also update branch_get_push1 to be as similar as possible to
> > branch_get_push_remoteref, but because of the error handling of the latter,
> > it would makes the syntax a bit weird, so I did not touch it.
> >
> > I am still a bit annoyed that I cannot call branch_get_push_remoteref from
> > branch_get_push1 because of the PUSH_DEFAULT_UPSTREAM case, but this can
> > wait and we will need to work with the code duplication meanwhile.
> 
> I looked into this, too, and have a working patch. It does get a little
> awkward, though, and I'm happy to just take your patch for now as the
> practical thing.

Here's what I came up with (against master, but I stole a few bits from
your patch to connect it to remote_ref_for_branch and test it). I'll
quote bits of it to comment inline, and you can find the complete patch
at the bottom.

> @@ -1604,7 +1582,7 @@ int branch_merge_matches(struct branch *branch,
>  }
>  
>  __attribute__((format (printf,2,3)))
> -static const char *error_buf(struct strbuf *err, const char *fmt, ...)
> +static void *error_buf(struct strbuf *err, const char *fmt, ...)
>  {
>  	if (err) {
>  		va_list ap;

This loosens up error_buf() to make it usable for functions that aren't
returning a string. Which we use for...

> @@ -1615,7 +1593,8 @@ static const char *error_buf(struct strbuf *err, const char *fmt, ...)
>  	return NULL;
>  }
>  
> -const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
> +struct refspec_item *branch_get_upstream_refspec(struct branch *branch,
> +						 struct strbuf *err)
>  {
>  	if (!branch)
>  		return error_buf(err, _("HEAD does not point to a branch"));
> @@ -1639,7 +1618,15 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
>  				 _("upstream branch '%s' not stored as a remote-tracking branch"),
>  				 branch->merge[0]->src);
>  
> -	return branch->merge[0]->dst;
> +	return branch->merge[0];
> +}
> +
> +const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
> +{
> +	struct refspec_item *ret = branch_get_upstream_refspec(branch, err);
> +	if (ret)
> +		return ret->dst;
> +	return NULL;
>  }
>  

We can't use branch_get_upstream() to get the remote side, since it
returns branch->merge[0]->dst, and we'd want branch->merge[0]->src. So
this factors out a helper that returns both sides, and
branch_get_upstream() can pick out "dst".

> @@ -1656,7 +1643,7 @@ static const char *tracking_for_push_dest(struct remote *remote,
>  	return ret;
>  }
>  
> -static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
> +static const char *branch_get_push_remoteref(struct branch *branch, struct strbuf *err)
>  {
>  	struct remote *remote;
>  

Here I was able to just convert push_1 into push_remoteref, since it has
all of the error-handling we want (and the error_buf() helper makes it
safe to pass a NULL and just ignore the errors if a caller wants to).

And then push_1 essentially becomes:

  const char *remoteref = branch_get_push_remoteref(branch, err);
  return tracking_for_push_dest(remote, remoteref, err);

> @@ -1667,33 +1654,34 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
>  				 branch->name);
>  
>  	if (remote->push.nr) {
> -		char *dst;
> -		const char *ret;
> -
> -		dst = apply_refspecs(&remote->push, branch->refname);
> +		char *dst = apply_refspecs(&remote->push, branch->refname);
>  		if (!dst)
>  			return error_buf(err,
>  					 _("push refspecs for '%s' do not include '%s'"),
>  					 remote->name, branch->name);
>  
> -		ret = tracking_for_push_dest(remote, dst, err);
> -		free(dst);
> -		return ret;
> +		return dst;
>  	}

We're really just dropping the tracking_for_push_dest() here, since we
want the remote side. This matches what your patch did, except that we
have the error handling.

By the way, this is how I noticed the memory leak. And this patch does
make it worse because we used to get the cleanup of "dst" right, but now
it will be split across two functions and we won't free it.

For that matter, tracking_for_push_dest() also returns an allocated
string as a "const char *", so it's a leak, too. Maybe the strbuf plan
is worth pursuing. :)

>  	if (remote->mirror)
> -		return tracking_for_push_dest(remote, branch->refname, err);
> +		return branch->refname;

Again, just dropping the tracking conversion, and it matches your patch.

>  	switch (push_default) {
>  	case PUSH_DEFAULT_NOTHING:
>  		return error_buf(err, _("push has no destination (push.default is 'nothing')"));

We don't need to touch anything here, because both the remote and local
sides are NULL. :)

>  
>  	case PUSH_DEFAULT_MATCHING:
>  	case PUSH_DEFAULT_CURRENT:
> -		return tracking_for_push_dest(remote, branch->refname, err);
> +		return branch->refname;

Again, just dropping tracking.

>  	case PUSH_DEFAULT_UPSTREAM:
> -		return branch_get_upstream(branch, err);
> +		{
> +			struct refspec_item *ret =
> +				branch_get_upstream_refspec(branch, err);
> +			if (ret)
> +				return ret->src;
> +			return NULL;
> +		}

Here we have to use the new helper to pull out the "src" side. This
unfortunately means that to get the tracking ref, we'll re-apply
tracking_for_push_dest(), even though we could have just gotten the
actual value we wanted from ret->dst (without a memory leak!).

> @@ -1709,7 +1697,7 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
>  			if (strcmp(cur, up))
>  				return error_buf(err,
>  						 _("cannot resolve 'simple' push to a single destination"));
> -			return cur;
> +			return branch->refname;
>  		}

And here again we're less efficient. We already checked the tracking
here to make sure we have the same name on both sides. But when we
return, we'll still apply tracking_for_push_dest(), which will just give
us the same name again (but the caller doesn't know that).

> @@ -1721,8 +1709,19 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
>  	if (!branch)
>  		return error_buf(err, _("HEAD does not point to a branch"));
>  
> -	if (!branch->push_tracking_ref)
> -		branch->push_tracking_ref = branch_get_push_1(branch, err);
> +	if (!branch->push_tracking_ref) {
> +		const char *remoteref = branch_get_push_remoteref(branch, err);
> +		if (remoteref) {
> +			/*
> +			 * ugh, we have to find remote again; should there be a
> +			 * master function which returns both remote and remoteref?
> +			 */
> +			struct remote *remote =
> +				remote_get(pushremote_for_branch(branch, NULL));
> +			branch->push_tracking_ref =
> +				tracking_for_push_dest(remote, remoteref, err);
> +		}
> +	}
>  	return branch->push_tracking_ref;

And here I just dropped push_1 entirely and did it inline. The extra
remote is ugly though. I guess we could return it as an out-parameter.

So it does work, but it's kind of awkward. And even if we solved the
leaking problem by using a strbuf, that would make it doubly awkward,
because the code above would need an _extra_ strbuf to store the
branch_get_push_remoteref() result, and only to then convert it via
tracking_for_push_dest().

Full patch is below if you want to try it out or hack on it further.

---
diff --git a/remote.c b/remote.c
index c43196ec06..22144c96b5 100644
--- a/remote.c
+++ b/remote.c
@@ -516,28 +516,6 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 	return remote_for_branch(branch, explicit);
 }
 
-const char *remote_ref_for_branch(struct branch *branch, int for_push)
-{
-	if (branch) {
-		if (!for_push) {
-			if (branch->merge_nr) {
-				return branch->merge_name[0];
-			}
-		} else {
-			const char *dst, *remote_name =
-				pushremote_for_branch(branch, NULL);
-			struct remote *remote = remote_get(remote_name);
-
-			if (remote && remote->push.nr &&
-			    (dst = apply_refspecs(&remote->push,
-						  branch->refname))) {
-				return dst;
-			}
-		}
-	}
-	return NULL;
-}
-
 static struct remote *remote_get_1(const char *name,
 				   const char *(*get_default)(struct branch *, int *))
 {
@@ -1604,7 +1582,7 @@ int branch_merge_matches(struct branch *branch,
 }
 
 __attribute__((format (printf,2,3)))
-static const char *error_buf(struct strbuf *err, const char *fmt, ...)
+static void *error_buf(struct strbuf *err, const char *fmt, ...)
 {
 	if (err) {
 		va_list ap;
@@ -1615,7 +1593,8 @@ static const char *error_buf(struct strbuf *err, const char *fmt, ...)
 	return NULL;
 }
 
-const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
+struct refspec_item *branch_get_upstream_refspec(struct branch *branch,
+						 struct strbuf *err)
 {
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
@@ -1639,7 +1618,15 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 				 _("upstream branch '%s' not stored as a remote-tracking branch"),
 				 branch->merge[0]->src);
 
-	return branch->merge[0]->dst;
+	return branch->merge[0];
+}
+
+const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
+{
+	struct refspec_item *ret = branch_get_upstream_refspec(branch, err);
+	if (ret)
+		return ret->dst;
+	return NULL;
 }
 
 static const char *tracking_for_push_dest(struct remote *remote,
@@ -1656,7 +1643,7 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
-static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
+static const char *branch_get_push_remoteref(struct branch *branch, struct strbuf *err)
 {
 	struct remote *remote;
 
@@ -1667,33 +1654,34 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 				 branch->name);
 
 	if (remote->push.nr) {
-		char *dst;
-		const char *ret;
-
-		dst = apply_refspecs(&remote->push, branch->refname);
+		char *dst = apply_refspecs(&remote->push, branch->refname);
 		if (!dst)
 			return error_buf(err,
 					 _("push refspecs for '%s' do not include '%s'"),
 					 remote->name, branch->name);
 
-		ret = tracking_for_push_dest(remote, dst, err);
-		free(dst);
-		return ret;
+		return dst;
 	}
 
 	if (remote->mirror)
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return branch->refname;
 
 	switch (push_default) {
 	case PUSH_DEFAULT_NOTHING:
 		return error_buf(err, _("push has no destination (push.default is 'nothing')"));
 
 	case PUSH_DEFAULT_MATCHING:
 	case PUSH_DEFAULT_CURRENT:
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return branch->refname;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		return branch_get_upstream(branch, err);
+		{
+			struct refspec_item *ret =
+				branch_get_upstream_refspec(branch, err);
+			if (ret)
+				return ret->src;
+			return NULL;
+		}
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
@@ -1709,7 +1697,7 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 			if (strcmp(cur, up))
 				return error_buf(err,
 						 _("cannot resolve 'simple' push to a single destination"));
-			return cur;
+			return branch->refname;
 		}
 	}
 
@@ -1721,8 +1709,19 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
 
-	if (!branch->push_tracking_ref)
-		branch->push_tracking_ref = branch_get_push_1(branch, err);
+	if (!branch->push_tracking_ref) {
+		const char *remoteref = branch_get_push_remoteref(branch, err);
+		if (remoteref) {
+			/*
+			 * ugh, we have to find remote again; should there be a
+			 * master function which returns both remote and remoteref?
+			 */
+			struct remote *remote =
+				remote_get(pushremote_for_branch(branch, NULL));
+			branch->push_tracking_ref =
+				tracking_for_push_dest(remote, remoteref, err);
+		}
+	}
 	return branch->push_tracking_ref;
 }
 
@@ -1735,6 +1734,20 @@ static int ignore_symref_update(const char *refname)
 	return (flag & REF_ISSYMREF);
 }
 
+const char *remote_ref_for_branch(struct branch *branch, int for_push)
+{
+	if (branch) {
+		if (!for_push) {
+			if (branch->merge_nr) {
+				return branch->merge_name[0];
+			}
+		} else {
+			return branch_get_push_remoteref(branch, NULL);
+		}
+	}
+	return NULL;
+}
+
 /*
  * Create and return a list of (struct ref) consisting of copies of
  * each remote_ref that matches refspec.  refspec must be a pattern.
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9c910ce746..60e21834fd 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -874,7 +874,34 @@ test_expect_success ':remotename and :remoteref' '
 		actual="$(git for-each-ref \
 			--format="%(push:remotename),%(push:remoteref)" \
 			refs/heads/push-simple)" &&
-		test from, = "$actual"
+		test from, = "$actual" &&
+		git config branch.push-simple.remote from &&
+		git config branch.push-simple.merge refs/heads/master &&
+		actual="$(git for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from, = "$actual" &&
+		actual="$(git -c push.default=upstream for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from,refs/heads/master = "$actual" &&
+		actual="$(git -c push.default=current for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from,refs/heads/push-simple = "$actual" &&
+		actual="$(git -c push.default=matching for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from,refs/heads/push-simple = "$actual" &&
+		actual="$(git -c push.default=nothing for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from, = "$actual" &&
+		git config branch.push-simple.merge refs/heads/push-simple &&
+		actual="$(git for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from,refs/heads/push-simple = "$actual"
 	)
 '
 
