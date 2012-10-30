From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v4 6/8] longest_ancestor_length(): require prefix list entries to be normalized
Date: Tue, 30 Oct 2012 18:23:45 +0000
Message-ID: <50901B31.7000402@ramsay1.demon.co.uk>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu> <1351440987-26636-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:26:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGVj-0000z8-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934099Ab2J3SZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:25:44 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:40564 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934109Ab2J3SZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:25:40 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 5F6CBA642CE;
	Tue, 30 Oct 2012 18:25:38 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 38688A642CA;	Tue, 30 Oct 2012 18:25:38 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Tue, 30 Oct 2012 18:25:34 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1351440987-26636-7-git-send-email-mhagger@alum.mit.edu>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208719>

Michael Haggerty wrote:
> Move the responsibility for normalizing prefixes from
> longest_ancestor_length() to its callers. Use slightly different
> normalizations at the two callers:
> 
> In setup_git_directory_gently_1(), use the old normalization, which
> ignores paths that are not usable.  In the next commit we will change
> this caller to also resolve symlinks in the paths from
> GIT_CEILING_DIRECTORIES as part of the normalization.
> 
> In "test-path-utils longest_ancestor_length", use the old
> normalization, but die() if any paths are unusable.  Also change t0060
> to only pass normalized paths to the test program (no empty entries or
> non-absolute paths, strip trailing slashes from the paths, and remove
> tests that thereby become redundant).
> 
> The point of this change is to reduce the scope of the ancestor_length
> tests in t0060 from testing normalization+longest_prefix to testing
> only mostly longest_prefix.  This is necessary because when
> setup_git_directory_gently_1() starts resolving symlinks as part of
> its normalization, it will not be reasonable to do the same in the
> test suite, because that would make the test results depend on the
> contents of the root directory of the filesystem on which the test is
> run.  HOWEVER: under Windows, bash mangles arguments that look like
> absolute POSIX paths into DOS paths.

Just to be clear, this is true for the MinGW port to Windows, but *not*
the cygwin port.
:-P

>                                      So we have to retain the level
> of normalization done by normalize_path_copy() to convert the
> bash-mangled DOS paths (which contain backslashes) into paths that use
> forward slashes.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  path.c                | 26 +++++++++++---------------
>  setup.c               | 23 +++++++++++++++++++++++
>  t/t0060-path-utils.sh | 41 +++++++++++++----------------------------
>  test-path-utils.c     | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 91 insertions(+), 44 deletions(-)
> 

[snip]

> diff --git a/test-path-utils.c b/test-path-utils.c
> index acb0560..0092cbf 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -1,6 +1,33 @@
>  #include "cache.h"
>  #include "string-list.h"
>  
> +/*
> + * A "string_list_each_func_t" function that normalizes an entry from
> + * GIT_CEILING_DIRECTORIES.  If the path is unusable for some reason,
> + * die with an explanation.
> + */
> +static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
> +{
> +	const char *ceil = item->string;
> +	int len = strlen(ceil);
> +	char buf[PATH_MAX+1];
> +
> +	if (len == 0)
> +		die("Empty path is not supported");
> +	if (len > PATH_MAX)
> +		die("Path \"%s\" is too long", ceil);
> +	if (!is_absolute_path(ceil))
> +		die("Path \"%s\" is not absolute", ceil);
> +	if (normalize_path_copy(buf, ceil) < 0)
> +		die("Path \"%s\" could not be normalized", ceil);
> +	len = strlen(buf);
> +	if (len > 1 && buf[len-1] == '/')
> +		die("Normalized path \"%s\" ended with slash", buf);
> +	free(item->string);
> +	item->string = xstrdup(buf);
> +	return 1;
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
> @@ -33,10 +60,26 @@ int main(int argc, char **argv)
>  	if (argc == 4 && !strcmp(argv[1], "longest_ancestor_length")) {
>  		int len;
>  		struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
> +		char *path = xstrdup(argv[2]);
>  
> +		/*
> +		 * We have to normalize the arguments because under
> +		 * Windows, bash mangles arguments that look like

ditto

> +		 * absolute POSIX paths or colon-separate lists of
> +		 * absolute POSIX paths into DOS paths (e.g.,
> +		 * "/foo:/foo/bar" might be converted to
> +		 * "D:\Src\msysgit\foo;D:\Src\msysgit\foo\bar"),
> +		 * whereas longest_ancestor_length() requires paths
> +		 * that use forward slashes.
> +		 */
> +		if (normalize_path_copy(path, path))
> +			die("Path \"%s\" could not be normalized", argv[2]);
>  		string_list_split(&ceiling_dirs, argv[3], PATH_SEP, -1);
> -		len = longest_ancestor_length(argv[2], &ceiling_dirs);
> +		filter_string_list(&ceiling_dirs, 0,
> +				   normalize_ceiling_entry, NULL);
> +		len = longest_ancestor_length(path, &ceiling_dirs);
>  		string_list_clear(&ceiling_dirs, 0);
> +		free(path);
>  		printf("%d\n", len);
>  		return 0;
>  	}


HTH

ATB,
Ramsay Jones
