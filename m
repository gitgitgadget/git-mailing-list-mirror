From: Jeff King <peff@peff.net>
Subject: [PATCH] Revert "completion: fix shell expansion of items"
Date: Tue, 25 Sep 2012 00:31:19 -0400
Message-ID: <20120925043119.GA6208@sigill.intra.peff.net>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
 <20120920014608.GA27782@sigill.intra.peff.net>
 <20120920181152.GA4689@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 06:31:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGMo0-000189-LD
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 06:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2IYEbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 00:31:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57619 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab2IYEbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 00:31:21 -0400
Received: (qmail 10941 invoked by uid 107); 25 Sep 2012 04:31:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 25 Sep 2012 00:31:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2012 00:31:19 -0400
Content-Disposition: inline
In-Reply-To: <20120920181152.GA4689@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206345>

On Thu, Sep 20, 2012 at 08:11:52PM +0200, SZEDER G=C3=A1bor wrote:

> > > Solves the original problem for me.
> >=20
> > Me too. Thanks.
>=20
> While it solves the original problem, it seems to break refs
> completion, as demonstrated by the following POC test:
>=20
>=20
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 92d7eb47..fab63b95 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -228,4 +228,11 @@ test_expect_success 'general options plus comman=
d' '
>  	test_completion "git --no-replace-objects check" "checkout "
>  '
> =20
> +test_expect_success 'basic refs completion' '
> +	touch file &&
> +	git add file &&
> +	git commit -m initial &&
> +	test_completion "git branch m" "master "
> +'
> +

Yeah, doing "git checkout jk/<tab>" is not working at all, and I notice=
d
the buggy commit is on the maint track, but has not yet been released.
I'm not sure of the solution, but I think we should do this in the
meantime:

-- >8 --
Subject: Revert "completion: fix shell expansion of items"

This reverts commit 25ae7cfd19c8f21721363c64163cd5d9d1135b20.

That patch does fix expansion of weird variables in some
simple tests, but it also seems to break other things, like
expansion of refs by "git checkout".

While we're sorting out the correct solution, we are much
better with the original bug (people with metacharacters in
their completions occasionally see an error message) than
the current bug (ref completion does not work at all).

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/completion/git-completion.bash | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5a5b5a0..d743e56 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -225,13 +225,6 @@ fi
 fi
 fi
=20
-# Quotes the argument for shell reuse
-__git_quote()
-{
-	local quoted=3D${1//\'/\'\\\'\'}
-	printf "'%s'" "$quoted"
-}
-
 # Generates completion reply with compgen, appending a space to possib=
le
 # completion words, if necessary.
 # It accepts 1 to 4 arguments:
@@ -268,7 +261,7 @@ __gitcomp_nl ()
 __gitcomp_nl ()
 {
 	local IFS=3D$'\n'
-	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$(__git_quote "$1")=
" -- "${3-$cur}"))
+	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}")=
)
 }
=20
 __git_heads ()
--=20
1.7.12.1.17.g7286916
