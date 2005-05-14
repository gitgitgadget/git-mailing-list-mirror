From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: [PATCH] Add --author match to git-rev-list and git-rev-tree.
Date: Sat, 14 May 2005 08:06:07 -0700
Message-ID: <20050514150607.GA14184@tumblerings.org>
References: <20050514061914.GB14353@tumblerings.org> <7vu0l62l27.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@ucw.cz, torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 17:11:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWyId-0003Vr-P6
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVENPLX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbVENPLX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:11:23 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:51090 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262779AbVENPLE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 11:11:04 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DWyDP-0005El-KY; Sat, 14 May 2005 08:06:07 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0l62l27.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 14, 2005 at 02:50:24AM -0700, Junio C Hamano wrote:
> Zack Brown wondered if handling author match at core GIT level
> would make cg-log -u go faster (JIT also can use this in jit-log
> --author).  Here is a patch to implement it.
> 
> I considered adding author and committer strings to commit
> objects for general use as commit objects are parsed, but I was
> unsure about the lifetime rules of the commit objects (nobody
> seems to free them in the current code), so refrained from doing
> so for the time being.  The code instead re-reads the commit
> object when it needs to filter them by the author.

I applied this, but can't figure out the change to make to cg-log in order to
actually test it.

- git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
+ git-cat-file --author $user commit $commit || continue

sure didn't work.

Z

> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
> commit.c   |   42 ++++++++++++++++++++++++++++++++++++++++++
> commit.h   |    2 ++
> rev-list.c |    6 ++++++
> rev-tree.c |   13 +++++++++++--
> 4 files changed, 61 insertions(+), 2 deletions(-)
> 
> --- a/commit.c
> +++ b/commit.c
> @@ -152,3 +152,45 @@
>  	}
>  	return ret;
>  }
> +
> +int author_match(const struct commit *item, const char *author)
> +{
> +	char type[20];
> +	void *buffer;
> +	char *author_line, *ep;
> +	unsigned long size;
> +	int ret;
> +
> +	buffer = read_sha1_file(item->object.sha1, type, &size);
> +	if (!buffer)
> +		return error("Could not read %s",
> +			     sha1_to_hex(item->object.sha1));
> +	if (strcmp(type, commit_type)) {
> +		free(buffer);
> +		error("Object %s not a commit",
> +		      sha1_to_hex(item->object.sha1));
> +		return 0;
> +	}
> +	/* we do not care what is in the message; we do not
> +	 * want to overrun with strstr and strchr.
> +	 */
> +	ep = buffer + (size -1);
> +	*ep = 0;
> +	if ((author_line = strstr(buffer, "\nauthor ")) == 0) {
> +		free(buffer);
> +		error("Commit %s does not have author.",
> +		      sha1_to_hex(item->object.sha1));
> +		return 0;
> +	}
> +	author_line = strchr(author_line, ' ') + 1;
> +	if ((ep = strchr(author_line, '>')) == 0) {
> +		free(buffer);
> +		error("Commit %s has a malformed author line.",
> +		      sha1_to_hex(item->object.sha1));
> +		return 0;
> +	}
> +	*++ep = 0;
> +	ret = (strstr(author_line, author) != 0);
> +	free(buffer);
> +	return ret;
> +}
> --- a/commit.h
> +++ b/commit.h
> @@ -36,4 +36,6 @@
>  struct commit *pop_most_recent_commit(struct commit_list **list, 
>  				      unsigned int mark);
>  
> +int author_match(const struct commit *, const char *);
> +
>  #endif /* COMMIT_H */
> --- a/rev-list.c
> +++ b/rev-list.c
> @@ -11,6 +11,7 @@
>  	unsigned long max_age = -1;
>  	unsigned long min_age = -1;
>  	int max_count = -1;
> +	const char *author = NULL;
>  
>  	for (i = 1 ; i < argc; i++) {
>  		char *arg = argv[i];
> @@ -21,6 +22,8 @@
>  			max_age = atoi(arg + 10);
>  		} else if (!strncmp(arg, "--min-age=", 10)) {
>  			min_age = atoi(arg + 10);
> +		} else if (!strncmp(arg, "--author=", 9)) {
> +			author = arg + 9;
>  		} else {
>  			commit_arg = arg;
>  		}
> @@ -28,6 +31,7 @@
>  
>  	if (!commit_arg || get_sha1(commit_arg, sha1))
>  		usage("usage: rev-list [OPTION] commit-id\n"
> +		      "  --author=author\n"
>  		      "  --max-count=nr\n"
>  		      "  --max-age=epoch\n"
>  		      "  --min-age=epoch\n");
> @@ -44,6 +48,8 @@
>  			continue;
>  		if (max_age != -1 && (commit->date < max_age))
>  			break;
> +		if (author && !author_match(commit, author))
> +			continue;
>  		if (max_count != -1 && !max_count--)
>  			break;
>  		printf("%s\n", sha1_to_hex(commit->object.sha1));
> --- a/rev-tree.c
> +++ b/rev-tree.c
> @@ -64,7 +64,7 @@
>  }
>  
>  /*
> - * Usage: rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id2>]
> + * Usage: rev-tree [--edges] [--author <author>] [--cache <cache-file>] <commit-id> [<commit-id2>]
>   *
>   * The cache-file can be quite important for big trees. This is an
>   * expensive operation if you have to walk the whole chain of
> @@ -75,6 +75,7 @@
>  	int i;
>  	int nr = 0;
>  	unsigned char sha1[MAX_COMMITS][20];
> +	const char *author = NULL; 
>  
>  	/*
>  	 * First - pick up all the revisions we can (both from
> @@ -83,6 +84,11 @@
>  	for (i = 1; i < argc ; i++) {
>  		char *arg = argv[i];
>  
> +		if (!strcmp(arg, "--author")) {
> +			author = argv[++i];
> +			continue;
> +		}
> +
>  		if (!strcmp(arg, "--cache")) {
>  			read_cache_file(argv[++i]);
>  			continue;
> @@ -98,7 +104,7 @@
>  			basemask |= 1<<nr;
>  		}
>  		if (nr >= MAX_COMMITS || get_sha1(arg, sha1[nr]))
> -			usage("rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]");
> +			usage("rev-tree [--edges] [--author <author>] [--cache <cache-file>] <commit-id> [<commit-id>]");
>  		process_commit(sha1[nr]);
>  		nr++;
>  	}
> @@ -125,6 +131,9 @@
>  		if (!interesting(commit))
>  			continue;
>  
> +		if (author && !author_match(commit, author))
> +			continue;
> +
>  		printf("%lu %s:%d", commit->date, sha1_to_hex(obj->sha1), 
>  		       obj->flags);
>  		p = commit->parents;
> ------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
