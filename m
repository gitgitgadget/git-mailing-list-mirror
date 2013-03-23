From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Sat, 23 Mar 2013 10:13:34 +0700
Message-ID: <20130323031334.GA10484@lanh>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
 <7v1ubaeyph.fsf@alter.siamese.dyndns.org>
 <20130321053326.GA17446@duynguyen-vnpc.dek-tpc.internal>
 <20130321054349.GA18101@duynguyen-vnpc.dek-tpc.internal>
 <7v4ng4br1y.fsf@alter.siamese.dyndns.org>
 <7vvc8kabhx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 04:15:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJEvE-0003wq-Gi
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 04:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab3CWDOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 23:14:32 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:56582 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997Ab3CWDNf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 23:13:35 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq12so207899pab.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 20:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=l3JNwk6xcKPl/0b1OV6zc5pzc40ETwPE1Fe/iU3Ohgw=;
        b=AYLhHxdnkXweAgjJ6Lb52ttJp4z963BcHflw7p4sSYNLeWNtECjzziP8Rt/iEojKd1
         IrlIUmi4wjRo2bYUosS92IaaJjNY0YoCbMryf4t/fRqNQr3oIAtlt6FzXgWB0kjaoWQp
         6CefYpfIhvHBo0BrOAt9hRvLr3JGy8BdkFUA6N5p31TjTAFeFFtm7rFBD42yLEVI6Udk
         Zj2AlRhN6EFQvp1QPcLXxPJAK9ROvxuJhNKbLI2jGF8SWSroEGZxfVBHywpLnluY25cQ
         jrqTULtA99KRnA+IhOXIGGX+vbu9oAU27Wwwd2OCkj2HGed9FJjtl39C7Fmn+DF8JgI+
         Tsgg==
X-Received: by 10.68.196.225 with SMTP id ip1mr5975588pbc.72.1364008415256;
        Fri, 22 Mar 2013 20:13:35 -0700 (PDT)
Received: from lanh ([115.74.37.60])
        by mx.google.com with ESMTPS id u9sm5222381paf.22.2013.03.22.20.13.31
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 20:13:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 23 Mar 2013 10:13:34 +0700
Content-Disposition: inline
In-Reply-To: <7vvc8kabhx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218879>

On Thu, Mar 21, 2013 at 10:50:02AM -0700, Junio C Hamano wrote:
> > Why could the test pass for you without it?  It doesn't look like a
> > bug that depended on uninitialized memory or something from the
> > above observation.

It depends on uninitialized memory. For absolute paths, prefix is
useless and I should have set the useful prefix length to zero, but I
did not. Later in prefix_pathspec, I rely on this value to set
nowildcard_len without checking if it's sane. The actual pathspec
after prefix_pathspec is "src" (length of 3) but nowildcard_len is 5.

In common_prefix_len(), I use nowildcard_len without sanity checks. So
the code examines 's', 'r', 'c', '\0', '<random>'. In my case,
'<random>' has never been '/'. I guess yours is '/' (which leads to
wrong common prefix length).

I've added an assert() to make sure nowildcard_len and prefix have
sane values before exiting prefix_pathspec. This assert() chokes at
t7300.8 for me.

> The change made to prefix_path_gently() in this series is beyond
> "disgusting", especially with the above fix-up.
> 
> Sometimes it uses the original "len", sometimes it uses the fixed-up
> *p_len (e.g. passes it down to normalize_path_copy_len()), and lets
> normalize_path_copy_len() further update it, and thenit makes the
> caller use the updated *p_len.
> 
> Does the caller know what the value in *p_len _mean_ after this
> function returns?  Can it afford to lose the original length of the
> prefix it saved in a variable, without getting confused?
> 
> I think any change that turns a value-passed argument in the
> existing code into modifiable pointer-to-variable in this series
> should add in-code comment to describe what the variable mean upon
> entry and after return, just like normalize_path_copy_len() that was
> built out of the original normalize_path_copy().  I didn't look if
> there are many others, or if this is the only one that is tricky. it
> is tricky that even the original author of the patch got it wrong
> X-<.
> 

