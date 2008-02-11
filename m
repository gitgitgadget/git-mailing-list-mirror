From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Sun, 10 Feb 2008 16:00:44 -0800
Message-ID: <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org>
References: <20080210175812.GB12162@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Mon Feb 11 01:01:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOM7M-00088w-R7
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 01:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbYBKABS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 19:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbYBKABS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 19:01:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbYBKABR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 19:01:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8990B3EC4;
	Sun, 10 Feb 2008 19:01:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DEFFD3EBF;
	Sun, 10 Feb 2008 19:01:06 -0500 (EST)
In-Reply-To: <20080210175812.GB12162@auto.tuwien.ac.at> (Martin Koegler's
	message of "Sun, 10 Feb 2008 18:58:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73441>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> So I tried to fix the problem in another way: Instead of coping with 
> corrupt objects, stop them from entering the repository.

Good intention.  Very nice.

> * add --strict option to unpack-objects (patch 1,8,9)
> * add --strict option to index-pack (patch 8,10)
>
>   Same as for unpack-objects, but without writting objects.
>
> * add config option for receive pack to enable checking (patch 11)

If this patch is any good, I strongly suspect it should not be
just the default but should always be on.  IOW no config is
necessary.  That would make the series a bit simpler, I guess.

> From 76e86fe55345e633c910d6b8fe166e27c23c5aaf Mon Sep 17 00:00:00 2001
> From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> Date: Fri, 8 Feb 2008 08:51:38 +0100
> Subject: [PATCH 01/12] unpack-object: cache for non written objects
>
> Preventing objects with broken links entering the repository
> means, that write of some objects must be delayed.
>
> This patch adds a cache to keep the object data in memory. The delta
> resolving code must also search in the cache.

I have to wonder what the memory pressure in real-life usage
will be like.

When an object is proven to be good, we should be able to free
its buffer after writing it out, but would that be a good enough
optimization we can make later on this code to keep its memory
consumption manageable?

> diff --git a/fsck.c b/fsck.c
> new file mode 100644
> index 0000000..089f775
> --- /dev/null
> +++ b/fsck.c
> @@ -0,0 +1,84 @@
> +#include "cache.h"
> +#include "object.h"
> +#include "blob.h"
> +#include "tree.h"
> +#include "tree-walk.h"
> +#include "commit.h"
> +#include "tag.h"
> +#include "fsck.h"
> +
> +static int fsck_walk_tree(struct tree* tree, fsck_walk_func walk, void* data)
> +{
> +	struct tree_desc desc;
> +	struct name_entry entry;
> +
> +	if(parse_tree(tree))
> +		return -1;

I noticed many coding style issues but I won't be mentioning
them in this response.

It's a bit hard to see how these new set of functions relate to
the original code in this patch series, because you add the new
things that are initially not used anywhere independently, start
referring to them in a separate patch and then remove the old
related functions that are now unused.  This style makes
reviewing easier and harder at the same time...

> From 80b22c3f2c3e13c207790a49646020c55b34bba7 Mon Sep 17 00:00:00 2001
> From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> Date: Fri, 8 Feb 2008 09:01:50 +0100
> Subject: [PATCH 03/12] fsck: move mark-reachable to fsck_walk
>
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
>  builtin-fsck.c |   34 ++++++++++++++++++++++++----------
>  1 files changed, 24 insertions(+), 10 deletions(-)
>  ...
> +static int mark_object(struct object* obj, int type, void* data)
> +{
> +	if (!obj)
> +		return 0;
> +	if (obj->flags & REACHABLE)
> +		return 0;
> +	obj->flags |= REACHABLE;
> +	if (!obj->parsed)
> +		return 0;
> +	return fsck_walk(obj, mark_object, data);
> +}

Hmm.  The return value 0 means Ok and negative is error?  The
reason we can say success if obj is NULL or it is not parsed yet
is because...?

> @@ -326,8 +344,6 @@ static int fsck_tree(struct tree *item)
>  		o_name = name;
>  		o_sha1 = sha1;
>  	}
> -	free(item->buffer);
> -	item->buffer = NULL;

Hmm.  The reason you still need the buffer after you checked the
contents of the tree in the loop is because you haven't actually
checked the referents are Ok.  But I do not see a corresponding
free that releases this memory after you are actually done with
the verification with fsck_walk() yet, so we leak this in the
meantime?

> @@ -375,8 +391,6 @@ static int fsck_commit(struct commit *commit)
>  	}
>  	if (memcmp(buffer, "author ", 7))
>  		return objerror(&commit->object, "invalid format - expected 'author' line");
> -	free(commit->buffer);
> -	commit->buffer = NULL;
>  	if (!commit->tree)
>  		return objerror(&commit->object, "could not load commit's tree %s", tree_sha1);
>  	if (!commit->parents && show_root)

