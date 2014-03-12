From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] general style: replaces memcmp() with proper
 starts_with()
Date: Wed, 12 Mar 2014 13:56:24 -0400
Message-ID: <20140312175624.GA7982@sigill.intra.peff.net>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 18:56:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNnON-0006AV-FO
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 18:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbaCLR43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 13:56:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:38192 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755446AbaCLR40 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 13:56:26 -0400
Received: (qmail 23932 invoked by uid 102); 12 Mar 2014 17:56:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 12:56:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 13:56:24 -0400
Content-Disposition: inline
In-Reply-To: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243949>

On Wed, Mar 12, 2014 at 10:43:54AM -0400, Quint Guvernator wrote:

> memcmp() is replaced with negated starts_with() when comparing strings
> from the beginning. starts_with() looks nicer and it saves the extra
> argument of the length of the comparing string.

Thanks, I think this is a real readability improvement in most cases.

One of the things to do when reviewing a patch like this is make sure
that there aren't any silly arithmetic mistakes. Checking that can be
tedious, so I thought about how _I_ would do it programatically, and
then compared our results.

I tried:

  perl -i -lpe '
    s/memcmp\(([^,]+), "(.*?)", (\d+)\)/
     length($2) == $3 ?
       qq{!starts_with($1, "$2")} :
       $&
    /ge
  ' $(git ls-files '*.c')

That comes up with almost the same results as yours, but misses a few
cases that you caught (in addition to the need to simplify
!!starts_with()):

  - memcmp(foo, "bar", strlen("bar"))

  - strings with interpolation, like "foo\n", which is actually 4
    characters in length, not 5.

But there were only a few of those, and I hand-verified them. So I feel
pretty good that the changes are all correct transformations.

That leaves the question of whether they are all improvements in
readability (more on that below).

> note: this commit properly handles negation in starts_with()
> 
> Signed-off-by: Quint Guvernator <quintus.public@gmail.com>
> ---

This note should go after the "---" line so that it is not part of the
commit message (it is only interesting to people seeing v2 and wondering
what changed from v1 earlier on the list, not people reading the history
much later).

> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
> index 987a4c3..2777519 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -66,7 +66,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
>  			continue;
>  		}
>  
> -		if (!memcmp(arg, "-S", 2)) {
> +		if (starts_with(arg, "-S")) {
>  			sign_commit = arg + 2;
>  			continue;
>  		}

This is an improvement, but we still have the magic "2" below. Would
skip_prefix be a better match here, like:

  if ((val = skip_prefix(arg, "-S"))) {
          sign_commit = val;
          continue;
  }

We've also talked about refactoring skip_prefix to return a boolean, and
put the value in an out-parameter. Which would make this even more
readable:

  if (skip_prefix(arg, "-S", &sign_commit))
          continue;

Maybe the time has come to do that.

> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -626,7 +626,7 @@ static int handle_boundary(void)
>  	strbuf_addch(&newline, '\n');
>  again:
>  	if (line.len >= (*content_top)->len + 2 &&
> -	    !memcmp(line.buf + (*content_top)->len, "--", 2)) {
> +	    starts_with(line.buf + (*content_top)->len, "--")) {

I'm not sure if this improves readability or not. It's certainly nice to
get rid of the magic "2", but starts_with is a bit of a misnomer, since
we are indexing deep into the buffer anyway. And we still have the magic
"2" above anyway.

I'm on the fence.

> @@ -727,8 +727,8 @@ static int is_scissors_line(const struct strbuf *line)
>  			continue;
>  		}
>  		if (i + 1 < len &&
> -		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2) ||
> -		     !memcmp(buf + i, ">%", 2) || !memcmp(buf + i, "%<", 2))) {
> +		    (starts_with(buf + i, ">8") || starts_with(buf + i, "8<") ||
> +		     starts_with(buf + i, ">%") || starts_with(buf + i, "%<"))) {

Same as above.

> @@ -66,7 +66,7 @@ static int verify_tag(char *buffer, unsigned long size)
>  		return error("char%"PRIuMAX": could not find next \"\\n\"",
>  				(uintmax_t) (type_line - buffer));
>  	tag_line++;
> -	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
> +	if (!starts_with(tag_line, "tag ") || tag_line[4] == '\n')
>  		return error("char%"PRIuMAX": no \"tag \" found",
>  				(uintmax_t) (tag_line - buffer));

I think this is another that could benefit from an enhanced skip_prefix:

  if (!skip_prefix(tag_line, "tag ", &tag_name) || *tag_name == '\n')
     ...

and then we can get rid of the "tag_line += 4" that is used much later
(in fact, I suspect that whole function could be improved in this
respect).

> @@ -269,7 +269,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>  		return 0;
>  	item->object.parsed = 1;
>  	tail += size;
> -	if (tail <= bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45] != '\n')
> +	if (tail <= bufptr + 46 || !starts_with(bufptr, "tree ") || bufptr[45] != '\n')
>  		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
>  	if (get_sha1_hex(bufptr + 5, parent) < 0)

