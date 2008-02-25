From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 08:46:11 +0100
Message-ID: <20080225074611.GC15761@auto.tuwien.ac.at>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at> <7vr6f1pwaw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 08:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTY2z-0006WF-59
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 08:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbYBYHqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 02:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbYBYHqN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 02:46:13 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:45679 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbYBYHqM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 02:46:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 55747680B59A;
	Mon, 25 Feb 2008 08:46:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HopjBnPtzAUT; Mon, 25 Feb 2008 08:46:11 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 3970D68018E5; Mon, 25 Feb 2008 08:46:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vr6f1pwaw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75002>

On Sun, Feb 24, 2008 at 07:08:39PM -0800, Junio C Hamano wrote:
> > diff --git a/Makefile b/Makefile
> > index a9b5a67..3b356f8 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -303,7 +303,7 @@ LIB_H =3D \
> >  	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h =
\
> >  	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h=
 \
> >  	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
> > -	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h =
ll-merge.h
> > +	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h =
ll-merge.h fsck.h
>=20
> I'd rather see a series does not depend on things in next that
> you do not have to depend on, pretty please?

I usually develop my patch on next. I can offer you two things:
* base my patches on something different (master?)
* add fsck.h/o some lines above

What do you prefer?

> > +static int fsck_walk_commit(struct commit *commit, fsck_walk_func =
walk, void *data)
> > +{
> > +	struct commit_list *parents =3D commit->parents;
> > +	int result;
> > +
> > +	if(parse_commit(commit))
> > +		return -1;
> > +
> > +	result =3D walk((struct object*)commit->tree, OBJ_TREE, data);
> > +	if (result)
> > +		return result;
> > +
> > +	while (parents) {
> > +		result =3D walk((struct object*)parents->item, OBJ_COMMIT, data)=
;
> > +		if (result)
> > +			return result;
> > +		parents =3D parents->next;
> > +	}
> > +	return 0;
> > +}
>=20
> Hmm.  For the purpose of proving there is _no_ error (or an
> error or more), it would be Ok to return early like this, but
> won't there be cases where you would want to get as many
> coverage as possible?
>=20
> For example, I do not think you can use this to mark reachable
> objects.  Even if you find error walking the first parent
> history, you would want to still mark a healthy second parent
> history reachable.

How should I define the return value of fsck_walk in the presence of
multiple errors?

It would not be necessary for all my users:

* in unpack-object and index-pack (I'll send an updated patch in the
  next days), any error means that we can abort. Further checking would
  mean wasting of resources.

* in fsck (patch 2) the error is signaled by the errors_found variable,=
 so
  all callbacks can return 0, even in the case of an error. Checking th=
e
  return value of fsck_walk would mean duplicate error messages.

mfg Martin K=F6gler
