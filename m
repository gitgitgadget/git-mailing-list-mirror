From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] tree.c: allow read_tree_recursive() to traverse
 gitlink entries
Date: Sun, 25 Jan 2009 12:43:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901251225250.14855@racer>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com> <1232844726-14902-2-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 12:44:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR3PU-0002HK-Q4
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 12:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbZAYLmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 06:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbZAYLmw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 06:42:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:55991 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752511AbZAYLmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 06:42:51 -0500
Received: (qmail invoked by alias); 25 Jan 2009 11:42:48 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp037) with SMTP; 25 Jan 2009 12:42:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pKv5ad/8pEudRWM937gUltR32QHCRV3M6rS5rQa
	jt4Wd2XA8TPYCC
X-X-Sender: gene099@racer
In-Reply-To: <1232844726-14902-2-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107050>

Hi,

On Sun, 25 Jan 2009, Lars Hjemli wrote:

> When the callback function invoked from read_tree_recursive() returns
> the value `READ_TREE_RECURSIVE` for a gitlink entry, the traversal will
> now continue into the tree connected to the gitlinked commit.

\n

> This functionality can be used to allow inter-repository operations, but 
> since the current users of read_tree_recursive() does not yet support 
> such operations, they have been modified where necessary to make sure 
> that they never return READ_TREE_RECURSIVE for gitlink entries (hence no 
> change in behaviour should be introduces by this patch alone).

s/\(introduce\)s/\1d/

> diff --git a/archive.c b/archive.c
> index 9ac455d..e6de039 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -132,7 +132,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>  		err = write_entry(args, sha1, path.buf, path.len, mode, NULL, 0);
>  		if (err)
>  			return err;
> -		return READ_TREE_RECURSIVE;
> +		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);

You do not need the parentheses around the conditional:

	$ git grep 'return (.*?' *.c | wc -l
	14
	gene099@racer:~/git (rebase-i-p)$ git grep 'return [^(]*?' *.c | wc -l
	41

Note that the 14 matches include 9 false positives.

> diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
> index 5b63e6e..fca4631 100644
> --- a/builtin-ls-tree.c
> +++ b/builtin-ls-tree.c
> @@ -68,13 +68,8 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
>  		 *
>  		 * Something similar to this incomplete example:
>  		 *
> -		if (show_subprojects(base, baselen, pathname)) {
> -			struct child_process ls_tree;
> -
> -			ls_tree.dir = base;
> -			ls_tree.argv = ls-tree;

I wondered how that could ever have compiled...

Until I inspected the file (which is different in junio/next from what you 
based your patch on; your patch is vs junio/master).

> @@ -131,6 +131,34 @@ int read_tree_recursive(struct tree *tree,
>  			if (retval)
>  				return -1;
>  			continue;
> +		} else if (S_ISGITLINK(entry.mode)) {
> +			int retval;
> +			struct strbuf path;

s/;/ = STRBUF_INIT;/

> +			unsigned int entrylen;
> +			struct commit *commit;
> +
> +			entrylen = tree_entry_len(entry.path, entry.sha1);
> +			strbuf_init(&path, baselen + entrylen + 1);
> +			strbuf_add(&path, base, baselen);
> +			strbuf_add(&path, entry.path, entrylen);
> +			strbuf_addch(&path, '/');

Why not
			strbuf_addf(&path, "%.*s%.*s/", baselen, base, 
				entrylen, entry.path);

> +
> +			commit = lookup_commit(entry.sha1);
> +			if (!commit)
> +				die("Commit %s in submodule path %s not found",
> +				    sha1_to_hex(entry.sha1), path.buf);
> +
> +			if (parse_commit(commit))
> +				die("Invalid commit %s in submodule path %s",
> +				    sha1_to_hex(entry.sha1), path.buf);
> +
> +			retval = read_tree_recursive(commit->tree,
> +						     path.buf, path.len,
> +						     stage, match, fn, context);
> +			strbuf_release(&path);
> +			if (retval)
> +				return -1;
> +			continue;

I'd also place a comment above read_tree_recursive() stating that this 
function tries to traverse into submodules when READ_TREE_RECURSIVE is 
returned for submodule entries, but no attempt is made at including 
alternate object directories.  (And it must be that way: think bare 
repositories -- they cannot just try to include a subdirectory's 
.git/objects/..)

Ciao,
Dscho