The author of the patch totally forgot that prefix has nothing to do
with prefix. How about this? The prefix length is passed as value as
before. A separate pointer is for passing back the actual prefix
length. You can pull the actual patch from

https://github.com/pclouds/git parse-pathspec

which also includes all document bugs reported so far.

-- 8< --
diff --git a/pathspec.c b/pathspec.c
index 0771e48..126771c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -205,7 +205,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 		match = xstrdup(copyfrom);
 		prefixlen = 0;
 	} else {
-		match = prefix_path_gently(prefix, &prefixlen, copyfrom);
+		match = prefix_path_gently(prefix, prefixlen, &prefixlen, copyfrom);
 		if (!match)
 			die("%s: '%s' is outside repository", elt, copyfrom);
 	}
@@ -284,6 +284,10 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 		    no_wildcard(item->match + item->nowildcard_len + 1))
 			item->flags |= PATHSPEC_ONESTAR;
 	}
+
+	/* sanity checks, pathspec matchers assume these are sane */
+	assert(item->nowildcard_len <= item->len &&
+	       item->prefix         <= item->len);
 	return magic;
 }
 
@@ -315,7 +319,7 @@ static void NORETURN unsupported_magic(const char *pattern,
 		n++;
 	}
 	/*
-	 * We may want to substitue "this command" with a command
+	 * We may want to substitute "this command" with a command
 	 * name. E.g. when add--interactive dies when running
 	 * "checkout -p"
 	 */
diff --git a/setup.c b/setup.c
index e59146b..6cf2bc6 100644
--- a/setup.c
+++ b/setup.c
@@ -5,24 +5,37 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
-char *prefix_path_gently(const char *prefix, int *p_len, const char *path)
+/*
+ * Normalize "path", prepending the "prefix" for relative paths. If
+ * remaining_prefix is not NULL, return the actual prefix still
+ * remains in the path. For example, prefix = sub1/sub2/ and path is
+ *
+ *  foo          -> sub1/sub2/foo  (full prefix)
+ *  ../foo       -> sub1/foo       (remaining prefix is sub1/)
+ *  ../../bar    -> bar            (no remaining prefix)
+ *  ../../sub1/sub2/foo -> sub1/sub2/foo (but no remaining prefix)
+ *  `pwd`/../bar -> sub1/bar       (no remaining prefix)
+ */
+char *prefix_path_gently(const char *prefix, int len,
+			 int *remaining_prefix, const char *path)
 {
 	const char *orig = path;
 	char *sanitized;
-	int len = *p_len;
 	if (is_absolute_path(orig)) {
 		const char *temp = real_path(path);
 		sanitized = xmalloc(len + strlen(temp) + 1);
 		strcpy(sanitized, temp);
-		if (p_len)
-			*p_len = 0;
+		if (remaining_prefix)
+			*remaining_prefix = 0;
 	} else {
 		sanitized = xmalloc(len + strlen(path) + 1);
 		if (len)
 			memcpy(sanitized, prefix, len);
 		strcpy(sanitized + len, path);
+		if (remaining_prefix)
+			*remaining_prefix = len;
 	}
-	if (normalize_path_copy_len(sanitized, sanitized, p_len))
+	if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix))
 		goto error_out;
 	if (is_absolute_path(orig)) {
 		size_t root_len, len, total;
@@ -47,7 +60,7 @@ char *prefix_path_gently(const char *prefix, int *p_len, const char *path)
 
 char *prefix_path(const char *prefix, int len, const char *path)
 {
-	char *r = prefix_path_gently(prefix, &len, path);
+	char *r = prefix_path_gently(prefix, len, NULL, path);
 	if (!r)
 		die("'%s' is outside repository", path);
 	return r;
@@ -56,7 +69,7 @@ char *prefix_path(const char *prefix, int len, const char *path)
 int path_inside_repo(const char *prefix, const char *path)
 {
 	int len = prefix ? strlen(prefix) : 0;
-	char *r = prefix_path_gently(prefix, &len, path);
+	char *r = prefix_path_gently(prefix, len, NULL, path);
 	if (r) {
 		free(r);
 		return 1;
-- 8< --
