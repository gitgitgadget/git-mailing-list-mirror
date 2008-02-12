From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Tue, 12 Feb 2008 08:20:30 +0100
Message-ID: <20080212072030.GA20857@auto.tuwien.ac.at>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 08:21:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOpS0-0005gc-Dx
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 08:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939AbYBLHUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 02:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758193AbYBLHUe
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 02:20:34 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40207 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310AbYBLHUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 02:20:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id F0544680BEB9;
	Tue, 12 Feb 2008 08:20:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZmlN68bBX65g; Tue, 12 Feb 2008 08:20:30 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id BE5466800656; Tue, 12 Feb 2008 08:20:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73630>

On Sun, Feb 10, 2008 at 04:00:44PM -0800, Junio C Hamano wrote:
> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> > * add --strict option to unpack-objects (patch 1,8,9)
> > * add --strict option to index-pack (patch 8,10)
> >
> >   Same as for unpack-objects, but without writting objects.
> >
> > * add config option for receive pack to enable checking (patch 11)
>=20
> If this patch is any good, I strongly suspect it should not be
> just the default but should always be on.  IOW no config is
> necessary.  That would make the series a bit simpler, I guess.

Not very much. In patch 11, we would not need to parse a config
variable and could pass --strict option unconditional to
index-pack/unpack-objects.

=46or the moment, I would like to keep it as an option (enabled by
default). If somebody has a repository with a totally broken history,
he would not be able to push any more, if there is no way to disable
it.

> > From 76e86fe55345e633c910d6b8fe166e27c23c5aaf Mon Sep 17 00:00:00 2=
001
> > From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> > Date: Fri, 8 Feb 2008 08:51:38 +0100
> > Subject: [PATCH 01/12] unpack-object: cache for non written objects
> >
> > Preventing objects with broken links entering the repository
> > means, that write of some objects must be delayed.
> >
> > This patch adds a cache to keep the object data in memory. The delt=
a
> > resolving code must also search in the cache.
>=20
> I have to wonder what the memory pressure in real-life usage
> will be like.
>=20
> When an object is proven to be good, we should be able to free
> its buffer after writing it out, but would that be a good enough
> optimization we can make later on this code to keep its memory
> consumption manageable?

This code is only used by unpack-objects, which is used for small
packs. It only caches metadata (tree,commit,tag), no blobs. So the
memory usage should not be a problem.

> > diff --git a/fsck.c b/fsck.c
> > new file mode 100644
> > index 0000000..089f775
> > --- /dev/null
> > +++ b/fsck.c
> > @@ -0,0 +1,84 @@
> > +#include "cache.h"
> > +#include "object.h"
> > +#include "blob.h"
> > +#include "tree.h"
> > +#include "tree-walk.h"
> > +#include "commit.h"
> > +#include "tag.h"
> > +#include "fsck.h"
> > +
> > +static int fsck_walk_tree(struct tree* tree, fsck_walk_func walk, =
void* data)
> > +{
> > +	struct tree_desc desc;
> > +	struct name_entry entry;
> > +
> > +	if(parse_tree(tree))
> > +		return -1;
>=20
> It's a bit hard to see how these new set of functions relate to
> the original code in this patch series, because you add the new
> things that are initially not used anywhere independently, start
> referring to them in a separate patch and then remove the old
> related functions that are now unused.  This style makes
> reviewing easier and harder at the same time...

Will try to restructure the patches.

> > From 80b22c3f2c3e13c207790a49646020c55b34bba7 Mon Sep 17 00:00:00 2=
001
> > From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> > Date: Fri, 8 Feb 2008 09:01:50 +0100
> > Subject: [PATCH 03/12] fsck: move mark-reachable to fsck_walk
> >
> > Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> > ---
> >  builtin-fsck.c |   34 ++++++++++++++++++++++++----------
> >  1 files changed, 24 insertions(+), 10 deletions(-)
> >  ...
> > +static int mark_object(struct object* obj, int type, void* data)
> > +{
> > +	if (!obj)
> > +		return 0;
> > +	if (obj->flags & REACHABLE)
> > +		return 0;
> > +	obj->flags |=3D REACHABLE;
> > +	if (!obj->parsed)
> > +		return 0;
> > +	return fsck_walk(obj, mark_object, data);
> > +}
>=20
> Hmm.  The return value 0 means Ok and negative is error?  The
> reason we can say success if obj is NULL or it is not parsed yet
> is because...?

In mark_objects, I don't care for the results. Its should only
mark all reachable objects (without crashing).

> > @@ -326,8 +344,6 @@ static int fsck_tree(struct tree *item)
> >  		o_name =3D name;
> >  		o_sha1 =3D sha1;
> >  	}
> > -	free(item->buffer);
> > -	item->buffer =3D NULL;
>=20
> Hmm.  The reason you still need the buffer after you checked the
> contents of the tree in the loop is because you haven't actually
> checked the referents are Ok.  But I do not see a corresponding
> free that releases this memory after you are actually done with
> the verification with fsck_walk() yet, so we leak this in the
> meantime?

