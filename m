From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 20:03:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805151958180.30431@racer>
References: <482C85C8.90804@facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:05:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwikK-0008V0-UQ
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 21:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbYEOTDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 15:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbYEOTDR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 15:03:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:55044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752253AbYEOTDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 15:03:16 -0400
Received: (qmail invoked by alias); 15 May 2008 19:03:14 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp056) with SMTP; 15 May 2008 21:03:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188lcYd+bI8QbqmYImTZEcTMPEEJW34P0aiMYytA4
	tMEFNikw3dEnUQ
X-X-Sender: gene099@racer
In-Reply-To: <482C85C8.90804@facebook.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82221>

Hi,

On Thu, 15 May 2008, David Reiss wrote:

>  cache.h                 |    1 +
>  setup.c                 |  127 ++++++++++++++++++++++++++++++++++----
>  t/t1504-ceiling-dirs.sh |  156 +++++++++++++++++++++++++++++++++++++++++++++++

By now, I strongly believe that these changes are too large.  I am 
convinced that what you desire can be expressed much simpler, and thus 
less error-prone.

Also, I think that your test cases are too extensive.  While it is usually 
good to have exhaustive tests, running them takes time.  And if it takes 
so much time that hardly anybody bothers with running the test suite, 
there are _too_ many tests.

> diff --git a/setup.c b/setup.c
> index b8fd476..fdcfae1 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -353,16 +353,118 @@ const char *read_gitfile_gently(const char *path)
>  }
>  
>  /*
> + * path = Canonical absolute path
> + * prefix_list = Colon-separated list of canonical absolute paths
> + *
> + * Determines, for each path in parent_list, whether the "prefix" really
> + * is an ancestor directory of path.  Returns the length of the longest
> + * ancestor directory, excluding any trailing slashes, or -1 if no prefix
> + * is an ancestry.  (Note that this means 0 is returned if prefix_list
> + * contains "/".)  "/foo" is not considered an ancestor of "/foobar".
> + * Directories are not considered to be their own ancestors.  Paths must
> + * be in a canonical form: empty components, or "." or ".." components
> + * are not allowed.  prefix_list may be null, which is like "".
> + */
> +static int longest_ancestor_length(const char *path, const char *prefix_list)
> +{
> +	const char *ceil, *colon;
> +	int max_len = -1;
> +
> +	if (prefix_list == NULL)
> +		return -1;
> +	/* "/" is a tricky edge case.  It should always return -1, though. */
> +	if (!strcmp(path, "/"))
> +		return -1;
> +
> +	ceil = prefix_list;
> +	for (;;) {
> +		int len;
> +
> +		/* Add strchrnul to compat? */
> +		colon = strchr(ceil, ':');
> +		if (colon)
> +			len = colon - ceil;
> +		else
> +			len = strlen(ceil);
> +
> +		/* "" would otherwise be treated like "/". */
> +		if (len) {
> +			/* Trim trailing slashes. */
> +			while (len && ceil[len-1] == '/')
> +				len--;
> +
> +			if (!strncmp(path, ceil, len) &&
> +					path[len] == '/' &&
> +					len > max_len) {
> +				max_len = len;
> +			}
> +		}
> +
> +		if (!colon)
> +			break;
> +		ceil = colon + 1;
> +	}
> +
> +	return max_len;
> +}

You know, I wonder why I even bothered writing those responses, if you 
just ignore them.

> +#if 0
> +static void test_longest_ancestor_length()
> +{
> +	assert(longest_ancestor_length("/", NULL           ) == -1);
> +	assert(longest_ancestor_length("/", ""             ) == -1);
> +	assert(longest_ancestor_length("/", "/"            ) == -1);
> +
> +	assert(longest_ancestor_length("/foo", NULL           ) == -1);
> +	assert(longest_ancestor_length("/foo", ""             ) == -1);
> +	assert(longest_ancestor_length("/foo", ":"            ) == -1);
> +	assert(longest_ancestor_length("/foo", "/"            ) ==  0);
> +	assert(longest_ancestor_length("/foo", "/fo"          ) == -1);
> +	assert(longest_ancestor_length("/foo", "/foo"         ) == -1);
> +	assert(longest_ancestor_length("/foo", "/foo/"        ) == -1);
> +	assert(longest_ancestor_length("/foo", "/bar"         ) == -1);
> +	assert(longest_ancestor_length("/foo", "/bar/"        ) == -1);
> +	assert(longest_ancestor_length("/foo", "/foo/bar"     ) == -1);
> +	assert(longest_ancestor_length("/foo", "/foo:/bar/"   ) == -1);
> +	assert(longest_ancestor_length("/foo", "/foo/:/bar/"  ) == -1);
> +	assert(longest_ancestor_length("/foo", "/foo::/bar/"  ) == -1);
> +	assert(longest_ancestor_length("/foo", "/:/foo:/bar/" ) ==  0);
> +	assert(longest_ancestor_length("/foo", "/foo:/:/bar/" ) ==  0);
> +	assert(longest_ancestor_length("/foo", "/:/bar/:/foo" ) ==  0);
> +
> +	assert(longest_ancestor_length("/foo/bar", NULL           ) == -1);
> +	assert(longest_ancestor_length("/foo/bar", ""             ) == -1);
> +	assert(longest_ancestor_length("/foo/bar", "/"            ) ==  0);
> +	assert(longest_ancestor_length("/foo/bar", "/fo"          ) == -1);
> +	assert(longest_ancestor_length("/foo/bar", "/foo"         ) ==  4);
> +	assert(longest_ancestor_length("/foo/bar", "/foo/"        ) ==  4);
> +	assert(longest_ancestor_length("/foo/bar", "/foo/ba"      ) == -1);
> +	assert(longest_ancestor_length("/foo/bar", "/:/fo"        ) ==  0);
> +	assert(longest_ancestor_length("/foo/bar", "/foo:/foo/ba" ) ==  4);
> +	assert(longest_ancestor_length("/foo/bar", "/bar"         ) == -1);
> +	assert(longest_ancestor_length("/foo/bar", "/bar/"        ) == -1);
> +	assert(longest_ancestor_length("/foo/bar", "/fo:"         ) == -1);
> +	assert(longest_ancestor_length("/foo/bar", ":/fo"         ) == -1);
> +	assert(longest_ancestor_length("/foo/bar", "/foo:/bar/"   ) ==  4);
> +	assert(longest_ancestor_length("/foo/bar", "/:/foo:/bar/" ) ==  4);
> +	assert(longest_ancestor_length("/foo/bar", "/foo:/:/bar/" ) ==  4);
> +	assert(longest_ancestor_length("/foo/bar", "/:/bar/:/fo"  ) ==  0);
> +	assert(longest_ancestor_length("/foo/bar", "/:/bar/"      ) ==  0);
> +}
> +#endif

This has _no_ place in the Git source code.  Have you looked around, and 
found similar dead code?  No?  That's because Git's source code is not a 
graveyard of useless code bits, but it is a collection of elegant code.  
Mostly, at least.

Instead of wasting my time further, I will try to come up with a better 
implementation, as is the way of Open Source.

Ciao,
Dscho
