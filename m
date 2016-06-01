From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 1 Jun 2016 03:04:26 -0400
Message-ID: <20160601070425.GA13648@sigill.intra.peff.net>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
 <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
 <20160601023159.GA5411@sigill.intra.peff.net>
 <20160601033139.GB5411@sigill.intra.peff.net>
 <20160601034413.GC5411@sigill.intra.peff.net>
 <20160601053325.GA20797@sigill.intra.peff.net>
 <20160601054048.GB20797@sigill.intra.peff.net>
 <xmqqshwx1k0p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 09:04:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b80Ch-0007hb-Da
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 09:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbcFAHEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 03:04:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:47018 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752209AbcFAHEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 03:04:30 -0400
Received: (qmail 23016 invoked by uid 102); 1 Jun 2016 07:04:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 03:04:29 -0400
Received: (qmail 30778 invoked by uid 107); 1 Jun 2016 07:04:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 03:04:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 03:04:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqshwx1k0p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296060>

On Tue, May 31, 2016 at 11:49:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > OK, last email tonight, I promise.
> >
> > Here's the subshell version. I'm a little embarrassed not to have
> > thought of it sooner (though the other one was a fun exercise).
> >
> > 	test_env () {
> > 		(
> > 			while test $# -gt 0
> > 			do
> > 				case "$1" in
> > 				*=3D*)
> > 					eval "${1%%=3D*}=3D\${1#*=3D}"
>=20
> Is this an elaborate way to say 'eval "$1"', or is there anything
> more subtle going on?

Notice that the value half isn't expanded until we get inside the eval.
So:

  $ good() { eval "${1%%=3D*}=3D\${1#*=3D}"; }
  $ bad() { eval "$1"; }
  $ good foo=3D"funny variable"; echo $foo
  funny variable
  $ bad foo=3D"funny variable"
  bash: variable: command not found

> > 				*)
> > 					"$@"
> > 					exit
>=20
> ... or 'exec "$@"'

You can't exec a function, AFAIK (and that was the point of this
exercise).

> > 		)
> > 	}
>=20
> You can dedent the whole thing and remove the outermost {} pair.

True. I didn't know about that until recently. Is it portable
everywhere?

Here's the patch I wrote up earlier (but was too timid to send out afte=
r
my barrage of emails :) ).

It doesn't have the dedent, but I don't mind if you want to tweak it.

-- >8 --
Subject: test-lib: add in-shell "env" replacement

The one-shot environment variable syntax:

  FOO=3DBAR some-program

is unportable when some-program is actually a shell
function, like test_must_fail (on some shells FOO remains
set after the function returns, and on others it does not).

We sometimes get around this by using env, like:

  test_must_fail env FOO=3DBAR some-program

But that only works because test_must_fail's arguments are
themselves a command which can be run. You can't run:

  env FOO=3DBAR test_must_fail some-program

because env does not know about our shell functions. So
there is no equivalent for test_commit, for example, and one
must resort to:

  (
    FOO=3DBAR
    export FOO
    test_commit
  )

which is a bit verbose.  Let's add a version of "env" that
works _inside_ the shell, by creating a subshell, exporting
variables from its argument list, and running the command.

Its use is demonstrated on a currently-unportable case in
t4014.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4014-format-patch.sh |  2 +-
 t/test-lib-functions.sh | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 8049cad..805dc90 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1072,7 +1072,7 @@ test_expect_success '--from omits redundant in-bo=
dy header' '
 '
=20
 test_expect_success 'in-body headers trigger content encoding' '
-	GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc" test_commit exotic &&
+	test_env GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc" test_commit exotic=
 &&
 	test_when_finished "git reset --hard HEAD^" &&
 	git format-patch -1 --stdout --from >patch &&
 	cat >expect <<-\EOF &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3978fc0..48884d5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -939,3 +939,25 @@ mingw_read_file_strip_cr_ () {
 		eval "$1=3D\$$1\$line"
 	done
 }
+
+# Like "env FOO=3DBAR some-program", but run inside a subshell, which =
means
+# it also works for shell functions (though those functions cannot imp=
act
+# the environment outside of the test_env invocation).
+test_env () {
+	(
+		while test $# -gt 0
+		do
+			case "$1" in
+			*=3D*)
+				eval "${1%%=3D*}=3D\${1#*=3D}"
+				eval "export ${1%%=3D*}"
+				shift
+				;;
+			*)
+				"$@"
+				exit
+				;;
+			esac
+		done
+	)
+}
--=20
2.9.0.rc0.174.g479a78d
