From: Jeff King <peff@peff.net>
Subject: Re: [BUG] 'git merge --quiet' is not always quiet
Date: Thu, 2 Apr 2015 17:39:52 -0400
Message-ID: <20150402213952.GB22988@peff.net>
References: <CADwUm8do1+2aAqSnwMmViTCwA9jpAZM21DtRP9YiniVtCenFKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carl =?utf-8?B?TcOkc2Fr?= <cmasak@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 23:40:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdmqJ-0001Iz-SY
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 23:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbbDBVj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2015 17:39:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:41609 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751066AbbDBVjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 17:39:55 -0400
Received: (qmail 26811 invoked by uid 102); 2 Apr 2015 21:39:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 16:39:54 -0500
Received: (qmail 16083 invoked by uid 107); 2 Apr 2015 21:40:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 17:40:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2015 17:39:52 -0400
Content-Disposition: inline
In-Reply-To: <CADwUm8do1+2aAqSnwMmViTCwA9jpAZM21DtRP9YiniVtCenFKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266682>

On Thu, Apr 02, 2015 at 02:42:30PM +0200, Carl M=C3=A4sak wrote:

> In the following session, a 'git merge' command shows some output eve=
n
> with the '--quiet' flag supplied.
>=20
>     ~/tmp $ git init example
>     Initialized empty Git repository in /tmp/example/.git/
>     ~/tmp $ cd example/
>     ~/tmp/example $ git commit --allow-empty -m'initial commit'
>     [master (root-commit) a7329b5] initial commit
>     ~/tmp/example $ git checkout -b b1
>     Switched to a new branch 'b1'
>     ~/tmp/example $ git commit --allow-empty -m'commit on branch'
>     [b1 d15e5ac] commit on branch
>     ~/tmp/example $ git checkout master
>     Switched to branch 'master'
>     ~/tmp/example $ git merge --quiet --no-ff --no-edit b1
>     Already up-to-date!
>     ~/tmp/example $
>=20
> My expectation is that '--quiet' would suppress all output, even this=
 one.

It looks like we end up calling into merge-recursive here, but the
"--quiet" flag is not passed down. This patch seems to fix it for me.

-- >8 --
Subject: merge: pass verbosity flag down to merge-recursive

This makes "git merge --quiet" really quiet when we call
into merge-recursive.

Note that we can't just pass our flag down as-is; the two
parts of the code use different scales. We center at "0" as
normal for git-merge (with "--quiet" giving a negative
value), but merge-recursive uses "2" as its center.  This
patch passes a negative value to merge-recursive rather than
"1", though, as otherwise the user would have to use "-qqq"
to squelch all messages (but the downside is that the user
cannot distinguish between levels 0-2 if without resorting
to the GIT_MERGE_VERBOSITY variable).

We may want to review and renormalize the message severities
in merge-recursive, but that does not have to happen now.
This is at least in improvement in the sense that we are
respecting "--quiet" at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3b0f8f9..068a83b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -684,6 +684,10 @@ static int try_merge_strategy(const char *strategy=
, struct commit_list *common,
 			o.subtree_shift =3D "";
=20
 		o.renormalize =3D option_renormalize;
+		if (verbosity < 0)
+			o.verbosity =3D verbosity;
+		else if (verbosity > 0)
+			o.verbosity +=3D verbosity;
 		o.show_rename_progress =3D
 			show_progress =3D=3D -1 ? isatty(2) : show_progress;
=20
--=20
2.4.0.rc0.363.gf9f328b
