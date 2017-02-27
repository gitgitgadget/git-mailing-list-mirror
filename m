Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A39C201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 09:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdB0JJT (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 04:09:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:34624 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbdB0JJR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 04:09:17 -0500
Received: (qmail 17200 invoked by uid 109); 27 Feb 2017 09:02:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 09:02:35 +0000
Received: (qmail 5213 invoked by uid 111); 27 Feb 2017 09:02:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 04:02:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 04:02:33 -0500
Date:   Mon, 27 Feb 2017 04:02:33 -0500
From:   Jeff King <peff@peff.net>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [BUG] branch renamed to 'HEAD'
Message-ID: <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net>
 <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 03:01:58AM -0500, Jeff King wrote:

> I do think the bug is in strbuf_check_branch_ref(), but it's hard for it
> to do a better job. It needs to feed arbitrary expressions into
> interpret_branch_name() to resolve things like "@{upstream}", "@{-1}",
> "foo@{upstream}", etc.
> 
> The problem is that it expects a branch name to come out of
> interpret_branch_name(), which _mostly_ happens. The exception is HEAD,
> which is a "special" name. But the returned value doesn't indicate
> whether it is special or not.
> 
> My first thought was that we might be handling "@" in the wrong place.
> But it needs to happen here to make things like "@@{upstream}" work
> (which turns "@" into HEAD, and then finds its upstream).
> 
> So I think the options are:
> 
>   1. Before calling interpret_branch_name(), strbuf_check_branch_ref()
>      checks for "@". I don't like this because it's making assumptions
>      about how the result will be parsed and interpreted.
> 
>   2. interpret_branch_name() returns a flag that says "this isn't
>      _really_ a branch name".
> 
>   3. After interpret_branch_name() returns, check whether the result is
>      "HEAD".
> 
> Doing (2) is the "right" thing in the sense that the "is it a branch"
> logic remains with the matching parsing code. But we have to surface
> that value (maybe across recursion via reinterpret?). Since we're
> unlikely to ever grow a return value that matches this case except
> "HEAD", it might be simplest to just do (3).

Ugh. Actually, there are a few complications I found:

  1. Checking "HEAD" afterwards means you can't actually have a branch
     named "HEAD". Doing so is probably insane, but we probably really
     _do_ want to just disallow the @-conversion here.

  2. This isn't limited to just HEAD and @-conversion. For instance:

     $ git clone /some/repo tmp
     $ cd tmp
     $ git branch -m master @{upstream}
     $ git for-each-ref --format='%(refname)'
     refs/heads/origin/master
     refs/remotes/origin/HEAD
     refs/remotes/origin/master

     Er, what? Now we have a branch called origin/master.

So I think it probably is fundamentally wrong to be calling
interpret_branch_name() here at all, if we're just going to tack
"refs/heads/" in front of it. We don't know that we're getting out a
real branchname.

But we do still need to handle @{-1}. And I suppose it's even possible
that you could want to use foo@{upstream} as long as that upstream
points to a _local_ branch.

So perhaps the fundamental issue is that interpret_branch_name() does
not give us fully qualified refs in the return value. We don't have any
clue if the return value is in "refs/heads" or "refs/remotes", or what.
We can fix that, but we're still stuck comparing the result to see if it
starts with "refs/" or is just "HEAD".

Which is wrong. If the user fed us a branch name of "refs/remotes/foo",
then the correct branch name is "refs/heads/refs/remotes/foo" (as stupid
as that probably is). It's only the branch-reinterpretation that we need
to be careful of. So we really do need to somehow have
interpret_branch_name() tell us whether or not it found an actual
branch. Actually, it passes through unknown names, so it can only tell
us when it definitely found something _outside_ of refs/heads/.

I guess something like the patch below works, but I wonder if there is a
less-horrible way to accomplish the same thing.

diff --git a/cache.h b/cache.h
index 61fc86e6d..d52e24f4f 100644
--- a/cache.h
+++ b/cache.h
@@ -1319,7 +1319,8 @@ extern char *oid_to_hex_r(char *out, const struct object_id *oid);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
 
-extern int interpret_branch_name(const char *str, int len, struct strbuf *);
+extern int interpret_branch_name(const char *str, int len, struct strbuf *,
+				 int *not_in_refs_heads);
 extern int get_oid_mb(const char *str, struct object_id *oid);
 
 extern int validate_headref(const char *ref);
diff --git a/refs.c b/refs.c
index cd36b64ed..78b32dd22 100644
--- a/refs.c
+++ b/refs.c
@@ -404,7 +404,7 @@ int refname_match(const char *abbrev_name, const char *full_name)
 static char *substitute_branch_name(const char **string, int *len)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_branch_name(*string, *len, &buf);
+	int ret = interpret_branch_name(*string, *len, &buf, NULL);
 
 	if (ret == *len) {
 		size_t size;
diff --git a/revision.c b/revision.c
index b37dbec37..233764802 100644
--- a/revision.c
+++ b/revision.c
@@ -147,7 +147,7 @@ static void add_pending_object_with_path(struct rev_info *revs,
 		revs->no_walk = 0;
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
-		int len = interpret_branch_name(name, 0, &buf);
+		int len = interpret_branch_name(name, 0, &buf, NULL);
 		int st;
 
 		if (0 < len && name[len] && buf.len)
diff --git a/sha1_name.c b/sha1_name.c
index 73a915ff1..2ef77afb0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1155,7 +1155,8 @@ int get_oid_mb(const char *name, struct object_id *oid)
 }
 
 /* parse @something syntax, when 'something' is not {.*} */
-static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)
+static int interpret_empty_at(const char *name, int namelen, int len,
+			      struct strbuf *buf, int *not_in_refs_heads)
 {
 	const char *next;
 
@@ -1173,10 +1174,13 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
 
 	strbuf_reset(buf);
 	strbuf_add(buf, "HEAD", 4);
+	*not_in_refs_heads = 1;
 	return 1;
 }
 
-static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
+static int reinterpret(const char *name, int namelen, int len,
+		       struct strbuf *buf, int *not_in_refs_heads)
+
 {
 	/* we have extra data, which might need further processing */
 	struct strbuf tmp = STRBUF_INIT;
@@ -1184,7 +1188,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 	int ret;
 
 	strbuf_add(buf, name + len, namelen - len);
-	ret = interpret_branch_name(buf->buf, buf->len, &tmp);
+	ret = interpret_branch_name(buf->buf, buf->len, &tmp, not_in_refs_heads);
 	/* that data was not interpreted, remove our cruft */
 	if (ret < 0) {
 		strbuf_setlen(buf, used);
@@ -1209,7 +1213,8 @@ static int interpret_branch_mark(const char *name, int namelen,
 				 int at, struct strbuf *buf,
 				 int (*get_mark)(const char *, int),
 				 const char *(*get_data)(struct branch *,
-							 struct strbuf *))
+							 struct strbuf *),
+				 int *not_in_refs_heads)
 {
 	int len;
 	struct branch *branch;
@@ -1234,6 +1239,9 @@ static int interpret_branch_mark(const char *name, int namelen,
 	if (!value)
 		die("%s", err.buf);
 
+	if (!starts_with(value, "refs/heads/"))
+		*not_in_refs_heads = 1;
+
 	set_shortened_ref(buf, value);
 	return len + at;
 }
@@ -1259,12 +1267,17 @@ static int interpret_branch_mark(const char *name, int namelen,
  * If the input was ok but there are not N branch switches in the
  * reflog, it returns 0.
  */
-int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
+int interpret_branch_name(const char *name, int namelen, struct strbuf *buf,
+			  int *not_in_refs_heads)
 {
 	char *at;
 	const char *start;
+	int dummy;
 	int len = interpret_nth_prior_checkout(name, namelen, buf);
 
+	if (!not_in_refs_heads)
+		not_in_refs_heads = &dummy;
+
 	if (!namelen)
 		namelen = strlen(name);
 
@@ -1274,24 +1287,29 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 		if (len == namelen)
 			return len; /* consumed all */
 		else
-			return reinterpret(name, namelen, len, buf);
+			return reinterpret(name, namelen, len, buf,
+					   not_in_refs_heads);
 	}
 
 	for (start = name;
 	     (at = memchr(start, '@', namelen - (start - name)));
 	     start = at + 1) {
 
-		len = interpret_empty_at(name, namelen, at - name, buf);
+		len = interpret_empty_at(name, namelen, at - name, buf,
+					 not_in_refs_heads);
 		if (len > 0)
-			return reinterpret(name, namelen, len, buf);
+			return reinterpret(name, namelen, len, buf,
+					   not_in_refs_heads);
 
 		len = interpret_branch_mark(name, namelen, at - name, buf,
-					    upstream_mark, branch_get_upstream);
+					    upstream_mark, branch_get_upstream,
+					    not_in_refs_heads);
 		if (len > 0)
 			return len;
 
 		len = interpret_branch_mark(name, namelen, at - name, buf,
-					    push_mark, branch_get_push);
+					    push_mark, branch_get_push,
+					    not_in_refs_heads);
 		if (len > 0)
 			return len;
 	}
@@ -1299,10 +1317,11 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	return -1;
 }
 
-int strbuf_branchname(struct strbuf *sb, const char *name)
+static int strbuf_branchname_1(struct strbuf *sb, const char *name,
+			       int *not_in_refs_heads)
 {
 	int len = strlen(name);
-	int used = interpret_branch_name(name, len, sb);
+	int used = interpret_branch_name(name, len, sb, not_in_refs_heads);
 
 	if (used == len)
 		return 0;
@@ -1312,9 +1331,17 @@ int strbuf_branchname(struct strbuf *sb, const char *name)
 	return len;
 }
 
+int strbuf_branchname(struct strbuf *sb, const char *name)
+{
+	return strbuf_branchname_1(sb, name, NULL);
+}
+
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
-	strbuf_branchname(sb, name);
+	int not_in_refs_heads = 0;
+	strbuf_branchname_1(sb, name, &not_in_refs_heads);
+	if (not_in_refs_heads)
+		return -1;
 	if (name[0] == '-')
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
