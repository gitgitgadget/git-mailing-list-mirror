From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] ls-remote: use parse-options api
Date: Sun, 17 Jan 2016 09:44:09 -0500
Message-ID: <20160117144409.GA15519@sigill.intra.peff.net>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453028643-13978-4-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 15:44:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKoZ0-0007g1-9S
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 15:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbcAQOoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 09:44:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:55078 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752327AbcAQOoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 09:44:13 -0500
Received: (qmail 5250 invoked by uid 102); 17 Jan 2016 14:44:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Jan 2016 09:44:13 -0500
Received: (qmail 1830 invoked by uid 107); 17 Jan 2016 14:44:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Jan 2016 09:44:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2016 09:44:09 -0500
Content-Disposition: inline
In-Reply-To: <1453028643-13978-4-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284256>

On Sun, Jan 17, 2016 at 12:04:01PM +0100, Thomas Gummerer wrote:

> Currently ls-remote uses a hand rolled parser for the its command line
> arguments.  Use the parse-options api instead of the hand rolled parser
> to simplify the code and make it easier to add new arguments.  In
> addition this improves the help message.

Sounds like a good idea.

> +	int tags = 0, heads = 0, refs = 0;
> [...]
> +		OPT_SET_INT('t', "tags", &tags, N_("limit to tags"), REF_TAGS),
> +		OPT_SET_INT('h', "heads", &heads, N_("limit to heads"), REF_HEADS),
> +		OPT_SET_INT(0, "refs", &refs, N_("no magic fake tag refs"), REF_NORMAL),
> [...]
> +	flags = tags | heads | refs;

Is there any reason these can't be:

  OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
  OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
  OPT_BIT(0, "refs", &flags, N_("no magic fake tag refs"), REF_NORMAL),

to make their interaction more obvious? I wondered if there was
anything tricky going on (like some of the bits for each option
overlapping), but I didn't see anything.

> +		OPT_SET_INT(0, "refs", &refs, N_("no magic fake tag refs"), REF_NORMAL),

I imagine you took the help string from the comment in check_ref. We can
probably come up with something more descriptive for the user-facing
string. :) How about "do not show peeled tags"?

> +		OPT_STRING(0, "upload-pack", &uploadpack, N_("exec"),
> +			   N_("path of git-upload-pack on the remote host")),
> +		OPT_STRING(0, "exec", &uploadpack, N_("exec"),
> +			   N_("path of git-upload-pack on the remote host")),

Since these are redundant with each other, should we declare one
"hidden" to not appear in "-h" output?

> +		OPT_SET_INT(0, "get-url", &get_url,
> +			    N_("take url.<base>.insteadOf into account"), 1),

Should this one be OPT_BOOL? I think "--no-get-url" works either way (it
resets the variable to 0), but OPT_BOOL communicates the intent more
clearly, I think.

> +		OPT_SET_INT(0, "exit-code", &status,
> +			    N_("exit with exit code 2 if no matching refs are found"), 2),

This one can't be OPT_BOOL, obviously. What happens with
"--no-exit-code"? We'll set it back to "0", which I think is the right
thing to do. Good.

The rest of the patch looked good to me.

-Peff