The tree is traversed multiple times:
* to mark reachable objects
* to mark it's childs used
* to check for broken links

The last use of the tree content is, after all objects are already in
memory.

> > @@ -375,8 +391,6 @@ static int fsck_commit(struct commit *commit)
> >  	}
> >  	if (memcmp(buffer, "author ", 7))
> >  		return objerror(&commit->object, "invalid format - expected 'aut=
hor' line");
> > -	free(commit->buffer);
> > -	commit->buffer =3D NULL;
> >  	if (!commit->tree)
> >  		return objerror(&commit->object, "could not load commit's tree %=
s", tree_sha1);
> >  	if (!commit->parents && show_root)
>=20
> Likewise.

Will change.

> > From ce43251ef71962ff64fe138f1295c405ef6aaf65 Mon Sep 17 00:00:00 2=
001
> > From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> > Date: Fri, 8 Feb 2008 09:04:08 +0100
> > Subject: [PATCH 04/12] fsck: move reachable object check to fsck_wa=
lk
> >
> > It handles NULL pointers in object references without crashing.
> >
> > Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> > ---
> >  builtin-fsck.c |   49 +++++++++++++++++++++++++++++---------------=
-----
> >  1 files changed, 29 insertions(+), 20 deletions(-)
> >
> > diff --git a/builtin-fsck.c b/builtin-fsck.c
> > index 49e96ff..2c1e10f 100644
> > --- a/builtin-fsck.c
> > +++ b/builtin-fsck.c
> > @@ -81,13 +81,39 @@ static int objwarning(struct object *obj, const=
 char *err, ...)
> >  	return -1;
> >  }
> > =20
> > +static int check_reachable_object_childs(struct object *obj, int t=
ype, void *data)
> > +{
> > +	struct object *parent =3D data;
> > +	if (!obj) {
> > +		printf("broken link from %7s %s\n",
> > +			   typename(parent->type), sha1_to_hex(parent->sha1));
> > +		printf("broken link from %7s %s\n",
> > +			   (type=3D=3DOBJ_ANY?"unknown":typename(type)), "unknown");
>=20
> Hmm?  I am not sure what this part is reporting...

If eg. the sha1 of a commit is stored as tree in a commit, you will
find a null pointer in struct commit->tree. Such things will hit this
check.

> > From ee11f771be1ef1c29725cb56ab3eb8dfe61ca25a Mon Sep 17 00:00:00 2=
001
> > From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> > Date: Fri, 8 Feb 2008 09:07:33 +0100
> > Subject: [PATCH 06/12] create a common object checker code out of f=
sck
> >
> > The function provides a callback for reporting errors.
>=20
> The same "add unused new stuff independently, later use it and
> then finally remove now unused old stuff" pattern is here.  I am
> neutral to that patch style but it is a bit harder to see what
> is going on.
>=20
> Most of the changes seem to be straight and sane copy-and-paste thoug=
h.

I'll merge this patch with the next patch.

> > From a8db4e754e717bac0b2462333d4145eac3452099 Mon Sep 17 00:00:00 2=
001
> > From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> > Date: Fri, 8 Feb 2008 09:14:14 +0100
> > Subject: [PATCH 09/12] unpack-objects: prevent writing of inconsist=
ent objects
> >
> > This patch introduces a strict mode, which ensures that:
> > - no malformed object will be written
> > - no object with broken links will be written
> >
> > The patch ensures this by delaying the write of all non blob object=
=2E
> > These object are written, after all objects they link to are writte=
n.
> >
> > An error can only result in unreferenced objects.
>=20
> > diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
> > index f18c7e8..3e906e4 100644
> > --- a/builtin-unpack-objects.c
> > +++ b/builtin-unpack-objects.c
> > @@ -173,7 +250,6 @@ static void resolve_delta(unsigned nr, enum obj=
ect_type type,
> >  		die("failed to apply delta");
> >  	free(delta);
> >  	write_object(nr, type, result, result_size);
> > -	free(result);
> >  }
>=20
> And this is freed later elsewhere?

The free is the task of write_object. If (!strict), then it is freeed
immediatly. Similar for blobs. Other objects are put in the cache (see
patch 1).

> > @@ -203,7 +279,8 @@ static void unpack_non_delta_entry(enum object_=
type type, unsigned long size,
> > =20
> >  	if (!dry_run && buf)
> >  		write_object(nr, type, buf, size);
> > -	free(buf);
> > +	else if (buf)
> > +		free(buf);
> >  }
>=20
> You can always free NULL without checking.

Will fix.

> > @@ -356,6 +434,7 @@ static void unpack_all(void)
> >  	if (!quiet)
> >  		progress =3D start_progress("Unpacking objects", nr_objects);
> >  	obj_list =3D xmalloc(nr_objects * sizeof(*obj_list));
> > +	memset(obj_list, 0, nr_objects * sizeof(*obj_list));
>=20
> Hmm, is this a fix to the 'master' independent from all the rest
> of your patches, or a new requirement?

This is, because the new field in obj_list must be initialized with
zero.

mfg martin K=F6gler
