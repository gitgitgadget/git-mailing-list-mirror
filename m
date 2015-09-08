From: Jeff King <peff@peff.net>
Subject: Re: Bug: git-upload-pack will return successfully even when it can't
 read all references
Date: Tue, 8 Sep 2015 02:53:47 -0400
Message-ID: <20150908065347.GG26331@sigill.intra.peff.net>
References: <CACBZZX6ZYDEPrQorg=pVh734ua+x55SYoKKvSZ_h0GQaR=m+8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:54:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZCnA-0006E3-QT
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 08:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbbIHGxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 02:53:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:56136 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751464AbbIHGxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 02:53:50 -0400
Received: (qmail 20828 invoked by uid 102); 8 Sep 2015 06:53:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 01:53:50 -0500
Received: (qmail 19480 invoked by uid 107); 8 Sep 2015 06:53:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 02:53:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 02:53:47 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX6ZYDEPrQorg=pVh734ua+x55SYoKKvSZ_h0GQaR=m+8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277492>

On Mon, Sep 07, 2015 at 02:11:15PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> This turned out to be a pretty trivial filesystem error.
> refs/heads/master wasn't readable by the backup process, but some
> other stuff in refs/heads and objects/* was.
>
> [...]
>
> I wanted to check if this was a regression and got as far back as
> v1.4.3 with the same behavior before the commands wouldn't work
> anymore due to changes in the git config parsing code.

Right, it has basically always been this way. for_each_ref() silently
eats oddities or errors while reading refs. Calling for_each_rawref()
will include them, but we don't do it in most places; it would make
non-critical operations on a corrupted repo barf.  And it is difficult
to know what is "critical" inside the code. You might be calling
"upload-pack" to salvage what you can from a corrupted repo, or to make
a backup where you want to know what is corrupted and what is not.

Commit 49672f2 introduced a "ref paranoia" environment variable to let
you specify this (and robust backups was definitely one of the use case=
s
I had in mind). It's a little tricky to use with upload-pack because yo=
u
may be crossing an ssh boundary, but:

  git clone -u 'GIT_REF_PARANOIA=3D1 git-upload-pack' ...

should work.

With your case:

  $ git clone --no-local -u 'GIT_REF_PARANOIA=3D1 git-upload-pack' repo=
 repo-checkout
  Cloning into 'repo-checkout'...
  fatal: git upload-pack: not our ref 000000000000000000000000000000000=
0000000
  fatal: The remote end hung up unexpectedly

Without "--no-local" it behaves weirdly, but I would not recommend loca=
l
clones in general if you are trying to be careful. They optimize out a
lot of the safety checks, and we do things like copy the packed-refs
file wholesale.

And certainly the error message is not the greatest. upload-pack is not
checking for the REF_ISBROKEN flag, so it just dumps:

  0000000000000000000000000000000000000000 refs/heads/master

in the advertisement, and the client happily requests that object.
REF_PARANOIA is really just a band-aid to feed the broken refs to the
normal code paths, which typically barf on their own. :)

Something like this:

diff --git a/upload-pack.c b/upload-pack.c
index 89e832b..3c621a5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -731,6 +731,9 @@ static int send_ref(const char *refname, const stru=
ct object_id *oid,
 	if (mark_our_ref(refname, oid))
 		return 0;
=20
+	if (flag & REF_ISBROKEN)
+		warning("remote ref '%s' is broken", refname);
+
 	if (capabilities) {
 		struct strbuf symref_info =3D STRBUF_INIT;
=20
kind of helps, but the advertisement is too early for us to send
sideband messages. So it makes it to the user if the transport is local
or ssh, but not over git:// or http.

That's something we could do better with protocol v2 (we'll negotiate
capabilities before the advertisement).

-Peff
