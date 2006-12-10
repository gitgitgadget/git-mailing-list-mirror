X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] diff_tree_sha1(): avoid rereading trees if possible
Date: Sat, 09 Dec 2006 17:47:11 -0800
Message-ID: <7vvekk5xpc.fsf@assigned-by-dhcp.cox.net>
References: <20061207101707.GA19139@spearce.org>
	<Pine.LNX.4.63.0612100055160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 01:47:18 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33862>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtDme-0001kA-WA for gcvg-git@gmane.org; Sun, 10 Dec
 2006 02:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759158AbWLJBrN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 20:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759151AbWLJBrN
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 20:47:13 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36428 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759050AbWLJBrM (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 20:47:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210014712.IDZZ22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 20:47:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wpnN1V00a1kojtg0000000; Sat, 09 Dec 2006
 20:47:23 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If the tree has already been read, no need to read it into memory
> again.

Hmm...

> This also helps when this function is called on temporary trees;
> these no longer have to be written to disk.

To generate tree-diff, probably yes, but I am not sure that
allows you to use hash_sha1_file() everywhere in merge_recursive
instead of write_sha1_file(), if that is what you are getting
at.

> +static int get_tree_desc_from_sha1(const unsigned char *sha1,
> +		struct tree_desc *t)
> +{
> +	struct object *o;
> +
> +	o = lookup_object(sha1);
> +	if (o && o->type == OBJ_TREE && o->parsed) {
> +		struct tree *tree = (struct tree *)o;
> +		t->size = tree->size;
> +		t->buf = xmalloc(t->size);
> +		memcpy(t->buf, tree->buffer, t->size);
> +	} else {
> +		t->buf = read_object_with_reference(sha1,
> +				tree_type, &t->size, NULL);
> +		if (!t->buf)
> +			die("unable to read source tree (%s)",
> +					sha1_to_hex(sha1));
> +	}
> +}

Are you absolutely sure that all users of "struct tree" retains
the tree->buffer for a parsed tree?  If nobody does
"free(tree->buffer)" without "tree->buffer = NULL", then the
situation is still salvageable (you need a bit more code above),
though.

I think this is overkill that only helps a very narrow "empty
tree" special case that [PATCH 2/3] addresses, and can be easily
and incorrectly abused.  We do not want people to expect that
reading many trees from different revisions as "struct tree"
objects and keeping all of them in memory would magically speed
up diff-tree, for example.

I'd prefer write_sha1_file() approach in Shawn's patch for its
simplicity at least for now.

I suspect gitlink/subproject people might want to modify in-core
representation of a tree to graft in subproject directory
somewhere in the superproject, just like the history traversal
code modifies in-core representation of a commit to simplify
parents.  Your approach might turn out to be the right thing to
for that application --- populate tree objects in the in-core
obj_hash[], muck with its entries and then have everybody else
go through get_tree_desc_from_sha1() interface to pretend as if
the superproject has everything contained in the subproject
tree.  I dunno.
