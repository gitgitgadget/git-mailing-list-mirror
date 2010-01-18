From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-parse --namespace
Date: Sun, 17 Jan 2010 23:56:35 -0800
Message-ID: <7vk4vfsv64.fsf@alter.siamese.dyndns.org>
References: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Jan 18 08:56:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWmTp-0001Xt-9Y
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 08:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab0ARH4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 02:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435Ab0ARH4t
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 02:56:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab0ARH4s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 02:56:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B96FB92A3D;
	Mon, 18 Jan 2010 02:56:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o3k9EcnRNdw4N1tWnVkZDCf36Dw=; b=P5V+cL
	sb7XHh9aXSmHGmemViBhoVBuaKt39Pk873DHwbIROUcnqknsOEPoM1A25GtHRmQ9
	jtBzLT5BkIs/PmFoLtLzqMtMbOGCz2C+FIGrPKXc/LHadBMNyu5nuOkWp7bDodvL
	PtD4DorOHRAbFgGzNr9/vTS/68cnQjYUHLJSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bkyTY/BWd59zpYI+AUViwXIOxel4F4Eh
	o3Fw4loC4yoPdf1sVqKKwVBqQh6YWfnnmpd7q+ynO+ictq2eRBvisHIaqyMn2vdd
	0Zc5k/Wzi1N1HozFDmeee+zbdSgTpjOx5PMQNKkIIlyyDGf4uvExeXBqfFWIr/Kx
	cteJ8oaMhmA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 968B492A3C;
	Mon, 18 Jan 2010 02:56:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E73092A3B; Mon, 18 Jan
 2010 02:56:37 -0500 (EST)
In-Reply-To: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Mon\, 18 Jan 2010 09\:15\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02FD4088-0407-11DF-B62A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137375>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Add --namespace=<namespace> option to rev-parse and everything that
> accepts its options. This option matches all refs in some subnamespace
> of refs hierarchy.
>
> Example:
>
> 'git log --branches --not --namespace=remotes/origin'
>
> To show what you have that origin doesn't.
>
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>

Thanks.

