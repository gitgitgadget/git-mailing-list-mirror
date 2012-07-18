From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: respect --no-ext-diff with typechange
Date: Wed, 18 Jul 2012 02:23:29 -0400
Message-ID: <20120718062329.GA12942@sigill.intra.peff.net>
References: <000301cd63b2$e39a2130$aace6390$@vrana.cz>
 <20120717041603.GD20945@sigill.intra.peff.net>
 <000e01cd6481$bbd63970$3382ac50$@vrana.cz>
 <7v7gu1y7tg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Vrana <jakub@vrana.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 08:23:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrNfd-0001Iv-A9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 08:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322Ab2GRGXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 02:23:33 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36794
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab2GRGXc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 02:23:32 -0400
Received: (qmail 15285 invoked by uid 107); 18 Jul 2012 06:23:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 02:23:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 02:23:29 -0400
Content-Disposition: inline
In-Reply-To: <7v7gu1y7tg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201652>

On Tue, Jul 17, 2012 at 10:08:59PM -0700, Junio C Hamano wrote:

> The impression I got from Peff's review was that the problem
> description in the proposed commit log message did not describe the
> reality at all, and the added three lines did not do what the
> message implied they do.  So I do not see how it can be acceptable
> by anybody.
> 
> It also needs a test to protect this fix from being broken by other
> people in the future.

Yeah, exactly.

> -- >8 --
> Subject: diff: correctly disable external_diff with --no-ext-diff
> 
> Upon seeing a type-change filepair, "diff --no-ext-diff" does not
> show the usual "deletion followed by addition" split patch and does
> not run the external diff driver either.
> 
> This is because the logic to disable external diff was placed at a
> wrong level in the callchain.  run_diff_cmd() decides to show the
> split patch only when external diff driver is not configured or
> specified via GIT_EXTERNAL_DIFF environment, but this is done before
> checking if --no-ext-diff was given.  To make things worse,
> run_diff_cmd() checks --no-ext-diff and disables the output for such
> a filepair completely, as the callchain below it (e.g. builtin_diff)
> does not want to handle typechange filepairs.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Your patch looks good to me.

> ---
>  * The use of userdiff_find_by_path() in run_diff_cmd() may be iffy;
>    it is probably OK to override diff.external with a more specific
>    per-path configuration, but I think an external diff specified by
>    the GIT_EXTERNAL_DIFF environment may want to trump the
>    configured per-path one, as an environment is a stronger one-shot
>    request.

I think this date all the way back to f1af60b (Support 'diff=pgm'
attribute, 2007-04-22). There's a tradeoff here; usually environment
variables trump config, but you end up using a large hammer (here is how
to diff _all_ files externally) to hit a small nail (here is how to diff
_just_ this file).  I suspect it isn't that big a problem in practice
because people tend to use either one mechanism or the other.

The most sensible thing to me is probably $GIT_EXTERNAL_DIFF, followed
by attributes, followed by diff.external. That uses the more specific
diff pulled from the on-disk config, but allows you to do one-shot overrides
with the environment as long as you are careful to restrict your command
(e.g., "GIT_EXTERNAL_DIFF=foo-differ git diff -- file.foo").

>    But this patch is not about changing that semantics, so I left it
>    as-is.

Sounds sensible.

-Peff
