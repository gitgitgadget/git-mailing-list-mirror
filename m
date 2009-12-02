From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCHv9 01/11] fast-import: Proper notes tree manipulation
Date: Wed, 2 Dec 2009 12:39:53 -0800
Message-ID: <20091202203953.GE31648@spearce.org>
References: <1259719783-4674-1-git-send-email-johan@herland.net> <1259719783-4674-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 21:40:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFvzp-0001Hx-6t
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 21:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbZLBUkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 15:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbZLBUkF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 15:40:05 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:57394 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbZLBUkE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 15:40:04 -0500
Received: by ywh12 with SMTP id 12so668209ywh.21
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 12:40:11 -0800 (PST)
Received: by 10.101.186.22 with SMTP id n22mr812830anp.194.1259786397739;
        Wed, 02 Dec 2009 12:39:57 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm724704yxe.18.2009.12.02.12.39.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 12:39:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259719783-4674-2-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134396>

Johan Herland <johan@herland.net> wrote:
> diff --git a/fast-import.c b/fast-import.c
> index b41d29f..b51ffbc 100644
> --- a/fast-import.c
> +++ b/fast-import.c

This new version is much cleaner, thank you.

> @@ -161,6 +161,7 @@ Format of STDIN stream:
>  #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
>  #define DEPTH_BITS 13
>  #define MAX_DEPTH ((1<<DEPTH_BITS)-1)
> +#define NOTE_MODE 0170000

Be consistent with S_IFGITLINK:

#define S_IFNOTE 0170000
#define S_ISNOTE(m) (((m) & S_IFMT) == S_IFNOTE)
 
> @@ -245,6 +246,7 @@ struct branch
>  	const char *name;
>  	struct tree_entry branch_tree;
>  	uintmax_t last_commit;
> +	unsigned int num_notes;

Use uintmax_t here?

> +static unsigned int do_change_note_fanout(
> +		struct tree_entry *orig_root, struct tree_entry *root,
> +		char *hex_sha1, unsigned int hex_sha1_len,
> +		char *fullpath, unsigned int fullpath_len,
> +		unsigned char fanout)
> +{
> +	struct tree_content *t = root->tree;
> +	struct tree_entry *e, leaf;
> +	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len, num_notes = 0;
> +	unsigned char sha1[20];
> +	char realpath[60];
> +	int is_note;
> +
> +	for (i = 0; i < t->entry_count; i++) {
> +		e = t->entries[i];
> +		is_note = (e->versions[1].mode & NOTE_MODE) == NOTE_MODE;
> +		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
> +		tmp_fullpath_len = fullpath_len;
> +
> +		if (tmp_hex_sha1_len <= 40 && e->name->str_len >= 2) {
> +			memcpy(hex_sha1 + hex_sha1_len, e->name->str_dat,
> +				e->name->str_len);
> +			if (tmp_fullpath_len)
> +				fullpath[tmp_fullpath_len++] = '/';
> +			memcpy(fullpath + tmp_fullpath_len, e->name->str_dat,
> +				e->name->str_len);
> +			tmp_fullpath_len += e->name->str_len;
> +			assert(tmp_fullpath_len < 60);
> +			fullpath[tmp_fullpath_len] = '\0';
> +		} else {
> +			assert(!is_note);
> +			continue;
> +		}

Are we rejecting a mixed content-tree here?  I thought a notes
tree was allowed to hold anything, e.g. isn't it ok to put a
".gitattributes" file into a notes tree.

I think we'd do better to have at the top of our loop:

	if (!is_note && !S_ISDIR(e->versions[1].mode))
		continue;

so that we ignore non-notes and non-subdirectories which might
contain notes.

Also, fast-import never uses assert.  I'd prefer to die() because
then the recent command trace can go into the crash report.
It gives the user more context about what the hell just went wrong.

> +		/* The above may have reallocated the current tree_content */
> +		if (t != root->tree)
> +			t = root->tree;

Why bother with the condition?  Just do the assignment every time
in the loop.

> @@ -2080,8 +2195,10 @@ static void note_change_n(struct branch *b)
>  			    typename(type), command_buf.buf);
>  	}
> 
> -	tree_content_set(&b->branch_tree, sha1_to_hex(commit_sha1), sha1,
> -		S_IFREG | 0644, NULL);
> +	construct_path_with_fanout(sha1_to_hex(commit_sha1), fanout, path);
> +	b->num_notes += adjust_num_notes(&b->branch_tree, path, sha1);
> +	mode = (is_null_sha1(sha1) ? S_IFREG : NOTE_MODE) | 0644;
> +	tree_content_set(&b->branch_tree, path, sha1, mode, NULL);

I wonder if it wouldn't be better to compute the fan out here on
each put.  That way if an importer drives 2,000,000 notes at once
to us in a single commit, we don't wind up with a flat 0 fan-out
tree and trying to perform a linear insert on each one, but instead
will start to increase the fan out as the number of entries goes up.

Basically, tree_content_set/remove are O(N) operations on N paths
in the tree, because their structures aren't necessarily sorted.
IIRC at one point in time I tried to do this with a binary search but
gave up and just did it unsorted.  At least using the fan out here
would help partition the search space dramatically on large inserts.

-- 
Shawn.
