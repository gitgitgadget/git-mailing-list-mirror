From: Jeff King <peff@peff.net>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 05:34:10 -0400
Message-ID: <20080731093410.GA21396@sigill.intra.peff.net>
References: <20080730150123.GB9758@atjola.homenet> <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com> <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org> <20080731072149.GA2304@sigill.intra.peff.net> <7v8wvi33ok.fsf@gitster.siamese.dyndns.org> <20080731082553.GA19522@sigill.intra.peff.net> <7v8wvizc16.fsf@gitster.siamese.dyndns.org> <20080731090348.GB20691@sigill.intra.peff.net> <20080731091515.GC12867@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 11:36:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOUZf-0003TM-8c
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 11:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167AbYGaJeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 05:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbYGaJeP
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 05:34:15 -0400
Received: from peff.net ([208.65.91.99]:4037 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755998AbYGaJeN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 05:34:13 -0400
Received: (qmail 22608 invoked by uid 111); 31 Jul 2008 09:34:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 05:34:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 05:34:10 -0400
Content-Disposition: inline
In-Reply-To: <20080731091515.GC12867@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90918>

[Pierre, you have the bogus MFT header that people are often complaining
about. Either I have to do extra work to fix the headers, or more people
end up in the To: field. I don't personally care about the latter, but
it seems that others organize their mail based on To versus Cc]

On Thu, Jul 31, 2008 at 11:15:15AM +0200, Pierre Habouzit wrote:

> --no-walk alters how add_pending_object_with_mode works, which is called
> by handle_revision_arg. IOW, <ref1> --no-walk <ref2> is not the same as
> --no-walk <ref1> <ref2>. IOW reference arguments and --no-walk ordering
> must be preserved, IOW --no-walk is a pseudo-argument like --all --tags
> or --remote are.

Ah, OK. Then that makes sense, then. And I definitely feel that the
patch I posted is the right thing to do, then. So here is a patch with
commit message. The commit message to patch ratio is ridiculous, but
obviously this fix took some thinking, so it seems best to document it.

-- >8 --
allow "non-option" revision options in parse_option-enabled commands

Commands which use parse_options but also call
setup_revisions must do their parsing in a two step process:

  1. first, they parse all options. Anything unknown goes to
     parse_revision_opt (which calls handle_revision_opt),
     which may claim the option or say "I don't recognize
     this"

  2. the non-option remainder goes to setup_revisions to
     actually get turned into revisions

Some revision options are "non-options" in that they must be
parsed in order with their revision counterparts in
setup_revisions. For example, "--all" functions as a
pseudo-option expanding to all refs, and "--no-walk" affects
refs after it on the command line, but not before. The
revision option parser in step 1 recognizes such options and
sets them aside for later parsing by setup_revisions.

However, the return value used from handle_revision_opt
indicated "I didn't recognize this", which was wrong. It
did, and it took appropriate action (even though that action
was just deferring it for later parsing). Thus it should
return "yes, I recognized this."

Previously, these pseudo-options generated an error when
used with parse_options parsers (currently just blame and
shortlog). With this patch, they should work fine, enabling
things like "git shortlog --all".

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index a843c42..eaa5572 100644
--- a/revision.c
+++ b/revision.c
@@ -1002,7 +1002,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
 	{
 		unkv[(*unkc)++] = arg;
-		return 0;
+		return 1;
 	}
 
 	if (!prefixcmp(arg, "--max-count=")) {
-- 
1.6.0.rc1.197.gc57ac6
