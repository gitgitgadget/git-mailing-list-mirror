From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 8 Apr 2011 16:54:37 -0400
Message-ID: <20110408205437.GB16540@sigill.intra.peff.net>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
 <1302274674-4231-1-git-send-email-asedeno@mit.edu>
 <7vmxk033ic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:54:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Iha-0002kY-Od
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841Ab1DHUyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 16:54:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59088
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401Ab1DHUyk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 16:54:40 -0400
Received: (qmail 5044 invoked by uid 107); 8 Apr 2011 20:55:28 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 16:55:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 16:54:37 -0400
Content-Disposition: inline
In-Reply-To: <7vmxk033ic.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171163>

On Fri, Apr 08, 2011 at 01:13:47PM -0700, Junio C Hamano wrote:

> A Tangent.
>=20
> >> X-Mailer: git-send-email 1.7.4.2.1.gd6f1f
> >> In-Reply-To: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
>=20
> This is not about this particular patch, but the From: address
> git-send-email generates for you does not seem to quote the human rea=
dable
> part, even though the name has a "." in it.
>=20
> Your mails seem to reach the recipients fine, but I saw my reply to y=
ou
> bounce, because "To:" or "Cc:" in my reply end up having the "R." par=
t not
> quoted, like this:
>=20
>   (wrong)  To: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>  (correct) To: "Alejandro R. Sede=C3=B1o" <asedeno@mit.edu>

Hmm. His case has an extra level of confusion, though, because the
non-ascii characters all need rfc2047 encoding. So two emails I've seen
from him have:

  From: =3D?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg=3D=3D?=3D <asedeno@M=
IT.EDU>
  From: =3D?UTF-8?q?Alejandro=3D20R=3D2E=3D20Sede=3DC3=3DB1o?=3D <asede=
no@mit.edu>

where the first is from Icedove (i.e., Thunderbird) and the second is
from git-send-email.

The first one contains double-quotes embedded in the encoded portion.
The second one (send-email) does not.

But I'm not clear on if that is necessary. I thought that rfc2047 could
only encode a "word" in the "phrase" portion in an address header,
meaning the parsing should be unambiguous.

That being said, I think we are not quoting in the non-rfc2047 case,
anyway, and that is a bug. rfc5322 says this (section 4.1, Miscellaneou=
s
obsolete tokens):

  Note: The "period" (or "full stop") character (".") in obs-phrase is
  not a form that was allowed in earlier versions of this or any other
  specification.  Period (nor any other character from specials) was no=
t
  allowed in phrase because it introduced a parsing difficulty
  distinguishing between phrases and portions of an addr-spec (see
  section 4.4).  It appears here because the period character is
  currently used in many messages in the display-name portion of
  addresses, especially for initials in names, and therefore must be
  interpreted properly.

which recognizes this situation. But being in the obsolete section, I
think it is saying "you still need to interpret these, but don't
generate them". IOW, we should still be generating quotes now.

I think format-patch is totally lacking in this type of quoting. If I
do:

  $ git init
  $ git config user.name '<bogus> with "quotes"'
  $ echo contents >foo && git add . && git commit -m foo
  $ git format-patch --stdout --root
  ...
  From: bogus with "quotes <peff@peff.net>

So some of my magic characters are just stripped, and some of them get
included, making the output bogus (the stripping of <> actually happens
within git, so the commit itself is missing them).

Not that I think a name like that is sane, but probably we should be
double-quoting properly anyway, and then the "." case would just fall
out.

-Peff