Again, we just use "bufptr + 5" a bit later here. So a candidate for
skip_prefix.

>  	graft = lookup_commit_graft(item->object.sha1);
> -	while (bufptr + 48 < tail && !memcmp(bufptr, "parent ", 7)) {
> +	while (bufptr + 48 < tail && starts_with(bufptr, "parent ")) {

Ditto here.

>  static inline int standard_header_field(const char *field, size_t len)
>  {
> -	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
> -		(len == 6 && !memcmp(field, "parent ", 7)) ||
> -		(len == 6 && !memcmp(field, "author ", 7)) ||
> -		(len == 9 && !memcmp(field, "committer ", 10)) ||
> -		(len == 8 && !memcmp(field, "encoding ", 9)));
> +	return ((len == 4 && starts_with(field, "tree ")) ||
> +		(len == 6 && starts_with(field, "parent ")) ||
> +		(len == 6 && starts_with(field, "author ")) ||
> +		(len == 9 && starts_with(field, "committer ")) ||
> +		(len == 8 && starts_with(field, "encoding ")));

These extra "len" checks are interesting.  They look like an attempt to
optimize lookup, since the caller will already have scanned forward to
the space. I wonder if that makes a measurable difference, or is simply
premature optimization.

> @@ -514,7 +514,7 @@ static int git_proxy_command_options(const char *var, const char *value,
>  		if (0 <= matchlen) {
>  			/* core.gitproxy = none for kernel.org */
>  			if (matchlen == 4 &&
> -			    !memcmp(value, "none", 4))
> +			    starts_with(value, "none"))

While technically correct, I'm not sure starts_with really expresses
what's going on here. We're matching a full string, but we cannot use
strcmp because the buffer isn't terminated. I'd think a more readable
alternative would be something like:

  int mem_equals(const char *buf, size_t len, const char *match)
  {
          int match_len = strlen(match);
          return len == match_len && !memcmp(buf, match, len);
  }

  ...

  if (mem_equals(value, matchlen, "none"))
          ...

That might also apply to some other cases (e.g., the case above with
standard_header_field). The name mem_equals might not be descriptive
enough, but hopefully you get the idea.

> --- a/credential-cache.c
> +++ b/credential-cache.c
> @@ -54,7 +54,7 @@ static void spawn_daemon(const char *socket)
>  	r = read_in_full(daemon.out, buf, sizeof(buf));
>  	if (r < 0)
>  		die_errno("unable to read result code from cache daemon");
> -	if (r != 3 || memcmp(buf, "ok\n", 3))
> +	if (r != 3 || !starts_with(buf, "ok\n"))
>  		die("cache daemon did not start: %.*s", r, buf);

Another mem_equals case?

>  	close(daemon.out);
>  }
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f061f1f..17823ab 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -506,7 +506,7 @@ static void filter_refs(struct fetch_pack_args *args,
>  		int keep = 0;
>  		next = ref->next;
>  
> -		if (!memcmp(ref->name, "refs/", 5) &&
> +		if (starts_with(ref->name, "refs/") &&
>  		    check_refname_format(ref->name, 0))
>  			; /* trash */
>  		else {
> diff --git a/fsck.c b/fsck.c
> index 99c0497..3bd69da 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -290,12 +290,12 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>  	if (commit->date == ULONG_MAX)
>  		return error_func(&commit->object, FSCK_ERROR, "invalid author/committer line");
>  
> -	if (memcmp(buffer, "tree ", 5))
> +	if (!starts_with(buffer, "tree "))
>  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>  	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')

Another skip_prefix case.

> -	while (!memcmp(buffer, "parent ", 7)) {
> +	while (starts_with(buffer, "parent ")) {
>  		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')

Ditto.

> -	if (memcmp(buffer, "author ", 7))
> +	if (!starts_with(buffer, "author "))
>  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
>  	buffer += 7;

Ditto.

> -	if (memcmp(buffer, "committer ", strlen("committer ")))
> +	if (!starts_with(buffer, "committer "))
>  		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
>  	buffer += strlen("committer ");

Ditto.

> diff --git a/http-walker.c b/http-walker.c
> index 1516c5e..9a8d412 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -245,7 +245,7 @@ static void process_alternates_response(void *callback_data)
>  						     - base);
>  					okay = 1;
>  				}
> -			} else if (!memcmp(data + i, "../", 3)) {
> +			} else if (starts_with(data + i, "../")) {
>  				/*
>  				 * Relative URL; chop the corresponding
>  				 * number of subpath from base (and ../
> @@ -267,7 +267,7 @@ static void process_alternates_response(void *callback_data)
>  				i += 3;

Another skip_prefix?

> --- a/path.c
> +++ b/path.c
> @@ -26,7 +26,7 @@ static char *get_pathname(void)
>  static char *cleanup_path(char *path)
>  {
>  	/* Clean it up */
> -	if (!memcmp(path, "./", 2)) {
> +	if (starts_with(path, "./")) {
>  		path += 2;

Another skip_prefix.

> @@ -63,7 +63,7 @@ static int check_refname_component(const char *refname, int flags)
>  		if (refname[1] == '\0')
>  			return -1; /* Component equals ".". */
>  	}
> -	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
> +	if (cp - refname >= 5 && starts_with(cp - 5, ".lock"))
>  		return -1; /* Refname ends with ".lock". */

Should this actually become ends_with? I guess it needs refname to be
NUL-terminated, though, which it is not. I don't know if it is worth
having a mem_ends_with variant, like:

  if (mem_ends_with(refname, cp - refname, ".lock"))
          ...

> diff --git a/submodule.c b/submodule.c
> index b80ecac..3de9ae5 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -203,7 +203,7 @@ void gitmodules_config(void)
>  			if (active_nr > pos) {  /* there is a .gitmodules */
>  				const struct cache_entry *ce = active_cache[pos];
>  				if (ce_namelen(ce) == 11 &&
> -				    !memcmp(ce->name, ".gitmodules", 11))
> +				    starts_with(ce->name, ".gitmodules"))
>  					gitmodules_is_unmerged = 1;

Jens singled this one out earlier, and I agree. I think this is a
"mem_equals".

> diff --git a/transport.c b/transport.c
> index ca7bb44..a267822 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1364,7 +1364,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
>  
>  	while (other[len-1] == '/')
>  		other[--len] = '\0';
> -	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
> +	if (len < 8 || !starts_with(other + len - 8, "/objects"))
>  		return 0;

This is another ends_with candidate (maybe mem_ends_with? I didn't
check).

Phew. That's a lot of changes. The ones I didn't mention are all
hands-down readability improvements, though I suspect some of them may
also be skip_prefix candidates (I didn't investigate each one, but only
mentioned the ones where I saw the obvious magic number in the diff
context).

I think we can take most of them as-is, though, and perhaps even some of
the ones I mentioned (even if skip_prefix can be used, switching to
starts_with may be an intermediate improvement).

If you don't feel like going further on this topic, that's OK, but I
think with a few more helpers we could really further clean up some of
these callsites.

-Peff
