From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Document format of basic Git objects
Date: Wed, 15 Feb 2012 11:31:27 -0600
Message-ID: <20120215173127.GA22004@burratino>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 18:31:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxihr-0000wt-5C
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 18:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab2BORbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 12:31:45 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50847 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab2BORbo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 12:31:44 -0500
Received: by iacb35 with SMTP id b35so1706959iac.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 09:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fhJ2tGFohan8LW0MUDoSHe2JG7NnTfpmpRks5HPKHTY=;
        b=nB3WZ82ZDu1TKS6DsphDU6FkmhCL6FQKvBPG14P3/Fkdjf4wwSRh9ECDm+zt3HqR86
         jPZRCzbvQYWODtAMwQJu60dlsjL+ZcxMe/k/++x2LgEoE64DPIDzY4WaITXeiK6GPX+L
         KOtQoismHZz7RoWD5oJmdHnT8w2DulLllDcIA=
Received: by 10.43.134.199 with SMTP id id7mr34698906icc.21.1329327104080;
        Wed, 15 Feb 2012 09:31:44 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wn6sm25942786igb.3.2012.02.15.09.31.43
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 09:31:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190839>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Basic objects' format is pretty simple and (I think) well-known.
> However it's good that we document them. At least we can keep track o=
f
> the evolution of an object format. The commit object, for example,
> over the years has learned "encoding" and recently GPG signing.

Yes, I agree.

> This is just a draft text with a bunch of fixmes. But I'd like to hea=
r
> from the community if this is a worthy effort. If so, then whether
> git-cat-file is a proper place for it. Or maybe we put relevant text
> in commit-tree, write-tree and mktag, then refer to them in cat-file
> because cat-file can show raw objects.

About where to place this text, I am of two minds.

1. On one hand, from the user's perspective it would be most intuitive
to place it in a separate git-object(5) manual page.  That way,
gitrepository-layout(5), git-fsck(1), git-hash-object(1), the user
manual, and so on would all have one document to link to.

2. On the other hand, from a development perspective I suspect it
would be valuable to put it in the git-fsck(1) page, since that would
have two consequences:

 - when changing the documentation, this would provide a reminder to
   update fsck.c at the same time

 - when changing fsck.c, this would provide a reminder to update the
   documentation at the same time

Ok, (2) was tongue in cheek. :)  I believe this information belongs in
a dedicated page with a name like gitobject(5), and that you are right
to put it in user-visible documentation instead of hiding it in
Documentation/technical, since it is information needed if one is to
use "git hash-object -w" correctly.

Ok, on to the text itself.

[...]
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -100,6 +100,46 @@ for each object specified on stdin that does not=
 exist in the repository:
>  <object> SP missing LF
>  ------------
> =20
> +OBJECT FORMAT
> +-------------
> +
> +Tree object consists of a series of tree entries sorted in memcmp()
> +order by entry name.

