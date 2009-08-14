From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 02:55:43 -0400
Message-ID: <20090814065543.GA7113@coredump.intra.peff.net>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
 <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
 <20090814052153.GA2881@coredump.intra.peff.net>
 <fabb9a1e0908132324td6869aydc752f67b95546f1@mail.gmail.com>
 <20090814063359.GA6898@coredump.intra.peff.net>
 <fabb9a1e0908132340n10da3e38kfab07ab2cff18c82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 08:55:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbqhc-0000Em-0e
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbZHNGzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 02:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754761AbZHNGzo
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:55:44 -0400
Received: from peff.net ([208.65.91.99]:54853 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754AbZHNGzn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 02:55:43 -0400
Received: (qmail 15366 invoked by uid 107); 14 Aug 2009 06:55:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 Aug 2009 02:55:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Aug 2009 02:55:43 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908132340n10da3e38kfab07ab2cff18c82@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125906>

On Thu, Aug 13, 2009 at 11:40:44PM -0700, Sverre Rabbelier wrote:

> > On the other hand, "--delete <ref>" introduces its own syntactic
> > problems.  [...]
> 
> It does indeed, and I don't think that's the way to go.

Hmm. Actually, looking at the code, we _already_ have a funny
two-element syntax:

  git push origin tag v1.6.1

which, AFAICT, is totally useless, as you can just push v1.6.1 directly.
I assume it's historical. I still think it's probably not a good idea to
introduce a similar "delete foo".

> > Perhaps saying that "--delete=<ref>" is equivalent to ":<ref>" would be
> > a reasonable way of adding just the syntactic sugar. [...]
> 
> That would work too I guess, although it would be technically more difficult.

Really? I was thinking something as simple as:

diff --git a/builtin-push.c b/builtin-push.c
index 67f6d96..aa3784c 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -44,6 +44,12 @@ static void set_refspecs(const char **refs, int nr)
 			strcat(tag, refs[i]);
 			ref = tag;
 		}
+		if (!prefixcmp("--delete=", ref)) {
+			struct strbuf deleted = STRBUF_INIT;
+			strbuf_addstr(&deleted, ":");
+			strbuf_addstr(&deleted, skip_prefix(ref, "--delete="));
+			ref = strbuf_detach(&deleted, NULL);
+		}
 		add_refspec(ref);
 	}
 }

which is even shorter than your patch, not needing a separate option
parser.

That being said, currently parseopt will complain about that, even after
the "remote" field; we would need to pass it
PARSE_OPT_STOP_AT_NON_OPTION.

> I don't think it's that confusing either, but it's hard to stumble
> upon, yes? When you're looking at the man page for git push it is
> easier to deduct that '--delete' is what you need, than ':master'.

I think you mean "deduce", but yes, I think we have seen people complain
about the syntax in the past. I'm not against fixing it; I just want to
make sure what we introduce doesn't make any new confusion.

-Peff
