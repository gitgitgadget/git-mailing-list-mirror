From: Jeff King <peff@peff.net>
Subject: Re: [topgit] tg update error
Date: Fri, 13 Feb 2009 13:26:09 -0500
Message-ID: <20090213182609.GB31860@coredump.intra.peff.net>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net> <20090212092558.GB21074@skywalker> <20090212125621.GB5397@sigill.intra.peff.net> <7veiy3l689.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, madduck@debian.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:27:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY2lH-0001kj-Rw
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 19:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbZBMS0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 13:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbZBMS0M
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 13:26:12 -0500
Received: from peff.net ([208.65.91.99]:60251 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbZBMS0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 13:26:12 -0500
Received: (qmail 25459 invoked by uid 107); 13 Feb 2009 18:26:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 13:26:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 13:26:09 -0500
Content-Disposition: inline
In-Reply-To: <7veiy3l689.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109772>

On Thu, Feb 12, 2009 at 01:01:42PM -0800, Junio C Hamano wrote:

> > Junio, I think we should probably revert b229d18 (and loosen
> > symbolic-ref's check to just "refs/"). Even if you want to argue that
> > topgit should be changed to handle this differently, we are still
> > breaking existing topgit installations, and who knows what other scripts
> > which might have relied on doing something like this.
> 
> I'm Ok with the revert (and I agree it is absolutely the right thing to do
> at least for the short term).

It looks like you have already pushed out the revert. But I think we
need this on top to make topgit work correctly.

-- >8 --
Subject: [PATCH] symbolic-ref: allow refs/<whatever> in HEAD

Commit afe5d3d5 introduced a safety valve to symbolic-ref to
disallow installing an invalid HEAD. It was accompanied by
b229d18a, which changed validate_headref to require that
HEAD contain a pointer to refs/heads/ instead of just refs/.
Therefore, the safety valve also checked for refs/heads/.

As it turns out, topgit is using refs/top-bases/ in HEAD,
leading us to re-loosen (at least temporarily) the
validate_headref check made in b229d18a. This patch does the
corresponding loosening for the symbolic-ref safety valve,
so that the two are in agreement once more.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-symbolic-ref.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
-- 
1.6.2.rc0.241.g088a
