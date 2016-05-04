From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 17:44:12 -0400
Message-ID: <20160504214412.GA25237@sigill.intra.peff.net>
References: <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
 <5729DF25.7030503@ramsayjones.plus.com>
 <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
 <xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
 <20160504192516.GD21259@sigill.intra.peff.net>
 <xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
 <20160504200635.GA22787@sigill.intra.peff.net>
 <xmqq8tzpfrt0.fsf@gitster.mtv.corp.google.com>
 <20160504213149.GA22828@sigill.intra.peff.net>
 <xmqq4madfqxs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:44:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4ah-00041Q-Lu
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbcEDVoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:44:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:34262 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753873AbcEDVoP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:44:15 -0400
Received: (qmail 6424 invoked by uid 102); 4 May 2016 21:44:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 17:44:14 -0400
Received: (qmail 14376 invoked by uid 107); 4 May 2016 21:44:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 17:44:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 17:44:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4madfqxs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293599>

On Wed, May 04, 2016 at 02:34:23PM -0700, Junio C Hamano wrote:

> Third time's a charm, perhaps?
>  
> -- >8 --
> Subject: [PATCH] ci: validate "gitlink:" in documentation
> 
> It is easy to add incorrect "linkgit:<page>[<section>]" references
> to our documentation suite.  Catch these common classes of errors:
> 
>  * Referring to Documentation/<page>.txt that does not exist.
> 
>  * Referring to a <page> outside the Git suite.  In general, <page>
>    must begin with "git".
> 
>  * Listing the manual <section> incorrectly.  The first line of the
>    Documentation/<page>.txt must end with "(<section>)".
> 
> with a new script "ci/lint-gitlink", and drive it from "make check-docs".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

This looks good to me. Two minor nits that may not be worth addressing:

> +lint-docs::
> +	$(QUIET_LINT)$(foreach txt,$(patsubst %.html,%.txt,$(DOC_HTML)), \
> +	../ci/lint-gitlink $(txt))
> +

This dependency feels funny. Wouldn't CI want to invoke this as:

  make -C Documentation lint-docs

IOW, Documentation owns the script (just like t/ owns its own lint
scripts like check-non-portable-shell.pl), and CI always just triggers
the make-driven checks, just as a normal developer would?

> +sub lint {
> +	my ($file) = @_;
> +	open my $fh, "<", $file
> +		or return;
> +	while (<$fh>) {
> +		my $where = "$file:$.";
> [... actual linting of line ...]
> +}
> +
> +for (@ARGV) {
> +	lint($_);
> +}

The usual perl way here would be:

  while(<>) {
	my $where = "$ARGV:$.";
	... actual linting of line ...
  }

where "<>" automagically reads from files on the command-line or stdin
if none were specified (and sets $ARGV as appropriate). But maybe you
prefer not to handle the stdin case (it is a benefit sometimes, but an
annoyance if you accidentally end up with an empty file list).

-Peff
