From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] parse_commit_buffer: don't parse invalid commits
Date: Mon, 7 Jan 2008 08:40:09 +0100
Message-ID: <20080107074009.GA32710@auto.tuwien.ac.at>
References: <11996461912682-git-send-email-mkoegler@auto.tuwien.ac.at> <11996461913672-git-send-email-mkoegler@auto.tuwien.ac.at> <7vbq7y4ns6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 08:40:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBmb9-0001nK-KA
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 08:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbYAGHkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2008 02:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754289AbYAGHkM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 02:40:12 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:46922 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbYAGHkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 02:40:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 8F3D6680BF73;
	Mon,  7 Jan 2008 08:40:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IB9BVMzczB05; Mon,  7 Jan 2008 08:40:09 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 65A12680BEA2; Mon,  7 Jan 2008 08:40:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vbq7y4ns6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69769>

On Sun, Jan 06, 2008 at 02:00:57PM -0800, Junio C Hamano wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
> > diff --git a/commit.c b/commit.c
> > index f074811..ffa0894 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -48,19 +48,33 @@ struct commit *lookup_commit(const unsigned cha=
r *sha1)
> >  	return check_commit(obj, sha1, 0);
> >  }
> > =20
> > -static unsigned long parse_commit_date(const char *buf)
> > +static unsigned long parse_commit_date(const char *buf, const char=
* tail)
>=20
> Should be "const char *tail" in our codebase.

Will fix.

> >  {
> >  	unsigned long date;
> > +	char datebuf[20];
> > +	unsigned long len;
> > =20
> > +	if (buf + 6 >=3D tail)
> > +		return 0;
> >  	if (memcmp(buf, "author", 6))
> >  		return 0;
>=20
> Even though buf, which is a result from read_sha1_file(), is
> always terminated with an extra NUL (outside its object size),
> if a bogus commit object ends with "author" (and without the
> author information) this part will pass, and ...

fsck_commit (builtin-fsck.c) does quite redundant checks (except that
it checks for author too). Should I make parse_commit fail, if there
is no author and commiter line? This way, we could remove=20
|        if (memcmp(buffer, "tree ", 5))
|                return objerror(&commit->object, "invalid format - exp=
ected 'tree' line");
|        if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] !=3D '\n')
|                return objerror(&commit->object, "invalid 'tree' line =
format - bad sha1");
|        buffer +=3D 46;
|        while (!memcmp(buffer, "parent ", 7)) {
|                if (get_sha1_hex(buffer+7, sha1) || buffer[47] !=3D '\=
n')
|                        return objerror(&commit->object, "invalid 'par=
ent' line format - bad sha1");
|                buffer +=3D 48;
|        }
|        if (memcmp(buffer, "author ", 7))
|                return objerror(&commit->object, "invalid format - exp=
ected 'author' line");
from fsck_commit.


> > -	while (*buf++ !=3D '\n')
> > +	while (buf < tail && *buf++ !=3D '\n')
> >  		/* nada */;
> > +	if (buf + 9 >=3D tail)
> > +		return 0;
>=20
> ... you catch that here.  That seems like a good change.
>=20
> >  	if (memcmp(buf, "committer", 9))
> >  		return 0;
> > -	while (*buf++ !=3D '>')
> > +	while (buf < tail && *buf++ !=3D '>')
> >  		/* nada */;
> > -	date =3D strtoul(buf, NULL, 10);
> > +	if (buf >=3D tail)
> > +		return 0;
>=20
> Likewise here.
>=20
> > +	len =3D tail - buf;
> > +	if (len > sizeof(datebuf) - 1)
> > +	  len =3D sizeof(datebuf) - 1;
>=20
> Broken indentation.

Will fix.

> > +	memcpy(datebuf, buf, len);
> > +	datebuf[len] =3D 0;
> > +	date =3D strtoul(datebuf, NULL, 10);
>=20
> However, as long as buf at this point hasn't go beyond tail,
> which you already checked, I think we can rely on strtoul()
> stopping at the NUL at the end of buffer (that is one beyond
> tail), without this extra memcpy().  Am I mistaken?

No.

parse_commit_buffer is only called from parse_commit (safe, as it uses
a buffer by read_sha1_file) and parse_object_buffer (safe, as it is
called by parse_object (safe as it uses a buffer by read_sha1_file)
and get_obj (in builtin-for-each-ref.c, safe as it uses a buffer by
read_sha1_file)).

> > @@ -275,7 +289,7 @@ int parse_commit_buffer(struct commit *item, vo=
id *buffer, unsigned long size)
> >  			n_refs++;
> >  		}
> >  	}
> > -	item->date =3D parse_commit_date(bufptr);
> > +	item->date =3D parse_commit_date(bufptr, tail);
> > =20
> >  	if (track_object_refs) {
> >  		unsigned i =3D 0;
> > --=20
> > 1.4.4.4
>=20
> When already somewhat deep in the rc cycle, looking at a patch
> from somebody who uses 1.4.4.4 makes me look at the patch a bit
> more carefully than usual ;-)

stg is much simpler to use for such patches. My distribution [Linus
already called it insafe for it's git version] ships stg 0.11, which
is sufficient for this. I simply use stg with the shipped git 1.4.4.4
to avoid any compatibiltiy problems.

mfg Martin K=F6gler
PS:
The function of get_obj in builtin-for-each-ref.c looks quite similar t=
o
parse_object.