Likewise.

> From ce43251ef71962ff64fe138f1295c405ef6aaf65 Mon Sep 17 00:00:00 2001
> From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> Date: Fri, 8 Feb 2008 09:04:08 +0100
> Subject: [PATCH 04/12] fsck: move reachable object check to fsck_walk
>
> It handles NULL pointers in object references without crashing.
>
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
>  builtin-fsck.c |   49 +++++++++++++++++++++++++++++--------------------
>  1 files changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/builtin-fsck.c b/builtin-fsck.c
> index 49e96ff..2c1e10f 100644
> --- a/builtin-fsck.c
> +++ b/builtin-fsck.c
> @@ -81,13 +81,39 @@ static int objwarning(struct object *obj, const char *err, ...)
>  	return -1;
>  }
>  
> +static int check_reachable_object_childs(struct object *obj, int type, void *data)
> +{
> +	struct object *parent = data;
> +	if (!obj) {
> +		printf("broken link from %7s %s\n",
> +			   typename(parent->type), sha1_to_hex(parent->sha1));
> +		printf("broken link from %7s %s\n",
> +			   (type==OBJ_ANY?"unknown":typename(type)), "unknown");

Hmm?  I am not sure what this part is reporting...

> From ee11f771be1ef1c29725cb56ab3eb8dfe61ca25a Mon Sep 17 00:00:00 2001
> From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> Date: Fri, 8 Feb 2008 09:07:33 +0100
> Subject: [PATCH 06/12] create a common object checker code out of fsck
>
> The function provides a callback for reporting errors.

The same "add unused new stuff independently, later use it and
then finally remove now unused old stuff" pattern is here.  I am
neutral to that patch style but it is a bit harder to see what
is going on.

Most of the changes seem to be straight and sane copy-and-paste though.

> From a8db4e754e717bac0b2462333d4145eac3452099 Mon Sep 17 00:00:00 2001
> From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> Date: Fri, 8 Feb 2008 09:14:14 +0100
> Subject: [PATCH 09/12] unpack-objects: prevent writing of inconsistent objects
>
> This patch introduces a strict mode, which ensures that:
> - no malformed object will be written
> - no object with broken links will be written
>
> The patch ensures this by delaying the write of all non blob object.
> These object are written, after all objects they link to are written.
>
> An error can only result in unreferenced objects.

> diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
> index f18c7e8..3e906e4 100644
> --- a/builtin-unpack-objects.c
> +++ b/builtin-unpack-objects.c
> @@ -173,7 +250,6 @@ static void resolve_delta(unsigned nr, enum object_type type,
>  		die("failed to apply delta");
>  	free(delta);
>  	write_object(nr, type, result, result_size);
> -	free(result);
>  }

And this is freed later elsewhere?

> @@ -203,7 +279,8 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
>  
>  	if (!dry_run && buf)
>  		write_object(nr, type, buf, size);
> -	free(buf);
> +	else if (buf)
> +		free(buf);
>  }

You can always free NULL without checking.

> @@ -356,6 +434,7 @@ static void unpack_all(void)
>  	if (!quiet)
>  		progress = start_progress("Unpacking objects", nr_objects);
>  	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
> +	memset(obj_list, 0, nr_objects * sizeof(*obj_list));

Hmm, is this a fix to the 'master' independent from all the rest
of your patches, or a new requirement?
