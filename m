From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v6] add --summary option to git-push and git-fetch
Date: Sun, 31 Jan 2010 19:57:51 -0500
Message-ID: <20100201005751.GA8322@cthulhu>
References: <20100130020548.GA29343@cthulhu>
 <7vsk9oysds.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 02:07:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbkkx-0004VP-1L
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 02:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815Ab0BABG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 20:06:26 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:54679 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab0BAA5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 19:57:52 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 2722882201C; Sun, 31 Jan 2010 19:57:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vsk9oysds.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138569>

* Junio C Hamano (gitster@pobox.com) [100130 02:16]:
> Larry D'Anna <larry@elder-gods.org> writes:
> > +
> > +	object =3D parse_object(sha1);=20
> > +	if (!object)
> > +	    die("bad object %s", arg);
> > +=09
> > +	object_deref =3D deref_tag(object, NULL, 0);=20
> > +	if (object_deref && object_deref->type =3D=3D OBJ_COMMIT)
> > +	    if (flags_to_clear)
> > +		clear_commit_marks((struct commit *) object_deref, flags_to_clea=
r);=20
> > +
> > +	object->flags |=3D flags ^ local_flags;=20
>=20
> This smells somewhat fishy---what is the reason this "peel and mark" =
needs
> to be done only in this codepath, and none of the other callers of
> get_reference() need a similar logic, for example?
>=20
> In general, why do you need to sprinkle clear-commit-marks all over t=
he
> place? =20

My idea was to call call clear_commit_marks on the "roots" of the revis=
ion arg,
and since handle_revision_arg looks up those roots in several different=
 places,
i had to put clear_commit_marks in each of those places.  the reason th=
e patch
is particularly ugly in this spot is that the other places where i put
clear_commit_marks, I already had a struct commit *, but here i just ha=
d a
object that might be a tag.

> This is not a rhetorical question (I haven't reviewed all the
> codepath involved for quite some time), but na=EFvely it appears it w=
ould be
> a lot simpler if you can let the existing code to do all the revision
> parsing and preparation to add to the pending object array as usual, =
and
> clear the flags from them before you let prepare_revision_walk() to s=
tart
> traversing the commit, but you probably had some reason why that simp=
ler
> approach would not work and did it this way.  What am I missing?

The "existing code" being the caller of print_summary_for_push_or_fetch=
?  I
suppose I just wanted to keep the patches interference with update_loca=
l_ref to
a minimum, so I had it just grab the existing variable "quickref" out o=
f that
function, because that was all the info I really needed to print the su=
mmary.

So i guess you're saying that it would be better for update_local_ref a=
nd
print_summary_for_push_or_fetch to clear the flags, and just pass a rev=
_info for
print_summary_for_push_or_fetch instead of quickref?

   --larry
