From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well [V3]
Date: Tue, 17 Jun 2008 17:42:54 -0700
Message-ID: <7vbq1z375d.fsf@gitster.siamese.dyndns.org>
References: <1213646686-31964-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 02:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8lmP-0002Nb-ME
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 02:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbYFRAnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 20:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757868AbYFRAnJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 20:43:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757633AbYFRAnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 20:43:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EFE411CF2;
	Tue, 17 Jun 2008 20:43:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D1DCE11CF1; Tue, 17 Jun 2008 20:43:01 -0400 (EDT)
In-Reply-To: <1213646686-31964-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Mon, 16 Jun 2008 16:04:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83F11800-3CCF-11DD-AE5D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85349>

Don Zickus <dzickus@redhat.com> writes:

> When working with a lot of people who backport patches all day long, every
> once in a while I get a patch that modifies the same file more than once
> inside the same patch.  git-apply either fails if the second change relies
> on the first change or silently drops the first change if the second change
> is independent.

Good issue to tackle.

> A new test has been added to cover the cases I addressed.  However,
> currently adding changes to renamed file inside the same patch doesn't work
> correctly (it fails to find new file).  I didn't know how to fix this
> correctly, so I have the test fail expectedly.

Do you mean that the first patch rename-edits A to B, and then the second
patch edits B in place?  Because your fn_cache is keyed by postimage
filename (in this case B), I would imagine that the later lookup of B
should successfully find the patch result from the previous one.  Unless
the in_fn_cache() is somehow wrong...

or do you mean that the first patch rename-edits A to B, but the second
one still wants to edit A in place and you would want to pretend as if the
later one is for a patch to B?  I would think that is doable but asking
for too much magic, and a tool with too much magic is scary.

> The fix is relatively straight-forward.  But I'm not sure if this new
> behaviour is something the git community wants.

> Changes since v2
> ================
> - the updated patch not a v1 copy (doh!)
>
> Changes since v1
> ================
> - converted to path-list structs
> - added testcases for renaming a patch and apply a new patch on top inside
> the same patch file
>
> Signed-off-by: Don Zickus <dzickus@redhat.com>
> ---

First, a minor style issue.  Because the final round after polishing on
the list is etched into the history without any of the earlier doh!
rounds, we do not want to have the above "Changes since..." in the commit
log message.

  Cf. http://article.gmane.org/gmane.comp.version-control.git/84308

>  builtin-apply.c          |   52 +++++++++++++++++++++++++++++++++++-
>  t/t4127-apply-same-fn.sh |   67 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+), 1 deletions(-)
>  create mode 100755 t/t4127-apply-same-fn.sh
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index c497889..9f76ce4 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -12,6 +12,7 @@
>  #include "blob.h"
>  #include "delta.h"
>  #include "builtin.h"
> +#include "path-list.h"
>  
>  /*
>   *  --check turns on checking that the working tree matches the
> @@ -185,6 +186,13 @@ struct image {
>  	struct line *line;
>  };
>  
> +/*
> + * Caches patch filenames to handle the case where a
> + * patch chunk reuses a filename
> + */
> +
> +struct path_list fn_cache = {NULL, 0, 0, 0};

"Reuses a filename"?  Do you mean touches the same file again?

This is not a "cache" in the sense that you can nuke it without changing
the behaviour except performance, but more about "Record the postimage
pathnames (and contents, indirectly by pointing at the patch structure)
each previous patch application would have created".

There is a case where a normal git patch contains two separate patches to
the same file.  A typechange patch is always expressed as a deletion of
the old path immediately followed by a creation of the same path.  I have
to wonder why that codepath for handing that particular special case is
not changed in this patch.  Surely the mechanism you are adding is a
generalization that can cover such a case as well, isn't it?

> @@ -2176,6 +2184,38 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
>  	return 0;
>  }
>  
> +struct patch *in_fn_cache(char *name)
> +{
> +	struct path_list_item *item;
> +
> +	item = path_list_lookup(name, &fn_cache);
> +	if (item != NULL)
> +		return (struct patch *)item->util;
> +
> +	return NULL;
> +}
> +
> +void add_to_fn_cache(char *name, struct patch *patch)
> +{
> +	struct path_list_item *item;
> +
> +	/* Always add new_name unless patch is a deletion */
> +	if (name != NULL) {
> +		item = path_list_insert(name, &fn_cache);
> +		item->util = patch;
> +	}
> +
> +	/* skip normal diffs, creations and copies */

This comment is a "Huh?".

> +	/*
> +	 * store a failure on rename/deletion cases because
> +	 * later chunks shouldn't patch old names
> +	 */
> +	if ((name == NULL) || (patch->is_rename)) {
> +		item = path_list_insert(patch->old_name, &fn_cache);
> +		item->util = (struct patch *) -1;

If you look at the patch->old_name _anyway_, why do you give a separate
name parameter to this function?  The function would be much easier to
read if you pass only patch, and use patch->new_name instead of the
separate name parameter.  Otherwise the reader needs to scroll down and
figure out that name is a new name by looking at the call site to
understand what is going on.

> +	}
> +}
> +
>  static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
>  {
>  	struct strbuf buf;
> @@ -2188,7 +2228,16 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
>  		if (read_file_or_gitlink(ce, &buf))
>  			return error("read of %s failed", patch->old_name);
>  	} else if (patch->old_name) {
> -		if (S_ISGITLINK(patch->old_mode)) {
> +		struct patch *tpatch = in_fn_cache(patch->old_name);
> +
> +		if (tpatch != NULL) {
> +			if (tpatch == (struct patch *) -1) {
> +				return error("patch %s has been renamed/deleted",
> +					patch->old_name);
> +			}
> +			/* We have a patched copy in memory use that */
> +			strbuf_add(&buf, tpatch->result, tpatch->resultsize);
> +		} else if (S_ISGITLINK(patch->old_mode)) {

Isn't this wrong?  Why can't this new enhancement be used while operating
only on the index?

>  			if (ce) {
>  				read_file_or_gitlink(ce, &buf);
>  			} else {
> @@ -2211,6 +2260,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
>  		return -1; /* note with --reject this succeeds. */
>  	patch->result = image.buf;
>  	patch->resultsize = image.len;
> +	add_to_fn_cache(patch->new_name, patch);
>  	free(image.line_allocated);

So after each patch application, the patch is remembered, keyed by the
pathname of the postimage, so by consulting fn_cache with a pathname, you
can know what the status of a path that was touched by previous patches
is.  That sounds quite straightforward.
