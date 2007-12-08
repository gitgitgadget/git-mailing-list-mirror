From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add status.relativePaths config variable
Date: Fri, 07 Dec 2007 23:34:14 -0800
Message-ID: <7vejdxy70p.fsf@gitster.siamese.dyndns.org>
References: <20071207165703.GA8889@sigill.intra.peff.net>
	<Pine.LNX.4.64.0712071853500.27959@racer.site>
	<4759996B.2000300@gmail.com>
	<20071207204937.GA20111@coredump.intra.peff.net>
	<20071207212607.GA11504@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 08 08:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0uD6-0000Hu-W8
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 08:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbXLHHea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 02:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbXLHHea
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 02:34:30 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:59543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbXLHHe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 02:34:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D89D1858;
	Sat,  8 Dec 2007 02:34:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB3E21857;
	Sat,  8 Dec 2007 02:34:16 -0500 (EST)
In-Reply-To: <20071207212607.GA11504@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 7 Dec 2007 16:26:07 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67520>

Jeff King <peff@peff.net> writes:

> The output of git-status was recently changed to output
> relative paths. Setting this variable to false restores the
> old behavior for any old-timers that prefer it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On Fri, Dec 07, 2007 at 03:49:37PM -0500, Jeff King wrote:
>
>> Personally, I don't like either the "../" or the "./", but I actually
>> think the relative paths are less readable than the full paths in
>> general.
>
> So here is a config option to turn it off; I don't think there should be
> any consistency problems, since git-status output is meant to be
> human-readable (and after all, we just changed it :) ).

I like the general idea (and suspect we might want to make it default to
false to retain the original behaviour, but I'd refrain from suggesting
it, to keep the user experience stable during the upcoming -rc period).

We'd need an update to git-status documentation to mention the variable.

> diff --git a/builtin-commit.c b/builtin-commit.c
> index 18c6323..04b3bf1 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -284,8 +284,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix)
>  {
>  	struct wt_status s;
>  
> -	wt_status_prepare(&s);
> -	s.prefix = prefix;
> +	wt_status_prepare(&s, prefix);

I have been wondering ever since receiving this patch if this is a good
interface change.  Was there a problem if instead:

	- The implementation of wt_status_prepare(&s) stays as before;

	- run_status(), after calling wt_status_prepare(&s), notices the
          configuration variable, and sets s.prefix conditionally;
