From: Jeff King <peff@peff.net>
Subject: Re: Bug in git-filter-branch example
Date: Mon, 1 Feb 2010 07:43:45 -0500
Message-ID: <20100201124345.GA32532@coredump.intra.peff.net>
References: <557ea2711002010348m57aa31fesd1047cbe3f01cb0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ivo Anjo <knuckles@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 13:44:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbvdD-0001R5-4w
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 13:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab0BAMnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2010 07:43:49 -0500
Received: from peff.net ([208.65.91.99]:55052 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897Ab0BAMns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 07:43:48 -0500
Received: (qmail 24898 invoked by uid 107); 1 Feb 2010 12:43:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 01 Feb 2010 07:43:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Feb 2010 07:43:45 -0500
Content-Disposition: inline
In-Reply-To: <557ea2711002010348m57aa31fesd1047cbe3f01cb0b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138605>

On Mon, Feb 01, 2010 at 11:48:27AM +0000, Ivo Anjo wrote:

> =C2=A0=C2=A0=C2=A0 To move the whole tree into a subdirectory, or rem=
ove it from there:
>=20
> =C2=A0=C2=A0=C2=A0 git filter-branch --index-filter \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'g=
it ls-files -s | sed "s-\t-&newsubdir/-" |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIT_INDEX_FILE=3D$GIT_IND=
EX_FILE.new \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 git update-index --index-info &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
>=20
>=20
> The problem is with filenames that use complex utf8 (non-ascii?) char=
s:

Yes, that is definitely the problem. update-index unquotes its input, a=
s
you would expect, but the sed munging does not take the quote into
account. You can fix it by doing:

  sed "s-\t\"*-&newsubdir/-"

instead. Here is a patch to fix the documentation. I am slightly unsure
of whether it should be applied. These examples are supposed to be
simple and readable to help the user understand what the filters can do=
=2E
And this makes it somewhat less simple for the sake of a special case.
But at the same time, users are going to cut-and-paste these examples (=
I
know I have), and the special case is not _that_ special, especially fo=
r
non-English speakers. And having it in the example helps make people
aware that quoted paths are a reality.

So I think on balance it is probably better to fix it.

Note also that another way of "fixing" this would be to set
core.quotepath to false (which is something you probably want to do
anyway if you are using utf8 characters in your filenames). And I put
"fix" in quotes because you still may run across quoted paths, but they
will be much less common; you will only see them if you have control
characters or other insanity in your paths.

-- >8 --
Subject: [PATCH] docs: fix filter-branch example for quoted paths

If there is a quoted path, update-index will correctly
unquote it. However, we must take care to put our new prefix
inside the double-quote.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index cfaba2a..020028c 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -358,7 +358,7 @@ To move the whole tree into a subdirectory, or remo=
ve it from there:
=20
 ---------------------------------------------------------------
 git filter-branch --index-filter \
-	'git ls-files -s | sed "s-\t-&newsubdir/-" |
+	'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
 		GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
--=20
1.7.0.rc1.16.g21332.dirty