Missing article ("A tree object", "The tree object", or "Each tree
object").  More importantly, the curious reader might want to know
whether a tree object is supposed to contain entries pointing to other
tree objects for subdirectories or whether the subdirectory's
information is included inline like in the index.

I guess I would expect something like (stealing from the user manual):

	TREE OBJECTS
	------------
	A tree object contains a list of entries, each with a mode,
	object type, object name, and filename, sorted by filename.  It
	represents the contents of a single directory tree.

	The object type may be a blob, representing the contents of a
	file, another tree, representing the contents of a subdirectory,
	or a commit (representing a subproject).  Since trees and blobs,
	like all other objects, are named by a hash of their contents,
	two trees have the same object name if and only if their
	contents (including, recursively, the contents of all
	subdirectories) are identical.  This allows git to quickly
	determine the differences between two related tree objects,
	since it can ignore any entries with identical object names.

	Note that the files all have mode 644 or 755: git actually only
	pays attention to the executable bit.

	Encoding
	~~~~~~~~
	Entries are of variable length and self-delimiting.  Each entry
	consists of

	- a POSIX file mode in octal representation
	- exactly one space (ASCII SP)
	- filename for the entry, as a NUL-terminated string
	- 20-byte binary object name

	The mode should be 100755 (executable file), 100644 (regular
	file), 120000 (symlink), 40000 (subdirectory), or 160000
	(subproject), with no leading zeroes.  Modes with one leading
	zero and the synonym 100664 for 100644 are also accepted for
	historical reasons.

	The filename may be an arbitrary nonempty string of bytes, as
	long as it contains no '/' or NUL character.

	The associated object must be a valid blob if the mode indicates
	a file or symlink, tree if it indicates a subdirectory, or
	commit if it indicates a subproject.  The blob associated to a
	symlink entry indicates the link target and its content not
	have any embedded NULs.

By the way, git fsck seems to tolerate the old "flat tree" format
(i.e., that condition is FSCK_WARN and not FSCK_ERROR), but I don't
see any code supporting it elsewhere in git.  Bug?

	Sorting
	~~~~~~~
	... no duplicates, sort order, etc ...

[...]
> +Tag object is ascii plain text in a format similar to email format
> +(RFC 822). It consists of a header and a body, separated by a blank
> +line.

The above description makes me worry that the reader might try some
things that are allowed by RFC 822: rearranging header fields,
continuation lines, and so on.

>        The header includes exactly four fields in the following order=
:
> +
> +1. "object" field, followed by SHA-1 in ascii of the tagged object
> +2. "type" field, followed by the type in ascii of the tagged object
> +   (either "commit", "tag", "blob" or "tree" without quotes,
> +   case-sensitive)
> +3. "tag" field, followed by the tag name
> +4. "tagger" field, followed by the <XXX, to be named>
> +
> +The tag body contains the tag's message and possibly GPG signature.

This part looks good.  Stealing from the user manual again, maybe:

	TAG OBJECTS
	-----------
	A tag object contains an object, object type, tag name, the name
	of the person ("tagger") who created the tag, and a message,
	which may contain a signature.

	------------------------------------------------
	$ git cat-file tag v1.5.0
	object 437b1b20df4b356c9342dac8d38849f24ef44f27
	type commit
	tag v1.5.0
	tagger Junio C Hamano <junkio@cox.net> 1171411200 +0000

	GIT 1.5.0
	-----BEGIN PGP SIGNATURE-----
	Version: GnuPG v1.4.6 (GNU/Linux)

	iD8DBQBF0lGqwMbZpPMRm5oRAuRiAJ9ohBLd7s2kqjkKlq1qqC57SbnmzQCdG4ui
	nLE/L9aUXdWeTFPron96DLA=3D
	=3D2E+0
	-----END PGP SIGNATURE-----
	------------------------------------------------

	More precisely, a tag contains at least five lines:

	1. "object", followed by a space, followed by the 40-character
	   textual object name of the tagged object
	2. "type" + SP + the type of the tagged object ("commit", "tag",
	   "blob", or "tree")
	3. "tag" + SP + the name of the tag
	4. "tagger" + SP + an ident string
	5. a blank line

	Any remaining text after these lines forms the tag message.

	The object field must point to a valid object of type indicated
	by the type field.  The tag name can be an arbitrary string
	without NUL bytes or embedded newlines; in practice it usually
	follows the restrictions described in git-check-ref-format(1).

[...]
> +
> +Commit object is in similar format to tag object. The commit body is
> +in plain text of the chosen encoding (by default UTF-8). The commit
> +header has the following fields in listed order

Same considerations apply here --- I'd suggest stealing text from the
commit-object section of the user manual and from commit logs.

Hope that helps,
Jonathan

> +
> +1. One "tree" field, followed by the commit's tree's SHA-1 in ascii
> +2. Zero, one or more "parent" field
> +3. One "author" field, in <XXX to be named> format
> +3. One "committer" field, in <XXX to be named> format
> +4. Optionally one "encoding" field, followed by the encoding used fo=
r
> +   commit body
> +5. GPG signature (fixme)
> +
> +More headers after these fields are allowed. Unrecognized header
> +fields must be kept untouched if the commit is rewritten. However, a
> +compliant Git implementation produces the above header fields only.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
