From: Carl Worth <cworth@cworth.org>
Subject: Re: Make "git am" properly unescape lines matching ">>*From "
Date: Tue, 08 Jun 2010 13:47:39 -0700
Message-ID: <87d3w1jlp0.fsf@yoom.home.cworth.org>
References: <87hbldjo0s.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 22:47:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5iG-00087r-18
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405Ab0FHUrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 16:47:51 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:43641 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab0FHUrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 16:47:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 703204196F0;
	Tue,  8 Jun 2010 13:47:50 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKFZ2ZTiiT3l; Tue,  8 Jun 2010 13:47:40 -0700 (PDT)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 14C4E431FC1;
	Tue,  8 Jun 2010 13:47:40 -0700 (PDT)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id C079F568FB5; Tue,  8 Jun 2010 13:47:39 -0700 (PDT)
In-Reply-To: <87hbldjo0s.fsf@yoom.home.cworth.org>
User-Agent: Notmuch/0.3.1-53-gd64d0cc (http://notmuchmail.org) Emacs/23.1.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148713>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jun 2010 12:57:23 -0700, Carl Worth <cworth@cworth.org> wrote:
> I'm adding support to notmuch[1] to more easily pipe a thread full of
> But I noticed that "git am" wasn't removing any of these added '>'
> characters, so I was getting corrupted commit messages.

I've also noticed that format-patch is generating bogus mbox files
without any escaping. (The only way it gets away with this is that
mailsplit only treats "From " lines as separators if they end with
something that looks quite a bit like the output of asctime.)

This does mean that without changing format-patch, the patched "git am"
could corrupt a commit message. This could happen if the commit message
originally contained a line matching "^From " which would previously be
passed through directly but will now be un-escaped to "From ".

This does seem less likely than a message containing a line matching
"^From " (which is the case that gets corrupted with an unpatched "git
am") so one option would be to ignore this, and apply my patch. That's
what I recommend for now.

Alternately, we could fix format-patch to add the correct, (and
reversible), escaping that is now expected by git-am.

Any attempt to add escaping to format-patch should recognize that many
users use the output of format-patch directly as content handed to their
MUA. Such users will *not* want escaping, (they are effectively treating
the format-patch output as a bare email message, not an mbox).

So if someone were to attempt this, I'd suggest first changing
format-patch to actually generate bare email messages when generating
files containing only a single message. This is instead of the invalid
mbox files it is generating now. This would be as simple as not emitting
the initial "From " line.

Then, when generating an actual mbox with multiple files, format-patch
should do the correct escaping, (which is now expected by "git am"), and
all of these cases of potential commit-message corruption should be
eliminated.

The other thing that would need to be fixed in this approach is to fix
"git send-email" to do the right thing with a bare email message. From a
quick glance at the code, it appears to be looking for an initial "From
" line, even though it doesn't appear to handle an mbox with multiple
messages. It looks for this line to distinguish an email message from
some custom "send lots of email" format. It should be simple to instead
distinguish a bare email message from the "send lots of email" format by
a first line which looks like an email header.

=2DCarl

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMDqxr6JDdNq8qSWgRAn8vAJ9QehvLWIwlyAk3XpD6rzZn1fvSxACeKL0C
PyQGnYBfDtKnzCfgMvfh7JQ=
=AvHB
-----END PGP SIGNATURE-----
--=-=-=--
