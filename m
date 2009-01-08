From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 2/3] replace_object: add mechanism to replace objects found in "refs/replace/"
Date: Thu, 8 Jan 2009 18:31:22 +0100
Message-ID: <200901081831.22616.chriscool@tuxfamily.org>
References: <20090107084341.1554d8cd.chriscool@tuxfamily.org> <7vmye3a4pt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 18:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyjc-0005qQ-ED
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 18:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbZAHRad convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 12:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753698AbZAHRad
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 12:30:33 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58910 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbZAHRac convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 12:30:32 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4FBF81AB33C;
	Thu,  8 Jan 2009 18:30:30 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2BF3C1AB2EC;
	Thu,  8 Jan 2009 18:30:30 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vmye3a4pt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104945>

Le mercredi 7 janvier 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > In "parse_commit_buffer", the parent sha1s from the original commit
> > or from a commit graft that match a ref name in "refs/replace/" are
> > replaced by the commit sha1 that has been read in the ref.
>
> I may be reading this wrong, but if you replace the parent of the com=
mit,
> that won't improve anything over the graft mechanism, which we alread=
y
> have.
>
> What I was hoping to see was to give replacing commit back when a com=
mit
> is asked for by normal callers,=20

Yeah, but read_sha1_file is called to read all object files, not just=20
commits. So putting the hook there will:

	1) add a lookup overhead when reading any object,
	2) make it possible to replace any object,

And there is also the following problem:

	3) this function is often called like this:

	buffer =3D read_sha1_file(sha1, &type, &size);
	if (!buffer)
		die("Cannot read %s", sha1_to_hex(sha1));

	so in case of error, it will give an error message with a bad sha1
	in it because the sha1 of the file that we cannot read is the sha1
	in the replace ref not the one passed to read_sha1_file.

To avoid the above problems, maybe we can try to also improve what=20
read_sha1_file does:

1) allow callers to pass a type in the "type" argument and only lookup =
in=20
the replace refs if we say we want a commit, but this makes calling thi=
s=20
function more error prone
2) when we say we want an object with a given type, check if the object=
 we=20
read has this type (and die if not)
3) die in read_sha1_file when there is an error and we are replacing so=
 that=20
callers don't need to die themself and so that we can always report an=20
accurate sha1 in the error message

Something like this (totally untested):

void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
		     unsigned long *size)
{
	void *data;
	enum object_type read_type;
	int replacing =3D (type && *type =3D=3D OBJ_COMMIT);

	/* only replace commits when we ask for one */
	if (replacing)
		sha1 =3D lookup_replace_object(sha1);
	data =3D read_object(sha1, &read_type, size);
	/* legacy behavior is to die on corrupted objects */
	if (!data && (has_loose_object(sha1) || has_packed_and_bad(sha1)))
		die("object %s is corrupted", sha1_to_hex(sha1));
	if (type && *type !=3D OBJ_NONE && *type !=3D read_type)
		die("type of object %s (%d) is different from the type we want (%d)",
		    sha1_to_hex(sha1), read_type, *type);
	if (!data && replacing)
		die("Cannot read commit %s", sha1_to_hex(sha1));

	return data;
}

Or perhaps it is better to leave read_sha1_file as it is and add a new=20
function like this:

void *read_commit(const unsigned char *sha1, unsigned long *size)
{
	void *data;
	enum object_type type;

	sha1 =3D lookup_replace_object(sha1);
	data =3D read_sha1_file(sha1, &type, size);

	if (*type !=3D OBJ_COMMIT)
		die("read_commit: object %s is not a commit", sha1_to_hex(sha1));
	if (!data)
		die("read_commit: cannot read commit %s", sha1_to_hex(sha1));

	return data;
}

The latter seems better to me. But I haven't looked much at the 60=20
read_sha1_file callers yet.

[...]

> Doing replacement at parse_commit_buffer() time is one step too late.=
=20
> For example, if you have replacement information for the commit that =
sits
> at the tip of 'master' branch, I think your "git log master" will ign=
ore
> that replacement information.  Creating one new commit on top of it a=
nd
> saying "git log master" then will show the new commit, and suddenly
> starts showing the replacement commit for the one you used to have at=
 the
> tip of the branch.

Yeah, I agree there are drawbacks to do it at parse_commit_buffer time.

Thanks,
Christian.
