From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] untracked-cache: fix subdirectory handling
Date: Sat, 15 Aug 2015 14:32:19 +0700
Message-ID: <20150815073219.GA4496@lanh>
References: <1438967873-792-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 09:31:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQVvf-0002ja-8J
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 09:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbbHOHay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 03:30:54 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36281 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbbHOHax (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 03:30:53 -0400
Received: by pacrr5 with SMTP id rr5so74511591pac.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bkOcs5v8xXJYKnPZj3lEg+PHglMuFOTmnMgS/+bT9yU=;
        b=y1YsI5kcoEhYKUm85JR3JpFeEPI2/rrIx//1Y+YRnFalbafk2mzbkuLIppLAQO6ur1
         ws6pYrBI2AzUXzKRlvgACLYnWJkZLGsQkUBVY40QAdyR9L9kXkOd4/TwF8ol223WXvD8
         Tl8ZxOVMmv18mP7WXrid1Y0wWOfMd9PRo+Maml8VVY2MivBMYK3WqhmLvdMwYguDY/Lo
         XZkKxMSPm0bnti4/bbg7xjkblNEKNsm3xwrSRZEMgIQ9qPQn3EBJcSM4HngFdd04HMXq
         RZIRJ15IP2UK6NNwx9B0V7tyLbCElyNOphC1b3u9od7qeCysf1rt3xOVpklBIuqHOzxi
         no0Q==
X-Received: by 10.68.103.5 with SMTP id fs5mr97135813pbb.55.1439623852738;
        Sat, 15 Aug 2015 00:30:52 -0700 (PDT)
Received: from lanh ([115.73.45.105])
        by smtp.gmail.com with ESMTPSA id tt8sm8054649pbc.49.2015.08.15.00.30.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2015 00:30:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Aug 2015 14:32:19 +0700
Content-Disposition: inline
In-Reply-To: <1438967873-792-1-git-send-email-dturner@twopensource.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275978>

First of all, sorry for my long silence. I'm going through my git
inbox now.

> diff --git a/dir.c b/dir.c
> index e7b89fe..314080b 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -631,6 +631,7 @@ static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
>  	memset(d, 0, sizeof(*d));
>  	memcpy(d->name, name, len);
>  	d->name[len] = '\0';
> +	d->depth = dir->depth + 1;
>  
>  	ALLOC_GROW(dir->dirs, dir->dirs_nr + 1, dir->dirs_alloc);
>  	memmove(dir->dirs + first + 1, dir->dirs + first,
> @@ -1324,7 +1325,19 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
>  		return exclude ? path_excluded : path_untracked;
>  
> -	untracked = lookup_untracked(dir->untracked, untracked, dirname, len);
> +	if (untracked) {
> +		const char *cur = dirname;
> +		int i;
> +
> +		for (i = 0; i < untracked->depth; i++) {
> +			cur = strchr(cur, '/');
> +			assert(cur);
> +			cur++;
> +		}
> +		untracked = lookup_untracked(dir->untracked, untracked,
> +					     cur,
> +					     len - (cur - dirname));
> +	}

If I read it correctly, the call chain is, treat_path() reconstructs
full path, then it calls treat_one_path -> treat_directory ->
lookup_untracked.

In the same treat_path(), we may also call treat_fast_path ->
read_directory_recursive -> lookup_untracked. In this call chain, we
retain the "baselen" and we can exclude the base path before passing
it to lookup_untracked().

So instead of adding "depth" (and spending some more cycles cutting
path components), perhaps we can do the same for the first call chain,
passing baselen to treat_one_path and treat_directory?  Something like
this passes your new tests

-- 8< --
diff --git a/dir.c b/dir.c
index 07a6642..a4c52bf 100644
--- a/dir.c
+++ b/dir.c
@@ -1297,7 +1297,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
 	struct untracked_cache_dir *untracked,
-	const char *dirname, int len, int exclude,
+	const char *dirname, int len, int baselen, int exclude,
 	const struct path_simplify *simplify)
 {
 	/* The "len-1" is to strip the final '/' */
@@ -1324,7 +1324,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return exclude ? path_excluded : path_untracked;
 
-	untracked = lookup_untracked(dir->untracked, untracked, dirname, len);
+	untracked = lookup_untracked(dir->untracked, untracked,
+				     dirname + baselen, len - baselen);
 	return read_directory_recursive(dir, dirname, len,
 					untracked, 1, simplify);
 }
@@ -1444,6 +1445,7 @@ static int get_dtype(struct dirent *de, const char *path, int len)
 static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct untracked_cache_dir *untracked,
 					  struct strbuf *path,
+					  int baselen,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
@@ -1495,8 +1497,8 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		return treat_directory(dir, untracked, path->buf, path->len, exclude,
-			simplify);
+		return treat_directory(dir, untracked, path->buf, path->len,
+				       baselen, exclude, simplify);
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
@@ -1557,7 +1559,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		return path_none;
 
 	dtype = DTYPE(de);
-	return treat_one_path(dir, untracked, path, simplify, dtype, de);
+	return treat_one_path(dir, untracked, path, baselen, simplify, dtype, de);
 }
 
 static void add_untracked(struct untracked_cache_dir *dir, const char *name)
@@ -1827,7 +1829,7 @@ static int treat_leading_path(struct dir_struct *dir,
 			break;
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
-		if (treat_one_path(dir, NULL, &sb, simplify,
+		if (treat_one_path(dir, NULL, &sb, baselen, simplify,
 				   DT_DIR, NULL) == path_none)
 			break; /* do not recurse into it */
 		if (len <= baselen) {
-- 8< --

> +static struct untracked_cache_dir *lookup_untracked_recursive(
> +	struct untracked_cache *uc, struct untracked_cache_dir *dir,
> +	const char *path, int len)
> +{
> +	const char *rest = strchr(path, '/');
> +
> +	if (rest) {
> +		int component_len = rest - path;
> +		struct untracked_cache_dir *d =
> +			lookup_untracked(uc, dir, path, component_len);
> +		return lookup_untracked_recursive(uc, d, rest + 1,
> +						  len - (component_len + 1));
> +	} else {
> +		return dir;
> +	}
> +}
> +
>  void untracked_cache_invalidate_path(struct index_state *istate,
>  				     const char *path)
>  {
> -	const char *sep;
>  	struct untracked_cache_dir *d;
>  	if (!istate->untracked || !istate->untracked->root)
>  		return;
> -	sep = strrchr(path, '/');
> -	if (sep)
> -		d = lookup_untracked(istate->untracked,
> -				     istate->untracked->root,
> -				     path, sep - path);
> -	else
> -		d = istate->untracked->root;
> +	d = lookup_untracked_recursive(istate->untracked,
> +				       istate->untracked->root,
> +				       path, strlen(path));

This is totally my fault. It's so obvious, how could I miss
it.. Thanks for fixing.

By the way, while running the tests, I noticed that the test "set up
sparse checkout" in t7063 performs the time-consuming "Testing
...... OK" again. At this point in the test suite, you are already
certain the underlying filesystem supports untracked-cached, maybe do
this to reduce test time for people who do not run tests in parallel?

s/update-index --untracked-cache/update-index --force-untracked-cache/

--
Duy
