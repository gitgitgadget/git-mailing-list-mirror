From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Sun, 24 Feb 2008 19:08:39 -0800
Message-ID: <7vr6f1pwaw.fsf@gitster.siamese.dyndns.org>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 25 04:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTTid-0003kN-Qw
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 04:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYBYDI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 22:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbYBYDI4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 22:08:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbYBYDIz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 22:08:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EA61515AB;
	Sun, 24 Feb 2008 22:08:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B964315A9; Sun, 24 Feb 2008 22:08:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74986>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> diff --git a/Makefile b/Makefile
> index a9b5a67..3b356f8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -303,7 +303,7 @@ LIB_H = \
>  	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
>  	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
>  	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
> -	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h ll-merge.h
> +	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h ll-merge.h fsck.h

I'd rather see a series does not depend on things in next that
you do not have to depend on, pretty please?

The patches have style issues everywhere.  The opening paren
that surrounds the conditional to if/while should always have a
SP before it, while function names at the function callsite
should immediately be followed by an open paren.

> +static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
> +{
> +	struct tree_desc desc;
> +	struct name_entry entry;
> +
> +	if(parse_tree(tree))
> +		return -1;
> +
> +	init_tree_desc(&desc, tree->buffer, tree->size);
> +	while(tree_entry(&desc, &entry)) {
> +		int result;
> +		
> +		if (S_ISGITLINK(entry.mode))
> +			continue;
> +		if (S_ISDIR(entry.mode))
> +			result = walk(&lookup_tree(entry.sha1)->object, OBJ_TREE, data);
> +		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
> +			result = walk(&lookup_blob(entry.sha1)->object, OBJ_BLOB, data);
> +		else {
> +			error("in tree %s: entry %s has bad mode %.6o\n",
> +			      sha1_to_hex(tree->object.sha1), entry.path, entry.mode);
> +			result = -1;
> +		}

Would "result = error(...)" be too cute ;-)?

> +static int fsck_walk_commit(struct commit *commit, fsck_walk_func walk, void *data)
> +{
> +	struct commit_list *parents = commit->parents;
> +	int result;
> +
> +	if(parse_commit(commit))
> +		return -1;
> +
> +	result = walk((struct object*)commit->tree, OBJ_TREE, data);
> +	if (result)
> +		return result;
> +
> +	while (parents) {
> +		result = walk((struct object*)parents->item, OBJ_COMMIT, data);
> +		if (result)
> +			return result;
> +		parents = parents->next;
> +	}
> +	return 0;
> +}

Hmm.  For the purpose of proving there is _no_ error (or an
error or more), it would be Ok to return early like this, but
won't there be cases where you would want to get as many
coverage as possible?

For example, I do not think you can use this to mark reachable
objects.  Even if you find error walking the first parent
history, you would want to still mark a healthy second parent
history reachable.

> diff --git a/fsck.h b/fsck.h
> new file mode 100644
> index 0000000..fccc89f
> --- /dev/null
> +++ b/fsck.h
> @@ -0,0 +1,10 @@
> +#ifndef GIT_FSCK_H
> +#define GIT_FSCK_H
> +
> +#define OBJ_ANY OBJ_BAD
> +
> +typedef int (*fsck_walk_func)(struct object *obj, int type, void *data);

It is unclear in this patch, but this "type" is not telling what
the type of the object is to the walk_func, but is telling it
that the given object was found in a place where object of that
type is expected/required, so that walk_func can check and
complain, right?  Needs a bit of commenting...
