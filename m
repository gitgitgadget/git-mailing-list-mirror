From: fuz@fuz.su
Subject: Re: git archive should use vendor extension in pax header
Date: Thu, 28 Jan 2016 00:45:12 +0100
Message-ID: <20160127234512.GA5453@fuz.su>
References: <20160124155909.GA16847@fuz.su>
 <56A7EDE1.1020909@web.de>
 <20160127114634.GA1976@fuz.su>
 <56A92913.3030909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 00:39:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOZgh-0002Ht-AO
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 00:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934791AbcA0Xjn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 18:39:43 -0500
Received: from fuz.su ([5.135.162.8]:60846 "EHLO fuz.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932241AbcA0Xjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 18:39:39 -0500
Received: by fuz.su (Postfix, from userid 1000)
	id A96D520227; Thu, 28 Jan 2016 00:45:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56A92913.3030909@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hallo Ren=C3=A9,

On Wed, Jan 27, 2016 at 09:31:15PM +0100, Ren=C3=A9 Scharfe wrote:
> Hello Robert,
>=20
> it's customary to discuss in the open by copying the list.  Unless
> there are secrets involved, but I don't see any below.  I kept it
> private anyway in case I missed any, but please cc:
> git@vger.kernel.org on your reply if possible.

I'm sorry for miss-sending the last mail, I sent it to the list again.

> >>This is only a problem if you don't know how a given tar files was
> >>created (or modified later).  How did you get into this situation?
> >>Or in other words: Please tell me more about your use case.
> >
> >My situation is that I'm interested in knowing if an archive was cre=
ated
> >by git so I can find out where the corresponding repository is and f=
ind
> >out which commit this archive was created from.  Right now the only =
way
> >is to open a hex editor or as archiving software is instructed to ig=
nore
> >the content of comment headers.  This is clearly a suboptimal situat=
ion.
>=20
> There is git get-tar-commit-id, which prints the commit ID if it
> finds a comment entry which looks like a hexadecimal SHA-1 hash.
> It's better than a hex editor at least. :)

This is incredibly fuzzy and can get wrong for a pleothora of reasons.
I hope you agree though that the situation is suboptimal, git is doing
the equivalent of using a custom file format without an easily
recognizable magic number.

> But I'm still interested how you got a collection of tar files with
> unknown origin.  Just curious.

Easy: Just download the (source) distribution archives of a distributio=
n
of choice and try to verify that the tarballs they use to compile their
packages actually come from the project's public git repositories.

There are other reasons why an easily detectable git hash might be
useful.  For example, file(1) could show that the archive comes from
git.  Other utilities could use this to work around git-specific bugs.
An unpacker could add corresponding meta-data when unpacking the file.

> >>>It would be much more useful if git created a
> >>>custom key. As per POSIX suggestions, something like this would be
> >>>appropriate:
> >>>
> >>>     GIT.commit=3D57ca140635bf157354124e4e4b3c8e1bde2832f1
> >>
> >>This would be included in addition to the comment in order to avoid
> >>breaking existing users, I guess.
> >
> >Good point.  I'm not sure how many user use the comment header at al=
l.
>=20
> Apart from git get-tar-commit-id I don't know any program for
> extracting pax comments.  And I don't know how widely used that is,
> but I assume there is *someone* out there, extracting commit IDs
> with it.

Neither do I.  But remember, POSIX explicitly specifies that programs
that parse pax file must ignore pax comments so an unpacker that
interpretes the content of such a comment in any way is in violation of
the pax specification.

> >>If you have a random archive and want to know if it was generated b=
y
> >>git then your next question might be which options and substitution=
s
> >>were used.  That reminds me of this thread regarding verifiable
> >>archives:
> >>
> >>     http://article.gmane.org/gmane.comp.version-control.git/240244
> >
> >Good point.  Something like this should be enough to be enough to ha=
ve
> >reproducable archives if archives with a tree ID were to have a time
> >stamp of 0 (1970-01-01) instead of the current date:
> >
> >     comment=3D...    (for compatibility)
> >     GIT.commit=3D... (like comment)
> >     GIT.umask=3D...  (tar.umask)
> >     GIT.prefix=3D... (--prefix=3D)
> >     GIT.path=3D...   (see below
> >     GIT.export-subst=3D1 (in extended header instead of global head=
er)
> >
> >A different key such as GIT.treeish might be appropriate.  The
> >GIT.export-subst key should be set only for those files where a
> >substitution has taken place.
>=20
> What would GIT.export-subst contain? There can be multiple
> replacements in a file.

GIT.export-subst would only contain a 1 if substitution is turned on.
The goal is to have reproduceable archives, not the ability to turn an
archive back into a git repository.

> >Maybe there should also be an
> >GIT.original-name key.
>=20
> What would it be used for?

In case an export substition changes the file name so the implementatio=
n
can verify that the original file could plausibly have been substituted
into the current name.  Also for the case where multiple files
substitute into the same name to tell which file git should check
equivalency with.

> >An option GIT.export-ignore is not required.  Instead it would be mo=
re
> >useful to have a special file type G (for git) with the convention t=
hat
> >the file name .gitattributes means =E2=80=9Cattributes that apply to=
 this git
> >archive.=E2=80=9D
>=20
> That would be a non-standard extension.  Archivers would extract
> these as regular files.  Storing a list of excluded paths (in
> GIT.exclude or so) might be a better idea.

No, that's not a good idea as pax headers are interpreted as =E2=80=9Ca=
ttributes
pertaining to a file.=E2=80=9D  A file doesn't have the attribute that =
other
files have been omitted.  Making this a special file type is useful as
it allows archivers that don't implement git extensions to recover this
information in a useful way (after all, the .gitattributes file took
part in creating the archive) and, more importantly, reserves a file
type for future git extensions.

> >The GIT.path option holds the paths that are being archived. It is a=
 bit
> >tricky to get right.  The intent of POSIX pax headers is that each k=
ey
> >is an attribute that applies to a series of files.  In the case of a
> >global header, each key applies until it is overridden with a new
> >header or with a local header.  A GIT.path key should only apply to =
the
> >files that correspond to this path operant to git archive.  Thus, a =
new
> >GIT.path should be written frequently.  There should always be at le=
ast
> >one GIT.path.
>=20
> That's for the optional path parameters of git archive, right?  A
> list of included paths (GIT.include) would be simpler and should
> suffice, no?

No.  Again: An attribute in a pax header pertains a file.  It's metadat=
a
attached to a file, not metadata attached to the whole archive, even wh=
en
part of a global header.  Thus each file should have attached what path
operand it came from.  A file doesn't have the attribute what other pat=
h
operands git received, only the path operand that caused the inclusion =
of
that one file is an attribute of the file.

> >It might be a good idea to be able to control the kind of metadata g=
it
> >adds to the archive as to be able to not leak any confidential
> >information with git archive.  If you are interested I can try to ma=
ke a
> >specification for these headers.
>=20
> Which of the field might be sensitive?

The existence of a git-specific pax header is sensitive as it proves
that a git archive of the source code exists.  This can be a problem if
you want to plausibly deny the possession of other versions of the
source code you distribute.  The existence of export-ignore meta data
leaks information about what other files are in the repository the
archive was created from and can be critical.  The existence of
path-operand meta data can show what path structure the repository has
which can be sensitive.  Basically the existence of any information
besides the information you want to add itself is sensitive.

> Users can always go back to the original format.  At least I don't
> expect this new format becoming the default too quickly.

Sure thing.  If this is going to be implemented, I would add options
to choose what / what style of metadata to include.

> An extractor is needed -- unlike the comment field (which is at
> least menationed in the spec) I can't see any generic archiver to
> add support for the git specific fields.

=46or most archivers, the support comprises ignoring them (and not warn=
ing
about the unrecognized fields).  But custom software could use them in
useful ways, e.g. to verify the validity of an archive.  The comment
field has the reliability problems outlined above.  It's like a file
format without a magic number.

> Ren=C3=A9

Best regards,
Robert Clausecker

--=20
()  ascii ribbon campaign - for an 8-bit clean world=20
/\  - against html email  - against proprietary attachments