> @@ -577,6 +578,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				for_each_tag_ref(show_reference, NULL);
>  				continue;
>  			}
> +			if (!prefixcmp(arg, "--namespace=")) {
> +				struct for_each_namespace_request req;
> +				req.req_namespace = arg + 12;
> +				req.req_opaque = NULL;

If the structure variable is often named after "request", there is not
much point naming its fields (which are most likely all related to
request) with "req_" prefix.  IOW, wouldn't this be much easier to read?

	struct for_each_namespace_request req;
	memset(&req, 0, sizeof(req));
        req.namespace = arg + 12;

But please don't worry about this part too much, as I'll suggest getting
rid of the struct altogether shortly (read on).

> diff --git a/refs.c b/refs.c
> index 3e73a0a..c7162d1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -7,6 +7,7 @@
>  /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
>  #define REF_KNOWS_PEELED 04
>  
> +/* Current prefix namespace in use. NULL means none. */
>  struct ref_list {
>  	struct ref_list *next;
>  	unsigned char flag; /* ISSYMREF? ISPACKED? */

Is the above new comment really about what this structure type is?

> diff --git a/refs.h b/refs.h
> index e141991..4bb63b0 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -25,6 +37,7 @@ extern int for_each_tag_ref(each_ref_fn, void *);
>  extern int for_each_branch_ref(each_ref_fn, void *);
>  extern int for_each_remote_ref(each_ref_fn, void *);
>  extern int for_each_replace_ref(each_ref_fn, void *);
> +extern int for_each_namespace_ref(each_ref_fn, void *);

I know somebody in the review discussion thought that the second parameter
for this should be void * for whatever reason, but I don't see the point.

Why cannot this be

	for_each_namespace_ref(each_ref_fn, const char *, void *)

where the second one specifies the "namespace prefix"?

The caller of for_each_namespace_ref() with v2 interface needs to be aware
of that for_each_namespace_request structure anyway, so there is nothing
"void *" about it.  You can have a function pointer that can point at
for_each_{branch,remote,replace}_ref and indirectly call one of the
functions via that pointer to grab different set of refs, but this new
function for_each_namespace_ref cannot play together with them, as its
cb_data must be of different shape for the request to make sense; having
the same function signature as others wouldn't help.

If the callback "each_ref_fn" function learns what ns-prefix was given for
it to be called (iow, it gets the whole for_each_namespace_request,
instead of just its req_opaque member), then I might be talked into
believing that it _could_ be useful in some situations, but the way the
callback is called is just the usual "this ref points at this object name,
by the way here is the message my caller told me to give it to you".  And
if the caller really wanted to tell the namespace prefix to the callback
function, it can be made part of the application specific cbdata.

So in short, I simply don't see the point of using this new "request"
structure.  Here is a suggested update that can be squashed on top of v2.

Am I missing some subtle issues?

 builtin-rev-parse.c |    5 +----
 refs.c              |   10 ++++------
 refs.h              |   14 +-------------
 revision.c          |    5 +----
 4 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 255191d..34af347 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -579,10 +579,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!prefixcmp(arg, "--namespace=")) {
-				struct for_each_namespace_request req;
-				req.req_namespace = arg + 12;
-				req.req_opaque = NULL;
-				for_each_namespace_ref(show_reference, &req);
+				for_each_namespace_ref(show_reference, arg + 12, NULL);
 				continue;
 			}
 			if (!strcmp(arg, "--remotes")) {
diff --git a/refs.c b/refs.c
index c7162d1..2bf8755 100644
--- a/refs.c
+++ b/refs.c
@@ -7,7 +7,6 @@
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
 
-/* Current prefix namespace in use. NULL means none. */
 struct ref_list {
 	struct ref_list *next;
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
@@ -675,19 +674,18 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
 }
 
-int for_each_namespace_ref(each_ref_fn fn, void *cb_data)
+int for_each_namespace_ref(each_ref_fn fn, const char *ns_prefix, void *cb_data)
 {
-	struct for_each_namespace_request *req = cb_data;
 	struct strbuf real_prefix = STRBUF_INIT;
 	int ret;
 
-	if (prefixcmp(req->req_namespace, "refs/"))
+	if (prefixcmp(ns_prefix, "refs/"))
 		strbuf_addstr(&real_prefix, "refs/");
-	strbuf_addstr(&real_prefix, req->req_namespace);
+	strbuf_addstr(&real_prefix, ns_prefix);
 	if (real_prefix.buf[real_prefix.len - 1] != '/')
 		strbuf_addch(&real_prefix, '/');
 
-	ret = for_each_ref_in(real_prefix.buf, fn, req->req_opaque);
+	ret = for_each_ref_in(real_prefix.buf, fn, cb_data);
 	strbuf_release(&real_prefix);
 	return ret;
 }
diff --git a/refs.h b/refs.h
index 4bb63b0..a1d7378 100644
--- a/refs.h
+++ b/refs.h
@@ -13,18 +13,6 @@ struct ref_lock {
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
 
-/* Opaque request for for_each_namespace_ref */
-struct for_each_namespace_request
-{
-	/*
-	 * The limiting namespace. 'refs/' and '/' are autoprepended /
-	 * autoappended if missing.
-	 */
-	const char *req_namespace;
-	/* The real opaque data for callback function. */
-	void *req_opaque;
-};
-
 /*
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
@@ -37,7 +25,7 @@ extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
-extern int for_each_namespace_ref(each_ref_fn, void *);
+extern int for_each_namespace_ref(each_ref_fn, const char *, void *);
 
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
diff --git a/revision.c b/revision.c
index ff9484f..ec63fa0 100644
--- a/revision.c
+++ b/revision.c
@@ -1359,13 +1359,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				continue;
 			}
 			if (!prefixcmp(arg, "--namespace=")) {
-				struct for_each_namespace_request req;
 				struct all_refs_cb cb;
 
 				init_all_refs_cb(&cb, revs, flags);
-				req.req_namespace = arg + 12;
-				req.req_opaque = &cb;
-				for_each_namespace_ref(handle_one_ref, &req);
+				for_each_namespace_ref(handle_one_ref, arg + 12, &cb);
 				continue;
 			}
 			if (!strcmp(arg, "--reflog")) {
