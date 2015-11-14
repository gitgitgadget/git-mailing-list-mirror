From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Sat, 14 Nov 2015 14:22:09 +0100
Message-ID: <20151114132209.GH16219@inner.h.apk.li>
References: <20150316142026.GJ7847@inner.h.apk.li> <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com> <20150316184040.GA8902@inner.h.apk.li> <20150317024005.GA26313@peff.net> <xmqqd248p4o9.fsf@gitster.dls.corp.google.com> <20150317054759.GA16860@peff.net> <20151113152915.GC16219@inner.h.apk.li> <20151114000118.GB18260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 14 14:23:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zxaml-0008NH-5w
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 14:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbKNNW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2015 08:22:27 -0500
Received: from continuum.iocl.org ([217.140.74.2]:39591 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbKNNW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2015 08:22:26 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tAEDM9d09012;
	Sat, 14 Nov 2015 14:22:09 +0100
Content-Disposition: inline
In-Reply-To: <20151114000118.GB18260@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281305>

On Fri, 13 Nov 2015 19:01:18 +0000, Jeff King wrote:
....
> > Can't we handle this in resolve_gitlink_ref itself? As I understand it,
> > it should resolve a ref (here "HEAD") when path points to a submodule.
> > When there isn't one it should return -1, so:
> 
> I'm not sure. I think part of the change to git-clean was that
> is_git_directory() is a _better_ check than "can we resolve HEAD?"
> because it covers empty repos, too.

I could do

  refs = find_ref_cache(submodule);
  if (!refs && !is_git_directory(....

in resolve_gitlink_ref().

...
> > @@ -1553,6 +1553,10 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
> >  	if (!len)
> >  		return -1;
> >  	submodule = xstrndup(path, len);
> > +	if (!is_git_directory(submodule)) {
> > +		free(submodule);
> > +		return -1;
> > +	}
> >  	refs = get_ref_cache(submodule);
> >  	free(submodule);
> 
> I don't think it produces wrong outcomes, but I think it's sub-optimal.
> In cases where we already have a ref cache, we'll hit the filesystem for
> each lookup to re-confirm what we already know. That doesn't affect your
> case, but it does when we actually _do_ have a submodule.

I could do

  refs = find_ref_cache(submodule);
  if (!refs && !is_git_directory(....

Also, in my case the current code tries .git/HEAD and .git/packed-refs
for each directory.

> So if we were to follow this route, I think it would go better in
> get_ref_cache itself (right after we determine there is no existing
> cache, but before we call create_ref_cache()).

The stupid part is that get_ref_cache itself only creates the
cache entry and leaved the actual check for later - then it
is too late to not create the cache entry.

Also, when we put it into get_ref_cache we need to return null
for our case and see what for_each_ref_submodule & co make out of that.
That's why I'd like it in resolve_gitlink_ref. :-) Or we put an
no_create parameter into get_ref_cache(). Probably violating
some style guide:

diff --git a/refs.c b/refs.c
index 132eff5..005d0eb 100644
--- a/refs.c
+++ b/refs.c
@@ -1160,7 +1160,7 @@ static struct ref_cache *create_ref_cache(const char *submodule)
  * will be allocated and initialized but not necessarily populated; it
  * should not be freed.
  */
-static struct ref_cache *get_ref_cache(const char *submodule)
+static struct ref_cache *get_ref_cache(const char *submodule, int do_create)
 {
 	struct ref_cache *refs;
 
@@ -1171,6 +1171,9 @@ static struct ref_cache *get_ref_cache(const char *submodule)
 		if (!strcmp(submodule, refs->name))
 			return refs;
 
+	if (!do_create && !is_git_directory(submodule))
+		return 0;
+
 	refs = create_ref_cache(submodule);
 	refs->next = submodule_ref_caches;
 	submodule_ref_caches = refs;
@@ -1553,9 +1556,12 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 	if (!len)
 		return -1;
 	submodule = xstrndup(path, len);
-	refs = get_ref_cache(submodule);
+	refs = get_ref_cache(submodule, 0);
 	free(submodule);
 
+	if (!refs)
+		return -1;
+
 	retval = resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
 	return retval;
 }
@@ -2126,7 +2132,7 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
+	return do_for_each_ref(get_ref_cache(submodule, 1), "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
@@ -2146,7 +2152,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(get_ref_cache(submodule, 1), prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)

(might be nicer to split into find_ref_cache() and get_ref_cache()
instead of adding the parameter).

...
>   2. But for a little more work, pushing the is_git_directory() check
>      out to the call-sites gives us probably saner semantics overall.

Actually, I don't quite think that. The code we push out would be
the same in each place ('is_git_directory() && ...'), wouldn't it?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
