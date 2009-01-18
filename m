From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into
 submodules
Date: Sun, 18 Jan 2009 16:48:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com> <1232275999-14852-2-git-send-email-hjemli@gmail.com> <1232275999-14852-3-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:49:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZuL-0001FI-JG
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbZARPs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbZARPsZ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:48:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:51509 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765627AbZARPsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:48:24 -0500
Received: (qmail invoked by alias); 18 Jan 2009 15:48:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 18 Jan 2009 16:48:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wjEBmXZzw+L9w1UAv0ub0d6DIN0MT4MKPPK7oA9
	FSU3mk7fFgZJJ9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232275999-14852-3-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106229>

Hi,

On Sun, 18 Jan 2009, Lars Hjemli wrote:

> diff --git a/environment.c b/environment.c
> index e278bce..35cc557 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -53,6 +53,8 @@ static char *work_tree;
>  static const char *git_dir;
>  static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
>  
> +static int traverse_gitlinks = 0;
> +
>  static void setup_git_env(void)
>  {
>  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
> @@ -159,3 +161,13 @@ int set_git_dir(const char *path)
>  	setup_git_env();
>  	return 0;
>  }
> +
> +int get_traverse_gitlinks()
> +{
> +	return traverse_gitlinks;
> +}
> +
> +void set_traverse_gitlinks(int traverse)
> +{
> +	traverse_gitlinks = traverse;
> +}

If you have full accessors anyway, it is much easier and cleaner to make 
this a global variable to begin with.

However, environment.c is reserved for things that come from the config 
and can be overridden by the user.  That is certainly not the case for 
traverse_gitlinks.

But let's think about it again: should traverse_gitlinks be a global 
varible at all?  I think not.  It should be a per-call decision.

 > diff --git a/tree.c b/tree.c
> index 03e782a..87cf309 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -5,6 +5,7 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "tree-walk.h"
> +#include "refs.h"
>  
>  const char *tree_type = "tree";
>  
> @@ -89,6 +90,61 @@ static int match_tree_entry(const char *base, int baselen, const char *path, uns
>  	return 0;
>  }
>  
> +/* Try to add the objectdb of a submodule */
> +int add_gitlink_odb(char *relpath)

This wants to be static.

> +{
> +	const char *odbpath;
> +	struct stat st;
> +
> +	odbpath = read_gitfile_gently(mkpath("%s/.git", relpath));
> +	if (!odbpath)
> +		odbpath = mkpath("%s/.git/objects", relpath);
> +
> +	if (stat(odbpath, &st))
> +		return 1;
> +
> +	return add_alt_odb(odbpath);
> +}
> +
> +/* Check if we should recurse into the specified submodule */
> +int traverse_gitlink(char *path, const unsigned char *commit_sha1,

This, too.

> +		     struct tree **subtree)
> +{
> +	unsigned char sha1[20];
> +	int linked_odb = 0;
> +	struct commit *commit;
> +	void *buffer;
> +	enum object_type type;
> +	unsigned long size;
> +
> +	hashcpy(sha1, commit_sha1);
> +	if (!add_gitlink_odb(path)) {
> +		linked_odb = 1;
> +		if (resolve_gitlink_ref(path, "HEAD", sha1))
> +			die("Unable to lookup HEAD in %s", path);
> +	}

Why would you want to continue if add_gitlink_odb() did not find a checked 
out submodule?

Seems you want to fall back to look in the superproject's object database.  
But I think that is wrong, as I have a superproject with many platform 
dependent submodules, only one of which is checked out, and for 
convenience, the submodules all live in the superproject's repository.

But I might misunderstand your code.

> +	commit = lookup_commit(sha1);
> +	if (!commit)
> +		die("traverse_gitlink(): internal error");

s/internal error/could not access commit '%s' of submodule '%s'",
			sha1_to_hex(sha1), path);/

> @@ -132,6 +188,30 @@ int read_tree_recursive(struct tree *tree,
>  				return -1;
>  			continue;
>  		}
> +		if (S_ISGITLINK(entry.mode) && get_traverse_gitlinks()) {

Like I said, traverse_gitlinks should be a flag to read_tree_recursive.  
So preferably, you should add a parameter 'flags' and make that option an 
enum.

> +			int retval;
> +			char *newbase;
> +			struct tree *subtree;
> +			unsigned int pathlen = tree_entry_len(entry.path, entry.sha1);

Nit: Long line.

> +
> +			newbase = xmalloc(baselen + 1 + pathlen);
> +			memcpy(newbase, base, baselen);
> +			memcpy(newbase + baselen, entry.path, pathlen);
> +			newbase[baselen + pathlen] = 0;

We have strbufs for that.

> +			if (!traverse_gitlink(newbase, entry.sha1, &subtree)) {
> +				free(newbase);
> +				continue;
> +			}
> +			newbase[baselen + pathlen] = '/';

... to avoid this off-by-one.

> +			retval = read_tree_recursive(subtree,
> +						     newbase,
> +						     baselen + pathlen + 1,
> +						     stage, match, fn, context);
> +			free(newbase);
> +			if (retval)
> +				return -1;
> +			continue;
> +		}
>  	}
>  	return 0;
>  }

Ciao,
Dscho
