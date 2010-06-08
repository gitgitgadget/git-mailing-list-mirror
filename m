From: Carl Worth <cworth@cworth.org>
Subject: Re: Make "git am" properly unescape lines matching ">>*From "
Date: Tue, 08 Jun 2010 14:52:34 -0700
Message-ID: <87typdi44d.fsf@yoom.home.cworth.org>
References: <87hbldjo0s.fsf@yoom.home.cworth.org> <4C0EAD00.8000706@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 23:52:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM6j5-0005AI-8P
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 23:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437Ab0FHVwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 17:52:46 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:40271 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab0FHVwp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 17:52:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 604384196F2;
	Tue,  8 Jun 2010 14:52:45 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9EuXT5KaaFcS; Tue,  8 Jun 2010 14:52:35 -0700 (PDT)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id DCA33431FC1;
	Tue,  8 Jun 2010 14:52:34 -0700 (PDT)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id 901A2568FB6; Tue,  8 Jun 2010 14:52:34 -0700 (PDT)
In-Reply-To: <4C0EAD00.8000706@zytor.com>
User-Agent: Notmuch/0.3.1-53-gd64d0cc (http://notmuchmail.org) Emacs/23.1.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148724>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jun 2010 13:50:08 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:
> On 06/08/2010 12:57 PM, Carl Worth wrote:
> > When I did that, I was careful to escape lines from the bodies of email
> > messages that begin with zero or more '>' characters followed
> > immediately by "From " (From_ lines) by adding an initial '>'. [2]
...
> The problem with that is that it is not universally applied.

Right. And since I can't fix this universe, I'd like to at least start
with getting notmuch and git to use the same thing. Currently, git is
using a non-standard not-quite-safe mbox format while notmuch doesn't
yet emit anything like mbox. So we have a nice opportunity to fix these
two projects to at least work well together, (if we can agree on a
format).

> As far as I can tell, the Content-Length: is the most reliably handled
> format and probably is what we should use.  This is the "mboxcl2" format
> in your list.[*]  Unfortunately "mboxcl2" and "mboxrd" cannot be
> distinguished from each other by inspection, which is a major defect of
> both formats.

What do you mean by "most reliably handled format"?

Of the four mbox formats listed on the page I cited[*], "mboxo" and
"mboxcl" are easy to discard as they both irreversibly corrupt messages.

That leaves both "mboxrd" and "mboxcl2" as candidates. Either of these
formats is reliable if both the reader and writer use the same
format. When the reader and writer don't agree, then there are problems
as follows ("W:" indicates writing, "R:" indicates reading expecting a
particular format):

W:mboxrd  then R:mboxcl2 -> Reader may corrupt by failing to remove '>'
			    Reader must give up/guess without CL headers
			    Guessing is at least unlikely to mis-split messages

W:mboxcl2 then R:mboxrd  -> Reader may corrupt by erroneously removing '>'
			    Reader may mis-split messages on "From " in content

I preferred to implement mboxrd over mboxcl2 for several reasons:

  1. The mboxrd writer implementation is much simpler. This format
     affords a simple streaming implementation where mboxcl2 requires
     knowing the length of the message in advance.

  2. The mboxrd format is robust in the face of file changes that
     invalidate the Content-Length headers, (for example, a person
     can hand-edit an mboxrd file without invalidating it, but cannot do
     the same with an mboxcl2 file).

  3. The mboxrd reader implementation is much simpler. An mboxcl2 reader
     necessarily has special-cases that an mboxrd implementation does
     not. What to do if there is no Content-Length header? What to do if
     the Content-Length header appears wrong? etc. Recovery code for
     these cases might well be to fallback to something like an mboxrd
     implementation, which demonstrates the increased complexity here.

As can be seen in my patch, doing an mboxrd reader in git-mailsplit was
quite simple. An mboxcl2 reader would be quite a bit more complicated,
but with no actual benefit in reliability, (assuming that the reader
matches the writer).

> The statement that "the entire "mbox" family of mailbox formats is
> gradually becoming irrelevant, and of only historical interest" is also
> pretty silly -- mbox is still the preferred format for moving groups of
> email from MUA to MUA, even if it is no longer used for active live
> spool storage.  But, of course, you knew that already.

Indeed. Though I was surprised to recently find that postfix does still
by default deliver to /var/mail/$user in "mboxo" format (ugh).

=2DCarl

[*] http://homepage.ntlworld.com/jonathan.deboynepollard/FGA/mail-mbox-form=
ats.html

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMDrui6JDdNq8qSWgRAlO8AJwMStglE8i8BBujq8rSxJsv4CwXzwCgqJAZ
RDEfKwCvVTpx3MbLK1bqmMc=
=Qrnm
-----END PGP SIGNATURE-----
--=-=-=--
