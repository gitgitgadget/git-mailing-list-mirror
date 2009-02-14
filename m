From: Jeff King <peff@peff.net>
Subject: Re: [topgit] tg update error
Date: Fri, 13 Feb 2009 21:24:36 -0500
Message-ID: <20090214022436.GC9907@coredump.intra.peff.net>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net> <20090212092558.GB21074@skywalker> <20090212125621.GB5397@sigill.intra.peff.net> <7veiy3l689.fsf@gitster.siamese.dyndns.org> <20090213182609.GB31860@coredump.intra.peff.net> <7vy6w93hdb.fsf@gitster.siamese.dyndns.org> <20090214020848.GA9907@coredump.intra.peff.net> <7vocx53gqw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, madduck@debian.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:26:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYAEJ-0007GI-9P
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbZBNCYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbZBNCYj
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:24:39 -0500
Received: from peff.net ([208.65.91.99]:42711 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753691AbZBNCYi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:24:38 -0500
Received: (qmail 27828 invoked by uid 107); 14 Feb 2009 02:24:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 21:24:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 21:24:36 -0500
Content-Disposition: inline
In-Reply-To: <7vocx53gqw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109806>

On Fri, Feb 13, 2009 at 06:16:23PM -0800, Junio C Hamano wrote:

> > Is there any reason to throw away the "must be in refs/" safety valve,
> > though? That was the actual patch I started with and solved my problem,
> > and the "tighten to refs/heads/" bit came from discussion. That is, I
> > think having a safety valve in symbolic-ref that matches
> > validate_headref is orthogonal to how tightly validate_headref matches.
> >
> > But yes, I obviously failed to run the test suite on the follow-up patch
> > I sent. The final test in t1401 would need to be reverted, as well.
> 
> Sure.

OK, here is the updated patch (that actually passes the test suite).

-- >8 --
Subject: [PATCH] symbolic-ref: allow refs/<whatever> in HEAD

Commit afe5d3d5 introduced a safety valve to symbolic-ref to
disallow installing an invalid HEAD. It was accompanied by
b229d18a, which changed validate_headref to require that
HEAD contain a pointer to refs/heads/ instead of just refs/.

As it turns out, topgit is using refs/top-bases/ in HEAD,
leading us to re-loosen (at least temporarily) the
validate_headref check made in b229d18a. This patch does the
corresponding loosening for the symbolic-ref safety check,
so that the two are in agreement once more.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-symbolic-ref.c  |    4 ++--
 t/t1401-symbolic-ref.sh |    5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index cafc4eb..6ae6bcc 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -45,8 +45,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		break;
 	case 2:
 		if (!strcmp(argv[0], "HEAD") &&
-		    prefixcmp(argv[1], "refs/heads/"))
-			die("Refusing to point HEAD outside of refs/heads/");
+		    prefixcmp(argv[1], "refs/"))
+			die("Refusing to point HEAD outside of refs/");
 		create_symref(argv[0], argv[1], msg);
 		break;
 	default:
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 569f341..7fa5f5b 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -27,11 +27,6 @@ test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
 '
 reset_to_sane
 
-test_expect_success 'symbolic-ref refuses non-branch for HEAD' '
-	test_must_fail git symbolic-ref HEAD refs/foo
-'
-reset_to_sane
-
 test_expect_success 'symbolic-ref refuses bare sha1' '
 	echo content >file && git add file && git commit -m one
 	test_must_fail git symbolic-ref HEAD `git rev-parse HEAD`
-- 
1.6.2.rc0.241.g088a
