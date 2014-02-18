From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] notes-utils: handle boolean notes.rewritemode
 correctly
Date: Tue, 18 Feb 2014 02:46:32 -0500
Message-ID: <20140218074632.GA29804@sigill.intra.peff.net>
References: <cover.1392565571.git.john@keeping.me.uk>
 <be9b384ec77fc39b939b8c5505862a6e1c641faa.1392565571.git.john@keeping.me.uk>
 <87txbzvxgq.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 08:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFfO3-0001GX-M4
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 08:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbaBRHqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 02:46:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:52480 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753573AbaBRHqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 02:46:35 -0500
Received: (qmail 17303 invoked by uid 102); 18 Feb 2014 07:46:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Feb 2014 01:46:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Feb 2014 02:46:32 -0500
Content-Disposition: inline
In-Reply-To: <87txbzvxgq.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242278>

On Sun, Feb 16, 2014 at 05:22:45PM +0100, David Kastrup wrote:

> Not really relevant to this patch, but looking at the output of
> 
> git grep config_error_nonbool
> 
> seems like a serious amount of ridiculousness going on.  The header
> shows
> 
> cache.h:extern int config_error_nonbool(const char *);
> cache.h:#define config_error_nonbool(s) (config_error_nonbool(s), -1)
> 
> and the implementation
> 
> config.c:#undef config_error_nonbool
> config.c:int config_error_nonbool(const char *var)

You could always look in the commit history:

  $ git log -S'#define config_error_nonbool' cache.h

or search the mailing list:

  http://thread.gmane.org/gmane.comp.version-control.git/211505

> Presumably this was done so that the uses of config_error_nonbool can be
> recognized as returning -1 unconditionally.

Yes, it helps prevent false positives in gcc's flow analysis
(specifically, -Wuninitialized warnings).

> But is that worth the obfuscation?

Yes?

> Why not let config_error_nonbool return -1 in the first place?

It originally did, but callers do not get to see the static return, so
they miss some analysis opportunities.

> It does not appear like any caller would call the function rather than
> the macro, so why declare the function as returning an int at all?

Because we don't use these macros on non-gnu compilers; they actually
see the real function return.

> And why give it the same name as the macro (risking human/computer
> confusion and requiring an explicit #undef for the definition or was
> that declaration?) instead of config_error_nonbool_internal or
> whatever else?

This particular case is simple, but see error() for another use of the
same technique which requires variadic macros, which are not available
everywhere. Callers want to say just "error(...)", so we have to name
the macro that. If we call the matching function "error_internal", then
non-gnu compilers would need a macro to convert "error(...)" to
"error_internal(...)". But they can't do so, because it would be a
variadic macro.

So you could adjust config_error_nonbool(), but not error(). But that
introduces its own confusion, because the technique is not applied
consistently.

I agree the #define is ugly. But it's confined to a small area, and it
does solve an actual problem.

-Peff
