From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Expand ~ and ~user in core.excludesfile,
	commit.template
Date: Thu, 28 Aug 2008 23:26:31 -0400
Message-ID: <20080829032630.GA7024@coredump.intra.peff.net>
References: <7vprnyqo59.fsf@gitster.siamese.dyndns.org> <20080824220854.GA27299@coredump.intra.peff.net> <7vzln2j9y2.fsf@gitster.siamese.dyndns.org> <20080824231343.GC27619@coredump.intra.peff.net> <7vhc9aj82i.fsf@gitster.siamese.dyndns.org> <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu> <20080827002506.GB7347@coredump.intra.peff.net> <quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu> <7vy72jrr00.fsf@gitster.siamese.dyndns.org> <quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 05:29:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYufv-0000iu-CQ
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 05:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbYH2D0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 23:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbYH2D0f
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 23:26:35 -0400
Received: from peff.net ([208.65.91.99]:4866 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbYH2D0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 23:26:33 -0400
Received: (qmail 10970 invoked by uid 111); 29 Aug 2008 03:26:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 23:26:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 23:26:31 -0400
Content-Disposition: inline
In-Reply-To: <quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94245>

On Thu, Aug 28, 2008 at 02:09:38AM -0700, Karl Chen wrote:

>  builtin-commit.c |    2 +-
>  cache.h          |    2 +
>  config.c         |   13 +++++++-
>  path.c           |   88 +++++++++++++++++++++++++++++++++--------------------
>  4 files changed, 69 insertions(+), 36 deletions(-)

Documentation?

>  	if (!strcmp(k, "commit.template"))
> -		return git_config_string(&template_file, k, v);
> +		return git_config_userdir(&template_file, k, v);

I like this.

> +int git_config_userdir(const char **dest, const char *var, const char *value) {
> +	if (!value)
> +		return config_error_nonbool(var);
> +	*dest = expand_user_path(NULL, value, 0);
> +	if (!*dest || !**dest) die("Failed to expand user dir in: '%s'", value);
> +	return 0;
> +}

I am not sure about !**dest here. This precludes somebody from using "".
While it might not matter here, if there are other users of
git_config_userdir(), they might want to allow a blank entry.

Also, style: there should be a newline after conditional but before
executed code. IOW, replace

  if (cond) code;

with

  if (cond)
          code;

> +static inline struct passwd *getpw_strspan(const char *begin_username,
> +										   const char *end_username) 

1. There seem to be extra tabs in the second line, pushing the
   end_username argument way too far to the right.

2. I'm not sure "strspan" is a good name for this helper, since it calls
   to mind the strspn C function, which is not really related to this at
   all.

3. Usually helper functions that take a non-terminated string like this
   in git use the combination of (char *begin, int len) instead of two
   pointers. While you are currently the only user of the helper, I
   think it makes sense to follow that convention for future users.

> +	if (begin_username == end_username) {
> +		return getpwuid(getuid());
> +	} else {

Style: omit braces on one-liner conditionals:

  if (begin_username == end_username)
          return getwpuid(getuid());

Also, you do a lot of early returns in your code. I think this is good,
because it makes it more readable. But that means you don't have to
worry about "else"ing the other half of the conditional, because you
have already returned. Which makes it even easier to read.

> +		size_t username_len = end_username - begin_username;

See, here you end up converting back from two pointers to a pointer and
a length. Which is why I think we tend to use the other representation.

> +		char *username = alloca(username_len + 1);

I don't think we use alloca() anywhere else. I don't know if there are
portability issues.

> +static inline char *concatstr(char *buf, const char *str1, const char *str2,
> +							  size_t bufsz)
> +{
> +	size_t len1 = strlen(str1);
> +	size_t len2 = strlen(str2);
> +	size_t needbuflen = len1 + len2 + 1;
> +	if (buf) {
> +		if (needbuflen > bufsz) return NULL;
> +	} else {
> +		buf = xmalloc(needbuflen);

Style: more braces which can be omitted.

This function seems a little superfluous, since its semantics are so
specific to this usage. I am all for splitting into little functions,
but I think it would be quite confusing for somebody to try reusing
this. Perhaps it at least needs a comment explaining the semantics of
buf?

> +static inline const char *strchr_or_end(const char *str, char c)
> +{
> +	while (*str && *str != c) ++str;
> +	return str;
> +}

This really seems like premature optimization to me. The only advantage
this has over

  p = strchr(s);
  if (!p)
    p = s + strlen(s);

is that we avoid traversing the string once. But balance that against an
assembler-optimized strchr provided by your libc. And then wonder if it
is even worth it, since this is not even remotely a critical path.

> +{
> +	if (path == NULL) {
>  		return NULL;
> [...]
> +	} else if (path[0] != '~') {
> +		if (buf == NULL) {
> +			return xstrdup(path);
> +		} else {
> +			if (strlen(path)+1 > sz) return NULL;
> +			return strcpy(buf, path);
> +		}

More early returns which can be removed from conditionals.

Also, some of this code seems duplicated with concatstr. Wouldn't it
just be simpler to let concatstr take a NULL for one of the arguments,
and then just use it again here? IOW, something like:

  if (!path)
    return NULL;
  if (path[0] != '~')
    return concatstr(path, NULL);

> -			if (!user_path(used_path, path, PATH_MAX))
> +			if (!expand_user_path(used_path, path, PATH_MAX))

But these functions don't have the same semantics, do they? user_path
used to return NULL if the path didn't start with ~, right?

-Peff
