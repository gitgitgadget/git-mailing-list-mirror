From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Fri, 15 Feb 2008 08:18:00 +0100
Message-ID: <20080215071800.GA27772@auto.tuwien.ac.at>
References: <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080213074209.GG24004@spearce.org> <20080213081128.GA27730@auto.tuwien.ac.at> <alpine.LSU.1.00.0802131200410.30505@racer.site> <20080214190455.GB26527@auto.tuwien.ac.at> <alpine.LSU.1.00.0802142345450.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 08:19:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPuqU-00062c-C9
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 08:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762591AbYBOHSG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2008 02:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762493AbYBOHSF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 02:18:05 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:43601 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761507AbYBOHSD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 02:18:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D7C92680BB31;
	Fri, 15 Feb 2008 08:18:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kduU4eWjDbga; Fri, 15 Feb 2008 08:18:00 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id AACD7680B59A; Fri, 15 Feb 2008 08:18:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802142345450.30505@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73941>

On Fri, Feb 15, 2008 at 12:06:49AM +0000, Johannes Schindelin wrote:
> On Thu, 14 Feb 2008, Martin Koegler wrote:
> > @@ -552,8 +553,10 @@ static struct commit_list *merge_bases(struct =
commit *one, struct commit *two)
> >  		 */
> >  		return commit_list_insert(one, &result);
> > =20
> > -	parse_commit(one);
> > -	parse_commit(two);
> > +	if (parse_commit(one))
> > +		die("invalid commit");
> > +	if (parse_commit(two))
> > +		die("invalid commit");
>=20
> I'd rather have this return NULL after displaying an error.  After al=
l,=20
> merge_bases() is sort of "libified".

Would all caller of get_merge_bases treat NULL as an error?

> BTW a simple "git grep parse_commit\( | grep -vwe if -e gitweb" shows=
=20
> this:
>=20
> builtin-blame.c:                        parse_commit(commit);
> builtin-checkout.c:     parse_commit(commit);
> builtin-checkout.c:                     parse_commit(old->commit);
> builtin-checkout.c:             parse_commit(new->commit);
> builtin-checkout.c:                     parse_commit(new.commit);
> builtin-describe.c:                     parse_commit(p);
> builtin-describe.c:                     parse_commit(p);
> builtin-fast-export.c:  parse_commit(commit);
> builtin-fast-export.c:          parse_commit(commit->parents->item);
> builtin-fetch-pack.c:                   parse_commit(commit);
> builtin-fetch-pack.c:                           parse_commit(commit);
> builtin-fetch-pack.c:                   parse_commit(commit);
> builtin-name-rev.c:             parse_commit(commit);
> builtin-show-branch.c:                          parse_commit(p);
> builtin-show-branch.c:          parse_commit(commit);
> commit.c:int parse_commit(struct commit *item)
> commit.c:               parse_commit(commit);
> commit.c:       parse_commit(one);
> commit.c:       parse_commit(two);
> commit.c:                       parse_commit(p);
> commit.h:int parse_commit(struct commit *item);
> contrib/gitview/gitview:                self.parse_commit(commit_line=
s)
> contrib/gitview/gitview:        def parse_commit(self, commit_lines):
> shallow.c:              parse_commit(commit);
> upload-pack.c:                          parse_commit((struct commit *=
)object);
>=20
> A few of those need checking, too, I think.

Same for prepare_revision_walk. It can fail because an error in parse_X=
XX,
but no caller checks the result.

