From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: print in-body "From" only when needed
Date: Fri, 20 Sep 2013 15:12:26 -0400
Message-ID: <20130920191226.GB31170@sigill.intra.peff.net>
References: <20130920101626.GA21684@sigill.intra.peff.net>
 <xmqq61tvqrw6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 21:12:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN689-0002B7-88
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 21:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab3ITTMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 15:12:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:49445 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160Ab3ITTMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 15:12:36 -0400
Received: (qmail 2172 invoked by uid 102); 20 Sep 2013 19:12:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Sep 2013 14:12:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Sep 2013 15:12:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61tvqrw6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235079>

On Fri, Sep 20, 2013 at 11:17:45AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Commit a908047 taught format-patch the "--from" option,
> > which places the author ident into an in-body from header,
> > and uses the committer ident in the rfc822 from header.  The
> > documentation claims that it will omit the in-body header
> > when it is the same as the rfc822 header, but the code never
> > implemented that behavior.
> >
> > This patch completes the feature by comparing the two idents
> > and doing nothing when they are the same (this is the same
> > as simply omitting the in-body header, as the two are by
> > definition indistinguishable in this case). This makes it
> > reasonable to turn on "--from" all the time (if it matches
> > your particular workflow), rather than only using it when
> > exporting other people's patches.
> 
> This fix makes 100% sense to me under the assumption that the
> "--from" option is a good idea, but then it makes me wonder why we
> need the option in the first place.  What would break if we made
> pp->from_ident default to the value of GIT_COMMITTER_IDENT?

Anything consuming format-patch output that does not understand in-body
headers would be broken.

I think rebase would be safe, because it uses git-am under the hood, so
in theory it is a noop.

send-email would have to learn to parse the in-body header, for two
reasons:

  1. We cannot get rid of send-email's in-body header writing, because
     we would want to handle patches generated (or munged) outside of
     format-patch, and because send-email has its own "--from" option
     and sendemail.from configuration.

     If that config matches the committer, it should be a noop. If it
     doesn't, we have we have two cases:

       a. There is no in-body header. We promote the rfc822 header to an
          in-body one, and add our configured "from" as the rfc822
          header.

       b. There is an in-body header. We leave it intact, but throw away
          the current rfc822 header and replace it with our configured
          header.

  2. send-email does header magic like auto-adding cc's, and suppressing
     addresses found in other headers. It would need (at least) to pick
     out the author from the in-body header to cc.

The patch below turns the feature on all the time. There are test
breakages in in t9001, t3901, t4014, and t4013. The last 3 I think are
just cosmetic. t9001 has a ton of breakages around the header
suppressions, but I didn't analyze which ones were just "this should now
read 'committer' instead of 'author'" and which ones represented real
breakage.

So I think it should be possible to fix our internal consumers of
format-patch output to handle this. And certainly there are some
external consumers that would be made more happy (i.e., anything that is
planning to actually send the output as an email). But I'm a little wary
of external consumers that might get confused by it. I think we'd want
to flip it at a major version boundary, at least.

-Peff

---
diff --git a/builtin/log.c b/builtin/log.c
index 77d0f5f..77564fd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1235,6 +1235,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.no_inline = 1;
 	}
 
+	from = xstrdup(git_committer_info(IDENT_NO_DATE));
+
 	/*
 	 * Parse the arguments before setup_revisions(), or something
 	 * like "git format-patch -o a123 HEAD^.." may fail; a123 is
