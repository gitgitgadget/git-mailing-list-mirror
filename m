From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC PATCH] Remove object-refs from fsck
Date: Thu, 14 Feb 2008 20:07:47 +0100
Message-ID: <20080214190746.GC26527@auto.tuwien.ac.at>
References: <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080212190411.GA23837@auto.tuwien.ac.at> <alpine.LFD.1.00.0802121507310.2732@xanadu.home> <20080212213858.GA29151@auto.tuwien.ac.at> <alpine.LFD.1.00.0802121645121.2732@xanadu.home> <20080213062015.GF24004@spearce.org> <20080213073959.GA27158@auto.tuwien.ac.at> <20080214090013.GK24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 20:08:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPjRY-0004nc-On
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 20:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758090AbYBNTHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2008 14:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757727AbYBNTHt
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 14:07:49 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:42259 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480AbYBNTHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 14:07:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 3EB6B680BEB9;
	Thu, 14 Feb 2008 20:07:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QdCKmuKqejir; Thu, 14 Feb 2008 20:07:47 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0C34A680B59E; Thu, 14 Feb 2008 20:07:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080214090013.GK24004@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73906>

On Thu, Feb 14, 2008 at 04:00:13AM -0500, Shawn O. Pearce wrote:
> =20
> +static int object_exists(const unsigned char *sha1)
> +{
> +	struct object *obj =3D lookup_object(sha1);
> +	if (obj && obj->flags & FSCKED)
> +		return 1;
> +	return has_sha1_file(sha1);
> +}
> +
> +static void broken_link(struct object *obj,
> +		enum object_type ref_type,
> +		const unsigned char *ref_sha1)
> +{
> +	printf("broken link from %7s %s\n",
> +	       typename(obj->type), sha1_to_hex(obj->sha1));
> +	printf("              to %7s %s\n",
> +	       typename(ref_type), sha1_to_hex(ref_sha1));
> +	errors_found |=3D ERROR_REACHABLE;
> +}
> +
> +static void broken_tree(struct tree *item)
> +{
> +	struct tree_desc desc;
> +
> +	item->object.parsed =3D 0;
> +	if (parse_tree(item) < 0)
> +		return; /* error already displayed */
> +
> +	init_tree_desc(&desc, item->buffer, item->size);
> +	while (desc.size) {
> +		unsigned mode;
> +		const char *name;
> +		const unsigned char *sha1;
> +
> +		sha1 =3D tree_entry_extract(&desc, &name, &mode);
> +		update_tree_entry(&desc);
> +		if (S_ISGITLINK(mode) || object_exists(sha1))
> +			continue;
> +		if (S_ISDIR(mode))
> +			broken_link(&item->object, OBJ_TREE, sha1);
> +		else
> +			broken_link(&item->object, OBJ_BLOB, sha1);
> +	}
> +	free(item->buffer);
> +	item->buffer =3D NULL;
> +}
> +
> +static void broken_commit(struct commit *commit)
> +{
> +	struct tree *tree =3D commit->tree;
> +	struct commit_list *pp;
> +
> +	if (tree && !object_exists(tree->object.sha1))
> +		broken_link(&commit->object, OBJ_TREE, tree->object.sha1);
> +
> +	pp =3D commit->parents;
> +	while (pp) {
> +		struct commit *p =3D pp->item;
> +		if (p && !object_exists(p->object.sha1))
> +			broken_link(&commit->object, OBJ_COMMIT, p->object.sha1);
> +		pp =3D pp->next;
> +	}
> +}
> +
> +static void broken_tag(struct tag *tag)
> +{
> +	struct object *ref =3D tag->tagged;
> +	if (ref && !object_exists(ref->sha1))
> +		broken_link(&tag->object, ref->type, ref->sha1);
> +}
> +
>  /*
>   * Check a single reachable object
>   */
>  static void check_reachable_object(struct object *obj)
>  {
> -	const struct object_refs *refs;
> -
>  	/*
>  	 * We obviously want the object to be parsed,
>  	 * except if it was in a pack-file and we didn't
> @@ -84,21 +155,28 @@ static void check_reachable_object(struct object=
 *obj)
>  	}
> =20
>  	/*
> -	 * Check that everything that we try to reference is also good.
> +	 * If the fsck routines found this object WANTING
> +	 * then we need to re-evaluate what it wanted and
> +	 * report on those broken links.
>  	 */
> -	refs =3D lookup_object_refs(obj);
> -	if (refs) {
> -		unsigned j;
> -		for (j =3D 0; j < refs->count; j++) {
> -			struct object *ref =3D refs->ref[j];
> -			if (ref->parsed ||
> -			    (has_sha1_file(ref->sha1)))
> -				continue;
> -			printf("broken link from %7s %s\n",
> -			       typename(obj->type), sha1_to_hex(obj->sha1));
> -			printf("              to %7s %s\n",
> -			       typename(ref->type), sha1_to_hex(ref->sha1));
> -			errors_found |=3D ERROR_REACHABLE;
> +	if (obj->flags & WANTING) {
> +		switch (obj->type) {
> +		case OBJ_TREE:
> +			broken_tree((struct tree *) obj);
> +			break;
> +
> +		case OBJ_COMMIT:
> +			broken_commit((struct commit *) obj);
> +			break;
> +
> +		case OBJ_TAG:
> +			broken_tag((struct tag *) obj);
> +			break;
> +
> +		default:
> +			objerror(obj,
> +				"type '%d' has broken link (internal fsck error)",
> +				obj->type);
>  		}
>  	}
>  }
> @@ -181,7 +259,7 @@ static void check_object(struct object *obj)
>  	if (verbose)
>  		fprintf(stderr, "Checking %s\n", sha1_to_hex(obj->sha1));
> =20
> -	if (obj->flags & REACHABLE)
> +	if (obj->flags & SEEN)
>  		check_reachable_object(obj);
>  	else
>  		check_unreachable_object(obj);
> @@ -309,6 +387,15 @@ static int fsck_tree(struct tree *item)
>  			has_bad_modes =3D 1;
>  		}
> =20
> +		/*
> +		 * If the SHA-1 should exist in this repository but
> +		 * we are missing it flag this tree as WANTING.  We
> +		 * will revisit this error later once we determine
> +		 * this tree is SEEN.
> +		 */
> +		if (!S_ISGITLINK(mode) && !object_exists(sha1))
> +			item->object.flags |=3D WANTING;
> +
>  		if (o_name) {
>  			switch (verify_ordered(o_mode, o_name, mode, name)) {
>  			case TREE_UNORDERED:
> @@ -367,10 +454,15 @@ static int fsck_commit(struct commit *commit)
>  		return objerror(&commit->object, "invalid format - expected 'tree'=
 line");
>  	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] !=3D '\n')
>  		return objerror(&commit->object, "invalid 'tree' line format - bad=
 sha1");
> +	if (!object_exists(tree_sha1))
> +		commit->object.flags |=3D WANTING;
> +

How do we verify, that tree_sha1 is a tree?


>  	buffer +=3D 46;
>  	while (!memcmp(buffer, "parent ", 7)) {
>  		if (get_sha1_hex(buffer+7, sha1) || buffer[47] !=3D '\n')
>  			return objerror(&commit->object, "invalid 'parent' line format - =
bad sha1");
> +		if (!object_exists(sha1))
> +			commit->object.flags |=3D WANTING;

How do we verify, that sha1 is a commit?

>  		buffer +=3D 48;
>  	}
>  	if (memcmp(buffer, "author ", 7))
> @@ -395,6 +487,9 @@ static int fsck_tag(struct tag *tag)
>  	if (!tagged) {
>  		return objerror(&tag->object, "could not load tagged object");
>  	}
> +	if (!object_exists(tagged->sha1))
> +		tag->object.flags |=3D WANTING;
> +

Same here. Where do we check the type?

mfg Martin K=F6gler