=20
> > diff --git a/revision.c b/revision.c
> > index 6e85aaa..9f8723d 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -46,6 +46,8 @@ void add_object(struct object *obj,
> > =20
> >  static void mark_blob_uninteresting(struct blob *blob)
> >  {
> > +	if (!blob)
> > +		return;
>=20
> IMHO not needed [*1*].  The first user of this (static) function call=
s it=20
> with lookup_blob(), which assumes that the blob has been read already=
=2E

What about calling handle_revision_arg with "^<tree-sha1>", where a
non blob object is stored under a blob mode?

handle_revision_arg will parse only the tree and put it on the pending
list. prepare_revision_walk will call mark_tree_uninteresting on it.
=46or any object with blob mode in the tree, it calls
mark_blob_uninteresting(lookup_blob(entry.sha1)); If entry.sha1 is the
sha1 of an already loaded non blob object, we need this check.

> [*1*] There might be a few people arguing that defensive programming =
is=20
> never wrong.
>=20
> Alas, I saw my share of defensive programming, and more often than no=
t,=20
> the real bugs were hard to find in between all those checks.  And som=
e=20
> checks were actively wrong -- again hard to see...
>=20
> Remember: You can make code so simple that there are obviously no bug=
s.=20
> And the other way is to make it so complicated that there are no obvi=
ous=20
> bugs.

I would put rev_info in the second category. What can not be done with
it?

> > @@ -57,6 +59,8 @@ void mark_tree_uninteresting(struct tree *tree)
> >  	struct name_entry entry;
> >  	struct object *obj =3D &tree->object;
> > =20
> > +	if (!obj)
> > +		return;
>=20
> Same here.

Same argument (s/blob/tree/g).

> > @@ -94,6 +98,8 @@ void mark_parents_uninteresting(struct commit *co=
mmit)
> > =20
> >  	while (parents) {
> >  		struct commit *commit =3D parents->item;
> > +		if (!commit)
> > +			continue;
>=20
> Can parents->item really be NULL?  I think not.  And indeed, a little=
=20
> search reveals that parse_commit_buffer() does this when it construct=
s the=20
> parents list, and encounters an invalid SHA-1:
>=20
> return error("bad parents in commit %s", sha1_to_hex(item->object.sha=
1));
>=20
> In case it is a valid SHA-1, but not a commit, it is ignored.

Its unnecessary, I missed this check.

> > @@ -173,6 +179,8 @@ static struct commit *handle_commit(struct rev_=
info *revs, struct object *object
> >  		struct tag *tag =3D (struct tag *) object;
> >  		if (revs->tag_objects && !(flags & UNINTERESTING))
> >  			add_pending_object(revs, object, tag->tag);
> > +		if (!tag->tagged)
> > +			die("bad tag");
>=20
> I haven't looked yet, but I suspect that this is as impossible as the=
=20
> invalid parent.

Eg. tag pointing to an blob, but when calling parse_tag_buffer, a non
blob object is loaded under blob sha1.

But wouldn't it be simpler, if we would add
	if (!item->tagged)
		return -1;
in parse_tag_buffer?

> > diff --git a/sha1_file.c b/sha1_file.c
> > index 4179949..c25ce64 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -1943,7 +1943,8 @@ void *read_object_with_reference(const unsign=
ed char *sha1,
> >  		}
> >  		ref_length =3D strlen(ref_type);
> > =20
> > -		if (memcmp(buffer, ref_type, ref_length) ||
> > +		if (ref_length + 40 >=3D size ||
> > +		    memcmp(buffer, ref_type, ref_length) ||
>=20
> Makes sense.
>=20
> > @@ -494,6 +498,8 @@ static int peel_onion(const char *name, int len=
, unsigned char *sha1)
> >  				return error("%.*s: expected %s type, but the object dereferen=
ces to %s type",
> >  					     len, name, typename(expected_type),
> >  					     typename(o->type));
> > +			if (!o)
> > +				return -1;
>=20
> You probably want to guard for ((tag *)o)->tagged =3D=3D NULL; Okay, =
now I am=20
> curious. *megoesandlooks*  Indeed, if the tag refers to an unknown ty=
pe,=20
> tagged =3D NULL.
>=20
> But I think in that case, it should return an error().  And maybe onl=
y for=20
> type =3D=3D OBJ_TAG.
>=20
> > @@ -580,6 +586,8 @@ static int handle_one_ref(const char *path,
> >  		return 0;
> >  	if (object->type =3D=3D OBJ_TAG)
> >  		object =3D deref_tag(object, path, strlen(path));
> > +	if (!object)
> > +		return 0;
>=20
> As above, it looks strange to see that object->something is checked, =
and=20
> _then_ object.  I'd put this into curly brackets, together with the=20
> deref_tag(), just to help the reader a bit, should she be as weak in =
mind=20
> as yours truly.
>=20
> > @@ -617,7 +625,8 @@ static int get_sha1_oneline(const char *prefix,=
 unsigned char *sha1)
> >  		unsigned long size;
> > =20
> >  		commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
> > -		parse_object(commit->object.sha1);
> > +		if(!parse_object(commit->object.sha1))
> > +			continue;
>=20
> Makes sense, but please add a space after the "if".
>=20
> > diff --git a/tag.c b/tag.c
> > index 38bf913..990134f 100644
> > --- a/tag.c
> > +++ b/tag.c
> > @@ -9,7 +9,10 @@ const char *tag_type =3D "tag";
> >  struct object *deref_tag(struct object *o, const char *warn, int w=
arnlen)
> >  {
> >  	while (o && o->type =3D=3D OBJ_TAG)
> > -		o =3D parse_object(((struct tag *)o)->tagged->sha1);
> > +		if (((struct tag *)o)->tagged)
> > +			o =3D parse_object(((struct tag *)o)->tagged->sha1);
> > +		else
> > +			o =3D NULL;
>=20
> Knowing that tagged _can_ be NULL, this makes tons of sense.  Except =
that=20
> again, I'd call error() to tell the user, before setting o =3D NULL.

mfg Martin K=F6gler
